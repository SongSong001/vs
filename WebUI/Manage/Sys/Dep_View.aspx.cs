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

namespace WC.WebUI.Manage.Sys
{
    public partial class Dep_View : WC.BLL.ViewPages
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["uid"]))
            {
                Show(Request.QueryString["uid"]);
            }
            else
            {
                Response.Write("<script>alert('信息不存在!');window.close();</script>");
            }
        }

        private void Show(string uid)
        {
            Sys_DepInfo sd = Sys_Dep.Init().GetById(Convert.ToInt32(uid));
            UDepName5.InnerText = sd.DepName;
            Orders5.InnerText = sd.Orders + "";
            Notes5.InnerText = sd.Notes;
            IsPosition5.InnerText = sd.IsPosition == 0 ? "职位" : "部门";
            Phone5.InnerText = sd.Phone;
            if (sd.ParentID != 0)
            {
                Sys_DepInfo sd_father = Sys_Dep.Init().GetById(Convert.ToInt32(sd.ParentID));
                father5.InnerText = sd_father.DepName;
            }
            else
            {
                father5.InnerText = "无上级 部门/职位";
            }
        }
    }
}
