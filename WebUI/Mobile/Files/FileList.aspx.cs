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

namespace WC.WebUI.Mobile.Files
{
    public partial class FileList : WC.BLL.MobilePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["type"]))
            {
                Response.Redirect("FileList.aspx?action=" + Request.QueryString["type"] + "&keywords="
                    + HttpContext.Current.Server.HtmlEncode(Request.Form["keywords"]));
            }

            if (!IsPostBack && !string.IsNullOrEmpty(Request.QueryString["action"]))
            {
                Show();
            }
        }

        private void Show()
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
            int nums = page_nums * (pagecount - 1);

            string keywords = Request.QueryString["keywords"];
            string action = Request.QueryString["action"];
            string tmp = "";

            if (action == "mydoc")
            {
                if (!string.IsNullOrEmpty(keywords))
                {
                    tmp = " CreatorID=" + Uid +
                        " and (DocTitle like '%" + keywords + "%' or CreatorRealName like '%" + keywords + "%' ) ";
                }
                else
                {
                    tmp = " CreatorID=" + Uid;
                }

                if (!string.IsNullOrEmpty(Request.QueryString["type"]))
                {
                    tmp = " CreatorID=" + Uid + " and DocTypeID=" + Request.QueryString["type"];
                }

            }
            if (action == "shared")
            {
                if (!string.IsNullOrEmpty(keywords))
                {
                    tmp = " CreatorID<>" + Uid + " and IsShare=1 and ShareUsers like '%#" + Uid + "#%' " +
                        " and (DocTitle like '%" + keywords + "%' or CreatorRealName like '%" + keywords + "%' ) ";
                }
                else
                {
                    tmp = " CreatorID<>" + Uid + " and IsShare=1 and ShareUsers like '%#" + Uid + "#%' ";
                }

            }

            int count = Convert.ToInt32(MsSqlOperate.ExecuteScalar(CommandType.Text,
            "select count(*) from Docs_Doc where " + tmp, null));

            num.InnerHtml =  count.ToString();

            string sql_rpt = "select top " + page_nums + " * from Docs_Doc where "
            + tmp + " order by id desc";
            if (pagecount != 1)
                sql_rpt = "SELECT TOP " + page_nums
                    + " * FROM Docs_Doc WHERE id<(SELECT MIN(id) FROM (SELECT TOP "
                    + nums.ToString() + " id FROM Docs_Doc WHERE (" + tmp + " ) ORDER BY id DESC) T1) AND ("
                    + tmp + " ) ORDER BY id DESC";

            Bind(sql_rpt, rpt);
            if (string.IsNullOrEmpty(keywords))
            {
                this.Page1.sty("meneame", pagecount, GetCountPage(count, page_nums), "?action=" + action + "&page=");
            }
            else
            {
                this.Page1.sty("meneame", pagecount, GetCountPage(count, page_nums),
                    "?action=" + action + "&keywords=" + keywords + "&page=");
            }

        }


        private int GetCountPage(int count, int pageSize)
        {
            if (count <= pageSize)
                return 1;
            else
            {
                if (count % pageSize == 0)
                    return count / pageSize;
                else
                    return count / pageSize + 1;
            }
        }

        private void Bind(string sql, Repeater r)
        {
            using (DataSet ds = MsSqlOperate.ExecuteDataset(CommandType.Text, sql, null))
            {
                r.DataSource = ds.Tables[0].DefaultView;
                r.DataBind();
            }
        }

        protected string GetPrestr()
        {
            string act = Request.QueryString["action"];
            if (act == "mydoc")
                return "我的文件";
            else if (act == "shared")
                return "同事共享";
            else return "";

        }
    }
}