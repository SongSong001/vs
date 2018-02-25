using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
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

namespace WC.WebUI.Mobile.Mails
{
    public partial class MailList : WC.BLL.MobilePage
    {
        protected string mail_tags = "";
        protected string fid = "0";
        protected string t = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            t = (!string.IsNullOrEmpty(Request.QueryString["fid"])) ? Request.QueryString["fid"] : "0";

            if (!string.IsNullOrEmpty(Request.QueryString["fid"]))
            {
                fid = Request.QueryString["fid"];
                switch (fid)
                {
                    case "0": mail_tags = "收件箱"; break;
                    case "1": mail_tags = "草稿箱"; break;
                    case "2": mail_tags = "发件箱"; break;
                    case "3": mail_tags = "垃圾箱"; break;
                    default: mail_tags = "收件箱"; break;

                }
            }

            if (!string.IsNullOrEmpty(Request.QueryString["type"]))
            {
                Response.Redirect("MailList.aspx?fid=" + Request.QueryString["type"] + "&keywords="
                + HttpContext.Current.Server.HtmlEncode(Request.Form["keywords"]));
            }

            if (!IsPostBack)
            {
                if (!string.IsNullOrEmpty(Request.QueryString["fid"]))
                    Show(Request.QueryString["fid"]);
            }
        }

        private void Show(string fid)
        {
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
            string tmp = "FolderType=" + fid + " and ReceiverID=" + Uid;
            string keywords = Request.QueryString["keywords"];
            if (!string.IsNullOrEmpty(keywords)
                && WC.Tool.Utils.CheckSql(keywords))
            {
                tmp += " and (SenderRealName like '%" + keywords + "%' or SenderDepName like '%" + keywords
                + "%' or Subject like '%" + keywords + "%') ";
            }
            int count = Convert.ToInt32(MsSqlOperate.ExecuteScalar(CommandType.Text,
                        "select count(*) from Mails where " + tmp, null));
            num.InnerHtml =  count.ToString() ;

            string sql_rpt = "select top " + page_nums + " * from Mails where "
                            + tmp + " order by id desc";

            if (pagecount != 1)
                sql_rpt = "SELECT TOP " + page_nums
                    + " * FROM Mails WHERE id<(SELECT MIN(id) FROM (SELECT TOP "
                    + nums.ToString() + " id FROM Mails WHERE (" + tmp + " ) ORDER BY id DESC) T1) AND ("
                    + tmp + " ) ORDER BY id DESC";

            Bind(sql_rpt, rpt);
            if (string.IsNullOrEmpty(Request.QueryString["keywords"]))
            {
                this.Page1.sty("meneame", pagecount, GetCountPage(count, page_nums), "?fid=" + Request.QueryString["fid"] + "&page=");
            }
            if (!string.IsNullOrEmpty(Request.QueryString["keywords"]))
            {
                this.Page1.sty("meneame", pagecount, GetCountPage(count, page_nums), "?fid=" + Request.QueryString["fid"] + "&keywords=" + keywords + "&page=");
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