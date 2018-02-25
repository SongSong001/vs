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

namespace WC.WebUI.Manage.CRM
{
    public partial class CRM_Manage : WC.BLL.ViewPages
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && !string.IsNullOrEmpty(Request.QueryString["cid"]))
            {
                Show(Request.QueryString["cid"]);
            }
        }

        private void Show(string cid)
        {
            if (!string.IsNullOrEmpty(cid))
            {
                CRMInfo ci = WC.BLL.CRM.Init().GetById(Convert.ToInt32(cid));
                if (ci != null)
                {
                    ViewState["ci"] = ci;

                    CRM_Name.Value = ci.CRM_Name;
                    Tel.Value = ci.Tel;
                    Fax.Value = ci.Fax;
                    Zip.Value = ci.Zip;
                    Address.Value = ci.Address;
                    MainPeople.Value = ci.MainPeople;
                    Position.Value = ci.Position;
                    Product.Value = ci.Product;
                    TypeName.SelectedValue = ci.TypeName;
                    Grade.SelectedValue = ci.Grade;
                    QQ.Value = ci.QQ;
                    Site.Value = ci.Site;
                    Email.Value = ci.Email;

                    if (ci.IsShare == 1)
                    {
                        IsShare.SelectedIndex = 1;
                        tr.Attributes["style"] = "";
                        userlist.Value = ci.ShareUsers;
                        namelist.Value = ci.namelist;

                    }

                    Notes.Value = ci.Notes;

                    if (!string.IsNullOrEmpty(ci.FilePath))
                    {
                        if (ci.FilePath.Contains("|"))
                        {
                            Attachword.Visible = true;
                            List<TmpInfo> list = new List<TmpInfo>();
                            string[] array = ci.FilePath.Split('|');
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
        }

        protected void Save_Btn(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["cid"]))
            {
                CRMInfo ci = ViewState["ci"] as CRMInfo;
                if (ci != null)
                {
                    if (ci.CreatorID == Convert.ToInt32(Uid))
                    {
                        ci.UpdateTime = DateTime.Now;
                        ci.Address = Address.Value;
                        ci.CRM_Name = CRM_Name.Value;
                        ci.Fax = Fax.Value;
                        ci.FilePath = UpdateFiles();
                        ci.Grade = Grade.SelectedValue;
                        ci.MainPeople = MainPeople.Value;
                        ci.Notes = Notes.Value;
                        ci.Position = Position.Value;
                        ci.Product = Product.Value;
                        ci.Tel = Tel.Value;
                        ci.TypeName = TypeName.SelectedValue;
                        ci.Zip = Zip.Value;
                        ci.QQ = QQ.Value;
                        ci.Site = Site.Value;
                        ci.Email = Email.Value;

                        if (IsShare.Value == "1")
                        {
                            ci.IsShare = 1;
                            ci.namelist = namelist.Value;
                            ci.ShareUsers = userlist.Value;
                        }
                        else
                        {
                            ci.IsShare = 0;
                            ci.namelist = "";
                            ci.ShareUsers = "";
                        }

                        WC.BLL.CRM.Init().Update(ci);

                        string sql = "update CRM_Contact set CRM_Name='" + ci.CRM_Name + "' where cid=" + ci.id;
                        MsSqlOperate.ExecuteNonQuery(CommandType.Text, sql);

                        string words = HttpContext.Current.Server.HtmlEncode("您好!客户信息已保存成功!");
                        Response.Redirect("/InfoTip/Operate_Success.aspx?returnpage="
                        + Request.Url.AbsoluteUri + "&tip=" + words);
                    }

                }

            }
            else
            {
                CRMInfo ci = new CRMInfo();
                ci.CreatorDepName = DepName;
                ci.CreatorRealName = RealName;
                ci.CreatorID = Convert.ToInt32(Uid);
                ci.AddTime = DateTime.Now;
                ci.UpdateTime = DateTime.Now;
                ci.Address = Address.Value;
                ci.CRM_Name = CRM_Name.Value;
                ci.Fax = Fax.Value;
                ci.FilePath = UpdateFiles();
                ci.Grade = Grade.SelectedValue;
                ci.MainPeople = MainPeople.Value;
                ci.Notes = Notes.Value;
                ci.Position = Position.Value;
                ci.Product = Product.Value;
                ci.Tel = Tel.Value;
                ci.TypeName = TypeName.SelectedValue;
                ci.Zip = Zip.Value;
                ci.QQ = QQ.Value;
                ci.Site = Site.Value;
                ci.Email = Email.Value;

                if (IsShare.Value == "1")
                {
                    ci.IsShare = 1;
                    ci.namelist = namelist.Value;
                    ci.ShareUsers = userlist.Value;
                }
                else
                {
                    ci.IsShare = 0;
                    ci.namelist = "";
                    ci.ShareUsers = "";
                }
                WC.BLL.CRM.Init().Add(ci);
                string words = HttpContext.Current.Server.HtmlEncode("您好!客户信息已添加成功!");
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
            string path = Server.MapPath("~/Files/CRMFiles/");
            string tmp = "~/Files/CRMFiles/" + timeFolder + "/";
            path += timeFolder;
            if (!Directory.Exists(path))
            {
                WC.Tool.FileSystemManager.CreateFolder(timeFolder, Server.MapPath("~/Files/CRMFiles"));
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
