using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.IO;
using WC.BLL;
using WC.Model;
using WC.DBUtility;

namespace WC.WebUI.Manage.Paper
{
    public partial class DownLoad : WC.BLL.ViewPages
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && !string.IsNullOrEmpty(Request.QueryString["pid"]))
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
                    if (fi.FullName.ToLower().Contains("files"))
                    {

                        PaperInfo pi = WC.BLL.Paper.Init().GetById(Convert.ToInt32(Request.QueryString["pid"]));
                        PaperDownloadInfo pdi = new PaperDownloadInfo();
                        pdi.PaperID = pi.id;
                        pdi.AddTime = DateTime.Now.ToString("yyyy-MM-dd");
                        pdi.DUserID = Convert.ToInt32(Uid);
                        pdi.DUserName = RealName;
                        pdi.DDepName = DepName;
                        pdi.DPaperNo = pi.PaperNO;
                        pdi.DPaperSymbol = pi.PaperSymbol;
                        pdi.DSendDep = pi.SendDep;
                        pdi.DPaperName = pi.PaperName;

                        string sql = "select count(*) from PaperDownload where PaperID=" + pi.id + " and DUserID=" + Uid + " and AddTime='" + pdi.AddTime + "'";
                        object n = MsSqlOperate.ExecuteScalar(CommandType.Text, sql);
                        if (Convert.ToInt32(n) == 0)
                            PaperDownload.Init().Add(pdi);

                        Response.Clear();
                        Response.ClearHeaders();
                        Response.Buffer = false;

                        Response.AppendHeader("Content-Disposition", "attachment;filename=" + HttpUtility.UrlEncode(Path.GetFileName(destFileName), System.Text.Encoding.UTF8));
                        Response.AppendHeader("Content-Length", fi.Length.ToString());
                        Response.ContentType = "application/octet-stream";

                        Response.WriteFile(destFileName);
                        Response.Flush();
                        Response.Clear();
                        Response.End();

                    }

                }
                else
                {
                    Response.Write("<script langauge=javascript>alert('文件不存在!');history.go(-1);</script>");
                    Response.End();
                }

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