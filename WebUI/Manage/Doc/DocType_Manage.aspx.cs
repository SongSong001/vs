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

namespace WC.WebUI.Manage.Doc
{
    public partial class DocType_Manage : WC.BLL.ViewPages
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
            Docs_DocTypeInfo ni = Docs_DocType.Init().GetById(Convert.ToInt32(id));
            ViewState["ni"] = ni;
            TypeName.Value = ni.TypeName;
            Notes.Value = ni.Notes;

        }

        protected void Save_Btn(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["tid"]))
            {
                Docs_DocTypeInfo ni = ViewState["ni"] as Docs_DocTypeInfo;
                ni.Notes = Notes.Value;
                ni.TypeName = TypeName.Value;
                ni.Uid = Convert.ToInt32(Uid);
                Docs_DocType.Init().Update(ni);
            }
            else
            {
                Docs_DocTypeInfo ni = new Docs_DocTypeInfo();
                ni.TypeName = TypeName.Value;
                ni.Notes = Notes.Value;
                ni.Uid = Convert.ToInt32(Uid);
                Docs_DocType.Init().Add(ni);
            }
            string words = HttpContext.Current.Server.HtmlEncode("您好!文档分类保存成功!");
            Response.Redirect("/InfoTip/Operate_Success.aspx?returnpage="
            + "/Manage/doc/DocType_List.aspx" + "&tip=" + words);

        }
    }
}
