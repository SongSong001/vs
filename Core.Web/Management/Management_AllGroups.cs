using Core;
using System;
using System.Data;
using System.Text;
using System.Web.UI;

public class Management_AllGroups : Page
{
    private CommandCtrl _cmdCtrl;
    private static string RowFormat = "\r\n\t<tr>\r\n\t\t<td class='headimg'>&nbsp;</td>\r\n\t\t<td class='name'>{1}</td>\r\n\t\t<td class='nickname'>{2}</td>\r\n\t\t<td class='creator'>{3}({4})</td>\r\n\t\t<td class='registerTime'>{8:yyyy-MM-dd HH:mm}</td>\r\n\t\t<td class='operation'><a href='javascript:Delete({5},{6},{7})'>删除群组</a></td>\r\n\t</tr>\r\n\t";

    private void cmdCtrl_OnCommand(string command, object data)
    {
        try
        {
            string peer = Convert.ToString(data);
            if (command == "Delete")
            {
                long id = Convert.ToInt64(data);
                AccountInfo groupInfo = AccountImpl.Instance.GetUserInfo(id);
                string[] members = groupInfo.Friends;
                AccountImpl.Instance.DeleteGroup(groupInfo.Name, groupInfo.Creator);
                foreach (string member in members)
                {
                    AccountInfo memberInfo = AccountImpl.Instance.GetUserInfo(member);
                    string content = Utility.RenderHashJson(new object[] { "Type", "DeletetGroupNotify", "Group", groupInfo });
                    MessageImpl.Instance.NewMessage(memberInfo.Name, "manager", content, null);
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
        AccountInfo cu = ServerImpl.Instance.GetCurrentUser(this.Context);
        if (cu == null)
        {
            throw new Exception("你没有权限访问该页面！");
        }
        if ((cu.Name.ToLower() != "sa") && !(cu.Name.ToLower() == "manager"))
        {
            throw new Exception("你没有权限访问该页面！");
        }
        this._cmdCtrl = this.FindControl("CommandCtrl") as CommandCtrl;
        this._cmdCtrl.OnCommand += new CommandCtrl.OnCommandDelegate(this.cmdCtrl_OnCommand);
    }

    protected string RenderFriendList()
    {
        StringBuilder builder = new StringBuilder();
        foreach (DataRow row in AccountImpl.Instance.GetAllGroups())
        {
            AccountInfo createor = AccountImpl.Instance.GetUserInfo(Convert.ToInt64(row["Creator"]));
            if (createor != null)
            {
                builder.AppendFormat(RowFormat, new object[] { "", HtmlUtil.ReplaceHtml(row["Name"].ToString()), HtmlUtil.ReplaceHtml(row["Nickname"].ToString()), HtmlUtil.ReplaceHtml(createor.Nickname), createor.Name, row["Key"], Utility.RenderJson(row["Nickname"].ToString()), Utility.RenderJson(row["Name"].ToString()), row["RegisterTime"] });
            }
        }
        return builder.ToString();
    }
}

