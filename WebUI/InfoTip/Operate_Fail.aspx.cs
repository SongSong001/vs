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
    public partial class Operate_Fail : System.Web.UI.Page
    {
        protected string times = "3";
        protected string return_page = "/Default.aspx";
        protected void Page_Load(object sender, EventArgs e)
        {
            Hashtable page_ht = (Hashtable)HttpContext.Current.Application["stand_config"];
            times = Convert.ToString(page_ht["infotip_refresh"]);
        }
    }
}
