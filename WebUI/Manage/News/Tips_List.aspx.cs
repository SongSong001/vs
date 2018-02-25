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

namespace WC.WebUI.Manage.News
{
    public partial class Tips_List : WC.BLL.ModulePages
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                Show();
        }

        private void Show()
        {
            IList list = Tips.Init().GetAll(null, " order by orders asc");
            rpt.DataSource = list;
            rpt.DataBind();

            num.InnerHtml = "当前 总计 - <span style='color:#ff0000; font-weight:bold;'>" + list.Count + "</span> 个 记录数据";
        }

        protected void Del_Btn(object obj, EventArgs e)
        {
            LinkButton lb = obj as LinkButton;
            RepeaterItem ri = lb.Parent as RepeaterItem;
            HtmlInputCheckBox hick = ri.FindControl("chk") as HtmlInputCheckBox;
            int rid = Convert.ToInt32(hick.Value);

            Tips.Init().Delete(rid);

            Show();

        }
    }
}
