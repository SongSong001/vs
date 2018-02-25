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
    public partial class FeedBack_View : WC.BLL.ViewPages
    {
        protected string fjs = "";
        protected string fj = "<span style='font-weight:bold;'>{1}</span> &nbsp;&nbsp;&nbsp;&nbsp;<a href='/Manage/Utils/Download.aspx?destFileName={0}' ><img src='/img/mail_attachment.gif' />下载附件</a><br>";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["tuid"]))
            {
                string t = Request.QueryString["tuid"];
                Show(t);
            }

        }

        protected void Save_Btn(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["tuid"]))
            {
                string t = Request.QueryString["tuid"];
                Tasks_UserInfo tui = Tasks_User.Init().GetById(Convert.ToInt32(t));
                //TasksInfo ti = WC.BLL.Tasks.Init().GetById(tui.TaskID);
                tui.Instruction += "<font color='#0055ff'>" + Request.Form["pz"] + "</font> -- " + RealName + " (" + DateTime.Now.ToString("yy-M-dd HH:mm") + ")<br><hr />";
                Tasks_User.Init().Update(tui);
                Show(t);
            }
        }

        private void Show(string tid)
        {
            Tasks_UserInfo tui = Tasks_User.Init().GetById(Convert.ToInt32(tid));
            TasksInfo ti = WC.BLL.Tasks.Init().GetById(tui.TaskID);

            if ((Uid == (tui.UserID + "")) || ( (ti.IsOtherSee == 1) && ti.ExecuteUserList.Contains("#" + Uid + "#")) || ti.ManageUserList.Contains("#" + Uid + "#") || Modules.Contains("51"))
            {
                pizhu1.Visible = false;
                pizhu3.Visible = false;
                if (ti.ManageUserList.Contains("#" + Uid + "#") && ti.Status == 1)
                {
                    pizhu1.Visible = true;
                    pizhu3.Visible = true;
                }
                TaskUser.InnerText = tui.RealName + "(" + tui.DepName + ")";
                TaskName.InnerText = ti.TaskName;
                WorkTitle.InnerText = tui.WorkTitle;
                AddTime.InnerText = WC.Tool.Utils.ConvertDate3(tui.AddTime);

                tui.WorkNotes = tui.WorkNotes + "";
                if (tui.WorkNotes.ToLower().Contains("script"))
                    Notes.InnerHtml = tui.WorkNotes.ToLower().Replace("script", "scrript");
                else Notes.InnerHtml = tui.WorkNotes.ToLower().Replace("<p>", "").Replace("</p>", "<br>");

                if (!string.IsNullOrEmpty(tui.FilePath))
                {
                    string[] array = tui.FilePath.Split('|');
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

                tui.Instruction = tui.Instruction + "";
                if (tui.Instruction.ToLower().Contains("script"))
                    Instruction.InnerHtml = tui.Instruction.ToLower().Replace("script", "scrript").Replace("\r\n", "<br>");
                else Instruction.InnerHtml = tui.Instruction.ToLower().Replace("<p>", "").Replace("</p>", "<br>");


            }
        }

    }
}