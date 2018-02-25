using System;
using System.Collections;
using System.Data;
using System.Data.SqlClient;

using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;

using WC.DBUtility;
using WC.BLL;
using WC.Model;

namespace WC.WebUI.Manage.Utils
{
    /// <summary>
    /// $codebehindclassname$ 的摘要说明
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class Seal : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            //获得URL的值
            string url = "http://" + HttpContext.Current.Request.ServerVariables["HTTP_HOST"].ToString()
                  + HttpContext.Current.Request.ServerVariables["PATH_INFO"].ToString();
            int i = url.LastIndexOf("/");
            url = url.Substring(0, i) + "/";
            url = url.ToLower();
            url = url.Replace("/manage/utils", "");

            context.Response.Charset = "UTF-8";
            context.Response.Cache.SetNoStore();
            string s = context.Request.Params["s"];
            string p = context.Request.Params["p"];
            string result = "";

            if (!string.IsNullOrEmpty(s) && !string.IsNullOrEmpty(p))
            {
                IList list = Sys_Seal.Init().GetAll("id=" + s + " and pwd='" + p + "'", null);
                if (list.Count > 0)
                {
                    Sys_SealInfo si = list[0] as Sys_SealInfo;
                    if (!string.IsNullOrEmpty(si.FilePath))
                    {
                        string f = si.FilePath;
                        result = url + f.Replace("~/", "").Trim();
                    }
                }

            }
            if (result == "")
                result = "1";

            context.Response.Write(result);
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
