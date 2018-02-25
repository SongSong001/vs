using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using WC.BLL;
using WC.Model;
using WC.DBUtility;
using WC.Tool;
using System.IO;

namespace WC.WebUI.Mobile.WorkLog
{
    public partial class WorkLogView : WC.BLL.MobilePage
    {
        protected string fjs = "";
        protected string fj = "<span style='font-weight:bold;'>{1}</span> &nbsp;&nbsp;&nbsp;&nbsp;<a href='/Manage/Utils/Download.aspx?destFileName={0}' ><img src='/img/mail_attachment.gif' />下载附件</a><br>";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["wid"]))
            {
                string t = Request.QueryString["wid"];
                Show(t);
            }
        }

        private void Show(string wid)
        {
            WorkLogInfo wi = WC.BLL.WorkLog.Init().GetById(Convert.ToInt32(wid));

            if ((Uid == (wi.CreatorID + "")) || (wi.ShareUsers.Contains("#" + Uid + "#")))
            {
                TaskUser.InnerText = wi.CreatorRealName + "(" + wi.CreatorDepName + ")";
                WorkTitle.InnerText ="标题："+ wi.LogTitle;
                AddTime.InnerText = wi.AddTime;
                UpdateTime.InnerText = wi.UpdateTime;

                if (Notes.InnerHtml.ToLower().Contains("script"))
                    Notes.InnerHtml = wi.Notes.ToLower().Replace("script", "scrript").Replace("\r\n", "<br>");
                else
                    Notes.InnerHtml = wi.Notes.ToLower().Replace("<p>", "").Replace("</p>", "<br>");

                if (!string.IsNullOrEmpty(wi.FilePath))
                {
                    string[] array = wi.FilePath.Split('|');
                    for (int i = 0; i < array.Length; i++)
                    {
                        if (array[i].Trim() != "")
                        {
                            int t = array[i].LastIndexOf('/') + 1;
                            string filename = array[i].Substring(t, array[i].Length - t);
                            string fileurl = array[i].ToString();

                            fjs += string.Format(fj, Server.UrlEncode(fileurl), filename);

                        }
                    }
                }

            }

        }
    }
}