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

namespace WC.WebUI.Manage.Gov
{
    public partial class Gov_Recipient : WC.BLL.ViewPages
    {
        protected string flow_list = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!string.IsNullOrEmpty(Request.QueryString["action"]))
                {
                    Show(Request.QueryString["action"]);
                }
                else
                {
                    Response.Write("<script>alert('非法的请求!');window.location='Gov_Recipient.aspx?action=archived'</script>");
                }
            }
        }

        protected void Search_Btn(object sender, EventArgs e)
        {
            string keywords = Request.Form["keyword"];
            string url = "?action=" + Request.QueryString["action"] + "&keywords=" + keywords;
            Response.Redirect("Gov_Recipient.aspx" + url);
        }

        private void Show(string type)
        {
            SqlParameter rid = new SqlParameter();
            rid.ParameterName = "@uid";
            rid.Size = 50;
            rid.Value = Uid;

            SqlParameter sqlpt1 = new SqlParameter();
            sqlpt1.Direction = ParameterDirection.Output;
            sqlpt1.ParameterName = "@pt1";
            sqlpt1.Size = 7;

            SqlParameter sqlpt2 = new SqlParameter();
            sqlpt2.Direction = ParameterDirection.Output;
            sqlpt2.ParameterName = "@pt2";
            sqlpt2.Size = 7;

            SqlParameter sqlpt3 = new SqlParameter();
            sqlpt3.Direction = ParameterDirection.Output;
            sqlpt3.ParameterName = "@pt3";
            sqlpt3.Size = 7;

            SqlParameter[] sqls = { sqlpt1, sqlpt2, sqlpt3, rid };
            MsSqlOperate.ExecuteNonQuery(CommandType.StoredProcedure, "Gov_GetRecipientCount", sqls);
            wdpy.InnerText = sqlpt1.Value + "";
            yjpy.InnerText = sqlpt2.Value + "";
            wdsq.InnerText = sqlpt3.Value + "";


            //IList list = null;
            if (type == "verify")
            {
                flow_list = ">> 公文签收";
                if (!string.IsNullOrEmpty(Request.QueryString["keywords"]))
                {
                    string key = Request.QueryString["keywords"];
                    string words = " and (a.Flow_Name like '%" + key + "%' or a.CreatorRealName like '%"
                    + key + "%' ) ";
                    string sql = "select a.* from Gov a,Gov_Recipient b where a.id=b.Flow_ID and a.status=1 and b.sign=0 and b.UserID=" + Uid + words + " order by a.id desc";
                    using (DataSet ds = MsSqlOperate.ExecuteDataset(CommandType.Text, sql))
                    {
                        CutPage(ds, "verify");
                    }
                }
                else
                {
                    string sql = "select a.* from Gov a,Gov_Recipient b where a.id=b.Flow_ID and a.status=1 and b.sign=0 and b.UserID=" + Uid + " order by a.id desc";
                    using (DataSet ds = MsSqlOperate.ExecuteDataset(CommandType.Text, sql))
                    {
                        CutPage(ds, "verify");
                    }
                }
            }

            if (type == "verified")
            {
                flow_list = ">> 已签收公文";
                if (!string.IsNullOrEmpty(Request.QueryString["keywords"]))
                {
                    string key = Request.QueryString["keywords"];
                    string words = " and (a.Flow_Name like '%" + key + "%' or a.CreatorRealName like '%"
                    + key + "%' ) ";
                    string sql = "select a.* from Gov a,Gov_Recipient b where a.id=b.Flow_ID and a.status=1 and b.sign=1 and b.UserID=" + Uid + words + " order by a.id desc";
                    using (DataSet ds = MsSqlOperate.ExecuteDataset(CommandType.Text, sql))
                    {
                        CutPage(ds, "verified");
                    }
                }
                else
                {
                    string sql = "select a.* from Gov a,Gov_Recipient b where a.id=b.Flow_ID and a.status=1 and b.sign=1 and b.UserID=" + Uid + " order by a.id desc";
                    using (DataSet ds = MsSqlOperate.ExecuteDataset(CommandType.Text, sql))
                    {
                        CutPage(ds, "verified");
                    }
                }
            }

            if (type == "archived")
            {
                flow_list = ">> 已归档公文";
                if (!string.IsNullOrEmpty(Request.QueryString["keywords"]))
                {
                    string key = Request.QueryString["keywords"];
                    string words = " and (a.Flow_Name like '%" + key + "%' or a.CreatorRealName like '%"
                    + key + "%' ) ";
                    string sql = "select a.* from Gov a,Gov_Recipient b where a.id=b.Flow_ID and a.status=5 and b.UserID=" + Uid + words + " order by a.id desc";
                    using (DataSet ds = MsSqlOperate.ExecuteDataset(CommandType.Text, sql))
                    {
                        CutPage(ds, "archived");
                    }
                }
                else
                {
                    string sql = "select a.* from Gov a,Gov_Recipient b where a.id=b.Flow_ID and a.status=5 and b.UserID=" + Uid + " order by a.id desc";
                    using (DataSet ds = MsSqlOperate.ExecuteDataset(CommandType.Text, sql))
                    {
                        CutPage(ds, "archived");
                    }
                }

            }

        }

        private void CutPage(IList list, string action)
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
            PagedDataSource pds = new PagedDataSource();

            pds.DataSource = list;
            pds.AllowPaging = true;
            pds.PageSize = page_nums;
            pds.CurrentPageIndex = pagecount - 1;
            rpt.DataSource = pds;
            rpt.DataBind();

            if (string.IsNullOrEmpty(Request.QueryString["keywords"]))
                this.Page1.sty("meneame", pagecount, pds.PageCount, "?action=" + action + "&page=");

            if (!string.IsNullOrEmpty(Request.QueryString["keywords"]))
                this.Page1.sty("meneame", pagecount, pds.PageCount, "?action=" + action + "&keywords=" + Request.QueryString["keywords"] + "&page=");

            rpt.DataSource = pds;
            rpt.DataBind();
            num.InnerHtml = "当前查询条件总计 - <span style='color:#ff0000; font-weight:bold;'>" + list.Count + "</span> 条 记录数据";

        }

        private void CutPage(DataSet ds, string action)
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
            PagedDataSource pds = new PagedDataSource();

            pds.DataSource = ds.Tables[0].DefaultView;
            pds.AllowPaging = true;
            pds.PageSize = page_nums;
            pds.CurrentPageIndex = pagecount - 1;
            rpt.DataSource = pds;
            rpt.DataBind();

            if (string.IsNullOrEmpty(Request.QueryString["keywords"]))
                this.Page1.sty("meneame", pagecount, pds.PageCount, "?action=" + action + "&page=");

            if (!string.IsNullOrEmpty(Request.QueryString["keywords"]))
                this.Page1.sty("meneame", pagecount, pds.PageCount, "?action=" + action + "&keywords=" + Request.QueryString["keywords"] + "&page=");

            rpt.DataSource = pds;
            rpt.DataBind();
            num.InnerHtml = "当前查询条件总计 - <span style='color:#ff0000; font-weight:bold;'>" + ds.Tables[0].Rows.Count + "</span> 条 记录数据";
        }


        protected string GetStatus(object obj)
        {
            int t = Convert.ToInt32(obj);
            if (t == 0)
            {
                if (Request.QueryString["action"] == "verify")
                {
                    return "<span style='color:#ff0000;'>待审批</span>";
                }
                else
                {
                    return "<span style='color:#ff0000;'>审批中</span>";
                }
            }
            else if (t == 1)
            {
                return "<span style='color:#006600;font-weight:bold'>已签发</span>";
            }
            else if (t == -1)
            {
                return "<span style='color:#999999;font-weight:bold'>已锁定</span>";
            }
            else if (t == -2)
            {
                return "<span style='color:black;font-weight:bold'>已退回</span>";
            }
            else if (t == 5)
            {
                return "<span style='color:black;font-weight:bold'>已归档</span>";
            }
            else
            {
                return "<span style='color:blue;'>已过期</span>";
            }
        }

        protected string GetTrTitle(object t)
        {
            string r = "";
            string action = Request.QueryString["action"];
            if (!string.IsNullOrEmpty(action))
            {
                if (action.ToLower().Contains("verify"))
                    r = "您需要签收的公文：" + t;
                if (action.ToLower().Contains("verified"))
                    r = "您已经签收的公文：" + t;
                if (action.ToLower().Contains("archived"))
                    r = "归档的公文：" + t;
            }
            return r;
        }

        protected string GetSelected(string i)
        {
            string f = Request.QueryString["action"] + "";
            if (f == i + "")
                return "class='selected'";
            else return "";
        }


    }
}
