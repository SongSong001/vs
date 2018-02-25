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

namespace WC.WebUI.Manage.Flow
{
    public partial class Flow_List : WC.BLL.ViewPages
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
                    Response.Write("<script>alert('非法的请求!');window.location='Flow_Manage.aspx'</script>");
                }
            }
        }

        protected void Search_Btn(object sender, EventArgs e)
        {
            string keywords = Request.Form["keyword"];
            string url = "?action=" + Request.QueryString["action"] + "&keywords=" + keywords;
            Response.Redirect("Flow_List.aspx" + url);
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

            SqlParameter sqlpt4 = new SqlParameter();
            sqlpt4.Direction = ParameterDirection.Output;
            sqlpt4.ParameterName = "@pt4";
            sqlpt4.Size = 7;

            SqlParameter[] sqls = { sqlpt1, sqlpt2, sqlpt3, sqlpt4, rid };
            MsSqlOperate.ExecuteNonQuery(CommandType.StoredProcedure, "Flows_GetUserFlowBoxCount", sqls);
            wdpy.InnerText = sqlpt1.Value + "";
            yjpy.InnerText = sqlpt2.Value + "";
            wdsq.InnerText = sqlpt3.Value + "";
            view.InnerText = sqlpt4.Value + "";


            IList list = null;
            if (type == "verify")
            {
                flow_list = ">> 我的批阅";
                if (!string.IsNullOrEmpty(Request.QueryString["keywords"]))
                {
                    string key = Request.QueryString["keywords"];
                    string words = " (Flow_Name like '%" + key + "%' or CreatorRealName like '%"
                    + key + "%' ) ";
                    string sql = "select a.* from flows a where a.status=0 and a.CurrentStepUserList like '%#" + Uid +
                    "#%' and a.CurrentStepID not in (select b.OperationStepID from Flows_StepAction b where b.UserID="
                    + Uid + " and b.FlowID=a.id ) and " + words;
                    using (DataSet ds = MsSqlOperate.ExecuteDataset(CommandType.Text, sql))
                    {
                        CutPage(ds, "verify");
                    }
                }
                else
                {
                    string sql = "select a.* from flows a where a.status=0 and a.CurrentStepUserList like '%#" + Uid +
                    "#%' and a.CurrentStepID not in (select b.OperationStepID from Flows_StepAction b where b.UserID="
                    + Uid + " and b.FlowID=a.id ) order by a.id desc";

                    if (!string.IsNullOrEmpty(Request.QueryString["td"]))
                        sql = "select a.* from flows a where a.comid=" + Request.QueryString["td"] +
                            " and a.status=0 and a.CurrentStepUserList like '%#" + Uid +
                    "#%' and a.CurrentStepID not in (select b.OperationStepID from Flows_StepAction b where b.UserID="
                    + Uid + " and b.FlowID=a.id ) order by a.id desc";

                    using (DataSet ds = MsSqlOperate.ExecuteDataset(CommandType.Text, sql))
                    {
                        CutPage(ds, "verify");
                    }
                }
            }

            if (type == "verified")
            {
                flow_list = ">> 已经批阅";
                if (!string.IsNullOrEmpty(Request.QueryString["keywords"]))
                {
                    string key = Request.QueryString["keywords"];
                    string words = "(Flow_Name like '%" + key + "%' or CreatorRealName like '%" + key + "%' ) and ";
                    list = Flows.Init().GetAll(words + " HasOperatedUserList like '%#" + Uid + "#%'", "order by id desc");
                }
                else
                {
                    if (string.IsNullOrEmpty(Request.QueryString["td"]))
                        list = Flows.Init().GetAll("HasOperatedUserList like '%#" + Uid + "#%'", "order by id desc");
                    else list = Flows.Init().GetAll("comid=" + Request.QueryString["td"] + " and HasOperatedUserList like '%#" + Uid + "#%'", "order by id desc");
                }
                CutPage(list, "verified");
            }

            if (type == "apply")
            {
                flow_list = ">> 我的申请";
                if (!string.IsNullOrEmpty(Request.QueryString["keywords"]))
                {
                    string key = Request.QueryString["keywords"];
                    string words = "(Flow_Name like '%" + key + "%' or CreatorRealName like '%" + key + "%') and ";
                    list = Flows.Init().GetAll(words + " CreatorID=" + Uid, "order by id desc");
                }
                else
                {
                    if (string.IsNullOrEmpty(Request.QueryString["td"]))
                        list = Flows.Init().GetAll("CreatorID=" + Uid, "order by id desc");
                    else list = Flows.Init().GetAll("comid=" + Request.QueryString["td"] + " and CreatorID=" + Uid, "order by id desc");
                }
                CutPage(list, "apply");
            }

            if (type == "view")
            {
                flow_list = ">> 抄送呈报";
                if (!string.IsNullOrEmpty(Request.QueryString["keywords"]))
                {
                    string key = Request.QueryString["keywords"];
                    string words = "(Flow_Name like '%" + key + "%' or CreatorRealName like '%" + key + "%' ) and ";
                    list = Flows.Init().GetAll(words + " ViewUserList like '%#" + Uid + "#%'", "order by id desc");
                }
                else
                {
                    if (string.IsNullOrEmpty(Request.QueryString["td"]))
                        list = Flows.Init().GetAll("ViewUserList like '%#" + Uid + "#%'", "order by id desc");
                    else list = Flows.Init().GetAll("comid=" + Request.QueryString["td"] + " and ViewUserList like '%#" + Uid + "#%'", "order by id desc");
                }
                CutPage(list, "view"); 
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
            {
                if (string.IsNullOrEmpty(Request.QueryString["td"]))
                    this.Page1.sty("meneame", pagecount, pds.PageCount, "?action=" + action + "&page=");
                else
                    this.Page1.sty("meneame", pagecount, pds.PageCount, "?action=" + action + "&td=" + Request.QueryString["td"] + "&page=");
            }

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
            {
                if (string.IsNullOrEmpty(Request.QueryString["td"]))
                    this.Page1.sty("meneame", pagecount, pds.PageCount, "?action=" + action + "&page=");
                else
                    this.Page1.sty("meneame", pagecount, pds.PageCount, "?action=" + action + "&td=" + Request.QueryString["td"] + "&page=");
            }

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
                return "<span style='color:#006600;font-weight:bold'>已完成</span>";
            }
            else if (t == -1)
            {
                return "<span style='color:#999999;font-weight:bold'>已锁定</span>";
            }
            else if (t == -2)
            {
                return "<span style='color:black;font-weight:bold'>已退回</span>";
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
                    r = "您需要审批的流程：" + t;
                if (action.ToLower().Contains("verified"))
                    r = "您已经审批过的流程：" + t;
                if (action.ToLower().Contains("apply"))
                    r = "您申请的工作流程：" + t;
                if (action.ToLower().Contains("view"))
                    r = "抄送呈报给您的工作流程：" + t;
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
