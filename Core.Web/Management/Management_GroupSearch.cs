using Core;
using System;
using System.Data;
using System.Text;
using System.Web.UI;

public class Management_GroupSearch : Page
{
    private CommandCtrl _cmdCtrl;
    private string filter = "";
    private static string RowFormat = "\r\n\t<tr>\r\n\t\t<td class='headimg'>&nbsp;</td>\r\n\t\t<td class='name'>{1}</td>\r\n\t\t<td class='nickname'>{2}</td>\r\n\t\t<td class='creator'>{3}({4})</td>\r\n\t\t<td class='operation'>\r\n\t\t\t{5}\r\n\t\t</td>\r\n\t</tr>\r\n\t";

    private void cmdCtrl_OnCommand(string command, object data)
    {
        try
        {
            if (command == "AddGroup")
            {
                string peer = Convert.ToString(data);
                string UserName = ServerImpl.Instance.GetCurrentUser(this.Context).Name;
                if (AccountImpl.Instance.GetUserInfo(peer) == null)
                {
                    this.Page.ClientScript.RegisterStartupScript(base.GetType(), "ExistsError0", string.Format("<script>alert('群组 \"{0}\" 不存在！');</script>", peer));
                }
                else
                {
                    AccountInfo peerInfo = AccountImpl.Instance.GetUserInfo(peer);
                    if (string.Compare(peerInfo.Creator, UserName, true) == 0)
                    {
                        this.Page.ClientScript.RegisterStartupScript(base.GetType(), "ExistsError3", string.Format("<script>alert('不能添加自己创建的群！');</script>", peer));
                    }
                    else if (peerInfo.Type == 1)
                    {
                        if (AccountImpl.Instance.GetUserInfo(UserName).ContainsFriend(peer))
                        {
                            this.Page.ClientScript.RegisterStartupScript(base.GetType(), "ExistsError2", string.Format("<script>alert('您已加入群 \"{0}({1})\"！');</script>", peerInfo.Nickname, peer));
                        }
                        else
                        {
                            MessageImpl.Instance.NewMessage(peerInfo.Creator, "administrator", Utility.RenderHashJson(new object[] { "Type", "AddGroupRequest", "User", AccountImpl.Instance.GetUserInfo(UserName), "Group", peerInfo, "Info", "" }), null);
                            this.Page.ClientScript.RegisterStartupScript(base.GetType(), "ok", string.Format("<script>alert('添加群的请求已发送，等待对方确认...');</script>", new object[0]));
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
        StringBuilder builder = new StringBuilder();
        AccountInfo cu = AccountImpl.Instance.GetUserInfo(ServerImpl.Instance.GetUserName(this.Context));
        foreach (DataRow row in AccountImpl.Instance.GetAllGroups())
        {
            if ((row["Name"].ToString().Contains(this.filter) || (this.filter == "")) || row["Nickname"].ToString().Contains(this.filter))
            {
                AccountInfo createor = AccountImpl.Instance.GetUserInfo(Convert.ToInt64(row["Creator"]));
                if (createor != null)
                {
                    builder.AppendFormat(RowFormat, new object[] { "", HtmlUtil.ReplaceHtml(row["Name"].ToString()), HtmlUtil.ReplaceHtml(row["Nickname"].ToString()), HtmlUtil.ReplaceHtml(createor.Nickname), createor.Name, (cu.ID == createor.ID) ? "" : string.Format("<a href='javascript:AddGroup({0})'>加入</a>", Utility.RenderJson(row["Name"].ToString())) });
                }
            }
        }
        return builder.ToString();
    }
}

