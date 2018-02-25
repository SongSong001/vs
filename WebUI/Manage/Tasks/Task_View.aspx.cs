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
using WC.BLL;
using WC.Model;
using WC.DBUtility;
using WC.Tool;
using System.IO;

namespace WC.WebUI.Manage.Tasks
{
    public partial class Task_View : WC.BLL.ViewPages
    {
        private TasksInfo ti = null;
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
            ti = WC.BLL.Tasks.Init().GetById(Convert.ToInt32(tid));

            if (Uid == (ti.CreatorID + "") || ti.ManageUserList.Contains("#" + Uid + "#") || ti.ExecuteUserList.Contains("#" + Uid + "#") || Modules.Contains("51"))
            {
                ListShow();
                DetailShow();
                RptShow();

                display.Visible = false; exetable.Visible = false; s1.Visible = false; s2.Visible = false;
                b1.Visible = false; b2.Visible = false; b3.Visible = false; display1.Visible = false;

                if (ti.ManageUserList.Contains("#" + Uid + "#"))
                {
                    display.Visible = true;

                    if (ti.Status == -1)
                    { b1.Visible = true; }
                    if (ti.Status == 1)
                    { b2.Visible = true; b3.Visible = true; }
                    if (ti.Status == 2)
                    { b1.Visible = true; }
                }

                if (ti.ExecuteUserList.Contains("#" + Uid + "#"))
                {
                    IList list = Tasks_User.Init().GetAll("TaskID=" + ti.id + " and UserID=" + Uid, null);
                    if (list.Count > 0 && ti.Status == 1)
                    {
                        Hashtable ht = GetTasks_UserHash(list);
                        string noaccept = ht["noaccept"] + "";
                        string accept = ht["accept"] + "";
                        string submit = ht["submit"] + "";

                        if (noaccept == "1" && accept == "0" && submit == "0")
                        {
                            display.Visible = true; exetable.Visible = false;
                            s1.Visible = false; s2.Visible = true;
                        }
                        if (accept == "1" && noaccept == "0" && submit == "0")
                        {
                            display.Visible = true; exetable.Visible = true; display1.Visible = true;
                            s1.Visible = true; s2.Visible = false;
                        }
                        if ((Convert.ToInt32(submit) > 0) && noaccept == "0" && accept == "0")
                        {
                            if (ti.OnceSubmit == 1)
                            {
                                display.Visible = true; exetable.Visible = true; display1.Visible = true;
                                s1.Visible = true; s2.Visible = false;
                            }
                        }
                    }

                }
            }
        }

        private Hashtable GetTasks_UserHash(IList list)
        {
            Hashtable ht = new Hashtable();
            int i=0, j=0, m=0;
            foreach (object obj in list)
            {
                Tasks_UserInfo tui = obj as Tasks_UserInfo;
                if (tui.WorkTag == -1)
                    i = 1;
                if (tui.WorkTag == 1)
                    j = 1;
                if (tui.WorkTag == 2)
                    m++;
            }
            ht.Add("noaccept", i + "");
            ht.Add("accept", j + "");
            ht.Add("submit", m + "");
            return ht;
        }

        private void ListShow()
        {
            SqlParameter rid = new SqlParameter();
            rid.ParameterName = "@uid";
            rid.Size = 50;
            rid.Value = Uid;

            SqlParameter sqlpt0 = new SqlParameter();
            sqlpt0.Direction = ParameterDirection.Output;
            sqlpt0.ParameterName = "@pt0";
            sqlpt0.Size = 7;

            SqlParameter sqlpt1 = new SqlParameter();
            sqlpt1.Direction = ParameterDirection.Output;
            sqlpt1.ParameterName = "@pt1";
            sqlpt1.Size = 7;

            SqlParameter sqlpt2 = new SqlParameter();
            sqlpt2.Direction = ParameterDirection.Output;
            sqlpt2.ParameterName = "@pt2";
            sqlpt2.Size = 7;

            SqlParameter sqlpt3 = new SqlParameter();
            sqlpt3.Direction = ParameterDirection.Output;
            sqlpt3.ParameterName = "@pt3";
            sqlpt3.Size = 7;


            SqlParameter[] sqls = { sqlpt0, sqlpt1, sqlpt2, sqlpt3, rid };
            MsSqlOperate.ExecuteNonQuery(CommandType.StoredProcedure, "Tasks_GetTaskCount", sqls);

            t_all.InnerText = sqlpt0.Value + "";
            t_exeute.InnerText = sqlpt1.Value + "";
            t_manage.InnerText = sqlpt2.Value + "";
            t_create.InnerText = sqlpt3.Value + "";
        }

