using Core;
using System;
using System.Collections;
using System.Configuration;
using System.Text;
using System.Web.UI;

public class Management_GroupList : Page
{
    private CommandCtrl _cmdCtrl;
    private static string RowFormat = "\r\n\t<tr>\r\n\t\t<td class='headimg'>&nbsp;</td>\r\n\t\t<td class='name'>{1}</td>\r\n\t\t<td class='nickname'>{2}</td>\r\n        <td class='isexit'>{12}</td>\r\n        <td class='gtype'>{13}</td>\r\n\t\t<td class='creator'>{3}({4})</td>\r\n\t\t<td class='operation'>\r\n\t\t\t{10}\r\n            {11}\r\n\t\t\t<a href='javascript:Delete({5},{6},{7},{8})'>{9}</a>\r\n\t\t</td>\r\n\t</tr>\r\n\t";

    private void cmdCtrl_OnCommand(string command, object data)
    {
        try
        {
            string peer = Convert.ToString(data);
            AccountInfo cu = ServerImpl.Instance.GetCurrentUser(this.Context);
            if (command == "NewGroup")
            {
                Hashtable info = data as Hashtable;
                if (Convert.ToInt64(info["Type"]) == 1)
                {
                    AccountImpl.Instance.CreateGroup(cu.Name, info["Name"].ToString(), info["Nickname"].ToString(), Convert.ToInt64(info["IsExitGroup"]));
                }
                else if (Convert.ToInt64(info["Type"]) == 2)
                {
                    AccountImpl.Instance.CreateTempGroup(cu.Name, info["Name"].ToString(), info["Nickname"].ToString(), "", "");
                }
                this._cmdCtrl.State["Action"] = "RefreshFriendsList";
            }
            else
            {
                long id;
                AccountInfo groupInfo;
                string content;
                if (command == "Exit")
                {
                    id = Convert.ToInt64(data);
                    groupInfo = AccountImpl.Instance.GetUserInfo(id);
                    AccountImpl.Instance.DeleteFriend(cu.Name, groupInfo.Name);
                    content = Utility.RenderHashJson(new object[] { "Type", "ExitGroupNotify", "User", cu, "Group", groupInfo });
                    SessionManagement.Instance.Send(cu.Name, "GLOBAL:REFRESH_FIRENDS", null);
                    SessionManagement.Instance.Send("GroupMemberChanged", Utility.RenderHashJson(new object[] { "User", groupInfo.Name }));
                    if (ConfigurationManager.AppSettings["GroupMembersAddDeleteIsReminded"].ToString() == "1")
                    {
                        MessageImpl.Instance.NewMessage(groupInfo.Name, groupInfo.Name, string.Format("{0}({1})已退出群！", cu.Nickname, cu.Name), null);
                    }
                }
                else if (command == "Delete")
                {
                    id = Convert.ToInt64(data);
                    groupInfo = AccountImpl.Instance.GetUserInfo(id);
                    AccountImpl.Instance.DeleteGroup(groupInfo.Name, cu.Name);
                    this._cmdCtrl.State["Action"] = "RefreshFriendsList";
                    foreach (string member in groupInfo.Friends)
                    {
                        AccountInfo memberInfo = AccountImpl.Instance.GetUserInfo(member);
                        if (memberInfo.ID != cu.ID)
                        {
                            content = Utility.RenderHashJson(new object[] { "Type", "DeletetGroupNotify", "Group", groupInfo });
                            if (ConfigurationManager.AppSettings["GroupMembersAddDeleteIsReminded"].ToString() == "1")
                            {
                                MessageImpl.Instance.NewMessage(memberInfo.Name, "administrator", content, null);
                            }
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            this._cmdCtrl.State["Action"] = "Error";
            this._cmdCtrl.State["Exception"] = ex;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        this._cmdCtrl = this.FindControl("CommandCtrl") as CommandCtrl;
        this._cmdCtrl.OnCommand += new CommandCtrl.OnCommandDelegate(this.cmdCtrl_OnCommand);
    }

    protected string RenderFriendList()
    {
        AccountInfo cu = AccountImpl.Instance.GetUserInfo(ServerImpl.Instance.GetUserName(this.Context));
        StringBuilder builder = new StringBuilder();
        foreach (string name in AccountImpl.Instance.GetUserInfo(cu.Name).Friends)
        {
            AccountInfo fi = AccountImpl.Instance.GetUserInfo(name);
            if (((fi != null) && (fi.Type != 0)) && (fi.Name.ToLower() != "sa"))
            {
                AccountInfo createor = AccountImpl.Instance.GetUserInfo(fi.Creator);
                if (createor != null)
                {
                    builder.AppendFormat(RowFormat, new object[] { "", HtmlUtil.ReplaceHtml(fi.Name), HtmlUtil.ReplaceHtml(fi.Nickname), HtmlUtil.ReplaceHtml(createor.Nickname), createor.Name, fi.ID, Utility.RenderJson(fi.Nickname), Utility.RenderJson(fi.Name), Utility.RenderJson(cu.ID == createor.ID), (cu.ID == createor.ID) ? "解散" : "退出", (cu.ID == createor.ID) ? string.Format("<a href='javascript:Update(\"{0}\")'>修改</a>", HtmlUtil.ReplaceHtml(fi.Name)) : "", (cu.ID == createor.ID) ? string.Format("<a href='javascript:ManageGroupMember(\"{0}\")'>管理成员</a>", HtmlUtil.ReplaceHtml(fi.Name)) : "", fi.IsExitGroup ? "允许" : "不允许", (fi.Type == 1) ? "群" : "讨论组" });
                }
            }
        }
        return builder.ToString();
    }
}

