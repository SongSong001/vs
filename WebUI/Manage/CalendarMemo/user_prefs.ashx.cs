using System;
using System.Collections;
using System.Data;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;


namespace WC.WebUI.limagan.cal
{
    /// <summary>
    /// $codebehindclassname$ 的摘要说明
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class user_prefs : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/javascript";
            context.Response.Charset = "utf-8";
            context.Response.Cache.SetCacheability(HttpCacheability.NoCache);
            context.Response.Expires = 0;

            string temp = "";
            string myeup = context.Request.Params["eup"];
            if (myeup != null)
            {
                string[] mytempeup = myeup.Split(':');
                temp = @"while(1);[['u',[['" + mytempeup[0] + "','" + mytempeup[1] + "']]],['_ShowMessageUndoable','点击单元格创建 新日程，双击单元格主题编辑 现有日程.']]";
            }

            context.Response.Write(temp);
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
