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
    public partial class CRM_Contact_Manage : WC.BLL.ViewPages
    {
        protected string c = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["cid"]))
                c = Request.QueryString["cid"];   
            if(!IsPostBack && !string.IsNullOrEmpty(Request.QueryString["cid"]) && !string.IsNullOrEmpty(Request.QueryString["ctid"]))
            {
                Show(Request.QueryString["cid"], Request.QueryString["ctid"]);
            }
            if (!IsPostBack && !string.IsNullOrEmpty(Request.QueryString["cid"]))
            {
                CRMInfo ci = WC.BLL.CRM.Init().GetById(Convert.ToInt32(Request.QueryString["cid"]));
                ViewState["ci"] = ci;
                CRM_Name1.InnerText = ci.CRM_Name;
            }
        }

        protected void Save_Btn(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["cid"]) && !string.IsNullOrEmpty(Request.QueryString["ctid"]))
            {
                CRM_ContactInfo cti = ViewState["cti"] as CRM_ContactInfo;
                if (!string.IsNullOrEmpty(AddTime.Value))
                {
                    cti.AddTime = Convert.ToDateTime(AddTime.Value);
                }
                else
                {
                    cti.AddTime = DateTime.Now;
                }
                cti.cid = Convert.ToInt32(Request.QueryString["cid"]);
                cti.ContactAim = ContactAim.Value;
                cti.ContactCharge = ContactCharge.Value;
                cti.ContactDetail = ContactDetail.Value;
                cti.ContactState = ContactState.SelectedValue;

                string t1 = "";
                for (int i = 0; i < ContactChargeType.Items.Count; i++)
                {
                    if (ContactChargeType.Items[i].Selected)
                    {
                        t1 += ContactChargeType.Items[i].Value;
                    }
                }
                cti.ContactChargeType = "";
                cti.ContactChargeType = t1;
                string t2 = "";
                for (int i = 0; i < ContactType.Items.Count; i++)
                {
                    if (ContactType.Items[i].Selected)
                    {
                        t2 += ContactType.Items[i].Value;
                    }
                }
                cti.ContactType = "";
                cti.ContactType = t2;

                if (ContactPeople.Value.Trim() != "")
                {
                    cti.ContactPeople = ContactPeople.Value;
                }
                else
                {
                    cti.ContactPeople = RealName;
                }

                CRM_Contact.Init().Update(cti);
                string words = HttpContext.Current.Server.HtmlEncode("您好!客户接触已保存成功!");
                Response.Redirect("/InfoTip/Operate_Success.aspx?returnpage="
                + Request.Url.AbsoluteUri + "&tip=" + words);

            }
            if (!string.IsNullOrEmpty(Request.QueryString["cid"]) && string.IsNullOrEmpty(Request.QueryString["ctid"]))
            {
                CRM_ContactInfo cti = new CRM_ContactInfo();
                CRMInfo ci = ViewState["ci"] as CRMInfo;
                if (!string.IsNullOrEmpty(AddTime.Value))
                {
                    cti.AddTime = Convert.ToDateTime(AddTime.Value);
                }
                else
                {
                    cti.AddTime = DateTime.Now;
                }
                cti.cid = Convert.ToInt32(Request.QueryString["cid"]);
                cti.ContactAim = ContactAim.Value;
                cti.ContactCharge = ContactCharge.Value;
                cti.ContactDetail = ContactDetail.Value;
                cti.ContactState = ContactState.SelectedValue;
                cti.CreatorID = ci.CreatorID;
                cti.CreatorDepName = ci.CreatorDepName;
                cti.CreatorRealName = ci.CreatorRealName;
                cti.CRM_Name = ci.CRM_Name;

                string t1 = "";
                for (int i = 0; i < ContactChargeType.Items.Count; i++)
                {
                    if (ContactChargeType.Items[i].Selected)
                    {
                        t1 += ContactChargeType.Items[i].Value;
                    }
                }
                cti.ContactChargeType = t1;
                string t2 = "";
                for (int i = 0; i < ContactType.Items.Count; i++)
                {
                    if (ContactType.Items[i].Selected)
                    {
                        t2 += ContactType.Items[i].Value;
                    }
                }
                cti.ContactType = t2;

                if (ContactPeople.Value.Trim() != "")
                {
                    cti.ContactPeople = ContactPeople.Value;
                }
                else
                {
                    cti.ContactPeople = RealName;
                }

                CRM_Contact.Init().Add(cti);
                string words = HttpContext.Current.Server.HtmlEncode("您好!客户接触已添加成功!");
                Response.Redirect("/InfoTip/Operate_Success.aspx?returnpage="
                + Request.Url.AbsoluteUri + "&tip=" + words);

            }

        }

        private void Show(string cid,string ctid)
        {
            CRM_ContactInfo cti = CRM_Contact.Init().GetById(Convert.ToInt32(ctid));

            if (cti != null)
            {
                ViewState["cti"] = cti;

                ContactAim.Value = cti.ContactAim;
                if (cti.AddTime != null)
                    AddTime.Value = cti.AddTime.ToString("yyyy-MM-dd");
                ContactCharge.Value = cti.ContactCharge;
                ContactState.SelectedValue = cti.ContactState;
                ContactDetail.Value = cti.ContactDetail;
                ContactPeople.Value = cti.ContactPeople;
                for (int i = 0; i < ContactChargeType.Items.Count; i++)
                {
                    if (cti.ContactChargeType.Contains(ContactChargeType.Items[i].Value))
                        ContactChargeType.Items[i].Selected = true;
                }
                for (int i = 0; i < ContactType.Items.Count; i++)
                {
                    if (cti.ContactType.Contains(ContactType.Items[i].Value))
                        ContactType.Items[i].Selected = true;
                }

            }

        }


    }
}
