using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;

namespace WC.WebUI
{
    public class Global : System.Web.HttpApplication
    {
        protected void Application_Start(object sender, EventArgs e)
        {
            WC.BLL.Admin_Help.UpdateApp();
            Dk.Help.SetDXBBSConn();
            //Dk.Help.GlobalOperateSql();
        }

        protected void Session_Start(object sender, EventArgs e)
        {
            //HttpContext.Current.Session.Timeout = 80;
        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

            //foreach (string i in this.Request.Form)
            //{
            //    if (i == "__VIEWSTATE" || i == "__EVENTVALIDATION") continue;
            //    string k = this.Request.Form[i + ""];
            //    if (!WC.Tool.Utils.CheckSql(k))
            //    {
            //        Response.Redirect("~/InfoTip/SqlAttack.htm");
            //        //throw new Exception("Sql注入(POST)：" + this.Request.Url.AbsoluteUri + " IP：" + WC.Tool.RequestUtils.GetIP() + " 时间：" + DateTime.Now);
            //    }
            //}

            //for (int i = 0; i < this.Request.QueryString.Count; i++)
            //{
            //    string t = this.Request.QueryString[i] + "";
            //    if (t.Contains("'"))
            //    {
            //        throw new Exception("请求包含危险字符：" + this.Request.Url.AbsoluteUri + " IP：" + WC.Tool.RequestUtils.GetIP() + " 时间：" + DateTime.Now);
            //    }
            //    //if (!WC.Tool.Utils.CheckSql(t))
            //    //{
            //    //    throw new Exception("Sql注入：" + this.Request.Url.AbsoluteUri + " IP：" + WC.Tool.RequestUtils.GetIP() + " 时间：" + DateTime.Now);
            //    //}
            //}

            if (Request.Url.AbsolutePath.ToLower().Contains(".config"))
            {
                Response.Redirect("Default.aspx");
            }

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {
            //WC.Tool.ErrorLog.ToTxt(Server.GetLastError(),
            //    Server.MapPath("~/DK_Log/" + DateTime.Now.ToString("yyyy-MM-dd") + ".log"),
            //    Request.UserHostAddress + "|" + Request.Url);
            //Server.ClearError();
            //HttpContext.Current.Response.Write("<script>if(window.parent !=null){window.parent.location='/InfoTip/Operate_Fail.aspx"
            //+ "';}else{window.location='/InfoTip/Operate_Fail.aspx"
            //+ "';}</script>");

            Exception ex = Server.GetLastError();
            if (ex is UnauthorizedAccessException)
            {
                Response.Redirect("~/Install/qx.htm");
            }

        }

        protected void Session_End(object sender, EventArgs e)
        {
            //会话结束时 更新在线名单
            System.Collections.Generic.List<WC.Model.Sys_UserInfo> online_ht = Application["user_online"] as System.Collections.Generic.List<WC.Model.Sys_UserInfo>;
            foreach (WC.Model.Sys_UserInfo item in online_ht)
            {
                if (item.LastLoginTime.AddMinutes(60) < DateTime.Now)
                    item.IsOnline = 0;
            }
        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}