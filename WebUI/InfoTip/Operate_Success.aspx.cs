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
    public partial class Operate_Success : System.Web.UI.Page
    {
        protected string times = "3";
        protected string return_page = "#";
        protected string tip = "您刚才的操作已成功完成";
        protected void Page_Load(object sender, EventArgs e)
        {
            Hashtable page_ht = (Hashtable)HttpContext.Current.Application["stand_config"];
            times = Convert.ToString(page_ht["infotip_refresh"]);
            if (!string.IsNullOrEmpty(Request.QueryString["returnpage"]))
            {
                string url = Request.Url.AbsoluteUri;

                if (url.Contains("returnpage=") && url.Contains("&tip="))
                {
                    string tmp = WC.Tool.Utils.SplitString(url, "returnpage=")[1];
                    return_page = WC.Tool.Utils.SplitString(tmp, "&tip=")[0];
                }
                if (url.Contains("returnpage=") && !url.Contains("&tip="))
                    return_page = WC.Tool.Utils.SplitString(url, "returnpage=")[1];
                if (!string.IsNullOrEmpty(Request.QueryString["tip"]))
                {
                    tip = Request.QueryString["tip"];
                }
            }
        }
    }
}
