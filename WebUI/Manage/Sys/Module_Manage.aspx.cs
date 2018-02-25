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
    public partial class Module_Manage : WC.BLL.ModulePages
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["mid"]) && !IsPostBack)
            {
                Show(Request.QueryString["mid"]);
            }
        }

        private void Show(string id)
        {
            Sys_ModuleInfo sm = Sys_Module.Init().GetById(Convert.ToInt32(id));
            ViewState["sm"] = sm;
            IsShow.Checked = Convert.ToBoolean(sm.IsShow);
            ModuleName.Value = sm.ModuleName;
            ModuleUrl.Value = sm.ModuleUrl;
            Notes.Value = sm.Notes;
            Orders.Value = sm.Orders + "";
            TypeName.Value = sm.TypeName;
        }

        protected void Save_Btn(object obj, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["mid"]))
            {
                Sys_ModuleInfo sm = ViewState["sm"] as Sys_ModuleInfo;
                sm.IsShow = Convert.ToInt32(IsShow.Checked);
                sm.ModuleName = ModuleName.Value;
                sm.ModuleUrl = ModuleUrl.Value;
                sm.Notes = Notes.Value;
                sm.Orders = Convert.ToInt32(Orders.Value);
                sm.TypeName = TypeName.Value;
                Sys_Module.Init().Update(sm);

                string words = HttpContext.Current.Server.HtmlEncode("您好!模块权限已编辑成功!");
                Response.Redirect("/InfoTip/Operate_Success.aspx?returnpage="
                + Request.Url.AbsoluteUri + "&tip=" + words);
            }
            else
            {
                Sys_ModuleInfo sm = new Sys_ModuleInfo();
                sm.IsShow = Convert.ToInt32(IsShow.Checked);
                sm.ModuleName = ModuleName.Value;
                sm.ModuleUrl = ModuleUrl.Value;
                sm.Notes = Notes.Value;
                sm.Orders = Convert.ToInt32(Orders.Value);
                sm.TypeName = TypeName.Value;

                Sys_Module.Init().Add(sm);

                string words = HttpContext.Current.Server.HtmlEncode("您好!模块权限已添加成功!");
                Response.Redirect("/InfoTip/Operate_Success.aspx?returnpage="
                + Request.Url.AbsoluteUri + "&tip=" + words);
            }
        }
    }
}
