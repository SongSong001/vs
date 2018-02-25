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

namespace WC.WebUI.Manage
{
    public partial class LoginOut : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HttpCookie cookie = new HttpCookie("UserCookies");
            HttpContext.Current.Response.AppendCookie(cookie);

            HttpCookie bbs_cookie = new HttpCookie("DXBBS");
            HttpContext.Current.Response.AppendCookie(bbs_cookie);

            //会话结束时 更新在线名单
            if (!string.IsNullOrEmpty(HttpContext.Current.Session["UserCookies"] + ""))
            {
                string strcookie = HttpContext.Current.Session["UserCookies"] + "";
                if (strcookie.Contains("|"))
                {
                    string Uid = strcookie.Split('|')[0];

                    List<WC.Model.Sys_UserInfo> online_ht = Application["user_online"] as List<WC.Model.Sys_UserInfo>;
                    if (online_ht != null)
                    {
                        online_ht.Find(
                            delegate(WC.Model.Sys_UserInfo s)
                            {
                                if (s.id.ToString() == Uid)
                                {
                                    s.IsOnline = 0;
                                    return true;
                                }
                                else return false;
                            }
                        );
                    }
                }
            }

            HttpContext.Current.Session.Abandon();

            HttpCookie cookie_Lesktop = new HttpCookie("Lesktop", "");
            cookie_Lesktop.Expires = DateTime.Now.AddDays(-7.0);
            HttpContext.Current.Response.Cookies.Add(cookie_Lesktop);

            if (!string.IsNullOrEmpty(Request.QueryString["action"]))
            {
                Response.Write("<script>if(window.parent !=null){ alert('您已安全注销，退出本系统！'); window.parent.location='Login.aspx';  } </script>");
            }
            else
            {
                Response.Redirect("Login.aspx");
            }

        }
    }
}
