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

namespace WC.WebUI.Manage.Sys
{
    public partial class User_LoginList : WC.BLL.ModulePages
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Show();
            }
        }

        protected void Del_Btn(object obj, EventArgs e)
        {
            LinkButton lb = obj as LinkButton;
            RepeaterItem ri = lb.Parent as RepeaterItem;
            HtmlInputCheckBox hick = ri.FindControl("chk") as HtmlInputCheckBox;
            int rid = Convert.ToInt32(hick.Value);
            //MeetingInfo mi = WC.BLL.Meeting.Init().GetById(rid);
            //Dk.Help.DeleteFiles(mi.FilePath);
            WC.BLL.Sys_UserLogin.Init().Delete(rid);
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
                    //MeetingInfo mi = WC.BLL.Meeting.Init().GetById(rid);
                    //Dk.Help.DeleteFiles(mi.FilePath);
                    WC.BLL.Sys_UserLogin.Init().Delete(rid);
                }
            }
            Show();
        }

        private void Show()
        {
            //每页显示数
            int page_nums = 50;

            //分页显示
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
            int count = Convert.ToInt32(MsSqlOperate.ExecuteScalar(CommandType.Text,
                "select count(*) from Sys_UserLogin ", null));

            num.InnerHtml = "当前查询条件总计 - <span style='color:#ff0000; font-weight:bold;'>" + count + "</span> 条 记录数据";
            string sql_rpt = "select top " + page_nums + " * from Sys_UserLogin "
                + " order by id desc";
            if (pagecount != 1)
                sql_rpt = "SELECT TOP " + page_nums
                    + " * FROM Sys_UserLogin WHERE id<(SELECT MIN(id) FROM (SELECT TOP "
                    + nums.ToString() + " id FROM Sys_UserLogin ORDER BY id DESC) T1) ORDER BY id DESC";

            Bind(sql_rpt, rpt);

            this.Page1.sty("meneame", pagecount, GetCountPage(count, page_nums), "?page=");


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