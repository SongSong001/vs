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
using WC.Model;
using WC.Tool;

namespace WC.WebUI.Mobile.Users
{
    public partial class User_OnLine : WC.BLL.MobilePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Show();
        }

        private void Show()
        {

            IList<Sys_UserInfo> list = Application["user_online"] as IList<Sys_UserInfo>;

            foreach (object item in list)
            {
                Sys_UserInfo ui = item as Sys_UserInfo;

                if (ui.IsOnline == 1 && ui.LastLoginTime.AddMinutes(60) < DateTime.Now)
                {
                    ui.IsOnline = 0;
                }
            }

            using (DataSet ds = WC.Tool.Utils.ConvertListToDataSet<Sys_UserInfo>(list))
            {
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

                DataTable table = ds.Tables[0];
                
                foreach (DataRow row in table.Rows)
                {
                    if (!string.IsNullOrEmpty(row["PerPic"].ToString()))
                    {
                        row["PerPic"] = "../../Files/common/" + row["PerPic"];
                    }
                    else
                    {
                        row["PerPic"] = "../image/user.jpg";
                    }
                }
                DataView dv = table.DefaultView;
                dv.Sort = "IsOnline Desc,LastLoginTime Desc";
                dv.RowFilter = "IsOnline<>9"; //设置删除人员 在线用户状态

                pds.DataSource = dv;
                pds.AllowPaging = true;
                pds.PageSize = page_nums;
                pds.CurrentPageIndex = pagecount - 1;

                this.Page1.sty("meneame", pagecount, pds.PageCount, "?page=");

                // num.InnerHtml = "当前总计 - <span style='color:#ff0000; font-weight:bold;'>" + ds.Tables[0].Select("IsOnline=1").Length + "</span> 位 在线用户";
                num1.InnerHtml =  ds.Tables[0].Select("IsOnline=1").Length.ToString() ;
                rpt_person.DataSource = pds;
                rpt_person.DataBind();
            }
        }
    }
}