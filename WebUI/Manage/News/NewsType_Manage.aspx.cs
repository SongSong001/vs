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
    public partial class NewsType_Manage : WC.BLL.ModulePages
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
            News_TypeInfo ni = News_Type.Init().GetById(Convert.ToInt32(id));
            ViewState["ni"] = ni;
            TypeName.Value = ni.TypeName;
            Orders.Value = ni.Orders + "";
            Notes.Value = ni.Notes;

        }

        protected void Save_Btn(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["tid"]))
            {
                News_TypeInfo ni = ViewState["ni"] as News_TypeInfo;
                ni.Notes = Notes.Value;
                ni.TypeName = TypeName.Value;
                ni.Orders = Convert.ToInt32(Orders.Value);
                News_Type.Init().Update(ni);
            }
            else
            {
                News_TypeInfo ni = new News_TypeInfo();
                ni.TypeName = TypeName.Value;
                ni.Notes = Notes.Value;
                ni.Orders = Convert.ToInt32(Orders.Value);
                News_Type.Init().Add(ni);
            }
            string words = HttpContext.Current.Server.HtmlEncode("您好!分类保存成功!");
            Response.Redirect("/InfoTip/Operate_Success.aspx?returnpage="
            + "/Manage/News/NewsType_List.aspx" + "&tip=" + words);

        }

    }
}
