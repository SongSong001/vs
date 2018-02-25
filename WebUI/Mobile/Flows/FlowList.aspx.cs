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
using WC.BLL;
using WC.Model;
using WC.DBUtility;

namespace WC.WebUI.Mobile.Flows
{
    public partial class FlowList : WC.BLL.MobilePage
    {
        protected string flow_list = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["type"]))
            {
                Response.Redirect("FlowList.aspx?action=" + Request.QueryString["type"] + "&keywords="
                    + HttpContext.Current.Server.HtmlEncode(Request.Form["keywords"]));
            }

            if (!IsPostBack)
            {
                if (!string.IsNullOrEmpty(Request.QueryString["action"]))
                {
                    Show(Request.QueryString["action"]);
                }
            }
        }

        private void Show(string type)
        {
            IList list = null;
            if (type == "verify")
            {
                flow_list = "我的批阅";
                if (!string.IsNullOrEmpty(Request.QueryString["keywords"]))
                {
                    string key = Request.QueryString["keywords"];
                    string words = " (Flow_Name like '%" + key + "%' or CreatorRealName like '%"
                    + key + "%' ) ";
                    string sql = "select a.* from flows a where a.status=0 and a.CurrentStepUserList like '%#" + Uid +
                    "#%' and a.CurrentStepID not in (select b.OperationStepID from Flows_StepAction b where b.UserID="
                    + Uid + " and b.FlowID=a.id ) and " + words;
                    using (DataSet ds = MsSqlOperate.ExecuteDataset(CommandType.Text, sql))
                    {
                        CutPage(ds, "verify");
                    }
                }
                else
                {
                    string sql = "select a.* from flows a where a.status=0 and a.CurrentStepUserList like '%#" + Uid +
                    "#%' and a.CurrentStepID not in (select b.OperationStepID from Flows_StepAction b where b.UserID="
                    + Uid + " and b.FlowID=a.id ) order by a.id desc";

                    if (!string.IsNullOrEmpty(Request.QueryString["td"]))
                        sql = "select a.* from flows a where a.comid=" + Request.QueryString["td"] +
                            " and a.status=0 and a.CurrentStepUserList like '%#" + Uid +
                    "#%' and a.CurrentStepID not in (select b.OperationStepID from Flows_StepAction b where b.UserID="
                    + Uid + " and b.FlowID=a.id ) order by a.id desc";

                    using (DataSet ds = MsSqlOperate.ExecuteDataset(CommandType.Text, sql))
                    {
                        CutPage(ds, "verify");
                    }
                }
            }
            
            if (type == "verified")
            {
                flow_list = "已经批阅";
                if (!string.IsNullOrEmpty(Request.QueryString["keywords"]))
                {
                    string key = Request.QueryString["keywords"];
                    string words = "(Flow_Name like '%" + key + "%' or CreatorRealName like '%" + key + "%' ) and ";
                    list = WC.BLL.Flows.Init().GetAll(words + " HasOperatedUserList like '%#" + Uid + "#%'", "order by id desc");
                }
                else
                {
                    if (string.IsNullOrEmpty(Request.QueryString["td"]))
                        list = WC.BLL.Flows.Init().GetAll("HasOperatedUserList like '%#" + Uid + "#%'", "order by id desc");
                    else list = WC.BLL.Flows.Init().GetAll("comid=" + Request.QueryString["td"] + " and HasOperatedUserList like '%#" + Uid + "#%'", "order by id desc");
                }
                CutPage(list, "verified");
            }

            if (type == "apply")
            {
                flow_list = "我的申请";
                if (!string.IsNullOrEmpty(Request.QueryString["keywords"]))
                {
                    string key = Request.QueryString["keywords"];
                    string words = "(Flow_Name like '%" + key + "%' or CreatorRealName like '%" + key + "%') and ";
                    list = WC.BLL.Flows.Init().GetAll(words + " CreatorID=" + Uid, "order by id desc");
                }
                else
                {
                    if (string.IsNullOrEmpty(Request.QueryString["td"]))
                        list = WC.BLL.Flows.Init().GetAll("CreatorID=" + Uid, "order by id desc");
                    else list = WC.BLL.Flows.Init().GetAll("comid=" + Request.QueryString["td"] + " and CreatorID=" + Uid, "order by id desc");
                }
                CutPage(list, "apply");
            }

            if (type == "view")
            {
                flow_list = "抄送呈报";
                if (!string.IsNullOrEmpty(Request.QueryString["keywords"]))
                {
                    string key = Request.QueryString["keywords"];
                    string words = "(Flow_Name like '%" + key + "%' or CreatorRealName like '%" + key + "%' ) and ";
                    list = WC.BLL.Flows.Init().GetAll(words + " ViewUserList like '%#" + Uid + "#%'", "order by id desc");
                }
                else
                {
                    if (string.IsNullOrEmpty(Request.QueryString["td"]))
                        list = WC.BLL.Flows.Init().GetAll("ViewUserList like '%#" + Uid + "#%'", "order by id desc");
                    else list = WC.BLL.Flows.Init().GetAll("comid=" + Request.QueryString["td"] + " and ViewUserList like '%#" + Uid + "#%'", "order by id desc");
                }
                CutPage(list, "view");
            }
        }

        private void CutPage(IList list, string action)
        {
            int page_nums = 30;

            int pagecount = 0;
            try
            {
                if (!string.IsNullOrEmpty(Request.QueryString["page"]))
                    pagecount = Convert.ToInt32(Request.QueryString["page"]);
            }
            catch { }
            if (pagecount == 0)
            {
                pagecount = 1;
            }
            PagedDataSource pds = new PagedDataSource();

            pds.DataSource = list;
            pds.AllowPaging = true;
            pds.PageSize = page_nums;
            pds.CurrentPageIndex = pagecount - 1;
            rpt.DataSource = pds;
            rpt.DataBind();

            if (string.IsNullOrEmpty(Request.QueryString["keywords"]))
            {
                if (string.IsNullOrEmpty(Request.QueryString["td"]))
                    this.Page1.sty("meneame", pagecount, pds.PageCount, "?action=" + action + "&page=");
                else
                    this.Page1.sty("meneame", pagecount, pds.PageCount, "?action=" + action + "&td=" + Request.QueryString["td"] + "&page=");
            }

            if (!string.IsNullOrEmpty(Request.QueryString["keywords"]))
                this.Page1.sty("meneame", pagecount, pds.PageCount, "?action=" + action + "&keywords=" + Request.QueryString["keywords"] + "&page=");

            rpt.DataSource = pds;
            rpt.DataBind();
            num.InnerHtml = list.Count.ToString();

        }

        private void CutPage(DataSet ds, string action)
        {
            int page_nums = 30;

            int pagecount = 0;
            try
            {
                if (!string.IsNullOrEmpty(Request.QueryString["page"]))
                    pagecount = Convert.ToInt32(Request.QueryString["page"]);
            }
            catch { }
            if (pagecount == 0)
            {
                pagecount = 1;
            }
            PagedDataSource pds = new PagedDataSource();

            pds.DataSource = ds.Tables[0].DefaultView;
            pds.AllowPaging = true;
            pds.PageSize = page_nums;
            pds.CurrentPageIndex = pagecount - 1;
            rpt.DataSource = pds;
            rpt.DataBind();

            if (string.IsNullOrEmpty(Request.QueryString["keywords"]))
            {
                if (string.IsNullOrEmpty(Request.QueryString["td"]))
                    this.Page1.sty("meneame", pagecount, pds.PageCount, "?action=" + action + "&page=");
                else
                    this.Page1.sty("meneame", pagecount, pds.PageCount, "?action=" + action + "&td=" + Request.QueryString["td"] + "&page=");
            }

            if (!string.IsNullOrEmpty(Request.QueryString["keywords"]))
                this.Page1.sty("meneame", pagecount, pds.PageCount, "?action=" + action + "&keywords=" + Request.QueryString["keywords"] + "&page=");

            rpt.DataSource = pds;
            rpt.DataBind();
            num.InnerHtml = ds.Tables[0].Rows.Count.ToString();
        }
    }
}