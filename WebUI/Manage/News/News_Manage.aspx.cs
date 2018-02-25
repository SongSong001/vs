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

namespace WC.WebUI.Manage.News
{
    public partial class News_Manage : WC.BLL.ModulePages
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                Show();
        }

        private void Show()
        {
            if (!string.IsNullOrEmpty(Request.QueryString["nid"]))
            {
                News_ArticleInfo na = News_Article.Init().GetById(Convert.ToInt32(Request.QueryString["nid"]));
                //ViewState["na"] = na;

                NewsTitle.Value = na.NewsTitle;
                Bodys.Value = na.Notes;
                ComID.SelectedValue = na.ComID + "";
                if (na.ShareDeps != "")
                {
                    sel.SelectedIndex = 1;
                    tr.Attributes["style"] = "";
                    userlist_dep.Value = na.ShareDeps;
                    namelist_dep.Value = na.namelist;
                }
                TypeID.SelectedValue = na.TypeID + "";

                if (!string.IsNullOrEmpty(na.FilePath))
                {
                    if (na.FilePath.Contains("|"))
                    {
                        Attachword.Visible = true;
                        List<TmpInfo> list = new List<TmpInfo>();
                        string[] array = na.FilePath.Split('|');
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
            IList list_type = News_Type.Init().GetAll(null, null);
            TypeID.DataTextField = "TypeName";
            TypeID.DataValueField = "id";
            TypeID.DataSource = list_type;
            TypeID.DataBind();

        }

        protected void Save_Btn(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["nid"]))
            {
                News_ArticleInfo na = News_Article.Init().GetById(Convert.ToInt32(Request.QueryString["nid"]));
                na.FilePath = UpdateFiles();
                na.NewsTitle = NewsTitle.Value;
                na.Notes = Bodys.Value;
                na.ShareDeps = userlist_dep.Value.Trim();
                na.namelist = namelist_dep.Value;
                na.TypeID = Convert.ToInt32(Request.Form["TypeID"]);
                na.AddTime = DateTime.Now;
                na.ComID = Convert.ToInt32(ComID.SelectedValue);
                News_Article.Init().Update(na);
            }
            else
            {
                News_ArticleInfo na = new News_ArticleInfo();
                na.AddTime = DateTime.Now;
                na.CreatorDepName = DepName;
                na.CreatorID = Convert.ToInt32(Uid);
                na.CreatorRealName = RealName;
                na.FilePath = UpdateFiles();
                na.NewsTitle = NewsTitle.Value;
                na.Notes = Bodys.Value;
                na.ShareDeps = userlist_dep.Value.Trim();
                na.namelist = namelist_dep.Value;
                na.TypeID = Convert.ToInt32(Request.Form["TypeID"]);
                na.ComID = Convert.ToInt32(ComID.SelectedValue);
                News_Article.Init().Add(na);

                if (IsSms.Checked)
                {
                    if (na.ShareDeps.Contains("#") && na.ShareDeps.Contains(","))
                    {
                        string[] arr = na.ShareDeps.Split(',');
                        List<string> phonelist = new List<string>();
                        for (int i = 0; i < arr.Length; i++)
                        {
                            if (arr[i].Contains("#"))
                            {
                                string sms_did = arr[i].Split('#')[1];
                                IList list_user = Sys_User.Init().GetAll("depid=" + sms_did, "id desc");

                                foreach (object j in list_user)
                                {
                                    Sys_UserInfo sms_ui = j as Sys_UserInfo;
                                    if (Dk.Help.ValidateMobile(sms_ui.Phone))
                                    {
                                        phonelist.Add(sms_ui.Phone);
                                    }
                                }
                            }
                        }
                        if (phonelist.Count > 0)
                        {
                            //短信发送
                            Dk.Help.NewsMobleSend(phonelist, na.NewsTitle);
                        }

                    }
                    if (na.ShareDeps.Trim() == "")
                    {
                        IList list_user = Sys_User.Init().GetAll(null, "id desc");
                        List<string> phonelist = new List<string>();
                        foreach (object j in list_user)
                        {
                            Sys_UserInfo sms_ui = j as Sys_UserInfo;
                            if (Dk.Help.ValidateMobile(sms_ui.Phone))
                            {
                                phonelist.Add(sms_ui.Phone);
                            }
                        }
                        if (phonelist.Count > 0)
                        {
                            //短信发送
                            Dk.Help.NewsMobleSend(phonelist, na.NewsTitle);
                        }
                    }
                }

            }
            string words = HttpContext.Current.Server.HtmlEncode("您好!资讯已保存成功!");
            Response.Redirect("/InfoTip/Operate_Success.aspx?returnpage="
            + Request.Url.AbsoluteUri + "&tip=" + words);

        }

        //上传所有附件,并返回 文件保存位置字符串集合
        private string UpdateFiles()
        {
            string fnames = "";
            System.Web.HttpFileCollection files = System.Web.HttpContext.Current.Request.Files;

            //得到或创建 上传目录
            string timeFolder = DateTime.Now.ToString("yyMMdd");
            string path = Server.MapPath("~/Files/NewsFiles/");
            string tmp = "~/Files/NewsFiles/" + timeFolder + "/";
            path += timeFolder;
            if (!Directory.Exists(path))
            {
                WC.Tool.FileSystemManager.CreateFolder(timeFolder, Server.MapPath("~/Files/NewsFiles"));
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
                    if(WC.Tool.Config.IsValidFile(f))
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
