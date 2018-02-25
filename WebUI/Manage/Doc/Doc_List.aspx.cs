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

namespace WC.WebUI.Manage.Doc
{
    public partial class Doc_List : WC.BLL.ViewPages
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && !string.IsNullOrEmpty(Request.QueryString["action"]))
            {
                Show();
            }
        }

        protected void Search_Btn(object sender, EventArgs e)
        {
            string keywords = Request.Form["keyword"];
            string action = Request.QueryString["action"];
            if (!string.IsNullOrEmpty(action) && !string.IsNullOrEmpty(keywords))
            {
                string url = "?action=" + action + "&keywords=" + HttpContext.Current.Server.HtmlEncode(keywords.Trim());
                Response.Redirect("Doc_List.aspx" + url);
            }
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
                int rid = Convert.ToInt32(hick.Value);
                Docs_DocInfo di = Docs_Doc.Init().GetById(rid);
                Dk.Help.DeleteFiles(di.FilePath);
                WC.BLL.Docs_Doc.Init().Delete(rid);
                Show();
            }
        }

        private void Show()
        {
            //根据分页配置文件 获取权限分页设置
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
            int nums = page_nums * (pagecount - 1);

            string keywords = Request.QueryString["keywords"];
            string action = Request.QueryString["action"];
            string tmp = "";

            if (action == "mydoc")
            {
                if (!string.IsNullOrEmpty(keywords))
                {
                    tmp = " CreatorID=" + Uid +
                        " and (DocTitle like '%" + keywords + "%' or CreatorRealName like '%"+keywords+"%' ) ";
                }
                else
                {
                    tmp = " CreatorID=" + Uid ;
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

            num.InnerHtml = "当前查询条件总计 - <span style='color:#ff0000; font-weight:bold;'>" + count + "</span> 条 记录数据";

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

        protected string GetDocType(object DocTypeID)
        {
            try
            {
                int t = Convert.ToInt32(DocTypeID);
                if (t == 0)
                    return "默认分类";
                else
                {
                    IList list = Docs_DocType.Init().GetAll("id=" + t, null);
                    if (list != null)
                    {
                        Docs_DocTypeInfo di = list[0] as Docs_DocTypeInfo;
                        return di.TypeName;
                    }
                    else return "";
                }
            }
            catch
            {
                return "默认分类";
            }

        }

        protected string GetSelected(string i)
        {
            string f = Request.QueryString["action"] + "";
            if (f == i + "")
                return "class='selected'";
            else return "";
        }

    }
}