        private void DetailShow()
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

        private void RptShow()
        {
            IList list = Tasks_User.Init().GetAll("TaskID=" + ti.id, "order by WorkTag desc,id desc");
            rpt.DataSource = list;
            rpt.DataBind();
        }

        protected void RowDataBind(object sender, RepeaterItemEventArgs e)
        {
            LinkButton lb = e.Item.FindControl("lb") as LinkButton;
            Panel pa = e.Item.FindControl("pa") as Panel;
            Panel pa1 = e.Item.FindControl("pa1") as Panel;
            Label lab1 = e.Item.FindControl("lab1") as Label;

            lb.Visible = false; pa.Visible = false;
            string worktag = lb.CommandArgument.Split(',')[0];
            string userid = lb.CommandArgument.Split(',')[1];
            lab1.Visible = true; 
            if (worktag == "2")
            {
                lab1.Text = "<span style='color:#999'>(Sorry，该任务设置禁止了 查看其他人的执行情况!)</span>";
                if ((ti.IsOtherSee == 1) || ti.ManageUserList.Contains("#" + Uid + "#") || (Uid == userid))
                {
                    pa.Visible = true;
                    pa1.Visible = true;
                    lab1.Visible = false;
                }
            }
            else
                lab1.Text = "<span style='color:#999'>(执行者没有接收任务 或 没有提交执行情况!)</span>";
        }

