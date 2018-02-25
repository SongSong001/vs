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
using WC.DBUtility;

namespace WC.WebUI.Mobile.AddrBook
{
    public partial class PublicAddrBook_Dep : WC.BLL.MobilePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                Show();
        }

        private void Show()
        {
            IList list = Sys_Dep.Init().GetAll(null, "order by orders asc,phone desc");
            rpt.DataSource = list;
            rpt.DataBind();

            num1.InnerHtml = list.Count.ToString();
        }
    }
}