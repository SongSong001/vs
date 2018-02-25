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

using WC.DBUtility;
using WC.BLL;
using WC.Model;

namespace WC.WebUI.Manage.Paper
{
    public partial class PaperAllList : WC.BLL.ModulePages
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
            string TypeID = HttpContext.Current.Server.HtmlEncode(Request.Form["TypeID"].Trim());
            string PaperName = HttpContext.Current.Server.HtmlEncode(Request.Form["PaperName"].Trim());
            string PaperSymbol = HttpContext.Current.Server.HtmlEncode(Request.Form["PaperSymbol"].Trim());
            //string PaperNO = HttpContext.Current.Server.HtmlEncode(Request.Form["PaperNO"].Trim());
            string SendDep = HttpContext.Current.Server.HtmlEncode(Request.Form["SendDep"].Trim());
            string PaperGrade = HttpContext.Current.Server.HtmlEncode(Request.Form["PaperGrade"].Trim());
            //string PaperUrgency = HttpContext.Current.Server.HtmlEncode(Request.Form["PaperUrgency"].Trim());
            string StartTime = HttpContext.Current.Server.HtmlEncode(Request.Form["StartTime"].Trim());
            string EndTime = HttpContext.Current.Server.HtmlEncode(Request.Form["EndTime"].Trim());

            string url = "?TypeID=" + TypeID + "&PaperName=" + PaperName + "&PaperSymbol=" + PaperSymbol 
                + "&SendDep=" + SendDep
                + "&PaperGrade=" + PaperGrade
                + "&StartTime=" + StartTime + "&EndTime=" + EndTime;
            Response.Redirect("PaperAllList.aspx" + url);
        }

        protected void Del_Btn(object obj, EventArgs e)
        {
            LinkButton lb = obj as LinkButton;
            RepeaterItem ri = lb.Parent as RepeaterItem;
            HtmlInputCheckBox hick = ri.FindControl("chk") as HtmlInputCheckBox;
            int rid = Convert.ToInt32(hick.Value);
            PaperInfo ni = WC.BLL.Paper.Init().GetById(rid);
            Dk.Help.DeleteFiles(ni.FilePath);
            WC.BLL.Paper.Init().Delete(rid);
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
                    PaperInfo ni = WC.BLL.Paper.Init().GetById(rid);
                    Dk.Help.DeleteFiles(ni.FilePath);
                    WC.BLL.Paper.Init().Delete(rid);
                }
            }
            Show();
        }

        private void Show()
        {
            IList mlist = PaperType.Init().GetAll(null, null);
            TypeID.Items.Clear();
            TypeID.Items.Add(new ListItem("所有电子档案分类", ""));
            foreach (object obj in mlist)
            {
                PaperTypeInfo fmi = obj as PaperTypeInfo;
                TypeID.Items.Add(new ListItem(fmi.TypeName, fmi.id + ""));
            }

            IList list = null;

            if (!string.IsNullOrEmpty(Request.QueryString["TypeID"]) || !string.IsNullOrEmpty(Request.QueryString["PaperName"])
                || !string.IsNullOrEmpty(Request.QueryString["PaperSymbol"])
                || !string.IsNullOrEmpty(Request.QueryString["SendDep"]) || !string.IsNullOrEmpty(Request.QueryString["PaperGrade"])
                || !string.IsNullOrEmpty(Request.QueryString["StartTime"])
                || !string.IsNullOrEmpty(Request.QueryString["EndTime"]))
            {
                string TypeID1 = Request.QueryString["TypeID"];
                string PaperName1 = Request.QueryString["PaperName"];
                string PaperSymbol1 = Request.QueryString["PaperSymbol"];
                //string PaperNO1 = Request.QueryString["PaperNO"];
                string SendDep1 = Request.QueryString["SendDep"];
                string PaperGrade1 = Request.QueryString["PaperGrade"];
                //string PaperUrgency1 = Request.QueryString["PaperUrgency"];
                string StartTime1 = Request.QueryString["StartTime"];
                string EndTime1 = Request.QueryString["EndTime"];

                string where = " 1=1 ";

                if (!string.IsNullOrEmpty(TypeID1))
                { where += " and (TypeID=" + TypeID1 + ") "; }

                if (!string.IsNullOrEmpty(PaperName1))
                { where += " and (PaperName like '%" + PaperName1 + "%') "; }

                if (!string.IsNullOrEmpty(PaperSymbol1))
                { where += " and (PaperSymbol like '%" + PaperSymbol1 + "%') "; }

                //if (!string.IsNullOrEmpty(PaperNO1))
                //{ where += " and (PaperNO like '%" + PaperNO1 + "%') "; }

                if (!string.IsNullOrEmpty(SendDep1))
                { where += " and (SendDep like '%" + SendDep1 + "%') "; }

                if (!string.IsNullOrEmpty(PaperGrade1))
                { where += " and (PaperGrade like '%" + PaperGrade1 + "%') "; }

                //if (!string.IsNullOrEmpty(PaperUrgency1))
                //{ where += " and (PaperUrgency like '%" + PaperUrgency1 + "%') "; }


                if (!string.IsNullOrEmpty(StartTime1) && !string.IsNullOrEmpty(EndTime1))
                {
                    where += " and (PaperDate between '" + StartTime1 + "' and '" + EndTime1 + "')";
                }

                if (!string.IsNullOrEmpty(StartTime1) && string.IsNullOrEmpty(EndTime1))
                    where += " and (PaperDate between '" + StartTime1 + "' and getdate())";

                if (string.IsNullOrEmpty(StartTime1) && !string.IsNullOrEmpty(EndTime1))
                    where += " and (PaperDate between getdate() and '" + EndTime1 + "')";

                list = WC.BLL.Paper.Init().GetAll(where, "order by id desc");

            }
            else
            {
                list = WC.BLL.Paper.Init().GetAll(null, "order by id desc");
            }

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

            if (Request.QueryString["PaperName"] == null)
                this.Page1.sty("meneame", pagecount, pds.PageCount, "?page=");

            if (Request.QueryString["PaperName"] != null)
            {
                this.Page1.sty("meneame", pagecount, pds.PageCount, "?PaperName=" + Request.QueryString["PaperName"]
                    + "&TypeID=" + Request.QueryString["TypeID"]
                    + "&PaperSymbol=" + Request.QueryString["PaperSymbol"]
                    //+ "&PaperNO=" + Request.QueryString["PaperNO"]
                    + "&SendDep=" + Request.QueryString["SendDep"]
                    + "&PaperGrade=" + Request.QueryString["PaperGrade"]
                    //+ "&PaperUrgency=" + Request.QueryString["PaperUrgency"]
                    + "&StartTime=" + Request.QueryString["StartTime"]
                    + "&EndTime=" + Request.QueryString["EndTime"]
                    + "&page=");
            }

            num.InnerHtml = "当前查询条件总计 - <span style='color:#ff0000; font-weight:bold;'>" + list.Count + "</span> 条 记录数据";

        }

        protected string GetTypeName(object tid)
        {
            return WC.BLL.PaperType.Init().GetById(Convert.ToInt32(tid)).TypeName;
        }

    }
}