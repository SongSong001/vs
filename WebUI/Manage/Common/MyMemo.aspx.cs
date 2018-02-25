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
using WC.DBUtility;
using WC.Model;

namespace WC.WebUI.Manage.Common
{
    public partial class MyMemo : WC.BLL.ViewPages
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                Show();
        }

        private void Show()
        {
            IList list = Sys_User.Init().GetAll(" et6 like '%#" + Uid +"#%' ", "order by MemoShare desc,depid asc,orders asc");
            rpt.DataSource = list;
            rpt.DataBind();

            num.InnerHtml = "您当前拥有 总计 - <span style='color:#ff0000; font-weight:bold;'>" + list.Count + "</span> 个 下属信息";
        }

        protected string GetStatus(object j)
        {
            string t = "<span style='color:{0};font-weight:bold'>{1}</span>";
            string r = "";
            if (Convert.ToInt32(j) == 0)
                r = string.Format(t, "#0066ff", "未启用 日程汇报");
            if (Convert.ToInt32(j) == 1)
                r = string.Format(t, "#ff0000", "已启用 日程汇报");
            return r;
        }

        protected string GetView(object b, object j)
        {
            string t = "<a href=Memo_SubList.aspx?uid={0} class='show'>查看下属日程</a>";
            string r = "";
            if (Convert.ToInt32(j) == 1)
                r = string.Format(t, b);
            return r;
        }

    }
}
