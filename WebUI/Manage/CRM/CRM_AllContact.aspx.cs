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
    public partial class CRM_AllContact : WC.BLL.ViewPages
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                Show();
        }

        protected void Del_Btn(object obj, EventArgs e)
        {
            LinkButton lb = obj as LinkButton;
            RepeaterItem ri = lb.Parent as RepeaterItem;
            HtmlInputCheckBox hick = ri.FindControl("chk") as HtmlInputCheckBox;
            int rid = Convert.ToInt32(hick.Value);
            WC.BLL.CRM_Contact.Init().Delete(rid);
            Show();
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
            Show();
        }

        protected void Search_Btn(object sender, EventArgs e)
        {
            string keywords = Request.Form["keyword"];
            string url = "?keywords=" + HttpContext.Current.Server.HtmlEncode(keywords.Trim());
            Response.Redirect("CRM_AllContact.aspx" + url);
        }

        private void Show()
        {
            //根据分页配置文件 获取权限分页设置
            Hashtable page_ht = (Hashtable)HttpContext.Current.Application["config_fenye"];
            //每页显示数
            int page_nums = Convert.ToInt32(page_ht["fenye_commom"]);

            string tmp = "1=1";
            string keywords = Request.QueryString["keywords"];
            if (!string.IsNullOrEmpty(keywords)
                && WC.Tool.Utils.CheckSql(keywords))
            {
                tmp = " (a.CRM_Name like '%" + keywords + "%' or b.ContactAim like '%" + keywords + "%') ";
            }
            string sql = "select a.id as crmid,a.CRM_Name as crm,b.id as contactid,b.ContactAim as ContactTitle,b.addtime as ContactTime from crm a,crm_contact b where a.id=b.cid and a.CreatorID=" + Uid + " and " + tmp +" order by b.id desc";
            DataSet ds = MsSqlOperate.ExecuteDataset(CommandType.Text, sql);

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

            pds.DataSource = ds.Tables[0].DefaultView;
            pds.AllowPaging = true;
            pds.PageSize = page_nums;
            pds.CurrentPageIndex = pagecount - 1;
            rpt.DataSource = pds;
            rpt.DataBind();

            if (!string.IsNullOrEmpty(Request.QueryString["keywords"]))
            {
                this.Page1.sty("meneame", pagecount, pds.PageCount, "?keywords=" + Request.QueryString["keywords"] + "&page=");
            }
            else
            {
                this.Page1.sty("meneame", pagecount, pds.PageCount, "?page=");
            }

            rpt.DataSource = pds;
            rpt.DataBind();
            num.InnerHtml = "当前查询条件总计 - <span style='color:#ff0000; font-weight:bold;'>" + ds.Tables[0].Rows.Count + "</span> 条 记录数据";

            ds.Dispose();
        }

    }
}
