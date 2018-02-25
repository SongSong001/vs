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

namespace WC.WebUI.Mobile.News
{
    public partial class NewsView : WC.BLL.MobilePage
    {
        protected string fjs = "";
        protected string fj = "<span>{1}</span> &nbsp;&nbsp;&nbsp;&nbsp;<a href='/Manage/Utils/Download.aspx?destFileName={0}' ><img src='/img/mail_attachment.gif' />下载</a><br>";


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && !string.IsNullOrEmpty(Request.QueryString["nid"]))
            {
                Show(Request.QueryString["nid"]);
            }
        }

        private void Show(string nid)
        {
            News_ArticleInfo na = News_Article.Init().GetById(Convert.ToInt32(nid));

            if (Modules.Contains("29") || (na.ShareDeps.Trim() == "") || na.ShareDeps.Contains("#" + DepID + "#"))
            {
                NewsTitle.InnerText = "标题："+ na.NewsTitle;
                Creator.InnerText = na.CreatorRealName;
                addtime.InnerText = WC.Tool.Utils.ConvertDate5(na.AddTime);

                na.Notes = na.Notes + "";
                if (na.Notes.ToLower().Contains("script"))
                {
                    Notes.InnerHtml = na.Notes.ToLower().Replace("script", "scrript");
                }
                else
                {
                    Notes.InnerHtml = na.Notes.ToLower().Replace("<p>", "").Replace("</p>", "<br>");
                }
                this.Page.Title = "标题：" + na.NewsTitle;

                AddReadRecord(nid);

                if (na.ShareDeps.Contains(","))
                {
                    string td = "";
                    string[] array = na.ShareDeps.Split(',');
                    for (int i = 0; i < array.Length; i++)
                    {
                        if (array[i].Contains("#"))
                        {
                            td += array[i].Split('#')[0] + " ";
                        }
                    }
                    Deps.InnerText = td;
                }
                else
                {
                    Deps.InnerText = "全体人员";
                }

                if (!string.IsNullOrEmpty(na.FilePath))
                {
                    fjs = "";
                    string[] array = na.FilePath.Split('|');
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

            else
            {
                Response.Write("<script>alert('您没有查看权限');window.location='NewsList.aspx';</script>");
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

        private void AddReadRecord(string nid)
        {
            IList list = ZEX2.Init().GetAll("e1=" + nid + " and e2=" + Uid, null);
            if (list.Count == 0)
            {
                ZEX2Info z = new ZEX2Info();
                z.e1 = Convert.ToInt32(nid);
                z.e2 = Convert.ToInt32(Uid);
                z.e10 = DateTime.Now;
                z.e5 = RealName;
                z.e6 = DepName;
                ZEX2.Init().Add(z);
            }
        }
    }
}