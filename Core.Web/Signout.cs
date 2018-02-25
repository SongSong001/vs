using Core;
using System;
using System.Configuration;
using System.Web.Configuration;
using System.Web.UI;

public class Signout : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        System.Configuration.Configuration config = WebConfigurationManager.OpenWebConfiguration((base.Request.ApplicationPath == "/") ? "/Lesktop" : (base.Request.ApplicationPath + "/Lesktop"));
        ServerImpl.Instance.Logout(this.Context);
        base.Response.Redirect(config.AppSettings.Settings["DefaultPage"].Value);
    }
}

