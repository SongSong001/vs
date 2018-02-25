using Core;
using System;
using System.Collections;
using System.Text;
using System.Web.UI;

public class Management_ManageGroupMember : Page
{
    private CommandCtrl cmdCtrl;
    private static string RowFormat = "\r\n\t<tr>\r\n\t\t<td class='headimg'>{0}</td>\r\n\t\t<td class='name'>{1}</td>\r\n\t\t<td class='nickname'>{2}</td>\r\n\t\t<td class='email'>{3}</td>\r\n\t</tr>\r\n\t";
    private string UserName = "";

    private void cmdCtrl_OnCommand(string command, object data)
    {
        try
        {
            this.UserName = base.Request.QueryString["Name"];
            if (command == "DeleteMember")
            {
                Hashtable haperr = (Hashtable) Utility.ParseJson(data.ToString());
                if (haperr != null)
                {
                    foreach (Hashtable peer in (object[]) haperr["Peers"])
                    {
                        AccountImpl.Instance.DeleteFriend(this.UserName, peer["Name"].ToString());
                        AccountInfo peerInfo = AccountImpl.Instance.GetUserInfo(peer["Name"].ToString());
                        AccountInfo Group = AccountImpl.Instance.GetUserInfo(this.UserName);
                        string content = Utility.RenderHashJson(new object[] { "Type", "ExitGroupNotify", "User", AccountImpl.Instance.GetUserInfo(peer["Name"].ToString()), "Group", Group });
                        MessageImpl.Instance.NewMessage(peerInfo.Name, "administrator", content, null);
                        MessageImpl.Instance.NewMessage(this.UserName, this.UserName, string.Format("{0}({1})已被移除出群！", peerInfo.Nickname, peerInfo.Name), null);
                        SessionManagement.Instance.Send("GroupMemberChanged", Utility.RenderHashJson(new object[] { "User", this.UserName }));
                    }
                }
            }
            if (command == "RefreshMember")
            {
                this.cmdCtrl.State["Action"] = "RefreshFriendsList";
            }
        }
        catch (Exception ex)
        {
            this.cmdCtrl.State["Action"] = "Error";
            this.cmdCtrl.State["Exception"] = ex;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        this.cmdCtrl = this.FindControl("CommandCtrl") as CommandCtrl;
        this.cmdCtrl.OnCommand += new CommandCtrl.OnCommandDelegate(this.cmdCtrl_OnCommand);
        this.UserName = base.Request.QueryString["Name"];
        this.cmdCtrl.State["Action"] = null;
    }

    protected string RenderFriendList()
    {
        StringBuilder builder = new StringBuilder();
        AccountInfo ac = AccountImpl.Instance.GetUserInfo(this.UserName);
        foreach (string name in AccountImpl.Instance.GetUserInfo(this.UserName).Friends)
        {
            if (((name.ToUpper() != "SA") && (name.ToUpper() != "ADMIN")) && !(name.ToUpper() == "ADMINISTRATOR"))
            {
                AccountInfo fi = AccountImpl.Instance.GetUserInfo(name);
                if ((fi.Type == 0) && (fi.Name != ac.Creator))
                {
                    builder.AppendFormat(RowFormat, new object[] { string.Format("<input type='checkbox'   id ='{0}'/>", Utility.RenderJson(fi.Name)), HtmlUtil.ReplaceHtml(fi.Name), HtmlUtil.ReplaceHtml(fi.Nickname), HtmlUtil.ReplaceHtml(fi.EMail) });
                }
            }
        }
        return builder.ToString();
    }
}

