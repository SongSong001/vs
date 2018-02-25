namespace Core
{
    using System;
    using System.Web;
    using System.Web.Configuration;

    public class DataBase
    {
        public static string GetSqlServerConnectionString()
        {
            return WebConfigurationManager.OpenWebConfiguration(((HttpContext.Current.Request.ApplicationPath == "/") != null) ? "/Lesktop" : (HttpContext.Current.Request.ApplicationPath + "/Lesktop")).ConnectionStrings.ConnectionStrings["Lesktop_ConnectString"].ConnectionString;
        }
    }
}

