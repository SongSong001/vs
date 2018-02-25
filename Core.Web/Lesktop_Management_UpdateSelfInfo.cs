using Core;
using Core.IO;
using System;
using System.Collections;
using System.IO;
using System.Web.UI;

public class Lesktop_Management_UpdateSelfInfo : Page
{
    private void cmdCtrl_OnCommand(string command, object data)
    {
        CommandCtrl cmdCtrl = this.FindControl("CommandCtrl1") as CommandCtrl;
        try
        {
            AccountInfo cu = ServerImpl.Instance.GetCurrentUser(this.Context);
            if (!(command == "Update"))
            {
                goto Label_0233;
            }
            Hashtable info = data as Hashtable;
            if ((base.Request.Files["file_headimg"] != null) && (base.Request.Files["file_headimg"].InputStream.Length > 0))
            {
                string filename = string.Format("/{0}/pub/{1}{2}", cu.Name, Guid.NewGuid().ToString().Replace("-", ""), Core.IO.Path.GetExtension(base.Request.Files["file_headimg"].FileName));
                info["HeadIMG"] = filename;
                Core.IO.Directory.CreateDirectory(Core.IO.Path.GetDirectoryName(filename));
                using (Stream stream = Core.IO.File.Open(filename, FileMode.Create, FileAccess.Write, FileShare.None))
                {
                    int c;
                    bool CS_4_0000;
                    byte[] buffer = new byte[0x1000];
                    goto Label_015A;
                Label_0113:
                    c = base.Request.Files["file_headimg"].InputStream.Read(buffer, 0, buffer.Length);
                    if (c == 0)
                    {
                        goto Label_0178;
                    }
                    stream.Write(buffer, 0, c);
                Label_015A:
                    CS_4_0000 = true;
                    goto Label_0113;
                }
            }
        Label_0178:
            AccountImpl.Instance.UpdateUserInfo(cu.Name, info);
            foreach (string friend in cu.Friends)
            {
                if (AccountImpl.Instance.GetUserInfo(friend).Type == 0)
                {
                    SessionManagement.Instance.Send(friend, "GLOBAL:REFRESH_FIRENDS", null);
                }
            }
            SessionManagement.Instance.Send(cu.Name, "GLOBAL:REFRESH_FIRENDS", null);
            cmdCtrl.State["SelfInfo"] = cu.DetailsJson;
            cmdCtrl.State["Action"] = "ResetUserInfo";
            return;
        Label_0233:
            if (command == "ChangePassword")
            {
                info = data as Hashtable;
                AccountImpl.Instance.UpdateUserInfo(cu.Name, info);
            }
        }
        catch (Exception ex)
        {
            cmdCtrl.State["Action"] = "Alert";
            cmdCtrl.State["Message"] = ex.Message;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        CommandCtrl cmdCtrl = this.FindControl("CommandCtrl1") as CommandCtrl;
        cmdCtrl.OnCommand += new CommandCtrl.OnCommandDelegate(this.cmdCtrl_OnCommand);
        cmdCtrl.State["SelfInfo"] = ServerImpl.Instance.GetCurrentUser(this.Context).DetailsJson;
    }
}

