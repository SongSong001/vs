using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using WC.Model;

namespace WC.WebUI.Manage.Utils
{
    /// <summary>
    /// $codebehindclassname$ 的摘要说明
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class online : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.Charset = "UTF-8";
            context.Response.Cache.SetNoStore();
            string result = "<a onclick=addTab('在线用户','/Manage/Common/User_OnLine.aspx','icon-usergroup') href='#'>在线用户：<strong>{0}</strong> 人</a>";

            IList<Sys_UserInfo> online_ht = HttpContext.Current.Application["user_online"] as IList<Sys_UserInfo>;
            IList<Sys_UserInfo> list = new List<Sys_UserInfo>();
            foreach (object item in online_ht)
            {
                Sys_UserInfo ui = item as Sys_UserInfo;

                if (ui.LastLoginTime.AddMinutes(60) < DateTime.Now)
                {
                    ui.IsOnline = 0;
                }

                if (ui.IsOnline == 1)
                    list.Add(ui);

            }

            context.Response.Write(string.Format(result, list.Count));
            context.Response.End();
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}
