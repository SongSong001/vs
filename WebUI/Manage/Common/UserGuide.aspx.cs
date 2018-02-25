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
using WC.Tool;

namespace WC.WebUI.Manage.Common
{
    public partial class UserGuide : WC.BLL.ViewPages
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
            Response.Redirect("UserGuide.aspx" + url);
        }

        private void Show()
        {
            //根据分页配置文件 获取权限分页设置
            Hashtable page_ht = (Hashtable)HttpContext.Current.Application["config_fenye"];
            //每页显示数
            int page_nums = Convert.ToInt32(page_ht["fenye_commom"]);

            IList list = Sys_User.Init().GetAll(null, "order by status asc,depid asc,orders asc");
            string tmp = "1=1";
            string keywords = Request.QueryString["keywords"];
            if (!string.IsNullOrEmpty(keywords)
                && WC.Tool.Utils.CheckSql(keywords))
            {
                tmp = " UserName like '%" + keywords + "%' or RealName like '%" + keywords
                + "%' or DepName like '%" + keywords + "%' ";
                list = Sys_User.Init().GetAll(tmp, "order by status asc,depid asc,orders asc");
            }
            if (!string.IsNullOrEmpty(Request.QueryString["did"]))
            {
                list = new List<Sys_UserInfo>();
                GetTreeItems(Convert.ToInt32(Request.QueryString["did"]), list);
            }

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

            if (string.IsNullOrEmpty(Request.QueryString["keywords"]) && string.IsNullOrEmpty(Request.QueryString["did"]))
                this.Page1.sty("meneame", pagecount, pds.PageCount, "?page=");

            if (!string.IsNullOrEmpty(Request.QueryString["keywords"]))
            {
                this.Page1.sty("meneame", pagecount, pds.PageCount, "?keywords=" + Request.QueryString["keywords"] + "&page=");
            }

            if (!string.IsNullOrEmpty(Request.QueryString["did"]))
            {
                this.Page1.sty("meneame", pagecount, pds.PageCount, "?did=" + Request.QueryString["did"] + "&page=");
            }
            num.InnerHtml = "当前查询条件总计 - <span style='color:#ff0000; font-weight:bold;'>" + list.Count + "</span> 条 记录数据";
        }

        private void GetTreeItems(int did, IList li)
        {
            IList list = Sys_User.Init().GetAll("DepID=" + did, "order by status asc,orders asc");
            foreach (object obj in list)
            {
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

        protected string GetAges(object obj)
        {
            string str = "";
            if (obj != null)
            {
                if (!string.IsNullOrEmpty(Convert.ToString(obj)))
                {
                    str = " (" + WC.Tool.Utils.GetAgeByDatetime(obj).Split(',')[0] + ")";
                }
            }
            return str;
        }
    }
}
