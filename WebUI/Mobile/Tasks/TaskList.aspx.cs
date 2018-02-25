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

using WC.DBUtility;
using WC.BLL;
using WC.Model;
using WC.Tool;

namespace WC.WebUI.Mobile.Tasks
{
    public partial class TaskList : WC.BLL.MobilePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["t"]))
            {
                Response.Redirect("TaskList.aspx?type=" + Request.QueryString["t"] + "&keywords="
                    + HttpContext.Current.Server.HtmlEncode(Request.Form["keywords"]));
            }

            if (!IsPostBack && !string.IsNullOrEmpty(Request.QueryString["type"]))
            {
                string t = Request.QueryString["type"];
                if (t == "all" || t == "exeute" || t == "manage" || t == "create")
                    Show(t);
            }
        }

        private void Show(string tp)
        {
            IList list = null;

            if (!string.IsNullOrEmpty(Request.QueryString["keywords"]))
            {
                string sql = " 1=1 ";

                if (!string.IsNullOrEmpty(Request.QueryString["keywords"]))
                { sql += " and (TaskName like '%" + Request.QueryString["keywords"] + "%') "; }

                if (tp == "all")
                {
                    sql += " and ( ManageUserList like '%#" + Uid + "#%' or ExecuteUserList like '%#" + Uid + "#%' )";
                }
                if (tp == "exeute")
                {
                    sql += " and ( ExecuteUserList like '%#" + Uid + "#%' )";
                }
                if (tp == "manage")
                {
                    sql += " and ( ManageUserList like '%#" + Uid + "#%' )";
                }
                if (tp == "create")
                {
                    sql += " and ( CreatorID=" + Uid + " )";
                }

                list = WC.BLL.Tasks.Init().GetAll(sql, "order by id desc");
            }
            else
            {
                string sql = " 1=1 and ";
                if (tp == "all")
                {
                    if (!string.IsNullOrEmpty(Request.QueryString["td"]))
                    {
                        if (WC.Tool.Utils.IsNumber(Request.QueryString["td"]))
                        {
                            sql += " ( TypeID=" + Request.QueryString["td"]
                                + " ) and ( ManageUserList like '%#" + Uid + "#%' or ExecuteUserList like '%#" + Uid + "#%' )";
                        }
                    }
                    else
                        sql += " ( ManageUserList like '%#" + Uid + "#%' or ExecuteUserList like '%#" + Uid + "#%' )";
                }
                if (tp == "exeute")
                    sql += " ( ExecuteUserList like '%#" + Uid + "#%' )";
                if (tp == "manage")
                    sql += " ( ManageUserList like '%#" + Uid + "#%' )";
                if (tp == "create")
                    sql += " ( CreatorID=" + Uid + " )";

                list = WC.BLL.Tasks.Init().GetAll(sql, "order by id desc");
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

            pds.DataSource = list;
            pds.AllowPaging = true;
            pds.PageSize = page_nums;
            pds.CurrentPageIndex = pagecount - 1;
            rpt.DataSource = pds;
            rpt.DataBind();

            if (Request.QueryString["keywords"] == null)
                this.Page1.sty("meneame", pagecount, pds.PageCount, "?type=" + tp + "&page=");

            if (Request.QueryString["keywords"] != null)
            {
                this.Page1.sty("meneame", pagecount, pds.PageCount, "?keywords=" + Request.QueryString["keywords"]
                    + "&type=" + tp
                    + "&page=");
            }

            num.InnerHtml =  list.Count.ToString();

        }

    }
}