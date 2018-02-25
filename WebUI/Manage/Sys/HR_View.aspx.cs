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
    public partial class HR_View : WC.BLL.ViewPages
    {
        protected string fjs = "", fjs1 = "";
        protected string fj = "<span style='font-weight:bold;'>{1}</span> &nbsp;&nbsp;&nbsp;&nbsp;<a href='/Manage/Utils/Download.aspx?destFileName={0}' ><img src='/img/mail_attachment.gif' />下载档案</a><br>";

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

            IList list = SysHR.Init().GetAll("UserID=" + uid, null);

            RealName5.InnerText = su.RealName;
            Sex5.InnerText = su.Sex == 0 ? "男" : "女";
            if (!string.IsNullOrEmpty(su.PerPic))
            {
                if (WC.Tool.Utils.FileExists(Server.MapPath("~/Files/common/" + su.PerPic)))
                {
                    PerPic.ImageUrl = "~/Files/common/" + su.PerPic;
                    PerPic.Attributes.Add("onclick", "window.open('" + PerPic.ImageUrl.ToString() + "','_blank')");
                }
            }
            Birthday5.InnerText = GetAges(su.Birthday);

            UDepName5.InnerText = su.DepName;
            PositionName5.InnerText = su.PositionName;
            Phone5.InnerText = su.Phone;
            Tel5.InnerText = su.Tel;
            Email5.InnerText = su.Email;
            QQ5.InnerText = su.QQ;
            HomeAddress5.InnerText = su.HomeAddress;

            if (!string.IsNullOrEmpty(su.et4))
            {
                if (Modules.Contains("19") || Modules.Contains("20"))
                {
                    if (su.et4.Contains("|"))
                    {
                        string[] array = su.et4.Split('|');
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

            if (list.Count > 0)
            {
                SysHRInfo hu = list[0] as SysHRInfo;

                MinZu5.InnerText = hu.MinZu;
                SFZNO.InnerText = hu.SFZNO;
                HuKouXZ.InnerText = hu.HuKouXZ;
                HuKouSZD.InnerText = hu.HuKouSZD;
                BiYeYX.InnerText = hu.BiYeYX;
                SchoolTime.InnerText = hu.SchoolTime;
                WorkTime.InnerText = hu.WorkTime;
                XueLi.InnerText = hu.XueLi;
                ZhuanYe.InnerText = hu.ZhuanYe;

                ZhuanZhengRQ.InnerText = WC.Tool.Utils.ConvertDate0(hu.ZhuanZhengRQ);


                SYQMonth.InnerText = hu.SYQMonth + "";
                HTNX.InnerText = hu.HTNX;
                HTRQ.InnerText = hu.HTRQ;
                HuoJiang.InnerHtml = hu.HuoJiang.Replace("\r\n", "<br>");
                ChuFa.InnerHtml = hu.ChuFa.Replace("\r\n", "<br>");
                JoinTime5.InnerText = su.JoinTime;

                if (!string.IsNullOrEmpty(hu.SFZFilePath))
                {
                    if (Modules.Contains("19") || Modules.Contains("20"))
                    {
                        if (hu.SFZFilePath.Contains("|"))
                        {
                            string[] array = hu.SFZFilePath.Split('|');
                            for (int i = 0; i < array.Length; i++)
                            {
                                if (array[i].Trim() != "")
                                {
                                    int t = array[i].LastIndexOf('/') + 1;
                                    string filename = array[i].Substring(t, array[i].Length - t);
                                    string fileurl = array[i].ToString();

                                    fjs1 += string.Format(fj, Server.UrlEncode(fileurl), filename);

                                }
                            }
                        }

                    }
                }
            }



        }

        private string GetAges(object obj)
        {
            string str = "";
            if (obj != null)
            {
                if (!string.IsNullOrEmpty(Convert.ToString(obj)))
                {
                    str = " (" + WC.Tool.Utils.GetAgeByDatetime(obj) + ")";
                }
            }
            return str;
        }

    }
}