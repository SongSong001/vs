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

namespace WC.WebUI.Mobile.AddrBook
{
    public partial class PublicAddrBook : WC.BLL.MobilePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["type"]))
            {
                Response.Redirect("PublicAddrBook.aspx?keywords="
                    + HttpContext.Current.Server.HtmlEncode(Request.Form["keywords"]));
            }
            if (!IsPostBack)
                Show();
        }

        private void Show()
        {
            if (!string.IsNullOrEmpty(Request.QueryString["keywords"]))
            {
                string keywords = Request.QueryString["keywords"];
                string where = " UserName like '%" + keywords + "%' or RealName like '%" + keywords
                + "%' or DepName like '%" + keywords + "%'  ";
                IList list1 = Sys_User.Init().GetAll(where, "Order BY DepID asc,orders asc, Phone DESC");
                rpt.DataSource = list1;
                rpt.DataBind();
            }
            else
            {
                int page_nums = 30;

                IList list1 = GetOrdersUser();
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

                pds.DataSource = list1;
                pds.AllowPaging = true;
                pds.PageSize = page_nums;
                pds.CurrentPageIndex = pagecount - 1;

                this.Page1.sty("meneame", pagecount, pds.PageCount, "?page=");

                num1.InnerHtml = list1.Count.ToString();
                rpt.DataSource = pds;
                rpt.DataBind();
            }

        }

        private IList GetOrdersUser()
        {
            object min = MsSqlOperate.ExecuteScalar(CommandType.Text, "select min(id) from sys_dep where ParentID=0");
            List<Sys_UserInfo> list = new List<Sys_UserInfo>();
            GetTreeItems(Convert.ToInt32(min), list);
            return list;
        }

        private void GetTreeItems(int did, IList li)
        {
            IList list = Sys_User.Init().GetAll("DepID=" + did, "order by status asc,orders asc, Phone DESC");
            foreach (object obj in list)
            {
                if (!li.Contains(obj))
                    li.Add(obj);
            }

            IList father_dep_list = Sys_Dep.Init().GetAll("ParentID=" + did, "order by orders asc");
            if (father_dep_list.Count != 0)
            {
                foreach (Sys_DepInfo item in father_dep_list)
                {
                    GetTreeItems(item.id, li);
                }
            }
        }

    }
}