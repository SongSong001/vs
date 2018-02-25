using Core;
using System;
using System.Data;
using System.Text;
using System.Web.UI;

public class Management_FriendSearch : Page
{
    private CommandCtrl cmdCtrl;
    private string filter = "";
    private static string RowFormat = "\r\n\t<tr>\r\n\t\t<td class='headimg'>&nbsp;</td>\r\n\t\t<td class='name'>{1}</td>\r\n\t\t<td class='nickname'>{2}</td>\r\n\t\t<td class='email'>{3}</td>\r\n\t\t<td class='operation'><a href='javascript:AddFriend({4})'>加为好友</a></td>\r\n\t</tr>\r\n\t";

    private void cmdCtrl_OnCommand(string command, object data)
    {
        try
        {
            if (command == "AddFriend")
            {
                string peer = Convert.ToString(data);
                string UserName = ServerImpl.Instance.GetCurrentUser(this.Context).Name;
                if (string.Compare(peer, UserName, true) == 0)
                {
                    this.Page.ClientScript.RegisterStartupScript(base.GetType(), "ExistsError3", string.Format("<script>alert('不能添加自己为好友！');</script>", peer));
                }
                else if (AccountImpl.Instance.GetUserInfo(peer) == null)
                {
                    this.Page.ClientScript.RegisterStartupScript(base.GetType(), "ExistsError0", string.Format("<script>alert('用户\"{0}\" 不存在！');</script>", peer));
                }
                else
                {
                    AccountInfo peerInfo = AccountImpl.Instance.GetUserInfo(peer);
                    if (peerInfo.Type == 0)
                    {
                        if (AccountImpl.Instance.GetUserInfo(UserName).ContainsFriend(peer))
                        {
                            this.Page.ClientScript.RegisterStartupScript(base.GetType(), "ExistsError1", string.Format("<script>alert('用户 \"{0}({1})\" 已经是您的好友！');</script>", peerInfo.Nickname, peer));
                        }
                        else
                        {
                            MessageImpl.Instance.NewMessage(peer, "administrator", Utility.RenderHashJson(new object[] { "Type", "AddFriendRequest", "Peer", AccountImpl.Instance.GetUserInfo(UserName), "Info", "" }), null);
                            this.Page.ClientScript.RegisterStartupScript(base.GetType(), "ok", string.Format("<script>alert('添加好友的请求已发送，等待对方确认...');</script>", new object[0]));
                        }
                    }
                }
            }
            else if (command == "Search")
            {
                this.filter = data.ToString();
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
        this.cmdCtrl.State["Action"] = null;
    }

    protected string RenderFriendList()
    {
        StringBuilder builder = new StringBuilder();
        foreach (DataRow row in AccountImpl.Instance.GetAllUsers())
        {
            if ((((row["Name"].ToString().ToUpper() != "SA") && (row["Name"].ToString().ToUpper() != "ADMIN")) && !(row["Name"].ToString().ToUpper() == "ADMINISTRATOR")) && ((row["Name"].ToString().Contains(this.filter) || (this.filter == "")) || row["Nickname"].ToString().Contains(this.filter)))
            {
                builder.AppendFormat(RowFormat, new object[] { "", HtmlUtil.ReplaceHtml(row["Name"].ToString()), HtmlUtil.ReplaceHtml(row["Nickname"].ToString()), HtmlUtil.ReplaceHtml(row["EMail"].ToString()), Utility.RenderJson(row["Name"].ToString()) });
            }
        }
        return builder.ToString();
    }
}

