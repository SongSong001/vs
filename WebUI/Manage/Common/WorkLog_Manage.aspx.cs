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


namespace WC.WebUI.Manage.Common
{
    public partial class WorkLog_Manage : WC.BLL.ViewPages
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && !string.IsNullOrEmpty(Request.QueryString["wid"]))
            {
                Show(Request.QueryString["wid"]);
            }
            if (!IsPostBack && string.IsNullOrEmpty(Request.QueryString["wid"]))
            {
                Show();
            }
        }

        private void Show()
        {
            Sys_UserInfo ui = Sys_User.Init().GetById(Convert.ToInt32(Uid));
            userlist.Value = ui.et6 + "";
            namelist.Value = ui.et5 + "";

        }

        private void Show(string did)
        {

            if (!string.IsNullOrEmpty(did))
            {
                WorkLogInfo di = WorkLog.Init().GetById(Convert.ToInt32(did));
                ViewState["di"] = di;

                LogTitle.Value = di.LogTitle;
                Bodys.Value = di.Notes;

                userlist.Value = di.ShareUsers;
                namelist.Value = di.namelist;
                addTime.Value = di.AddTime;
                addTime.Disabled = true;

                if (!string.IsNullOrEmpty(di.FilePath))
                {
                    if (di.FilePath.Contains("|"))
                    {
                        Attachword.Visible = true;
                        List<TmpInfo> list = new List<TmpInfo>();
                        string[] array = di.FilePath.Split('|');
                        for (int i = 0; i < array.Length; i++)
                        {
                            if (array[i].Trim() != "")
                            {
                                TmpInfo ti = new TmpInfo();
                                int t = array[i].LastIndexOf('/') + 1;
                                string filename = array[i].Substring(t, array[i].Length - t);
                                string fileurl = array[i].ToString();
                                ti.Tmp1 = array[i];
                                ti.Tmp2 = filename;
                                ti.Tmp3 = fileurl;
                                list.Add(ti);
                            }
                        }
                        rpt.DataSource = list;
                        rpt.DataBind();
                    }
                }

            }
        }

        protected void Save_Btn(object sender, EventArgs e)
        {
            System.Web.HttpFileCollection files = System.Web.HttpContext.Current.Request.Files;
            //int isfile = 0; //文件上传判断为空 (启用)
            int isfile = 1; //文件上传判断为空 (作废 2011.04.24)
            for (int i = 0; i < files.Count; i++)
            {
                System.Web.HttpPostedFile f = files[i];
                if (WC.Tool.Config.IsValidFile(f))
                {
                    isfile++;
                }
            }

            if (!string.IsNullOrEmpty(Request.QueryString["wid"]))
            {
                WorkLogInfo di = ViewState["di"] as WorkLogInfo;
                di.LogTitle = LogTitle.Value;
                di.FilePath = UpdateFiles();
                di.Notes = Bodys.Value;

                di.namelist = namelist.Value;
                di.ShareUsers = userlist.Value;

                di.UpdateTime = DateTime.Now.ToString("yyyy-MM-dd");

                WorkLog.Init().Update(di);
                string words = HttpContext.Current.Server.HtmlEncode("您好!工作汇报已保存成功!");
                Response.Redirect("/InfoTip/Operate_Success.aspx?returnpage="
                + Request.Url.AbsoluteUri + "&tip=" + words);
            }
            else
            {
                WorkLogInfo di = new WorkLogInfo();
                di.AddTime = addTime.Value;
                di.UpdateTime = DateTime.Now.ToString("yyyy-MM-dd");
                di.CreatorDepName = DepName;
                di.CreatorID = Convert.ToInt32(Uid);
                di.CreatorRealName = RealName;
                di.LogTitle = LogTitle.Value;
                di.FilePath = UpdateFiles();
                di.Notes = Bodys.Value;

                di.namelist = namelist.Value;
                di.ShareUsers = userlist.Value;

                WorkLog.Init().Add(di);
                string words = HttpContext.Current.Server.HtmlEncode("您好!工作汇报已保存成功!");
                Response.Redirect("/InfoTip/Operate_Success.aspx?returnpage="
                + Request.Url.AbsoluteUri + "&tip=" + words);


            }

        }

        //上传所有附件,并返回 文件保存位置字符串集合
        private string UpdateFiles()
        {
            string fnames = "";
            System.Web.HttpFileCollection files = System.Web.HttpContext.Current.Request.Files;

            //得到或创建 上传目录
            string timeFolder = DateTime.Now.ToString("yyMMdd");
            string path = Server.MapPath("~/Files/DocsFiles/");
            string tmp = "~/Files/DocsFiles/" + timeFolder + "/";
            path += timeFolder;
            if (!Directory.Exists(path))
            {
                WC.Tool.FileSystemManager.CreateFolder(timeFolder, Server.MapPath("~/Files/DocsFiles"));
            }

            try
            {
                string old = "";
                if (Attachword.Visible == true)
                {
                    foreach (RepeaterItem item in rpt.Items)
                    {
                        HtmlInputCheckBox hick = item.FindControl("chk") as HtmlInputCheckBox;
                        if (hick.Checked)
                        {
                            old += hick.Value + "|";
                        }
                    }
                }

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