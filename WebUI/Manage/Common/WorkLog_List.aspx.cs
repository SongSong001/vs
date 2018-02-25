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

namespace WC.WebUI.Manage.Common
{
    public partial class WorkLog_List : WC.BLL.ViewPages
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
            string TaskName = HttpContext.Current.Server.HtmlEncode(Request.Form["TaskName"].Trim());
            string StartTime = HttpContext.Current.Server.HtmlEncode(Request.Form["StartTime"].Trim());
            string EndTime = HttpContext.Current.Server.HtmlEncode(Request.Form["EndTime"].Trim());
            string action = Request.QueryString["action"];
            if (!string.IsNullOrEmpty(action))
            {
                string url = "?action=" + action + "&keywords=" + HttpContext.Current.Server.HtmlEncode(TaskName.Trim())
                    + "&StartTime=" + StartTime + "&EndTime=" + EndTime;
                Response.Redirect("WorkLog_List.aspx" + url);
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
                WorkLogInfo di = WorkLog.Init().GetById(rid);
                Dk.Help.DeleteFiles(di.FilePath);
                WC.BLL.WorkLog.Init().Delete(rid);
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

            string st = Request.QueryString["StartTime"];
            string et = Request.QueryString["EndTime"];

            string tmp = "";

            if (action == "mydoc")
            {
                tmp = " CreatorID=" + Uid;
                if (!string.IsNullOrEmpty(keywords))
                {
                    tmp += " and (LogTitle like '%" + keywords + "%' or CreatorRealName like '%" + keywords + "%') ";
                }
                if (!string.IsNullOrEmpty(st) && !string.IsNullOrEmpty(et))
                {
                    tmp += " and (AddTime between '" + st + "' and '" + et + "') ";
                }

            }
            if (action == "shared")
            {
                tmp = " (CreatorID<>" + Uid + " and ShareUsers like '%#" + Uid + "#%') ";
                if (!string.IsNullOrEmpty(keywords))
                {
                    tmp += " and (LogTitle like '%" + keywords + "%' or CreatorRealName like '%" + keywords + "%') ";
                }
                if (!string.IsNullOrEmpty(st) && !string.IsNullOrEmpty(et))
                {
                    tmp += " and (AddTime between '" + st + "' and '" + et + "') ";
                }

            }

            int count = Convert.ToInt32(MsSqlOperate.ExecuteScalar(CommandType.Text,
            "select count(id) from WorkLog where " + tmp, null));

            num.InnerHtml = "当前查询条件总计 - <span style='color:#ff0000; font-weight:bold;'>" + count + "</span> 条 记录数据";

            string sql_rpt = "select top " + page_nums + " * from WorkLog where "
            + tmp + " order by id desc";
            if (pagecount != 1)
                sql_rpt = "SELECT TOP " + page_nums
                    + " * FROM WorkLog WHERE id<(SELECT MIN(id) FROM (SELECT TOP "
                    + nums.ToString() + " id FROM WorkLog WHERE (" + tmp + " ) ORDER BY id DESC) T1) AND ("
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
    }
}