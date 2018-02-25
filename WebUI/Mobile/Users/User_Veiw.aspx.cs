﻿using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using WC.Model;
using WC.BLL;

namespace WC.WebUI.Mobile.Users
{
    public partial class User_Veiw : WC.BLL.MobilePage
    {
        protected string fjs = "";
        protected string fj = "<span>{1}</span> &nbsp;&nbsp;&nbsp;&nbsp;<a href='/Manage/Utils/Download.aspx?destFileName={0}' ><img src='/img/mail_attachment.gif' />下载档案</a><br>";
        protected string Sex, Birthday, Phone, Tel, Notes, Status, JoinTime, DirectSupervisor, HomeAddress, Email, QQ, ImageUrl="";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["uid"]))
            {
                Show(Request.QueryString["uid"]);
            }

        }

        private void Show(string uid)
        {
            Sys_UserInfo su = Sys_User.Init().GetById(Convert.ToInt32(uid));
            //UUserName.Text = su.UserName;
            //URealName5.InnerText = su.RealName;
            //UDepName5.InnerText = su.DepName;
            Sex = su.Sex == 0 ? "男" : "女";
            Birthday = GetAges(su.Birthday);
            if (Dk.Help.ValidateMobile(su.Phone))
                Phone= "<a href='wtai://wp/mc;" + su.Phone + "'>" + su.Phone + " (拨号)</a>";
            Tel = su.Tel;
            Notes = su.Notes;
            Status = su.Status == 0 ? "在职" : "离职";
            //MemoShare5.InnerText = su.MemoShare == 0 ? "未启用 日程汇报" : "已启用 日程汇报";

            JoinTime = su.JoinTime;
            DirectSupervisor = su.et5;

            HomeAddress = su.HomeAddress;
            //PositionName5.InnerText = su.PositionName;
            Email = su.Email;
            QQ = su.QQ;
            if (!string.IsNullOrEmpty(su.PerPic))
            {
                if (WC.Tool.Utils.FileExists(Server.MapPath("~/Files/common/" + su.PerPic)))
                    //PerPic.ImageUrl = "~/Files/common/" + su.PerPic;
                    //ImageUrl = "~/Files/common/" + su.PerPic;
                    ImageUrl = "../../Files/common/" + su.PerPic;

            }

            if (!string.IsNullOrEmpty(Request.QueryString["type"]) && !string.IsNullOrEmpty(su.et4))
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