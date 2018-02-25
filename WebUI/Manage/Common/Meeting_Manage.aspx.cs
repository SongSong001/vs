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
using System.IO;
using WC.BLL;
using WC.Model;

namespace WC.WebUI.Manage.Common
{
    public partial class Meeting_Manage : WC.BLL.ViewPages
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && !string.IsNullOrEmpty(Request.QueryString["mid"]))
                Show(Request.QueryString["mid"]);
        }

        private void Show(string mid)
        {
            MeetingInfo mi = Meeting.Init().GetById(Convert.ToInt32(mid));
            ViewState["mi"] = mi;
            Bodys.Value = mi.Bodys;
            CTime.Value = mi.CTime;
            Address.Value = mi.Address;
            Recorder.Value = mi.Recorder;
            ListPerson.Value = mi.ListPerson;
            AbsencePerson.Value = mi.AbsencePerson;
            Chaired.Value = mi.Chaired;
            MainTopics.Value = mi.MainTopics;
            Remarks.Value = mi.Remarks;

            if (!string.IsNullOrEmpty(mi.FilePath))
            {
                if (mi.FilePath.Contains("|"))
                {
                    Attachword.Visible = true;
                    List<TmpInfo> list = new List<TmpInfo>();
                    string[] array = mi.FilePath.Split('|');
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

        protected void Save_Btn(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["mid"]))
            {
                MeetingInfo mi = ViewState["mi"] as MeetingInfo;
                mi.AbsencePerson = AbsencePerson.Value;
                mi.Address = Address.Value;
                mi.Bodys = Bodys.Value;
                mi.Chaired = Chaired.Value;
                mi.CTime = CTime.Value;
                mi.FilePath = UpdateFiles();
                mi.ListPerson = ListPerson.Value;
                mi.MainTopics = MainTopics.Value;
                mi.Recorder = Recorder.Value;
                mi.Remarks = Remarks.Value;
                mi.UserID = Convert.ToInt32(Uid);

                Meeting.Init().Update(mi);

                string words = HttpContext.Current.Server.HtmlEncode("您好!会议已保存成功!");
                Response.Redirect("/InfoTip/Operate_Success.aspx?returnpage="
                + "/manage/common/Meeting_List.aspx" + "&tip=" + words);
            }
            else
            {
                MeetingInfo mi = new MeetingInfo();
                mi.AbsencePerson = AbsencePerson.Value;
                mi.Address = Address.Value;
                mi.Bodys = Bodys.Value;
                mi.Chaired = Chaired.Value;
                mi.CTime = CTime.Value;
                mi.FilePath = UpdateFiles();
                mi.ListPerson = ListPerson.Value;
                mi.MainTopics = MainTopics.Value;
                mi.Recorder = Recorder.Value;
                mi.Remarks = Remarks.Value;
                mi.UserID = Convert.ToInt32(Uid);

                Meeting.Init().Add(mi);

                string words = HttpContext.Current.Server.HtmlEncode("您好!会议已保存成功!");
                Response.Redirect("/InfoTip/Operate_Success.aspx?returnpage="
                + "/manage/common/Meeting_List.aspx" + "&tip=" + words);
            }

        }

        //上传所有附件,并返回 文件保存位置字符串集合
        private string UpdateFiles()
        {
            string fnames = "";
            System.Web.HttpFileCollection files = System.Web.HttpContext.Current.Request.Files;

            //得到或创建 上传目录
            string timeFolder = DateTime.Now.ToString("yyMMdd");
            string path = Server.MapPath("~/Files/Common/");
            string tmp = "~/Files/Common/" + timeFolder + "/";
            path += timeFolder;
            if (!Directory.Exists(path))
            {
                WC.Tool.FileSystemManager.CreateFolder(timeFolder, Server.MapPath("~/Files/Common"));
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
