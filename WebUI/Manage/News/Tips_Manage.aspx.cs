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
using WC.Model;
using WC.BLL;

namespace WC.WebUI.Manage.News
{
    public partial class Tips_Manage : WC.BLL.ModulePages
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && !string.IsNullOrEmpty(Request.QueryString["tid"]))
            {
                Show(Request.QueryString["tid"]);
            }
        }

        private void Show(string id)
        {
            TipsInfo ni = WC.BLL.Tips.Init().GetById(Convert.ToInt32(id));
            ViewState["ni"] = ni;
            Tips.Value = ni.Tips;
            Orders.Value = ni.Orders + "";


        }

        protected void Save_Btn(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["tid"]))
            {
                TipsInfo ni = ViewState["ni"] as TipsInfo;
                ni.Tips = Tips.Value.Replace("\r\n", "").Replace("'", "");
                ni.Orders = Convert.ToInt32(Orders.Value);
                WC.BLL.Tips.Init().Update(ni);
            }
            else
            {
                TipsInfo ni = new TipsInfo();
                ni.Tips = Tips.Value.Replace("\r\n", "").Replace("'", "");
                ni.Orders = Convert.ToInt32(Orders.Value);
                WC.BLL.Tips.Init().Add(ni);
            }
            string words = HttpContext.Current.Server.HtmlEncode("您好!滚动公告保存成功!");
            Response.Redirect("/InfoTip/Operate_Success.aspx?returnpage="
            + "/Manage/News/Tips_List.aspx" + "&tip=" + words);

        }
    }
}