        protected void Accept_Btn(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["tid"]))
            {
                string t = Request.QueryString["tid"];
                TasksInfo ti = WC.BLL.Tasks.Init().GetById(Convert.ToInt32(t));
                IList list = Tasks_User.Init().GetAll("TaskID=" + ti.id + " and UserID=" + Uid + " and WorkTag=-1", null);
                if (list.Count == 1)
                {
                    Tasks_UserInfo tui = list[0] as Tasks_UserInfo;
                    tui.WorkTag = 1;
                    tui.AddTime = DateTime.Now.ToString("yy-M-dd HH:mm");
                    Tasks_User.Init().Update(tui);

                    ti.UpdateTime = DateTime.Now.ToString("yy-M-dd HH:mm");

                    ti.Records += "<font color='#2828ff'>[执行者]</font> <strong>" + RealName + "(" + DepName + ")</strong> 在 "
                        + WC.Tool.Utils.ConvertDate3(DateTime.Now)
                        + " 操作：<font color='#2828ff'>接收了任务!</font> <br><br>";

                    WC.BLL.Tasks.Init().Update(ti);

                    string words = HttpContext.Current.Server.HtmlEncode("您好!操作成功,任务已接收!");
                    Response.Redirect("/InfoTip/Operate_Success.aspx?returnpage="
                    + Request.Url.AbsoluteUri + "&tip=" + words);

                }
            }

        }

        protected void Submit_Btn(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["tid"]))
            {
                string t = Request.QueryString["tid"];
                TasksInfo ti = WC.BLL.Tasks.Init().GetById(Convert.ToInt32(t));
                IList list = Tasks_User.Init().GetAll("TaskID=" + ti.id + " and UserID=" + Uid + " and WorkTag=1", null);
                if (list.Count == 1)
                {
                    Tasks_UserInfo tui = list[0] as Tasks_UserInfo;
                    tui.WorkTag = 2;
                    tui.AddTime = DateTime.Now.ToString("yy-M-dd HH:mm");

                    tui.TaskID = ti.id;
                    tui.RealName = RealName;
                    tui.UserID = Convert.ToInt32(Uid);
                    tui.DepName = DepName;

                    tui.FilePath = UpdateFiles();
                    tui.WorkTitle = Request.Form["WorkTitle"];
                    tui.WorkNotes = Request.Form["Bodys"];
                    tui.Instruction = "";

                    Tasks_User.Init().Update(tui);

                    ti.UpdateTime = DateTime.Now.ToString("yy-M-dd HH:mm");

                    ti.Records += "<font color='#2828ff'>[执行者]</font> <strong>" + RealName + "(" + DepName + ")</strong> 在 "
                        + WC.Tool.Utils.ConvertDate3(DateTime.Now)
                        + " 操作：<font color='#006600'>首次提交了执行情况!</font> <br><br>";

                    WC.BLL.Tasks.Init().Update(ti);

                    string words = HttpContext.Current.Server.HtmlEncode("您好!操作成功,执行情况已提交!");
                    Response.Redirect("/InfoTip/Operate_Success.aspx?returnpage="
                    + Request.Url.AbsoluteUri + "&tip=" + words);
                }
                else
                {
                    Tasks_UserInfo tui = new Tasks_UserInfo();
                    tui.WorkTag = 2;
                    tui.AddTime = DateTime.Now.ToString("yy-M-dd HH:mm");

                    tui.TaskID = ti.id;
                    tui.RealName = RealName;
                    tui.UserID = Convert.ToInt32(Uid);
                    tui.DepName = DepName;

                    tui.FilePath = UpdateFiles();
                    tui.WorkTitle = Request.Form["WorkTitle"];
                    tui.WorkNotes = Request.Form["Bodys"];
                    tui.Instruction = "";
                    Tasks_User.Init().Add(tui);

                    ti.UpdateTime = DateTime.Now.ToString("yy-M-dd HH:mm");

                    ti.Records += "<font color='#2828ff'>[执行者]</font> <strong>" + RealName + "(" + DepName + ")</strong> 在 "
                        + WC.Tool.Utils.ConvertDate3(DateTime.Now)
                        + " 操作：<font color='#006600'>提交了执行情况!</font> <br><br>";

                    WC.BLL.Tasks.Init().Update(ti);

                    string words = HttpContext.Current.Server.HtmlEncode("您好!操作成功,执行情况已提交!");
                    Response.Redirect("/InfoTip/Operate_Success.aspx?returnpage="
                    + Request.Url.AbsoluteUri + "&tip=" + words);
                }
            }

        }

        protected void ReStart_Btn(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["tid"]))
            {
                string t = Request.QueryString["tid"];
                TasksInfo ti = WC.BLL.Tasks.Init().GetById(Convert.ToInt32(t));
                ti.Status = 1;
                ti.UpdateTime = DateTime.Now.ToString("yy-M-dd HH:mm");

                ti.Records += "<font color='#ff0000'>[管理者]</font> <strong>" + RealName + "(" + DepName + ")</strong> 在 "
                    + WC.Tool.Utils.ConvertDate3(DateTime.Now)
                    + " 操作：<strong style='color:#ff0000'>任务重新启动!</strong> <br><br>";

                WC.BLL.Tasks.Init().Update(ti);

                string words = HttpContext.Current.Server.HtmlEncode("您好!操作成功,任务已重新启动!");
                Response.Redirect("/InfoTip/Operate_Success.aspx?returnpage="
                + Request.Url.AbsoluteUri + "&tip=" + words);
            }
        }

        protected void Stop_Btn(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["tid"]))
            {
                string t = Request.QueryString["tid"];
                TasksInfo ti = WC.BLL.Tasks.Init().GetById(Convert.ToInt32(t));
                ti.Status = -1;
                ti.UpdateTime = DateTime.Now.ToString("yy-M-dd HH:mm");

                ti.Records += "<font color='#ff0000'>[管理者]</font> <strong>" + RealName + "(" + DepName + ")</strong> 在 "
                    + WC.Tool.Utils.ConvertDate3(DateTime.Now)
                    + " 操作：<strong>任务停止!</strong> <br><br>";

                WC.BLL.Tasks.Init().Update(ti);

                string words = HttpContext.Current.Server.HtmlEncode("您好!操作成功,任务已停止!");
                Response.Redirect("/InfoTip/Operate_Success.aspx?returnpage="
                + Request.Url.AbsoluteUri + "&tip=" + words);
            }
        }

        protected void Complete_Btn(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["tid"]))
            {
                string t = Request.QueryString["tid"];
                TasksInfo ti = WC.BLL.Tasks.Init().GetById(Convert.ToInt32(t));
                ti.Status = 2;
                ti.UpdateTime = DateTime.Now.ToString("yy-M-dd HH:mm");

                ti.Records += "<font color='#ff0000'>[管理者]</font> <strong>" + RealName + "(" + DepName + ")</strong> 在 "
                    + WC.Tool.Utils.ConvertDate3(DateTime.Now)
                    + " 操作：<strong style='color:#006600'>任务完成!</strong> <br><br>";

                WC.BLL.Tasks.Init().Update(ti);

                string words = HttpContext.Current.Server.HtmlEncode("您好!操作成功,任务已完成!");
                Response.Redirect("/InfoTip/Operate_Success.aspx?returnpage="
                + Request.Url.AbsoluteUri + "&tip=" + words);
            }
        }

        protected string GetWorkTag(object obj)
        {
            string r = "";
            switch (obj + "")
            {
                case "-1": r = "<strong style='color:#0055ff'>× 未接收</strong>"; break;
                case "1": r = "<strong style='color:#006600'>√ 已接收</strong>"; break;
                case "2": r = "<strong style='color:#ff0000'>√ 已提交</strong>"; break;
                default: r = ""; break;
            }
            return r;
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

        //上传所有附件,并返回 文件保存位置字符串集合
        private string UpdateFiles()
        {
            string fnames = "";
            System.Web.HttpFileCollection files = System.Web.HttpContext.Current.Request.Files;

            //得到或创建 上传目录
            string timeFolder = DateTime.Now.ToString("yyMMdd");
            string path = Server.MapPath("~/Files/OfficeFiles/");
            string tmp = "~/Files/OfficeFiles/" + timeFolder + "/";
            path += timeFolder;
            if (!Directory.Exists(path))
            {
                WC.Tool.FileSystemManager.CreateFolder(timeFolder, Server.MapPath("~/Files/OfficeFiles"));
            }

            try
            {
                string old = "";

                for (int i = 0; i < files.Count; i++)
                {
                    System.Web.HttpPostedFile f = files[i];
                    if (WC.Tool.Config.IsValidFile(f))
                    {
                        string fileName = Path.GetFileName(f.FileName);
                        string name = tmp + fileName;
                        string doc = path + "\\" + fileName;
                        if (File.Exists(doc))
                        {
                            string rd = DateTime.Now.ToString("HHmmssfff") + WC.Tool.Utils.CreateRandomStr(3) + Uid + i;
                            doc = path + "\\" + rd + "@" + WC.Tool.Utils.GetFileExtension(fileName);
                            name = tmp + rd + "@" + WC.Tool.Utils.GetFileExtension(fileName);
                        }

                        f.SaveAs(doc);
                        fnames += name + "|";
                    }
                }
                fnames = old + fnames;

            }
            catch (IOException ex)
            {
                throw ex;
            }

            return fnames;
        }

    }
}