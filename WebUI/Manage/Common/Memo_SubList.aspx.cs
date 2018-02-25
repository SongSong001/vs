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
    public partial class Memo_SubList : WC.BLL.ViewPages
    {
        protected string uname = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!string.IsNullOrEmpty(Request.QueryString["uid"]))
                    Show(Convert.ToInt32(Request.QueryString["uid"]));
            }
        }

        protected void Search_Btn(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["uid"]))
            {
                string st = HttpContext.Current.Server.HtmlEncode(Request.Form["StartTime"].Trim());
                string et = HttpContext.Current.Server.HtmlEncode(Request.Form["EndTime"].Trim());

                string url = "?uid=" + Request.QueryString["uid"] + "&st=" + st + "&et=" + et;
                Response.Redirect("Memo_SubList.aspx" + url);
            }
        }

        private void Show(int uid)
        {
            Sys_UserInfo su = Sys_User.Init().GetById(uid);
            if (!su.et6.Contains("#" + Uid + "#"))
                Response.Write("<script>alert('您不是" + su.RealName + "(" + su.DepName + ")的直接上级,无权查看他的工作日程');window.location='/manage/common/MyMemo.aspx'</script>");
            uname = su.RealName + " (" + su.DepName + ")";

            //每页显示数
            int page_nums = 30;

            string where = " and 1=1 ";
            string st = Request.QueryString["st"];
            string et = Request.QueryString["et"];

            if (!string.IsNullOrEmpty(st) && !string.IsNullOrEmpty(et))
            {
                st = st.Replace("-", "");
                et = et.Replace("-", "");
                where += " and (SUBSTRING(STime, 1, 8) between " + st + " and " + et + ")";
            }

            if (!string.IsNullOrEmpty(st) && string.IsNullOrEmpty(et))
            {
                st = st.Replace("-", "");
                where += " and (SUBSTRING(STime, 1, 8) between " + st + " and CONVERT(varchar(50), GETDATE(), 112))";
            }

            if (string.IsNullOrEmpty(st) && !string.IsNullOrEmpty(et))
            {
                et = et.Replace("-", "");
                where += " and (SUBSTRING(STime, 1, 8) between CONVERT(varchar(50), GETDATE(), 112) and " + et + ")";
            }

            string sql = "SELECT DISTINCT SUBSTRING(STime, 1, 8) AS s FROM  Calendar where uid='"
                         + uid + "' " + where + " ORDER BY s DESC";

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

            using (DataSet ds = MsSqlOperate.ExecuteDataset(CommandType.Text, sql))
            {
                num.InnerHtml = "当前查询条件总计 - <span style='color:#ff0000; font-weight:bold;'>" + ds.Tables[0].Rows.Count + "</span> 条 记录数据 每页30条";
                
                pds.DataSource = ds.Tables[0].DefaultView;
                pds.AllowPaging = true;
                pds.PageSize = page_nums;
                pds.CurrentPageIndex = pagecount - 1;
                rpt.DataSource = pds;
                rpt.DataBind();

                if (!string.IsNullOrEmpty(Request.QueryString["st"]) && !string.IsNullOrEmpty(Request.QueryString["et"]))
                {
                    this.Page1.sty("meneame", pagecount, pds.PageCount, "?uid="+Request.QueryString["uid"]+"&st=" 
                        + Request.QueryString["st"]+"&et="+ Request.QueryString["et"] + "&page=");
                }
                else
                {
                    this.Page1.sty("meneame", pagecount, pds.PageCount, "?uid=" + Request.QueryString["uid"] + "&page=");
                }

            }

        }

        protected string GetDate(object j)
        {
            string s = j + "";
            if (s.Length == 8 && WC.Tool.Utils.IsNumber(s))
            {
                string t = s.Substring(0, 4) + "-" + s.Substring(4, 2) + "-" + s.Substring(6, 2);
                s = WC.Tool.Utils.ConvertDate4(t);
            }
            return s;
        }

        protected void DownLoad(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["uid"]))
            {
                string tt = "";
                string url = "Memo_Download.aspx?uid=" + Request.QueryString["uid"] + "&tt={0}";
                foreach (RepeaterItem item in rpt.Items)
                {
                    HtmlInputCheckBox hick = item.FindControl("chk") as HtmlInputCheckBox;
                    if (hick.Checked)
                    {
                        tt += hick.Value + ";";
                    }
                }
                if (!string.IsNullOrEmpty(tt))
                {
                    url = string.Format(url, tt);
                    Response.Redirect(url);
                }

            }
        }

    }
}
