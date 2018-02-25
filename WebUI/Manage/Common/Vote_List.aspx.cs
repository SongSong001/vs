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

namespace WC.WebUI.Manage.Common
{
    public partial class Vote_List : WC.BLL.ViewPages
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
            Response.Redirect("Vote_List.aspx" + url);
        }

        protected void RowDataBind(object sender, RepeaterItemEventArgs e)
        {
            Label clab = e.Item.FindControl("c") as Label;
            Panel pal = e.Item.FindControl("d") as Panel;
            if (clab.Text == Uid)
                pal.Visible = true;
        }

        protected void Del_Btn(object obj, EventArgs e)
        {
            LinkButton lb = obj as LinkButton;
            RepeaterItem ri = lb.Parent.Parent as RepeaterItem;
            Panel p = ri.FindControl("d") as Panel;
            if (p.Visible == true)
            {
                HtmlInputCheckBox hick = ri.FindControl("chk") as HtmlInputCheckBox;
                int vid = Convert.ToInt32(hick.Value);
                string sql = "delete from VoteDetail where VoteID=" + vid;
                MsSqlOperate.ExecuteNonQuery(CommandType.Text, sql);
                WC.BLL.Vote.Init().Delete(vid);
                Response.Redirect("Vote_List.aspx");
            }
        }

        protected void Valide_Btn(object sender, EventArgs e)
        {
            LinkButton l = sender as LinkButton;
            string vid = l.CommandArgument.ToString();
            VoteInfo vi = Vote.Init().GetById(Convert.ToInt32(vid));
            vi.IsValide = Math.Abs(vi.IsValide - 1);
            Vote.Init().Update(vi);
            Response.Redirect("Vote_List.aspx");
        }

        private void Show()
        {
            Hashtable page_ht = (Hashtable)HttpContext.Current.Application["config_fenye"];
            //每页显示数
            int page_nums = Convert.ToInt32(page_ht["fenye_commom"]);

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

            string keywords = Request.QueryString["keywords"];

            string where = " userlist like '%#" + Uid + "#%' or CreateUserID=" + Uid;

            if (!string.IsNullOrEmpty(keywords))
            {
                where = "VoteTitle like '%" + keywords + "%' and ( userlist like '%#" + Uid + "#%' or CreateUserID=" + Uid + ")";
            }

            IList list = Vote.Init().GetAll(where, "order by id desc");
            num.InnerHtml = "当前查询条件总计 - <span style='color:#ff0000; font-weight:bold;'>" + list.Count + "</span> 条 记录数据";

            pds.DataSource = list;
            pds.AllowPaging = true;
            pds.PageSize = page_nums;
            pds.CurrentPageIndex = pagecount - 1;
            rpt.DataSource = pds;
            rpt.DataBind();

            if (!string.IsNullOrEmpty(Request.QueryString["keywords"]))
            {
                this.Page1.sty("meneame", pagecount, pds.PageCount, "?keywords=" + keywords + "&page=");
            }
            else
            {
                this.Page1.sty("meneame", pagecount, pds.PageCount, "?page=");
            }

        }

    }
}
