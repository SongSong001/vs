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
using System.IO;
using WC.BLL;
using WC.Model;
using WC.DBUtility;
using WC.Tool;

namespace WC.WebUI.Manage.Sys
{
    public partial class HR_List : WC.BLL.ViewPages
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!string.IsNullOrEmpty(Request.QueryString["action"]))
                {
                    Show();
                }
                else
                {
                    Response.Write("<script>alert('信息不存在!');window.close();</script>");
                }
            }

        }

        protected void Search_Btn(object sender, EventArgs e)
        {
            string keywords = Request.Form["keyword"];
            string url = "?keywords=" + HttpContext.Current.Server.HtmlEncode(keywords.Trim());
            Response.Redirect("User_List.aspx" + url);
        }

        private void Show()
        {
            string action = Request.QueryString["action"];
            string tmp = "";


            if (action == "zz")
            {
                //tmp = " datediff(day,ZhuanZhengRQ,getdate())<7 ";
                tmp = " 1=1 ";
            }

            int count = Convert.ToInt32(MsSqlOperate.ExecuteScalar(CommandType.Text, "select count(id) from SysHR where " + tmp, null));
            num.InnerHtml = "当前查询条件总计 - <span style='color:#ff0000; font-weight:bold;'>" + count + "</span> 条 记录数据";

            string sql = "select * from SysHR where " + tmp + "order by id desc";
            //每页显示数
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

            using (DataSet ds = MsSqlOperate.ExecuteDataset(CommandType.Text, sql))
            {
                num.InnerHtml = "当前查询条件总计 - <span style='color:#ff0000; font-weight:bold;'>" + ds.Tables[0].Rows.Count + "</span> 条 记录数据 每页30条";

                pds.DataSource = ds.Tables[0].DefaultView;
                pds.AllowPaging = true;
                pds.PageSize = page_nums;
                pds.CurrentPageIndex = pagecount - 1;
                rpt.DataSource = pds;
                rpt.DataBind();

                this.Page1.sty("meneame", pagecount, pds.PageCount, "?action=" + Request.QueryString["action"] + "&page=");

            }

        }

        protected void RowDataBind(object sender, RepeaterItemEventArgs e)
        {
            Label clab = e.Item.FindControl("c") as Label;
            PlaceHolder ph = e.Item.FindControl("p1") as PlaceHolder;
            string uid = clab.Text;
            List<WC.Model.Sys_UserInfo> online_ht = Application["user_online"] as List<WC.Model.Sys_UserInfo>;
            if (online_ht != null)
            {
                online_ht.Find(
                    delegate(WC.Model.Sys_UserInfo s)
                    {
                        if ((s.id.ToString() == uid) && s.Status == 0)
                        {
                            ph.Visible = false;
                            return true;
                        }
                        else return false;
                    }
                );
            }

            ph.Visible = true;
        }

        protected string GetTime(object j, string type)
        {
            string s = "";
            DateTime tm;
            if (type == Request.QueryString["action"])
            {
                if (true == DateTime.TryParse(j + "", out tm))
                {
                    s = WC.Tool.Utils.ConvertDate0(tm);
                }
            }
            return s;
        }

        protected string GetDate(object j, string type)
        {
            string s = "";
            if (type == Request.QueryString["action"])
                s = j + "";
            return s;
        }

    }
}