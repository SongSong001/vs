using Core;
using Core.IO;
using System;
using System.Collections;
using System.Data;
using System.IO;
using System.Text;
using System.Web.UI;

public class Management_GroupShare : Page
{
    private CommandCtrl _cmdCtrl;
    private string filter = "";
    private static string RowFormat = "\r\n\t<tr>\r\n\t\t<td class='filename'>{1}</td>\r\n\t\t<td class='size'>{2}KB</td>\r\n\t\t<td class='operation'>\r\n\t\t\t{3}\r\n            {4}\r\n\t\t</td>\r\n\t</tr>\r\n\t";

    private void cmdCtrl_OnCommand(string command, object data)
    {
        try
        {
            long groupId = Convert.ToInt64(base.Request.QueryString["GroupId"]);
            AccountInfo groupInfo = AccountImpl.Instance.GetUserInfo(groupId);
            Hashtable info = data as Hashtable;
            AccountInfo cu = AccountImpl.Instance.GetUserInfo(ServerImpl.Instance.GetUserName(this.Context));
            if (command == "Upload")
            {
                string filename = "";
                string oldname = "";
                if ((base.Request.Files["upload_file"] != null) && (base.Request.Files["upload_file"].InputStream.Length > 0))
                {
                    oldname = Core.IO.Path.GetFileNameWithoutExtension(base.Request.Files["upload_file"].FileName.Replace(@"\", "//"));
                    filename = string.Format("/{0}/pub/{1}{2}", groupInfo.Name, Guid.NewGuid().ToString().Replace("-", ""), Core.IO.Path.GetExtension(base.Request.Files["upload_file"].FileName));
                    Core.IO.Directory.CreateDirectory(Core.IO.Path.GetDirectoryName(filename));
                    using (Stream stream = Core.IO.File.Open(filename, FileMode.Create, FileAccess.Write, FileShare.None))
                    {
                        bool CS_4_0000;
                        byte[] buffer = new byte[0x1000];
                        int fileSize = 0;
                        int size = 0;
                        goto Label_01BB;
                    Label_016D:
                        size = base.Request.Files["upload_file"].InputStream.Read(buffer, 0, buffer.Length);
                        fileSize += size;
                        if (size == 0)
                        {
                            goto Label_01C0;
                        }
                        stream.Write(buffer, 0, size);
                    Label_01BB:
                        CS_4_0000 = true;
                        goto Label_016D;
                    Label_01C0:
                        AttachmentImpl.Instance.InsertAttachment(groupId, cu.ID, oldname, filename, (double) (fileSize / 0x400));
                    }
                }
            }
            else if (command == "Delete")
            {
                long id = Convert.ToInt64(info["Id"]);
                DataTable dt = AttachmentImpl.Instance.GetAttachmentById(id);
                if (dt.Rows.Count > 0)
                {
                    Core.IO.File.Delete(dt.Rows[0]["savename"].ToString());
                }
                AttachmentImpl.Instance.DeleteAttachment(id);
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

    protected string RenderFileList()
    {
        StringBuilder builder = new StringBuilder();
        AccountInfo cu = AccountImpl.Instance.GetUserInfo(ServerImpl.Instance.GetUserName(this.Context));
        long groupId = Convert.ToInt64(base.Request.QueryString["GroupId"]);
        DataTable dt = AttachmentImpl.Instance.GetListByGroupId(groupId);
        long uplaodId = 0;
        foreach (DataRow row in dt.Rows)
        {
            uplaodId = Convert.ToInt64(row["uplaodId"]);
            builder.AppendFormat(RowFormat, new object[] { "", HtmlUtil.ReplaceHtml(row["oldname"].ToString()), HtmlUtil.ReplaceHtml(row["size"].ToString()), (uplaodId != cu.ID) ? "" : string.Format("<a href='javascript:Delete({0},\"{1}\")'>删除</a>", row["Id"], row["oldname"].ToString()), string.Format("<a href='download.aspx?FileName={0}'>下载</a>", row["savename"].ToString()) });
        }
        return builder.ToString();
    }
}

