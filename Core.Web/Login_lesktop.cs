using Core;
using Core.IO;
using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using WC.DBUtility;

public class Login_lesktop : WC.BLL.ViewPages
{
    private static string[] UserDirs = new string[] { "Config", "Home", "pub", "Temp" };

    protected void Page_Load(object sender, EventArgs e)
    {
        string sessionId = Guid.NewGuid().ToString().ToUpper();

        foreach (string dir in UserDirs)
        {
            string path = string.Format("/{0}/{1}", UserName, dir);
            if (!Directory.Exists(path))
            {
                Directory.CreateDirectory(path);
            }
        }
        (this.FindControl("status") as HtmlInputHidden).Value = "login";
        (this.FindControl("data") as HtmlInputHidden).Value = Utility.RenderHashJson(new object[] { "UserInfo", AccountImpl.Instance.GetUserInfo(UserName).DetailsJson });
        ServerImpl.Instance.Login(sessionId, this.Context, UserName, null);

        (this.FindControl("sessionId") as HtmlInputHidden).Value = sessionId;
    }
}