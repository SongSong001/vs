using Core;
using System;
using System.Data;
using System.Web.UI;
using WC.DBUtility;

public class Desktop : WC.BLL.ViewPages
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (base.Request.QueryString["auto"] == "true")
        {
            int c = Convert.ToInt32(MsSqlOperate.ExecuteScalar(CommandType.Text, "select count(*) from WM_Users where Name='" + UserName + "'"));

            if (c > 0)
            {
                //string sessionId = Guid.NewGuid().ToString().ToUpper();
                //ServerImpl.Instance.Login(sessionId, this.Context, UserName, null, false);
            }
            else
            {
                Response.Redirect("~/lesktop/datascan.aspx?u=" + UserName);
            }
        }
        if (base.Request.QueryString["signout"] != null)
        {
            ServerImpl.Instance.Logout(this.Context);
        }
    }
}

