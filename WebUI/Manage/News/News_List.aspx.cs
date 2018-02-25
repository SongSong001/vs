﻿using System;
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

namespace WC.WebUI.Manage.News
{
    public partial class News_List : WC.BLL.ViewPages
    {
        protected string news_menu = "", news_list = ">> 所有资讯";
        private string news_tmp = "<a href='/Manage/News/News_List.aspx?tid={0}' {1}>{2}</a>";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Show();
            }
        }

        protected void Search_Btn(object sender, EventArgs e)
        {
            string keywords = Request.Form["keyword"];
            string url = "?keywords=" + HttpContext.Current.Server.HtmlEncode(keywords.Trim());
            Response.Redirect("News_List.aspx" + url);
        }

        protected void RowDataBind(object sender, RepeaterItemEventArgs e)
        {
            Label clab = e.Item.FindControl("c") as Label;
            Panel pal = e.Item.FindControl("d") as Panel;
            if (clab.Text == Uid)
                pal.Visible = true;
        }

        protected void Del_Btn(object obj, EventArgs e)
        {
            LinkButton lb = obj as LinkButton;
            RepeaterItem ri = lb.Parent.Parent as RepeaterItem;
            Panel p = ri.FindControl("d") as Panel;
            if (p.Visible == true)
            {
                HtmlInputCheckBox hick = ri.FindControl("chk") as HtmlInputCheckBox;
                int rid = Convert.ToInt32(hick.Value);
                News_ArticleInfo ni = News_Article.Init().GetById(rid);
                Dk.Help.DeleteFiles(ni.FilePath);
                WC.BLL.News_Article.Init().Delete(rid);
                Show();
            }
        }

        private void Show()
        {
            IList list = News_Type.Init().GetAll(null, " order by orders asc");
            for (int i = 0; i < list.Count; i++)
            {
                News_TypeInfo nt = list[i] as News_TypeInfo;
                if (nt.id + "" == Request.QueryString["tid"] + "")
                {
                    news_menu += string.Format(news_tmp, nt.id, "", nt.TypeName);
                    news_list = ">> " + nt.TypeName;
                }
                else
                    news_menu += string.Format(news_tmp, nt.id, "", nt.TypeName);
            }

            //根据分页配置文件 获取权限分页设置
            Hashtable page_ht = (Hashtable)HttpContext.Current.Application["config_fenye"];
            //每页显示数
            int page_nums = Convert.ToInt32(page_ht["fenye_commom"]);

            int pagecount = 0;
            try
            {
                if (!string.IsNullOrEmpty(Request.QueryString["page"]))
                    pagecount = Convert.ToInt32(Request.QueryString["page"]);
            }
            catch { }
            if (pagecount == 0)
            {
                pagecount = 1;
            }
            PagedDataSource pds = new PagedDataSource();

            string tmp = " a.TypeID = b.id and ( a.ShareDeps='' or a.ShareDeps like '%#" + DepID + "#%') ";
            string keywords = Request.QueryString["keywords"];
            if (!string.IsNullOrEmpty(keywords) && WC.Tool.Utils.CheckSql(keywords))
            {
                tmp = " a.TypeID = b.id and ( a.ShareDeps='' or a.ShareDeps like '%#" + DepID + "#%') ";
                tmp += " and (a.NewsTitle like '%" + keywords + "%'  ) ";
            }
            if (!string.IsNullOrEmpty(Request.QueryString["tid"]))
            {
                string tid = Request.QueryString["tid"];
                tmp = " a.TypeID=" + tid + " and a.TypeID = b.id and ( a.ShareDeps='' or a.ShareDeps like '%#" + DepID + "#%') ";
            }

            string sql = "select a.*,b.TypeName from News_Article as a,News_Type as b where " + tmp + " order by a.id desc";

            using (DataSet ds = MsSqlOperate.ExecuteDataset(CommandType.Text, sql))
            {
                num.InnerHtml = "当前查询条件总计 - <span style='color:#ff0000; font-weight:bold;'>" + ds.Tables[0].Rows.Count + "</span> 条 记录数据";

                pds.DataSource = ds.Tables[0].DefaultView;
                pds.AllowPaging = true;
                pds.PageSize = page_nums;
                pds.CurrentPageIndex = pagecount - 1;
                rpt.DataSource = pds;
                rpt.DataBind();
                
                if (!string.IsNullOrEmpty(Request.QueryString["keywords"]))
                {
                    this.Page1.sty("meneame", pagecount, pds.PageCount, "?keywords=" + keywords + "&page=");
                }
                if (!string.IsNullOrEmpty(Request.QueryString["tid"]))
                {
                    this.Page1.sty("meneame", pagecount, pds.PageCount, "?tid=" + Request.QueryString["tid"] + "&page=");
                }
                this.Page1.sty("meneame", pagecount, pds.PageCount, "?page=");
                
            }

        }


    }
}