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


namespace WC.WebUI.Install
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (WC.Tool.Config.CheckInstall())
            {
                //Response.Write("<script>window.location='../Default.aspx'</script>");
                Response.Redirect("~/Default.aspx");
            }
        }

        protected void Refuse_btn(object sender, EventArgs e)
        {

        }

        protected void Accept_btn(object sender, EventArgs e)
        {
            Response.Redirect("Prepare.aspx");
        }
    }
}
