using Core;
using System;
using System.Text;
using System.Web.UI;

public class Management_FriendList : Page
{
    private static string RowFormat = "\r\n\t<tr>\r\n\t\t<td class='headimg'>&nbsp;</td>\r\n\t\t<td class='name'>{1}</td>\r\n\t\t<td class='nickname'>{2}</td>\r\n\t\t<td class='email'>{3}</td>\r\n\t\t<td class='operation'><a href='javascript:Delete({4},{5},{6})'>删除好友</a></td>\r\n\t</tr>\r\n\t";

    private void cmdCtrl_OnCommand(string command, object data)
    {
        string peer = Convert.ToString(data);
        AccountInfo cu = ServerImpl.Instance.GetCurrentUser(this.Context);
        if (command == "Delete")
        {
            AccountImpl.Instance.DeleteFriend(cu.Name, peer);
            string content = Utility.RenderHashJson(new object[] { "Type", "DeleteFriendNotify", "User", AccountImpl.Instance.GetUserInfo(cu.Name), "Peer", AccountImpl.Instance.GetUserInfo(peer), "Info", "" });
            MessageImpl.Instance.NewMessage(peer, "administrator", content, null);
            MessageImpl.Instance.NewMessage(cu.Name, "administrator", content, null);
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        CommandCtrl cmdCtrl = this.FindControl("CommandCtrl") as CommandCtrl;
        cmdCtrl.OnCommand += new CommandCtrl.OnCommandDelegate(this.cmdCtrl_OnCommand);
        cmdCtrl.State["Action"] = null;
    }

    protected string RenderFriendList()
    {
        AccountInfo cu = AccountImpl.Instance.GetUserInfo(ServerImpl.Instance.GetUserName(this.Context));
        StringBuilder builder = new StringBuilder();
        foreach (string name in AccountImpl.Instance.GetUserInfo(cu.Name).Friends)
        {
            if (((name.ToUpper() != "SA") && (name.ToUpper() != "ADMIN")) && !(name.ToUpper() == "ADMINISTRATOR"))
            {
                AccountInfo fi = AccountImpl.Instance.GetUserInfo(name);
                if ((fi.Type == 0) && (fi.Name.ToLower() != "sa"))
                {
                    builder.AppendFormat(RowFormat, new object[] { "", HtmlUtil.ReplaceHtml(fi.Name), HtmlUtil.ReplaceHtml(fi.Nickname), HtmlUtil.ReplaceHtml(fi.EMail), fi.ID, Utility.RenderJson(fi.Nickname), Utility.RenderJson(fi.Name) });
                }
            }
        }
        return builder.ToString();
    }
}

