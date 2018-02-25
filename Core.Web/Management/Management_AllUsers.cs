using Core;
using System;
using System.Collections;
using System.Data;
using System.Text;
using System.Web.UI;

public class Management_AllUsers : Page
{
    private static string RowFormat = "\r\n\t<tr>\r\n\t\t<td class='name'>{0}</td>\r\n\t\t<td class='nickname'>{1}</td>\r\n\t\t<td class='email'>{2}</td>\r\n\t\t<td class='phone'>{3}</td>\r\n        <td class='telphone'>{4}</td>\r\n\t\t<td class='operation'>\r\n            {8}\r\n         <a href='javascript:Delete({5},{6},{7})'>删除用户</a></td>\r\n\t</tr>\r\n\t";

    private void cmdCtrl_OnCommand(string command, object data)
    {
        string peer = Convert.ToString(data);
        AccountInfo cu = ServerImpl.Instance.GetCurrentUser(this.Context);
        if (command == "NewUser")
        {
            Hashtable info = data as Hashtable;
            AccountImpl.Instance.AddUser(info["Name"] as string, info["Nickname"] as string, "123", "", info["Phone"] as string, info["TelPhone"] as string);
        }
        if (command == "Delete")
        {
            long id = Convert.ToInt64(data);
            AccountInfo userInfo = AccountImpl.Instance.GetUserInfo(id);
            AccountImpl.Instance.DeleteUser(userInfo.Name);
            string[] friends = userInfo.Friends;
            foreach (string friend in friends)
            {
                if (AccountImpl.Instance.GetUserInfo(friend).Type == 0)
                {
                    SessionManagement.Instance.Send(friend, "GLOBAL:REFRESH_FIRENDS", null);
                }
            }
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
        CommandCtrl cmdCtrl = this.FindControl("CommandCtrl") as CommandCtrl;
        cmdCtrl.OnCommand += new CommandCtrl.OnCommandDelegate(this.cmdCtrl_OnCommand);
        cmdCtrl.State["Action"] = null;
    }

    protected string RenderAllUsersList()
    {
        StringBuilder builder = new StringBuilder();
        DataRowCollection users = AccountImpl.Instance.GetAllUsers();
        foreach (DataRow row in users)
        {
            if (((row["Name"].ToString().ToUpper() != "SA") && (row["Name"].ToString().ToUpper() != "ADMIN")) && !(row["Name"].ToString().ToUpper() == "ADMINISTRATOR"))
            {
                builder.AppendFormat(RowFormat, new object[] { HtmlUtil.ReplaceHtml(row["Name"].ToString()), HtmlUtil.ReplaceHtml(row["Nickname"].ToString()), HtmlUtil.ReplaceHtml(row["EMail"].ToString()), HtmlUtil.ReplaceHtml(row["phone"].ToString()), HtmlUtil.ReplaceHtml(row["telphone"].ToString()), row["Key"], Utility.RenderJson(row["Nickname"].ToString()), Utility.RenderJson(row["Name"].ToString()), string.Format("<a href='javascript:Update(\"{0}\")'>修改</a>", HtmlUtil.ReplaceHtml(row["Name"].ToString())) });
            }
        }
        return builder.ToString();
    }
}

