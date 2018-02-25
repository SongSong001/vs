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
    public partial class PrivateAddrBook : WC.BLL.ViewPages
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                Show();
        }

        protected void Del_Btn(object obj, EventArgs e)
        {
            LinkButton lb = obj as LinkButton;
            RepeaterItem ri = lb.Parent as RepeaterItem;
            HtmlInputCheckBox hick = ri.FindControl("chk") as HtmlInputCheckBox;
            int rid = Convert.ToInt32(hick.Value);
            PhoneBook.Init().Delete(rid);
            Show();

        }

        protected void Search_Btn(object sender, EventArgs e)
        {
            string keywords = Request.Form["keyword"];
            string url = "?keywords=" + HttpContext.Current.Server.HtmlEncode(keywords.Trim());
            Response.Redirect("PrivateAddrBook.aspx" + url);
        }

        private void Show()
        {
            string where = "userid=" + Uid;
            if (!string.IsNullOrEmpty(Request.QueryString["keywords"]))
            {
                string key = Request.QueryString["keywords"];
                where = "userid=" + Uid + " and ( Person like '%" + key + "%' or Phone like '%" + key + "%' or TagName like '%" + key + "%' )";
            }
            IList list = PhoneBook.Init().GetAll(where, "order by TagName asc,id desc");
            rpt_person.DataSource = list;
            rpt_person.DataBind();

            num.InnerHtml = "当前 总计 - <span style='color:#ff0000; font-weight:bold;'>" + list.Count + "</span> 个 记录数据";
        }

        protected void DownLoad(object sender, EventArgs e)
        {
            IList list = PhoneBook.Init().GetAll("userid=" + Uid, "order by TagName asc,id desc");
            string ct = RealName + " 的个人通讯录\r\n\r\n";
            string fn = "Personal ContactsBook";
            foreach (object j in list)
            {
                PhoneBookInfo pi = j as PhoneBookInfo;
                ct += "姓名 (" + pi.TagName + ")：" + pi.Person + " 电话：" + pi.Phone + " \r\n";
            }
            Response.Clear();
            Response.ClearHeaders();
            Response.Buffer = false;

            Response.AppendHeader("Content-Disposition", "attachment;filename=" + fn + ".txt");
            Response.ContentType = "application/vnd.txt";
            Response.Write(ct);
            Response.Flush();
            Response.End();
        }

    }
}
