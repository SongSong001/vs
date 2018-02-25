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

using WC.DBUtility;
using WC.BLL;
using WC.Model;

namespace WC.WebUI.Mobile.News
{
    public partial class NewsMenu : WC.BLL.MobilePage
    {
        //private string s = "<li ><a href='NewsList.aspx?tid={0}' ><img src='../Style/Mobile/thumbs/start.png'/><span class='name'>{1} ({2})</span><span class='arrow'></span></a></li> ";
        private string s = "<li ><a href='NewsList.aspx?tid={0}' ><i class='icon icon_list{3}'></i>{1} ({2})</a></li> ";

        protected string news_menu = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Show();
            }
        }

        private void Show()
        {
            news_menu = "<li ><a href='NewsList.aspx' ><i class='icon icon_list16'></i>所有资讯 ({0})</a></li> ";
            news_menu = string.Format(news_menu, GetAllNums());
            IList list = News_Type.Init().GetAll(null, " order by orders asc");
            int cla = 17;
            for (int i = 0; i < list.Count; i++)
            {
                News_TypeInfo nt = list[i] as News_TypeInfo;
                news_menu += string.Format(s, nt.id, nt.TypeName,GetNumsByType(nt.id),cla.ToString());
                cla++;
            }

        }

        private string GetNumsByType(int typeid)
        {
            return MsSqlOperate.ExecuteScalar(CommandType.Text, "select count(id) from News_Article where typeid=" + typeid) + "";
        }

        private string GetAllNums()
        {
            return MsSqlOperate.ExecuteScalar(CommandType.Text, "select count(id) from News_Article") + "";
        }

    }
}