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

namespace WC.WebUI.Manage.Gov
{
    public partial class Gov_Recipient_List : WC.BLL.ViewPages
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!string.IsNullOrEmpty(Request.QueryString["fl"]))
                {
                    Show(Request.QueryString["fl"]);
                }
                else
                {
                    Response.Write("<script>alert('非法的请求!');window.close();</script>");
                }
            }
        }

        protected void Search_Btn(object sender, EventArgs e)
        {
            string keywords = Request.Form["keyword"];
            string url = "?fl=" + Request.QueryString["fl"] + "&keywords=" + keywords;
            Response.Redirect("Gov_Recipient_List.aspx" + url);
        }

        private void Show(string fl)
        {
            SqlParameter rid = new SqlParameter();
            rid.ParameterName = "@uid";
            rid.Size = 50;
            rid.Value = Uid;

            SqlParameter sqlpt1 = new SqlParameter();
            sqlpt1.Direction = ParameterDirection.Output;
            sqlpt1.ParameterName = "@pt1";
            sqlpt1.Size = 7;

            SqlParameter sqlpt2 = new SqlParameter();
            sqlpt2.Direction = ParameterDirection.Output;
            sqlpt2.ParameterName = "@pt2";
            sqlpt2.Size = 7;

            SqlParameter sqlpt3 = new SqlParameter();
            sqlpt3.Direction = ParameterDirection.Output;
            sqlpt3.ParameterName = "@pt3";
            sqlpt3.Size = 7;

            SqlParameter[] sqls = { sqlpt1, sqlpt2, sqlpt3, rid };
            MsSqlOperate.ExecuteNonQuery(CommandType.StoredProcedure, "Gov_GetRecipientCount", sqls);
            wdpy.InnerText = sqlpt1.Value + "";
            yjpy.InnerText = sqlpt2.Value + "";
            wdsq.InnerText = sqlpt3.Value + "";

            IList list = null;
            if (!string.IsNullOrEmpty(Request.QueryString["keywords"]))
            {
                string key = Request.QueryString["keywords"];
                string words = " and (UserRealName like '%" + key + "%' or UserDepName like '%"
                + key + "%') ";
                list = WC.BLL.Gov_Recipient.Init().GetAll("Flow_ID=" + fl + words, "order by SignTime desc");
                CutPage(list, fl);
            }
            else
            {
                list = WC.BLL.Gov_Recipient.Init().GetAll("Flow_ID=" + fl, "order by SignTime desc");
                CutPage(list, fl);
            }

        }

        private void CutPage(IList list, string action)
        {
            int page_nums = 50;

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
                this.Page1.sty("meneame", pagecount, pds.PageCount, "?fl=" + action + "&page=");

            if (!string.IsNullOrEmpty(Request.QueryString["keywords"]))
                this.Page1.sty("meneame", pagecount, pds.PageCount, "?fl=" + action + "&keywords=" + Request.QueryString["keywords"] + "&page=");

            rpt.DataSource = pds;
            rpt.DataBind();
            num.InnerHtml = "当前查询条件总计 - <span style='color:#ff0000; font-weight:bold;'>" + list.Count + "</span> 条 记录数据";

        }

        protected string IsSign(object a)
        {
            int t = Convert.ToInt32(a);
            if (t == 0)
                return "<span style='color:#ff0000;font-weight:bold;'>× 未签收</span>";
            else return "<span style='color:#006600;font-weight:bold;'>√ 已签收</span>";
        }

        protected string SignTime(object a,object b)
        {
            if (Convert.ToInt32(b) == 0)
                return "";
            else
                return WC.Tool.Utils.ConvertDate1(a);
        }

    }
}
