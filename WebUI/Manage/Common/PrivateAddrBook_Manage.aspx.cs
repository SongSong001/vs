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
    public partial class PrivateAddrBook_Manage : WC.BLL.ViewPages
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                Show();
        }

        protected void Save_Btn(object obj, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["pid"]))
            {
                PhoneBookInfo pi = ViewState["pi"] as PhoneBookInfo;
                pi.Person = Person.Value;
                pi.TagName = TagName.Value;
                pi.Phone = Phone.Value;
                pi.Notes = Notes.Value;
                PhoneBook.Init().Update(pi);
            }
            else
            {
                PhoneBookInfo pi = new PhoneBookInfo();
                pi.Person = Person.Value;
                pi.Phone = Phone.Value;
                pi.Notes = Notes.Value;
                pi.RealName = RealName;
                pi.TagName = TagName.Value;
                pi.UserID = Convert.ToInt32(Uid);
                pi.DepName = DepName;
                pi.AddTime = DateTime.Now;
                PhoneBook.Init().Add(pi);
            }

            string words = HttpContext.Current.Server.HtmlEncode("您好!个人通讯录保存成功!");
            Response.Redirect("/InfoTip/Operate_Success.aspx?returnpage="
            + "/manage/common/PrivateAddrBook.aspx" + "&tip=" + words);
        }

        private void Show()
        {
            PhoneBookInfo pi = PhoneBook.Init().GetById(Convert.ToInt32(Request.QueryString["pid"]));
            if (pi != null)
            {
                Phone.Value = pi.Phone;
                TagName.Value = pi.TagName;
                Person.Value = pi.Person;
                Notes.Value = pi.Notes;
                ViewState["pi"] = pi;
            }
        }

    }
}
