using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

namespace WC.WebUI.InfoTip
{
    public partial class Operate_Redirect : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["url"]) && !string.IsNullOrEmpty(Request.QueryString["type"]))
            {
                string url = Request.QueryString["url"];
                string type = Request.QueryString["type"];
                if (type == "1")
                {
                    string sc = "<script>if(window.parent !=null){window.parent.location='/Manage/Login.aspx?ReturnUrl="
                + url + "';}else{window.location='/Manage/Login.aspx?ReturnUrl="
                + url + "';}</script>";
                    Response.Write(sc);
                    return;
                }
                if (type == "2")
                {
                    string sc = "<script>if(window.parent !=null){window.parent.location='/InfoTip/Operate_Nologin.aspx?ReturnUrl="
                + url + "';}else{window.location='/InfoTip/Operate_Nologin.aspx?ReturnUrl="
                + url + "';}</script>";
                    Response.Write(sc);
                    return;
                }

                if (type == "3")
                {
                    string sc = "<script>if(window.parent !=null){window.parent.location='/Mobile/Login.aspx?ReturnUrl="
                + url + "';}else{window.location='/Mobile/Login.aspx?ReturnUrl="
                + url + "';}</script>";
                    Response.Write(sc);
                    return;
                }

            }

        }
    }
}
