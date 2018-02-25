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
using WC.DBUtility;

namespace WC.WebUI.Manage.CRM
{
    public partial class CRM_View : WC.BLL.ViewPages
    {
        protected string c = "";
        protected string fjs = "";
        protected string fj = "<span style='font-weight:bold;'>{1}</span> &nbsp;&nbsp;&nbsp;&nbsp;<a href='/Manage/Utils/Download.aspx?destFileName={0}' ><img src='/img/mail_attachment.gif' />下载附件</a><br>";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && !string.IsNullOrEmpty(Request.QueryString["cid"]))
            {
                Show(Request.QueryString["cid"]);
                c = Request.QueryString["cid"];
            }
        }

        private void Show(string cid)
        {
            CRMInfo ci = WC.BLL.CRM.Init().GetById(Convert.ToInt32(cid));
            CRM_Name1.InnerText = ci.CRM_Name;

            if (ci.CreatorID + "" != Uid)
                div.Visible = false;

            Grade.Text = Convert.ToString(ci.Grade).ToUpper() + " - " + GetGrade(ci.Grade);
            lx.Text = " <span style='color:#006600;font-weight:bold;'>电话:</span> " + ci.Tel + " &nbsp;&nbsp; <span style='color:#006600;font-weight:bold;'>传真:</span> " + ci.Fax + " &nbsp;&nbsp; <span style='color:#006600;font-weight:bold;'>邮编:</span> " + ci.Zip;
            hlw.Text = " <span style='color:#006600;font-weight:bold;'>网站:</span> " + ci.Site + " &nbsp;&nbsp; <span style='color:#006600;font-weight:bold;'>QQ:</span> " + ci.QQ + " &nbsp;&nbsp; <span style='color:#006600;font-weight:bold;'>Email:</span> " + ci.Email;
            Address.Text = ci.Address;
            MainPeople.Text = ci.MainPeople;
            Position.Text = ci.Position;
            Product.Text = ci.Product;
            TypeName.Text = ci.TypeName;
            Notes.Text = ci.Notes;

            string sql = "select count(*) from crm_contact where cid=" + cid;
            object obj = MsSqlOperate.ExecuteScalar(CommandType.Text, sql);
            Contact.Text = "目前已接触 <strong>" + obj +
            "</strong> 次 &nbsp;&nbsp;&nbsp;&nbsp; <a href=/manage/crm/CRM_Contact_List.aspx?cid=" + cid +
            "><strong>查看接触详情</strong></a>" + " &nbsp;&nbsp;&nbsp;&nbsp; " + "<a href=/manage/crm/CRM_Contact_Manage.aspx?cid=" +
            cid + "><strong>添加客户接触</strong></a>";

            if (!string.IsNullOrEmpty(ci.FilePath))
            {
                string[] array = ci.FilePath.Split('|');
                for (int i = 0; i < array.Length; i++)
                {
                    if (array[i].Trim() != "")
                    {
                        int t = array[i].LastIndexOf('/') + 1;
                        string filename = array[i].Substring(t, array[i].Length - t);
                        string fileurl = array[i].ToString();
                        fjs += string.Format(fj, Server.UrlEncode(fileurl), filename);
                    }
                }
            }

        }

        private bool IsOfficeFile(string filename)
        {
            bool b = false;
            if (filename.Contains("."))
            {
                string t = filename.Split('.')[1].ToLower();
                if (t.Contains("doc") || t.Contains("xls"))
                {
                    b = true;
                }
            }
            return b;
        }

        protected string GetGrade(object obj)
        {
            string t = obj + "";
            t = t.ToUpper();
            string r = "";
            if (t == "A")
                r = "暂无需求，潜在培养的客户";
            if (t == "B")
                r = "有需求，正在跟进客户";
            if (t == "C")
                r = "短期可签入的客户";
            if (t == "D")
                r = "已签约客户/老客户";
            return r;
        }


    }
}
