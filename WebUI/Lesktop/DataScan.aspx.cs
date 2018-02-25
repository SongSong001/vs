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

namespace WC.WebUI.Lesktop
{
    public partial class DataScan : WC.BLL.ViewPages
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["type"] == "1")
            {
                IList list = Sys_User.Init().GetAll("Status=0", "order by id asc");
                int n = 0;
                foreach (object obj in list)
                {
                    Sys_UserInfo ui = obj as Sys_UserInfo;
                    WC.WebUI.Dk.Help.UpdateIMUser(ui);
                    n++;
                }
                Response.Write("<script>alert('IM用户数据已完成扫描！(总计" + n + "个)');window.close()</script>");
            }
            if (!string.IsNullOrEmpty(Request.QueryString["u"]))
            {
                IList list = Sys_User.Init().GetAll("username='" + Request.QueryString["u"] + "'", null);
                if (list.Count > 0)
                {
                    Sys_UserInfo ui = list[0] as Sys_UserInfo;
                    WC.WebUI.Dk.Help.UpdateIMUser(ui);
                    Response.Redirect("Default.aspx");
                }
            }
        }
    }
}
