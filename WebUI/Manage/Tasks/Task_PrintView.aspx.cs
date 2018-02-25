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

namespace WC.WebUI.Manage.Tasks
{
    public partial class Task_PrintView : WC.BLL.ViewPages
    {
        protected string fjs = "";
        protected string fj = "<span style='font-weight:bold;'>{1}</span> &nbsp;&nbsp;&nbsp;&nbsp;<a href='/Manage/Utils/Download.aspx?destFileName={0}' ><img src='/img/mail_attachment.gif' />下载附件</a><br>";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && !string.IsNullOrEmpty(Request.QueryString["tid"]))
            {
                string t = Request.QueryString["tid"];
                Show(t);
            }
        }

        private void Show(string tid)
        {
            TasksInfo ti = WC.BLL.Tasks.Init().GetById(Convert.ToInt32(tid));

            if (Uid == (ti.CreatorID + "") || ti.ManageUserList.Contains("#" + Uid + "#") || ti.ExecuteUserList.Contains("#" + Uid + "#") || Modules.Contains("51"))
            {
                Subject.InnerText = ti.TaskName;
                status.InnerText = GetStatus(ti.Status);
                Creator.InnerText = ti.CreatorRealName + "(" + ti.CreatorDepName + ")";
                TypeName.InnerText = ti.TypeName;
                AddTime.InnerText = ti.AddTime;
                UpdateTime.InnerText = ti.UpdateTime;
                ExpectTime.InnerText = ti.ExpectTime;
                Important.InnerText = ti.Important;
                ManageNameList.InnerText = ti.ManageNameList;

                TaskNO.InnerText = DateTime.Now.Year + "-" + DateTime.Now.Month + (10000 + ti.id);

                ti.Notes = ti.Notes + "";
                if (ti.Notes.ToLower().Contains("script"))
                    bodys1.InnerHtml = ti.Notes.ToLower().Replace("script", "scrript");
                else bodys1.InnerHtml = ti.Notes.ToLower().Replace("<p>", "").Replace("</p>", "<br>");

                if (!string.IsNullOrEmpty(ti.FilePath))
                {
                    fjs = "<span style='font-weight:bold; color:#006600;'>任务附件</span>：<br>";
                    string[] array = ti.FilePath.Split('|');
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

        protected string GetStatus(object obj)
        {
            string r = "";
            switch (obj + "")
            {
                case "-1": r = "已停止"; break;
                case "1": r = "进行中"; break;
                case "2": r = "已完成"; break;
                default: r = ""; break;
            }
            return r;
        }

    }
}