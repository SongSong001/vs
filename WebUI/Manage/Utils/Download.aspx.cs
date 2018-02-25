using System;
using System.Collections;
using System.Configuration;
using System.Data;

using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

using System.IO;

namespace WC.WebUI.Manage.Utils
{
    public partial class Download : WC.BLL.ViewPages
    {
        protected void Page_Load(object sender, System.EventArgs e)
        {
            string destFileName = Request.QueryString["destFileName"] != null ? Request.QueryString["destFileName"] : "";
            destFileName = Server.UrlDecode(destFileName);

            if (IsCharStart(destFileName.Trim(), '~'))
            {
                destFileName = Server.MapPath(destFileName);
            }
            else
            {
                destFileName = "~" + destFileName;
                destFileName = Server.MapPath(destFileName);
            }

            if (File.Exists(destFileName))
            {
                FileInfo fi = new FileInfo(destFileName);

                Response.Clear();
                Response.ClearHeaders();
                Response.Buffer = false;

                Response.AppendHeader("Content-Disposition", "attachment;filename=" + HttpUtility.UrlEncode(Path.GetFileName(destFileName), System.Text.Encoding.UTF8));
                Response.AppendHeader("Content-Length", fi.Length.ToString());
                Response.ContentType = "application/octet-stream";
                Response.WriteFile(destFileName);
                Response.Flush();
                Response.End();

            }
            else
            {
                Response.Write("<script langauge=javascript>alert('文件不存在!');history.go(-1);</script>");
                Response.End();
            }
        }

        public bool IsCharStart(string s, char c)
        {
            if (s.Length > 0)
            {
                char[] ch = s.ToCharArray();
                if (ch[0] == c)
                    return true;
                else return false;
            }
            else return false;
        }


    }
}
