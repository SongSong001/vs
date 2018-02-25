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

namespace WC.WebUI.Manage.Gov
{
    public partial class DocBodyView : WC.BLL.ViewPages
    {
        protected string name = "", dep = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && !string.IsNullOrEmpty(Request.QueryString["gid"]))
            {
                Gov_DocInfo gds = Gov_Doc.Init().GetById(Convert.ToInt32(Request.QueryString["gid"]));
                DocBody.Value = gds.DocBody;
                //name = gds.UserRealName;
                //dep = " (" + gds.UserDepName + ")";
            }

            if (!IsPostBack && !string.IsNullOrEmpty(Request.QueryString["fid"]))
            {
                //Flows_DocInfo gds = Flows_Doc.Init().GetById(Convert.ToInt32(Request.QueryString["gid"]));
                GovInfo fi = WC.BLL.Gov.Init().GetById(Convert.ToInt32(Request.QueryString["fid"]));
                DocBody.Value = fi.DocBody;
                //name = gds.UserRealName;
                //dep = " (" + gds.UserDepName + ")";
            }

        }
    }
}
