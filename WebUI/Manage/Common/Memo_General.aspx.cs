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


namespace WC.WebUI.Manage.Common
{
    public partial class Memo_General : WC.BLL.ViewPages
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Todo_Btn(object sender, EventArgs ea)
        {
            if (!string.IsNullOrEmpty(Request.Form["StartTime"]) && !string.IsNullOrEmpty(Request.Form["EndTime"]))
            {
                string st = Request.Form["StartTime"].Replace("-", "");
                string et = Request.Form["EndTime"].Replace("-", "");
                int s = Convert.ToInt32(st);
                int e = Convert.ToInt32(et);
                int a = 0, b = 0;
                if (s >= e)
                {
                    a = s;
                    b = e;
                }
                else
                {
                    a = e;
                    b = s;
                }

                Response.Redirect("Memo_Download.aspx?uid=" + Uid + "&s=" + b + "&e=" + a);
            }
        }


    }
}
