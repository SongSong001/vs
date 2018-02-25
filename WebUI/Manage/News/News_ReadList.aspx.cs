using System;
using System.Collections;
using System.Collections.Generic;
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

namespace WC.WebUI.Manage.News
{
    public partial class News_ReadList : WC.BLL.ViewPages
    {

        protected string news_menu = "";
        private string news_tmp = "<a href='/Manage/News/News_List.aspx?tid={0}' >{1}</a>";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && !string.IsNullOrEmpty(Request.QueryString["nid"]))
            {
                Show(Request.QueryString["nid"]);
            }

        }

        private void Show(string nid)
        {
            IList list = News_Type.Init().GetAll(null, " order by orders asc");
            for (int i = 0; i < list.Count; i++)
            {
                News_TypeInfo ni = list[i] as News_TypeInfo;
                news_menu += string.Format(news_tmp, ni.id, ni.TypeName);
            }

            using (DataSet ds = GetReadList(nid))
            {
                int page_nums = 100;

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

                DataView dv = ds.Tables[0].DefaultView;
                dv.Sort = "et3 Desc,et4 Desc";
                pds.DataSource = dv;

                pds.AllowPaging = true;
                pds.PageSize = page_nums;
                pds.CurrentPageIndex = pagecount - 1;
                rpt.DataSource = pds;
                rpt.DataBind();

                this.Page1.sty("meneame", pagecount, pds.PageCount, "?nid=" + nid + "&page=");


                num.InnerHtml = "当前查询条件总计 - <span style='color:#ff0000; font-weight:bold;'>" + ds.Tables[0].Rows.Count + "</span> 条 记录数据";
            }
        }

        protected void Search_Btn(object sender, EventArgs e)
        {
            string keywords = Request.Form["keyword"];
            string url = "?keywords=" + HttpContext.Current.Server.HtmlEncode(keywords.Trim());
            Response.Redirect("News_List.aspx" + url);
        }

        private DataSet GetReadList(string nid)
        {
            IList li = ZEX2.Init().GetAll("e1=" + nid, null);
            IList list = GetAllNewsUser(nid);
            foreach (object obj in list)
            {
                Sys_UserInfo ui = obj as Sys_UserInfo;
                ui.et4 = "";
                foreach (object t in li)
                {
                    ZEX2Info zi = t as ZEX2Info;
                    if (ui.id == zi.e2)
                    {
                        ui.et3 = 1;
                        ui.et4 = WC.Tool.Utils.ConvertDate3(zi.e10);
                    }
                }
            }
            IList<Sys_UserInfo> tlist = (List<Sys_UserInfo>)list;
            return WC.Tool.Utils.ConvertListToDataSet<Sys_UserInfo>(tlist);
        }

        private IList GetAllNewsUser(string nid)
        {
            IList<Sys_UserInfo> list = new List<Sys_UserInfo>();

            string o_sql = "select ShareDeps from News_Article where id=" + nid;
            string ShareDeps = WC.DBUtility.MsSqlOperate.ExecuteScalar(CommandType.Text, o_sql) + "";

            if (ShareDeps.Contains(","))
            {
                string[] arr1 = ShareDeps.Split(',');
                string m_sql = "";
                List<string> li = new List<string>();
                for (int i = 0; i < arr1.Length; i++)
                {
                    if (arr1[i].Contains("#"))
                    {
                        string depid = arr1[i].Split('#')[1];
                        li.Add(depid);
                    }
                }
                string[] arr2 = li.ToArray();
                for (int i = 0; i < arr2.Length; i++)
                {
                    if (i != arr2.Length - 1)
                    {
                        m_sql += " depid=" + arr2[i] + " or ";
                    }
                    else
                    {
                        m_sql += " depid=" + arr2[i] + " ";
                    }
                }
                IList u_list = Sys_User.Init().GetAll(m_sql, null);
                foreach (object obj in u_list)
                {
                    Sys_UserInfo ui = obj as Sys_UserInfo;
                    list.Add(ui);
                }
            }
            else
            {
                IList all = Sys_User.Init().GetAll("Status=0 and IsLock=0", null);
                foreach (object obj in all)
                {
                    Sys_UserInfo ui = obj as Sys_UserInfo;
                    list.Add(ui);
                }

            }

            return (IList)list;
        }

    }
}
