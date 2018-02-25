using System;
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

namespace WC.WebUI.Manage.Sys
{
    public partial class User_View : WC.BLL.ViewPages
    {
        protected string fjs = "";
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
            //UUserName.Text = su.UserName;
            URealName5.InnerText = su.RealName;
            UDepName5.InnerText = su.DepName;
            Sex5.InnerText = su.Sex == 0 ? "男" : "女";
            Birthday5.InnerText = GetAges(su.Birthday);
            Phone5.InnerText = su.Phone;
            Tel5.InnerText = su.Tel;
            Notes5.InnerText = su.Notes;
            Status5.InnerText = su.Status == 0 ? "在职" : "离职";
            MemoShare5.InnerText = su.MemoShare == 0 ? "未启用 日程汇报" : "已启用 日程汇报";

            JoinTime5.InnerText = su.JoinTime;
            DirectSupervisor5.InnerText = su.et5;

            HomeAddress5.InnerText = su.HomeAddress;
            PositionName5.InnerText = su.PositionName;
            Email5.InnerText = su.Email;
            QQ5.InnerText = su.QQ;
            if (!string.IsNullOrEmpty(su.PerPic))
            {
                if (WC.Tool.Utils.FileExists(Server.MapPath("~/Files/common/" + su.PerPic)))
                {
                    PerPic.ImageUrl = "~/Files/common/" + su.PerPic;
                    PerPic.Attributes.Add("onclick", "window.open('" + PerPic.ImageUrl.ToString() + "','_blank')");
                }
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
