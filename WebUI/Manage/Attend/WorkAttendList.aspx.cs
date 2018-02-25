using System;
using System.Collections;
using System.Collections.Generic;
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

namespace WC.WebUI.Manage.Attend
{
    public partial class WorkAttendList : WC.BLL.ViewPages
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!string.IsNullOrEmpty(Request.QueryString["type"]))
                {
                    Show(Request.QueryString["type"]);
                }
            }
        }

        protected void Search_Btn(object sender, EventArgs e)
        {
            string t = AttendType.SelectedValue;
            string st = HttpContext.Current.Server.HtmlEncode(Request.Form["BeginTime_S"].Trim());
            string et = HttpContext.Current.Server.HtmlEncode(Request.Form["EndTime_S"].Trim());
            //string ulist = userlist.Value;

            string url = "?type=" + t + "&st=" + st + "&et=" + et;
            Response.Redirect("WorkAttendList.aspx" + url);
        }

        private void Show(string t)
        {
            switch (t)
            {
                case "1": Show1(); break;
                case "2": Show2(); break;
                case "3": Show3(); break;
                case "4": Show4(); break;
                default: break;
            }
        }

        private void Show1()
        {
            list1.Visible = true;
            string type = Request.QueryString["type"];

            //每页显示数
            int page_nums = 60;

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

            string tmp = " AttendType=" + type + " and UID=" + Uid + " ";
            string sts = Request.QueryString["st"];
            if (!string.IsNullOrEmpty(sts))
            {
                string st = Request.QueryString["st"];
                string et = Request.QueryString["et"];
                tmp += " and (addtime between '" + st + "' and '" + et + "') ";

            }
            else
            {
                tmp += " and datediff(d,addtime,getdate())<180 ";
            }

            int count = Convert.ToInt32(MsSqlOperate.ExecuteScalar(CommandType.Text,
                        "select count(id) from Work_Attend where " + tmp, null));

            num1.InnerHtml = "当前查询条件总计 - <span style='color:#ff0000; font-weight:bold;'>" + count + "</span> 条 记录数据";

            string sql_rpt = "select top " + page_nums + " * from Work_Attend where "
                + tmp + " order by id desc";
            if (pagecount != 1)
                sql_rpt = "SELECT TOP " + page_nums
                    + " * FROM Work_Attend WHERE id<(SELECT MIN(id) FROM (SELECT TOP "
                    + nums.ToString() + " id FROM Work_Attend WHERE (" + tmp + " ) ORDER BY id DESC) T1) AND ("
                    + tmp + " ) ORDER BY id DESC";

            Bind(sql_rpt, rpt1);

            if (!string.IsNullOrEmpty(sts))
            {
                this.Page1.sty("meneame", pagecount, GetCountPage(count, page_nums), "?type=" + type
                    + "&st=" + Request.QueryString["st"]
                    + "&et=" + Request.QueryString["et"]
                    + "&page=");
            }
            else
            {
                this.Page1.sty("meneame", pagecount, GetCountPage(count, page_nums), "?type=" + type + "&page=");
            }


        }

        private void Show2()
        {
            list2.Visible = true;
            string type = Request.QueryString["type"];

            //每页显示数
            int page_nums = 60;

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

            string tmp = " AttendType=" + type + " and UID=" + Uid + " ";
            string sts = Request.QueryString["st"];
            if (!string.IsNullOrEmpty(sts))
            {
                string st = Request.QueryString["st"];
                string et = Request.QueryString["et"];
                tmp += " and (addtime between '" + st + "' and '" + et + "') ";

            }
            else
            {
                tmp += " and datediff(d,addtime,getdate())<180 ";
            }

            int count = Convert.ToInt32(MsSqlOperate.ExecuteScalar(CommandType.Text,
                        "select count(id) from Work_Attend where " + tmp, null));

            num2.InnerHtml = "当前查询条件总计 - <span style='color:#ff0000; font-weight:bold;'>" + count + "</span> 条 记录数据";

            string sql_rpt = "select top " + page_nums + " * from Work_Attend where "
                + tmp + " order by id desc";
            if (pagecount != 1)
                sql_rpt = "SELECT TOP " + page_nums
                    + " * FROM Work_Attend WHERE id<(SELECT MIN(id) FROM (SELECT TOP "
                    + nums.ToString() + " id FROM Work_Attend WHERE (" + tmp + " ) ORDER BY id DESC) T1) AND ("
                    + tmp + " ) ORDER BY id DESC";

            Bind(sql_rpt, rpt2);

            if (!string.IsNullOrEmpty(sts))
            {
                this.Page2.sty("meneame", pagecount, GetCountPage(count, page_nums), "?type=" + type
                    + "&st=" + Request.QueryString["st"]
                    + "&et=" + Request.QueryString["et"]
                    + "&page=");
            }
            else
            {
                this.Page2.sty("meneame", pagecount, GetCountPage(count, page_nums), "?type=" + type + "&page=");
            }

        }

        private void Show3()
        {
            list3.Visible = true;
            string type = Request.QueryString["type"];

            //每页显示数
            int page_nums = 60;

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

            string tmp = " AttendType=" + type + " and UID=" + Uid + " ";
            string sts = Request.QueryString["st"];
            if (!string.IsNullOrEmpty(sts))
            {
                string st = Request.QueryString["st"];
                string et = Request.QueryString["et"];
                tmp += " and (addtime between '" + st + "' and '" + et + "') ";

            }
            else
            {
                tmp += " and datediff(d,addtime,getdate())<180 ";
            }

            int count = Convert.ToInt32(MsSqlOperate.ExecuteScalar(CommandType.Text,
                        "select count(id) from Work_Attend where " + tmp, null));

            num3.InnerHtml = "当前查询条件总计 - <span style='color:#ff0000; font-weight:bold;'>" + count + "</span> 条 记录数据";

            string sql_rpt = "select top " + page_nums + " * from Work_Attend where "
                + tmp + " order by id desc";
            if (pagecount != 1)
                sql_rpt = "SELECT TOP " + page_nums
                    + " * FROM Work_Attend WHERE id<(SELECT MIN(id) FROM (SELECT TOP "
                    + nums.ToString() + " id FROM Work_Attend WHERE (" + tmp + " ) ORDER BY id DESC) T1) AND ("
                    + tmp + " ) ORDER BY id DESC";

            Bind(sql_rpt, rpt3);

            if (!string.IsNullOrEmpty(sts))
            {
                this.Page3.sty("meneame", pagecount, GetCountPage(count, page_nums), "?type=" + type
                    + "&st=" + Request.QueryString["st"]
                    + "&et=" + Request.QueryString["et"]
                    + "&page=");
            }
            else
            {
                this.Page3.sty("meneame", pagecount, GetCountPage(count, page_nums), "?type=" + type + "&page=");
            }
        }

        private void Show4()
        {
            list4.Visible = true;
            string type = Request.QueryString["type"];

            //每页显示数
            int page_nums = 60;

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

            string tmp = " AttendType=" + type + " and UID=" + Uid + " ";
            string sts = Request.QueryString["st"];
            if (!string.IsNullOrEmpty(sts))
            {
                string st = Request.QueryString["st"];
                string et = Request.QueryString["et"];
                tmp += " and (addtime between '" + st + "' and '" + et + "') ";

            }
            else
            {
                tmp += " and datediff(d,addtime,getdate())<180 ";
            }

            int count = Convert.ToInt32(MsSqlOperate.ExecuteScalar(CommandType.Text,
                        "select count(id) from Work_Attend where " + tmp, null));

            num4.InnerHtml = "当前查询条件总计 - <span style='color:#ff0000; font-weight:bold;'>" + count + "</span> 条 记录数据";

            string sql_rpt = "select top " + page_nums + " * from Work_Attend where "
                + tmp + " order by id desc";
            if (pagecount != 1)
                sql_rpt = "SELECT TOP " + page_nums
                    + " * FROM Work_Attend WHERE id<(SELECT MIN(id) FROM (SELECT TOP "
                    + nums.ToString() + " id FROM Work_Attend WHERE (" + tmp + " ) ORDER BY id DESC) T1) AND ("
                    + tmp + " ) ORDER BY id DESC";

            Bind(sql_rpt, rpt4);

            if (!string.IsNullOrEmpty(sts))
            {
                this.Page4.sty("meneame", pagecount, GetCountPage(count, page_nums), "?type=" + type
                    + "&st=" + Request.QueryString["st"]
                    + "&et=" + Request.QueryString["et"]
                    + "&page=");
            }
            else
            {
                this.Page4.sty("meneame", pagecount, GetCountPage(count, page_nums), "?type=" + type + "&page=");
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

        protected string SignJudge(object b)
        {
            string r = "";
            if (b.ToString().Contains("正常"))
                r = "<span style='color:#006600'>" + b + "</span>";
            else r = "<span style='color:#ff0000'>" + b + "</span>";
            return r;
        }

        protected string TypeStr()
        {
            string b = "", a = Request.QueryString["type"];
            switch (a)
            {
                case "1": b = " >> 上下班"; break;
                case "2": b = " >> 外出"; break;
                case "3": b = " >> 请假"; break;
                case "4": b = " >> 出差"; break;
                default: break;
            }
            return b;
        }

    }

}