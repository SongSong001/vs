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
    public class caldetails : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/javascript";
            context.Response.Charset = "UTF-8";
            context.Response.Cache.SetCacheability(HttpCacheability.NoCache);
            context.Response.Expires = 0;
            string mytemp = "";
            context.Response.Write(mytemp);
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
