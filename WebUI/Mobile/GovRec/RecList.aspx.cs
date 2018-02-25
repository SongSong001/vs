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

namespace WC.WebUI.Mobile.GovRec
{
    public partial class RecList : WC.BLL.MobilePage
    {
        protected string flow_list = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["type"]))
            {
                Response.Redirect("RecList.aspx?action=" + Request.QueryString["type"] + "&keywords="
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
            if (type == "verify")
            {
                flow_list = "公文签收";
                if (!string.IsNullOrEmpty(Request.QueryString["keywords"]))
                {
                    string key = Request.QueryString["keywords"];
                    string words = " and (a.Flow_Name like '%" + key + "%' or a.CreatorRealName like '%"
                    + key + "%' ) ";
                    string sql = "select a.* from Gov a,Gov_Recipient b where a.id=b.Flow_ID and a.status=1 and b.sign=0 and b.UserID=" + Uid + words + " order by a.id desc";
                    using (DataSet ds = MsSqlOperate.ExecuteDataset(CommandType.Text, sql))
                    {
                        CutPage(ds, "verify");
                    }
                }
                else
                {
                    string sql = "select a.* from Gov a,Gov_Recipient b where a.id=b.Flow_ID and a.status=1 and b.sign=0 and b.UserID=" + Uid + " order by a.id desc";
                    using (DataSet ds = MsSqlOperate.ExecuteDataset(CommandType.Text, sql))
                    {
                        CutPage(ds, "verify");
                    }
                }
            }

            if (type == "verified")
            {
                flow_list = "已签收公文";
                if (!string.IsNullOrEmpty(Request.QueryString["keywords"]))
                {
                    string key = Request.QueryString["keywords"];
                    string words = " and (a.Flow_Name like '%" + key + "%' or a.CreatorRealName like '%"
                    + key + "%' ) ";
                    string sql = "select a.* from Gov a,Gov_Recipient b where a.id=b.Flow_ID and a.status=1 and b.sign=1 and b.UserID=" + Uid + words + " order by a.id desc";
                    using (DataSet ds = MsSqlOperate.ExecuteDataset(CommandType.Text, sql))
                    {
                        CutPage(ds, "verified");
                    }
                }
                else
                {
                    string sql = "select a.* from Gov a,Gov_Recipient b where a.id=b.Flow_ID and a.status=1 and b.sign=1 and b.UserID=" + Uid + " order by a.id desc";
                    using (DataSet ds = MsSqlOperate.ExecuteDataset(CommandType.Text, sql))
                    {
                        CutPage(ds, "verified");
                    }
                }
            }

            if (type == "archived")
            {
                flow_list = "已归档公文";
                if (!string.IsNullOrEmpty(Request.QueryString["keywords"]))
                {
                    string key = Request.QueryString["keywords"];
                    string words = " and (a.Flow_Name like '%" + key + "%' or a.CreatorRealName like '%"
                    + key + "%' ) ";
                    string sql = "select a.* from Gov a,Gov_Recipient b where a.id=b.Flow_ID and a.status=5 and b.UserID=" + Uid + words + " order by a.id desc";
                    using (DataSet ds = MsSqlOperate.ExecuteDataset(CommandType.Text, sql))
                    {
                        CutPage(ds, "verified");
                    }
                }
                else
                {
                    string sql = "select a.* from Gov a,Gov_Recipient b where a.id=b.Flow_ID and a.status=5 and b.UserID=" + Uid + " order by a.id desc";
                    using (DataSet ds = MsSqlOperate.ExecuteDataset(CommandType.Text, sql))
                    {
                        CutPage(ds, "archived");
                    }
                }

            }

        }

        private void CutPage(IList list, string action)
        {
            //每页显示数
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
                this.Page1.sty("meneame", pagecount, pds.PageCount, "?action=" + action + "&page=");

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
                this.Page1.sty("meneame", pagecount, pds.PageCount, "?action=" + action + "&page=");

            if (!string.IsNullOrEmpty(Request.QueryString["keywords"]))
                this.Page1.sty("meneame", pagecount, pds.PageCount, "?action=" + action + "&keywords=" + Request.QueryString["keywords"] + "&page=");

            rpt.DataSource = pds;
            rpt.DataBind();
            num.InnerHtml = ds.Tables[0].Rows.Count.ToString();
        }

    }
}