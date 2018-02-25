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

namespace WC.WebUI.Manage.CRM
{
    public partial class CRM_Contact_View : WC.BLL.ViewPages
    {
        protected string c = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["cid"]))
                c = Request.QueryString["cid"];    
            if (!IsPostBack && !string.IsNullOrEmpty(Request.QueryString["ctid"]))
            {
                Show(Request.QueryString["ctid"]);
            }
        }

        private void Show(string ctid)
        {
            CRM_ContactInfo cti = CRM_Contact.Init().GetById(Convert.ToInt32(ctid));
            CRM_Name1.InnerText = cti.CRM_Name;
            ContactAim.Text = cti.ContactAim;
            ContactPeople.Text = cti.ContactPeople;
            AddTime.Text = WC.Tool.Utils.ConvertDate3(cti.AddTime);
            ContactType.Text = cti.ContactType;
            ContactCharge.Text = cti.ContactCharge;
            ContactChargeType.Text = cti.ContactChargeType;
            ContactDetail.Text = cti.ContactDetail;
            ContactState.Text = "[" + cti.ContactState + "]";

        }

        protected string GetGrade(object obj)
        {
            string t = obj + "";
            t = t.ToUpper();
            string r = "";
            if (t == "A")
                r = "暂无需求，潜在培养的客户";
            if (t == "B")
                r = "有需求，正在跟进客户";
            if (t == "C")
                r = "短期可签入的客户";
            if (t == "D")
                r = "已签约客户/老客户";
            return r;
        }

    }
}
