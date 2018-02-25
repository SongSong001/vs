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

namespace WC.WebUI.Manage.Common
{
    public partial class PublicAddrBook : WC.BLL.ViewPages
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                Show();
        }

        protected void Search_Btn(object sender, EventArgs e)
        {
            string keywords = Request.Form["keyword"];
            string url = "?keywords=" + keywords;
            Response.Redirect("PublicAddrBook.aspx" + url);
        }

        private void Show()
        {
            if (!string.IsNullOrEmpty(Request.QueryString["keywords"]))
            {
                string keywords = Request.QueryString["keywords"];
                string where = " UserName like '%" + keywords + "%' or RealName like '%" + keywords
                + "%' or DepName like '%" + keywords + "%'  ";
                IList list1 = Sys_User.Init().GetAll(where, "Order BY DepID asc,orders asc, Phone DESC");
                rpt_person.DataSource = list1;
                rpt_person.DataBind();
            }
            else
            {
                int page_nums = 50;

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

                num.InnerHtml = "当前查询条件总计 - <span style='color:#ff0000; font-weight:bold;'>" + list1.Count + "</span> 条 记录数据";
                rpt_person.DataSource = pds;
                rpt_person.DataBind();
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

        protected void DownLoad(object sender, EventArgs e)
        {
            IList list = Sys_User.Init().GetAll(" phone <>'' or tel <>'' ", "Order BY DepID asc,orders asc, Phone DESC");
            string ct = "人员通讯录\r\n\r\n";
            string fn = "People ContactsBook";
            foreach (object j in list)
            {
                Sys_UserInfo si = j as Sys_UserInfo;
                if (!string.IsNullOrEmpty(si.Tel) && !string.IsNullOrEmpty(si.Phone))
                {
                    ct += si.RealName + " (" + si.DepName + ")：移动电话:" + si.Phone + " 固定电话:" + si.Tel + "\r\n";
                }
                if (string.IsNullOrEmpty(si.Tel) && !string.IsNullOrEmpty(si.Phone))
                {
                    ct += si.RealName + " (" + si.DepName + ")：移动电话:" + si.Phone + "\r\n";
                }
                if (!string.IsNullOrEmpty(si.Tel) && string.IsNullOrEmpty(si.Phone))
                {
                    ct += si.RealName + " (" + si.DepName + ")：固定电话:" + si.Tel + "\r\n";
                }
            }
            Response.Clear();
            Response.ClearHeaders();
            Response.Buffer = false;

            Response.AppendHeader("Content-Disposition", "attachment;filename=" + fn + ".txt");
            Response.ContentType = "application/vnd.txt";
            Response.Write(ct);
            Response.Flush();
            Response.End();
        }

    }
}
