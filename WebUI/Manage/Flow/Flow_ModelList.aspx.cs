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
using WC.Tool;

namespace WC.WebUI.Manage.Flow
{
    public partial class Flow_ModelList : WC.BLL.ModulePages
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Show();
            }
        }

        protected void Search_Btn(object sender, EventArgs e)
        {
            string keywords = Request.Form["keyword"];
            string url = "?keywords=" + HttpContext.Current.Server.HtmlEncode(keywords.Trim());
            Response.Redirect("Flow_ModelList.aspx" + url);
        }

        protected void Del_Btn(object obj, EventArgs e)
        {
            LinkButton lb = obj as LinkButton;
            RepeaterItem ri = lb.Parent as RepeaterItem;
            HtmlInputCheckBox hick = ri.FindControl("chk") as HtmlInputCheckBox;
            int rid = Convert.ToInt32(hick.Value);

            string sql0 = "delete from Flows_Model where id=" + rid;
            string sql = "delete from Flows_ModelStep where Flow_ModelID=" + rid;
            MsSqlOperate.ExecuteNonQuery(CommandType.Text, sql0);
            MsSqlOperate.ExecuteNonQuery(CommandType.Text, sql);
            Show();
        }

        protected void Del_All(object sender, EventArgs e)
        {
            foreach (RepeaterItem item in rpt.Items)
            {
                HtmlInputCheckBox hick = item.FindControl("chk") as HtmlInputCheckBox;
                if (hick.Checked)
                {
                    int rid = Convert.ToInt32(hick.Value);
                    string sql0 = "delete from Flows_Model where id=" + rid;
                    string sql = "delete from Flows_ModelStep where Flow_ModelID=" + rid;
                    MsSqlOperate.ExecuteNonQuery(CommandType.Text, sql0);
                    MsSqlOperate.ExecuteNonQuery(CommandType.Text, sql);
                }
            }
            Show();
        }

        private void Show()
        {
            string where = "1=1";
            if (!string.IsNullOrEmpty(Request.QueryString["keywords"]))
                where += " and (Flow_Name like '%" + Request.QueryString["keywords"]
                    + "%' )";

            if (!string.IsNullOrEmpty(Request.QueryString["td"]))
                where += " and (comid =" + Request.QueryString["td"] + " )";

            IList list = Flows_Model.Init().GetAll(where, "order by id desc");

            //每页显示数
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
                this.Page1.sty("meneame", pagecount, pds.PageCount, "?page=");

            if (!string.IsNullOrEmpty(Request.QueryString["keywords"]))
                this.Page1.sty("meneame", pagecount, pds.PageCount, "?keywords=" + Request.QueryString["keywords"] + "&page=");

            rpt.DataSource = pds;
            rpt.DataBind();
            num.InnerHtml = "当前查询条件总计 - <span style='color:#ff0000; font-weight:bold;'>" + list.Count + "</span> 条 记录数据";

        }

    }
}
