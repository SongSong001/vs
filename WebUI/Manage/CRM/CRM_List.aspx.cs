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

namespace WC.WebUI.Manage.CRM
{
    public partial class CRM_List : WC.BLL.ViewPages
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && !string.IsNullOrEmpty(Request.QueryString["action"]))
            {
                Show();
            }
        }

        protected void RowDataBind(object sender, RepeaterItemEventArgs e)
        {
            Panel pal = e.Item.FindControl("d") as Panel;
            if (Request.QueryString["action"]=="mycrm")
                pal.Visible = true;
        }

        protected void Search_Btn(object sender, EventArgs e)
        {
            string keywords = Request.Form["keyword"];
            string action = Request.QueryString["action"];
            if (!string.IsNullOrEmpty(action) && !string.IsNullOrEmpty(keywords))
            {
                string url = "?action=" + action + "&keywords=" + HttpContext.Current.Server.HtmlEncode(keywords.Trim());
                Response.Redirect("CRM_List.aspx" + url);
            }
        }

        protected void Del_Btn(object obj, EventArgs e)
        {
            LinkButton lb = obj as LinkButton;
            RepeaterItem ri = lb.Parent.Parent as RepeaterItem;
            HtmlInputCheckBox hick = ri.FindControl("chk") as HtmlInputCheckBox;
            int rid = Convert.ToInt32(hick.Value);
            CRMInfo ci = WC.BLL.CRM.Init().GetById(rid);
            Dk.Help.DeleteFiles(ci.FilePath);
            string sql = "delete from CRM_Contact where cid=" + rid;
            MsSqlOperate.ExecuteNonQuery(CommandType.Text, sql);
            WC.BLL.CRM.Init().Delete(rid);
            Show();
        }

        //protected void Del_All(object sender, EventArgs e)
        //{
        //    foreach (RepeaterItem item in rpt.Items)
        //    {
        //        HtmlInputCheckBox hick = item.FindControl("chk") as HtmlInputCheckBox;
        //        if (hick.Checked)
        //        {
        //            int rid = Convert.ToInt32(hick.Value);
        //            string sql = "delete from CRM_Contact where cid=" + rid;
        //            MsSqlOperate.ExecuteNonQuery(CommandType.Text, sql);
        //            WC.BLL.CRM.Init().Delete(rid);
        //        }
        //    }
        //    Show();
        //}

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

            if (action == "mycrm")
            {
                if (!string.IsNullOrEmpty(keywords))
                {
                    tmp = " CreatorID=" + Uid +
                        " and (CRM_Name like '%" + keywords + "%' or MainPeople like '%" + keywords + "%' or grade like '%" + keywords.ToUpper() + "%' ) ";
                }
                else
                {
                    tmp = " CreatorID=" + Uid;
                    if (!string.IsNullOrEmpty(Request.QueryString["g"]))
                        tmp = " CreatorID=" + Uid + " and Grade='" + Request.QueryString["g"] + "'";
                }

            }
            if (action == "shared")
            {
                if (!string.IsNullOrEmpty(keywords))
                {
                    tmp = " CreatorID<>" + Uid + " and IsShare=1 and ShareUsers like '%#" + Uid + "#%' " +
                        " and (CRM_Name like '%" + keywords + "%' or MainPeople like '%" + keywords + "%' or grade like '%" + keywords.ToUpper() + "%' ) ";
                }
                else
                {
                    tmp = " CreatorID<>" + Uid + " and IsShare=1 and ShareUsers like '%#" + Uid + "#%' ";
                }

            }

            int count = Convert.ToInt32(MsSqlOperate.ExecuteScalar(CommandType.Text,
            "select count(*) from CRM where " + tmp, null));

            num.InnerHtml = "当前查询条件总计 - <span style='color:#ff0000; font-weight:bold;'>" + count + "</span> 条 记录数据";

            string sql_rpt = "select top " + page_nums + " * from CRM where "
            + tmp + " order by id desc";
            if (pagecount != 1)
                sql_rpt = "SELECT TOP " + page_nums
                    + " * FROM CRM WHERE id<(SELECT MIN(id) FROM (SELECT TOP "
                    + nums.ToString() + " id FROM CRM WHERE (" + tmp + " ) ORDER BY id DESC) T1) AND ("
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

        protected string GetGrade(object obj)
        {
            string t = obj + "";
            t = t.ToUpper();
            string r = "";
            if (t == "A")
                r = "暂无需求，潜在培养的客户";
            if (t == "B")
                r = "有需求，正在跟进客户";
            if (t == "C")
                r = "短期可签入的客户";
            if (t == "D")
                r = "已签约客户/老客户";
            return r;
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
