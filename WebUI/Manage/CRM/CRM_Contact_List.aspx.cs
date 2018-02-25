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

namespace WC.WebUI.Manage.CRM
{
    public partial class CRM_Contact_List : WC.BLL.ViewPages
    {
        protected string c = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && !string.IsNullOrEmpty(Request.QueryString["cid"]))
            {
                Show(Request.QueryString["cid"]);
            }
            if (!string.IsNullOrEmpty(Request.QueryString["cid"]))
                c = Request.QueryString["cid"];   
        }

        protected void Del_Btn(object obj, EventArgs e)
        {
            LinkButton lb = obj as LinkButton;
            RepeaterItem ri = lb.Parent as RepeaterItem;
            HtmlInputCheckBox hick = ri.FindControl("chk") as HtmlInputCheckBox;
            int rid = Convert.ToInt32(hick.Value);
            WC.BLL.CRM_Contact.Init().Delete(rid);
            Show(Request.QueryString["cid"]);
        }

        protected void Del_All(object sender, EventArgs e)
        {
            foreach (RepeaterItem item in rpt.Items)
            {
                HtmlInputCheckBox hick = item.FindControl("chk") as HtmlInputCheckBox;
                if (hick.Checked)
                {
                    int rid = Convert.ToInt32(hick.Value);
                    WC.BLL.CRM_Contact.Init().Delete(rid);
                }
            }
            Show(Request.QueryString["cid"]);
        }

        private void Show(string cid)
        {
            //根据分页配置文件 获取权限分页设置
            Hashtable page_ht = (Hashtable)HttpContext.Current.Application["config_fenye"];
            //每页显示数
            int page_nums = Convert.ToInt32(page_ht["fenye_commom"]);

            //分页显示
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
            string tmp = " cid=" + cid + " and CreatorID=" + Uid + " ";

            int count = Convert.ToInt32(MsSqlOperate.ExecuteScalar(CommandType.Text,
                "select count(*) from CRM_Contact where " + tmp, null));

            num.InnerHtml = "当前查询条件总计 - <span style='color:#ff0000; font-weight:bold;'>" + count + "</span> 条 记录数据";
            string sql_rpt = "select top " + page_nums + " * from CRM_Contact where "
                + tmp + " order by id desc";
            if (pagecount != 1)
                sql_rpt = "SELECT TOP " + page_nums
                    + " * FROM CRM_Contact WHERE id<(SELECT MIN(id) FROM (SELECT TOP "
                    + nums.ToString() + " id FROM CRM_Contact WHERE (" + tmp + " ) ORDER BY id DESC) T1) AND ("
                    + tmp + " ) ORDER BY id DESC";

            Bind(sql_rpt, rpt);
            this.Page1.sty("meneame", pagecount, GetCountPage(count, page_nums), "?cid=" + cid + "&page=");

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


    }
}
