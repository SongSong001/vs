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
using System.IO;
using WC.Tool;

namespace WC.WebUI.js
{
    public partial class GetCode_Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        override protected void OnInit(EventArgs e)
        {
            base.OnInit(e);

            string checkCode = FileSystemManager.CreateRandomStr(4);
            //Session["FeedBackCode_Login"] = checkCode.ToLower();
            Response.Cookies.Add(new HttpCookie("FeedBackCode_Login", Encrypt.RC4_Encode(checkCode, "lazylog")));
            MemoryStream ms = FileSystemManager.DrawRandomStr(checkCode);
            Response.ClearContent();
            Response.BinaryWrite(ms.ToArray());
        }
    }
}
