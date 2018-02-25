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

namespace WC.WebUI.Mobile.Files
{
    public partial class FileView : WC.BLL.MobilePage
    {
        protected string fjs = "";
        protected string fj = "<span>{1}</span> &nbsp;&nbsp;&nbsp;&nbsp;<a href='/Manage/Utils/Download.aspx?destFileName={0}' ><img src='/img/mail_attachment.gif' />下载附件</a><br>";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && !string.IsNullOrEmpty(Request.QueryString["did"]))
            {
                Show(Request.QueryString["did"]);
            }
        }

        private void Show(string did)
        {
            Docs_DocInfo di = Docs_Doc.Init().GetById(Convert.ToInt32(did));
            ViewState["di"] = di;

            DocTitle5.InnerText ="标题："+ di.DocTitle;
            Creator5.InnerText = di.CreatorRealName + " (" + di.CreatorDepName + ")";
            AddTime5.InnerText = WC.Tool.Utils.ConvertDate2(di.AddTime);
            Notes5.InnerText = di.Notes;
            doctype5.InnerText = GetDocType(di.DocTypeID);

            if (di.IsShare == 0)
                IsShare5.InnerText = "不共享";
            else
            {
                IsShare5.InnerText = "已经共享";
            }

            if (!string.IsNullOrEmpty(di.FilePath))
            {
                string[] array = di.FilePath.Split('|');
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

        protected void SaveToMe(object sender, EventArgs e)
        {
            Docs_DocInfo old = ViewState["di"] as Docs_DocInfo;
            Docs_DocInfo di = new Docs_DocInfo();
            di.AddTime = DateTime.Now;
            di.CreatorDepName = DepName;
            di.CreatorID = Convert.ToInt32(Uid);
            di.CreatorRealName = RealName;
            di.DocTitle = "来自：[" + old.CreatorRealName + "] " + old.DocTitle;
            di.FilePath = old.FilePath;
            di.Notes = old.Notes;
            di.ShareUsers = "";
            di.IsShare = 0;
            Docs_Doc.Init().Add(di);

            Response.Write("<script>alert('您好!文档已保存成功!');" +
            "window.location='" + Request.Url.AbsoluteUri + "'</script>");
        }

        protected string GetDocType(object DocTypeID)
        {
            try
            {
                int t = Convert.ToInt32(DocTypeID);
                if (t == 0)
                    return "默认分类";
                else
                {
                    IList list = Docs_DocType.Init().GetAll("id=" + t, null);
                    if (list != null)
                    {
                        Docs_DocTypeInfo di = list[0] as Docs_DocTypeInfo;
                        return di.TypeName;
                    }
                    else return "";
                }
            }
            catch
            {
                return "默认分类";
            }

        }
    }
}