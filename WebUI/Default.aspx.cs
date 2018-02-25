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

using WC.BLL;
using WC.Model;
using WC.Tool;

namespace WC.WebUI
{
    public partial class Default : System.Web.UI.Page
    {
        private Bas_ComInfo bi = HttpContext.Current.Application["cominfo"] as Bas_ComInfo;
        protected string et = "1";

        protected void Page_Load(object sender, EventArgs e)
        {
            Config.IsInstall();

            Admin_Help.UpdateApp();
            bi = HttpContext.Current.Application["cominfo"] as Bas_ComInfo;
            if (bi != null)
            {
                if (bi.et3 == 0)
                {
                    et = "0";
                }
            }

        }



    }
}
