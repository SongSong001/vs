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
using WC.DBUtility;
using WC.Tool;

namespace WC.WebUI.Manage.Sys
{
    public partial class HR_Manage : WC.BLL.ViewPages
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["uid"]))
            {
                Show(Request.QueryString["uid"]);
            }
            else
            {
                Response.Write("<script>alert('信息不存在!');window.close();</script>");
            }
        }

        private void Show(string uid)
        {
            Sys_UserInfo su = Sys_User.Init().GetById(Convert.ToInt32(uid));

            IList list1 = SysHR.Init().GetAll("UserID=" + uid, null);
            if (list1.Count > 0)
            {
                SysHRInfo hu = list1[0] as SysHRInfo;
                MinZu.Value = hu.MinZu;
                HuKouXZ.Value = hu.HuKouXZ;
                HuKouSZD.Value = hu.HuKouSZD;

                WorkTime.Value = hu.WorkTime;
                BiYeYX.Value = hu.BiYeYX;
                SchoolTime.Value = hu.SchoolTime;
                XueLi.Value = hu.XueLi;
                ZhuanYe.Value = hu.ZhuanYe;

                SYQMonth.Value = hu.SYQMonth + "";
                ZhuanZhengRQ.Value = WC.Tool.Utils.ConvertDate0(hu.ZhuanZhengRQ);
                HTRQ.Value = hu.HTRQ;
                HTNX.Value = hu.HTNX;

                HuoJiang.Value = hu.HuoJiang;
                ChuFa.Value = hu.ChuFa;
                SFZNO.Value = hu.SFZNO;

                if (!string.IsNullOrEmpty(hu.SFZFilePath))
                {
                    if (hu.SFZFilePath.Contains("|"))
                    {
                        Attachword.Visible = true;
                        List<TmpInfo> list = new List<TmpInfo>();
                        string[] array = hu.SFZFilePath.Split('|');
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
            Sys_UserInfo su = Sys_User.Init().GetById(Convert.ToInt32(Request.QueryString["uid"]));

            IList list1 = SysHR.Init().GetAll("UserID=" + Request.QueryString["uid"], null);
            if (list1.Count > 0)
            {
                SysHRInfo hu = list1[0] as SysHRInfo;
                hu.UserID = su.id;
                hu.UserName = su.UserName;
                hu.RealName = su.RealName;
                hu.DepID = su.DepID;
                hu.DepName = su.DepName;

                hu.MinZu = MinZu.Value;
                hu.HuKouXZ = HuKouXZ.Value;
                hu.HuKouSZD = HuKouSZD.Value;
                hu.WorkTime = WorkTime.Value;
                hu.BiYeYX = BiYeYX.Value;
                hu.SchoolTime = SchoolTime.Value;
                hu.XueLi = XueLi.Value;
                hu.ZhuanYe = ZhuanYe.Value;

                if (WC.Tool.Utils.IsNumber(SYQMonth.Value))
                {
                    hu.SYQMonth = Convert.ToInt32(SYQMonth.Value);
                }
                if (WC.Tool.Utils.IsDate(ZhuanZhengRQ.Value))
                {
                    hu.ZhuanZhengRQ = Convert.ToDateTime(ZhuanZhengRQ.Value);
                }
                hu.SFZNO = SFZNO.Value;
                hu.SFZFilePath = UpdateFiles();
                hu.HTRQ = HTRQ.Value;
                hu.HTNX = HTNX.Value;
                hu.HuoJiang = HuoJiang.Value;
                hu.ChuFa = ChuFa.Value;

                SysHR.Init().Update(hu);

                Sys_User.Init().Update(su);

            }
            else
            {
                SysHRInfo hu = new SysHRInfo();
                hu.UserID = su.id;
                hu.UserName = su.UserName;
                hu.RealName = su.RealName;
                hu.DepID = su.DepID;
                hu.DepName = su.DepName;

                hu.MinZu = MinZu.Value;
                hu.HuKouXZ = HuKouXZ.Value;
                hu.HuKouSZD = HuKouSZD.Value;
                hu.WorkTime = WorkTime.Value;
                hu.BiYeYX = BiYeYX.Value;
                hu.SchoolTime = SchoolTime.Value;
                hu.XueLi = XueLi.Value;
                hu.ZhuanYe = ZhuanYe.Value;

                DateTime dtt = Convert.ToDateTime("1/1/1753 12:00:00");
                hu.ZhuanZhengRQ = dtt;
                if (WC.Tool.Utils.IsDate(ZhuanZhengRQ.Value))
                {
                    hu.ZhuanZhengRQ = Convert.ToDateTime(ZhuanZhengRQ.Value);
                }

                if (WC.Tool.Utils.IsNumber(SYQMonth.Value))
                {
                    hu.SYQMonth = Convert.ToInt32(SYQMonth.Value);
                }

                hu.SFZNO = SFZNO.Value;
                hu.SFZFilePath = UpdateFiles();
                hu.HTRQ = HTRQ.Value;
                hu.HTNX = HTNX.Value;
                hu.HuoJiang = HuoJiang.Value;
                hu.ChuFa = ChuFa.Value;

                SysHR.Init().Add(hu);

                Sys_User.Init().Update(su);
            }

            string words = HttpContext.Current.Server.HtmlEncode("您好!员工人事资料编辑成功!");
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