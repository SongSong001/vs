using System;
using System.Collections.Generic;

using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WC.WebUI.Mobile.Utils
{
    public partial class Redirect : WC.BLL.MobilePage
    {
        protected string return_page = "", tip = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["p"]))
            {
                return_page = Request.QueryString["p"];
                tip = Request.QueryString["t"];
            }
        }
    }
}