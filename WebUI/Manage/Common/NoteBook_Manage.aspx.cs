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

namespace WC.WebUI.Manage.Common
{
    public partial class NoteBook_Manage : WC.BLL.ViewPages
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && !string.IsNullOrEmpty(Request.QueryString["nid"]))
                Show();
        }

        private void Show()
        {
            NoteBookInfo ni = WC.BLL.NoteBook.Init().GetById(Convert.ToInt32(Request.QueryString["nid"]));
            Bodys.Value = ni.Bodys;
            Subject.Value = ni.Subject;
            ViewState["ni"] = ni;
        }

        protected void Save_Btn(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(Request.QueryString["nid"]))
            {
                NoteBookInfo ni = new NoteBookInfo();
                ni.AddTime = DateTime.Now;
                ni.Bodys = Bodys.Value;
                ni.DepName = DepName;
                ni.RealName = RealName;
                ni.UserID = Convert.ToInt32(Uid);
                ni.Subject = Subject.Value;
                WC.BLL.NoteBook.Init().Add(ni);
            }
            else
            {
                NoteBookInfo ni = ViewState["ni"] as NoteBookInfo;
                ni.AddTime = DateTime.Now;
                ni.Bodys = Bodys.Value;
                ni.Subject = Subject.Value;
                WC.BLL.NoteBook.Init().Update(ni);
            }

            string words = HttpContext.Current.Server.HtmlEncode("您好!记事便笺保存成功!");
            Response.Redirect("/InfoTip/Operate_Success.aspx?returnpage="
            + "/Manage/Common/NoteBook_List.aspx" + "&tip=" + words);
        }

    }
}
