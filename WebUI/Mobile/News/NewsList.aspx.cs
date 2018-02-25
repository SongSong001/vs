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

using WC.DBUtility;
using WC.BLL;
using WC.Model;

namespace WC.WebUI.Mobile.News
{
    public partial class NewsList : WC.BLL.MobilePage
    {
        protected string news_list = "所有资讯";
        protected string t = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            t = (!string.IsNullOrEmpty(Request.QueryString["tid"])) ? Request.QueryString["tid"] : "0";

            if (!string.IsNullOrEmpty(Request.QueryString["type"]))
            {
                if (Request.QueryString["type"] != "0")
                    Response.Redirect("NewsList.aspx?tid=" + Request.QueryString["type"] + "&keywords="
                        + HttpContext.Current.Server.HtmlEncode(Request.Form["keywords"]));
                else
                    Response.Redirect("NewsList.aspx?keywords="
                        + HttpContext.Current.Server.HtmlEncode(Request.Form["keywords"]));
            }

            if (!IsPostBack)
            {
                Show();
            }
        }

        private void Show()
        {
            IList list = News_Type.Init().GetAll(null, " order by orders asc");
            for (int i = 0; i < list.Count; i++)
            {
                News_TypeInfo nt = list[i] as News_TypeInfo;
                if (nt.id + "" == Request.QueryString["tid"] + "")
                {
                    news_list = nt.TypeName;
                }
            }

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

            string tmp = " a.TypeID = b.id and ( a.ShareDeps='' or a.ShareDeps like '%#" + DepID + "#%') ";
            string keywords = Request.QueryString["keywords"];
            if (!string.IsNullOrEmpty(keywords) && WC.Tool.Utils.CheckSql(keywords))
            {
                tmp = " a.TypeID = b.id and ( a.ShareDeps='' or a.ShareDeps like '%#" + DepID + "#%') ";
                tmp += " and (a.NewsTitle like '%" + keywords + "%'  ) ";
            }
            if (!string.IsNullOrEmpty(Request.QueryString["tid"]))
            {
                string tid = Request.QueryString["tid"];
                tmp = " a.TypeID=" + tid + " and a.TypeID = b.id and ( a.ShareDeps='' or a.ShareDeps like '%#" + DepID + "#%') ";
            }

            string sql = "select a.*,b.TypeName from News_Article as a,News_Type as b where " + tmp + " order by a.id desc";

            using (DataSet ds = MsSqlOperate.ExecuteDataset(CommandType.Text, sql))
            {
                num1.InnerHtml =  ds.Tables[0].Rows.Count.ToString();

                pds.DataSource = ds.Tables[0].DefaultView;
                pds.AllowPaging = true;
                pds.PageSize = page_nums;
                pds.CurrentPageIndex = pagecount - 1;
                rpt.DataSource = pds;
                rpt.DataBind();

                if (!string.IsNullOrEmpty(Request.QueryString["keywords"]))
                {
                    this.Page1.sty("meneame", pagecount, pds.PageCount, "?keywords=" + keywords + "&page=");
                }
                if (!string.IsNullOrEmpty(Request.QueryString["tid"]))
                {
                    this.Page1.sty("meneame", pagecount, pds.PageCount, "?tid=" + Request.QueryString["tid"] + "&page=");
                }
                this.Page1.sty("meneame", pagecount, pds.PageCount, "?page=");

            }

        }
    }
}