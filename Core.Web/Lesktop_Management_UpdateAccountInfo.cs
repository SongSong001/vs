using Core;
using Core.IO;
using System;
using System.Collections;
using System.IO;
using System.Web.UI;

public class Lesktop_Management_UpdateAccountInfo : Page
{
    private void cmdCtrl_OnCommand(string command, object data)
    {
        CommandCtrl cmdCtrl = this.FindControl("CommandCtrl1") as CommandCtrl;
        AccountInfo groupInfo = AccountImpl.Instance.GetUserInfo(base.Request.QueryString["Name"]);
        try
        {
            if (!(command == "Update"))
            {
                return;
            }
            Hashtable info = data as Hashtable;
            if ((base.Request.Files["file_headimg"] != null) && (base.Request.Files["file_headimg"].InputStream.Length > 0))
            {
                string filename = string.Format("/{0}/pub/{1}{2}", groupInfo.Name, Guid.NewGuid().ToString().Replace("-", ""), Core.IO.Path.GetExtension(base.Request.Files["file_headimg"].FileName));
                info["HeadIMG"] = filename;
                Core.IO.Directory.CreateDirectory(Core.IO.Path.GetDirectoryName(filename));
                using (Stream stream = Core.IO.File.Open(filename, FileMode.Create, FileAccess.Write, FileShare.None))
                {
                    int c;
                    bool CS_4_0000;
                    byte[] buffer = new byte[0x1000];
                    goto Label_0169;
                Label_0122:
                    c = base.Request.Files["file_headimg"].InputStream.Read(buffer, 0, buffer.Length);
                    if (c == 0)
                    {
                        goto Label_0187;
                    }
                    stream.Write(buffer, 0, c);
                Label_0169:
                    CS_4_0000 = true;
                    goto Label_0122;
                }
            }
        Label_0187:
            AccountImpl.Instance.UpdateUserInfo(groupInfo.Name, info);
            foreach (string friend in groupInfo.Friends)
            {
                if (AccountImpl.Instance.GetUserInfo(friend).Type == 0)
                {
                    SessionManagement.Instance.Send(friend, "GLOBAL:REFRESH_FIRENDS", null);
                }
            }
            cmdCtrl.State["AccountInfo"] = groupInfo.DetailsJson;
        }
        catch (Exception ex)
        {
            cmdCtrl.State["Action"] = "Alert";
            cmdCtrl.State["Message"] = ex.Message;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        AccountInfo cu = ServerImpl.Instance.GetCurrentUser(this.Context);
        AccountInfo groupInfo = AccountImpl.Instance.GetUserInfo(base.Request.QueryString["Name"]);
        if (string.Compare(cu.Name, groupInfo.Creator, true) != 0)
        {
            throw new Exception("权限不足！");
        }
        CommandCtrl cmdCtrl = this.FindControl("CommandCtrl1") as CommandCtrl;
        cmdCtrl.OnCommand += new CommandCtrl.OnCommandDelegate(this.cmdCtrl_OnCommand);
        cmdCtrl.State["AccountInfo"] = groupInfo.DetailsJson;
    }
}

