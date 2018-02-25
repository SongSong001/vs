using System;
using System.Data;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using WC.Tool;
using WC.Model;
namespace WC.BLL
{
    public class MobilePage : Page
    {
        protected string Uid, UserName, RealName, DepID, DepName, Modules, CurrentLoginTime, px, PositionName;

        public MobilePage()
        {
            Admin_Help.UpdateApp();
            Context.Response.Cache.SetNoStore();
            //IsLoginUser();

            //处理加载事件
            this.Load += new EventHandler(AdminPage_Load);
        }

        void AdminPage_Load(object sender, EventArgs e)
        {
            IsLoginUser();
        }

        private void IsLoginUser()
        {
            string url = Context.Request.Url.AbsoluteUri;

            //利用cookie延长session信息
            if (Context.Request.Cookies["UserCookies"] != null)
            {
                if (Context.Request.Cookies["UserCookies"]["key"] != null)
                {
                    string ts = Context.Request.Cookies["UserCookies"]["key"].ToString();
                    string tcookie = WC.Tool.Encrypt.RC4_Decode(ts, "lazy_oa");
                    if (tcookie.Contains("|"))
                    {
                        if (HttpContext.Current.Session["UserCookies"] == null || string.IsNullOrEmpty(HttpContext.Current.Session["UserCookies"] + ""))
                        {
                            HttpContext.Current.Session["UserCookies"] = tcookie;
                        }
                    }
                }
            }

            // 用户身份登录验证
            if (HttpContext.Current.Session["UserCookies"] == null || string.IsNullOrEmpty(HttpContext.Current.Session["UserCookies"] + ""))
            {

                Context.Response.Redirect("/InfoTip/Operate_Redirect.aspx?type=3&url=" + url);

                return;
            }
            // 通过身份登录验证 
            else
            {
                if (!string.IsNullOrEmpty(HttpContext.Current.Session["UserCookies"] + ""))
                {
                    //操作Cookie
                    string strcookie = HttpContext.Current.Session["UserCookies"] + "";

                    if (strcookie.Contains("|"))
                    {
                        //根据基本配置文件 获取用户cookie有效期限
                        Hashtable page_ht = (Hashtable)HttpContext.Current.Application["stand_config"];
                        //用户cookie有效期限
                        //double user_cookie_delay = Convert.ToDouble(page_ht["user_cookie_delay"]);
                        int user_cookie_delay = Convert.ToInt32(page_ht["user_cookie_delay"]);

                        Uid = strcookie.Split('|')[0];
                        UserName = strcookie.Split('|')[1];
                        RealName = strcookie.Split('|')[2];
                        DepID = strcookie.Split('|')[3];
                        DepName = strcookie.Split('|')[4];
                        Modules = strcookie.Split('|')[5];
                        CurrentLoginTime = strcookie.Split('|')[6];
                        px = strcookie.Split('|')[7];
                        PositionName = strcookie.Split('|')[8];

                        List<Sys_UserInfo> online_ht = HttpContext.Current.Application["user_online"] as List<Sys_UserInfo>;
                        WC.Model.Sys_UserInfo su = null;

                        if (online_ht != null)
                        {
                            online_ht.Find(
                                delegate (Sys_UserInfo s)
                                {
                                    if (s.id.ToString() == Uid)
                                    {
                                        su = s;
                                        return true;
                                    }
                                    else return false;
                                }
                            );
                        }


                        //维护在线用户列表
                        if (su != null)
                        {
                            su.IsOnline = 1;
                            su.LastLoginTime = DateTime.Now;


                            if (!string.IsNullOrEmpty(su.CurrentLoginTime))
                            {
                                if (su.CurrentLoginTime == CurrentLoginTime)
                                {
                                    //维护用户信息
                                    string user_info = strcookie;

                                    HttpContext.Current.Session["UserCookies"] = user_info;

                                }
                            }
                        }

                    }
                    else
                    {
                        Context.Response.Redirect("/InfoTip/Operate_Redirect.aspx?type=3&url=" + url);
                        return;
                    }

                }
                else
                {
                    Context.Response.Redirect("/InfoTip/Operate_Redirect.aspx?type=3&url=" + url);
                    return;

                }


            }

            if (!Utils.IsNumber(Uid + ""))
            {
                Context.Response.Redirect("/InfoTip/Operate_Redirect.aspx?type=3&url=" + url);
                return;
            }


        }

        protected void Page_Error(object sender, EventArgs e)
        {
            Exception ex = Server.GetLastError();

            WC.Tool.ErrorLog.ToTxt(ex,
                Server.MapPath("~/DK_Log/" + DateTime.Now.ToString("yyyy-MM-dd") + ".log"),
                Request.UserHostAddress + "|" + Request.Url);

            if (ex is NullReferenceException)
            {
                Response.Redirect("~/InfoTip/nofind.htm");
            }

            if (ex is HttpRequestValidationException || ex is System.Web.HttpException)
            {
                Server.ClearError();
            }
            else
            {
                Response.Redirect("~/InfoTip/Error.htm");
            }

        }

    }
}
