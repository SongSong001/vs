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

namespace WC.WebUI.Manage.Sys
{
    public partial class Seal_List : WC.BLL.ModulePages
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
            Response.Redirect("Seal_List.aspx" + url);
        }

        protected void Del_Btn(object obj, EventArgs e)
        {
            LinkButton lb = obj as LinkButton;
            RepeaterItem ri = lb.Parent as RepeaterItem;
            HtmlInputCheckBox hick = ri.FindControl("chk") as HtmlInputCheckBox;
            int mid = Convert.ToInt32(hick.Value);
            Sys_SealInfo si = Sys_Seal.Init().GetById(mid);
            Dk.Help.DeleteFiles(si.FilePath);
            Sys_Seal.Init().Delete(mid);
            
            Show();
        }

        protected void Del_All(object sender, EventArgs e)
        {
            foreach (RepeaterItem item in rpt.Items)
            {
                HtmlInputCheckBox hick = item.FindControl("chk") as HtmlInputCheckBox;
                if (hick.Checked)
                {
                    int mid = Convert.ToInt32(hick.Value);
                    Sys_SealInfo si = Sys_Seal.Init().GetById(mid);
                    Dk.Help.DeleteFiles(si.FilePath);
                    Sys_Seal.Init().Delete(mid);
                }
            }
            Show();
        }


        private void Show()
        {
            //根据分页配置文件 获取权限分页设置
            Hashtable page_ht = (Hashtable)HttpContext.Current.Application["config_fenye"];
            //每页显示数
            int page_nums = Convert.ToInt32(page_ht["fenye_module"]);

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
            string tmp = "1=1";
            string keywords = Request.QueryString["keywords"];
            if (!string.IsNullOrEmpty(keywords) && WC.Tool.Utils.CheckSql(keywords))
            {
                tmp = " SealName like '%" + keywords + "%' or TagName like '%" + keywords + "%' ";
            }
            int count = Convert.ToInt32(MsSqlOperate.ExecuteScalar(CommandType.Text,
                "select count(*) from Sys_Seal where " + tmp, null));
            num.InnerHtml = "当前查询条件总计 - <span style='color:#ff0000; font-weight:bold;'>" + count + "</span> 条 记录数据";
            string sql_rpt = "select top " + page_nums + " * from Sys_Seal where "
                + tmp + " order by id asc";
            if (pagecount != 1)
                sql_rpt = "SELECT TOP " + page_nums
                    + " * FROM Sys_Seal WHERE id<(SELECT MIN(id) FROM (SELECT TOP "
                    + nums.ToString() + " id FROM Sys_Seal WHERE (" + tmp + " ) ORDER BY id ASC) T1) AND ("
                    + tmp + " ) ORDER BY id asc";

            if (tmp == "1=1")
            {
                Bind(sql_rpt, rpt);
                this.Page1.sty("meneame", pagecount, GetCountPage(count, page_nums), "?page=");
            }
            else
            {
                Bind(sql_rpt, rpt);
                this.Page1.sty("meneame", pagecount, GetCountPage(count, page_nums),
                    "?keywords=" + keywords + "&page=");
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


    }
}
