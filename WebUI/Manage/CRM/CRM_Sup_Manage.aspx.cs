using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.IO;
using WC.BLL;
using WC.Model;
using WC.DBUtility;

namespace WC.WebUI.Manage.CRM
{
    public partial class CRM_Sup_Manage : WC.BLL.ViewPages
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && !string.IsNullOrEmpty(Request.QueryString["cid"]))
            {
                Show(Request.QueryString["cid"]);
            }
        }

        private void Show(string cid)
        {
            if (!string.IsNullOrEmpty(cid))
            {
                CRM_SupInfo ci = WC.BLL.CRM_Sup.Init().GetById(Convert.ToInt32(cid));
                if (ci != null)
                {
                    ViewState["ci"] = ci;
                    Sup_Name.Value = ci.Sup_Name;
                    MainPeople.Value = ci.MainPeople;
                    Tel.Value = ci.Tel;
                    Addr.Value = ci.Addr;
                    Notes.Value = ci.Notes;
                }

            }
        }

        protected void Save_Btn(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["cid"]))
            {
                CRM_SupInfo ci = ViewState["ci"] as CRM_SupInfo;
                if (ci != null)
                {
                    if (ci.CreatorID == Convert.ToInt32(Uid))
                    {
                        ci.MainPeople = MainPeople.Value;
                        ci.Notes = Notes.Value;
                        ci.Sup_Name = Sup_Name.Value;
                        ci.Tel = Tel.Value;
                        ci.Addr = Addr.Value;

                        WC.BLL.CRM_Sup.Init().Update(ci);

                        string words = HttpContext.Current.Server.HtmlEncode("您好!供应商信息已保存成功!");
                        Response.Redirect("/InfoTip/Operate_Success.aspx?returnpage="
                        + Request.Url.AbsoluteUri + "&tip=" + words);
                    }

                }

            }
            else
            {
                CRM_SupInfo ci = new CRM_SupInfo();
                ci.MainPeople = MainPeople.Value;
                ci.Notes = Notes.Value;
                ci.Sup_Name = Sup_Name.Value;
                ci.Tel = Tel.Value;
                ci.Addr = Addr.Value;
                ci.CreatorDepName = DepName;
                ci.CreatorID = Convert.ToInt32(Uid);
                ci.CreatorRealName = RealName;

                WC.BLL.CRM_Sup.Init().Add(ci);

                string words = HttpContext.Current.Server.HtmlEncode("您好!供应商信息已添加成功!");
                Response.Redirect("/InfoTip/Operate_Success.aspx?returnpage="
                + Request.Url.AbsoluteUri + "&tip=" + words);

            }

        }

    }
}
