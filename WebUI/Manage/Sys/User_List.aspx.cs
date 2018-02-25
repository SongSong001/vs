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
using WC.DBUtility;
using WC.Tool;

namespace WC.WebUI.Manage.Sys
{
    public partial class User_List : WC.BLL.ModulePages
    {
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
            Response.Redirect("User_List.aspx" + url);
        }

        protected void Del_Btn(object obj, EventArgs e)
        {
            LinkButton lb = obj as LinkButton;
            RepeaterItem ri = lb.Parent as RepeaterItem;
            HtmlInputCheckBox hick = ri.FindControl("chk") as HtmlInputCheckBox;
            int uid = Convert.ToInt32(hick.Value);
            WC.WebUI.Dk.Help.DeleteIMUser(uid);
            Sys_User.Init().Delete(uid);
            DelUserDetail(uid + "");
            Show();
        }

        protected void Del_All(object sender, EventArgs e)
        {
            foreach (RepeaterItem item in rpt.Items)
            {
                HtmlInputCheckBox hick = item.FindControl("chk") as HtmlInputCheckBox;
                if (hick.Checked)
                {
                    int uid = Convert.ToInt32(hick.Value);
                    WC.WebUI.Dk.Help.DeleteIMUser(uid);
                    Sys_User.Init().Delete(uid);
                    DelUserDetail(uid + "");
                }
            }
            Show();
        }

        private void DelUserDetail(string u)
        {
            string sql_Calendar = "delete from Calendar where uid='" + u + "';";
            string sql_Docs_Office = "delete from Docs_Office where CreatorID=" + u + ";";
            string sql_NoteBook = "delete from NoteBook where UserID=" + u + ";";
            string sql_PhoneBook = "delete from PhoneBook where UserID=" + u + ";";
            string sql_Mails = "delete from Mails where ReceiverID=" + u + ";";
            string sql_Docs_Doc = "delete from Docs_Doc where CreatorID=" + u + ";";
            string sql_Docs_DocType = "delete from Docs_DocType where Uid=" + u + ";";
            string sql_SysHR = "delete from SysHR where UserID=" + u + ";";

            MsSqlOperate.ExecuteNonQuery(CommandType.Text, sql_Calendar + sql_Docs_Office + sql_NoteBook + sql_PhoneBook + sql_Mails + sql_Docs_Doc + sql_Docs_DocType + sql_SysHR);

            List<WC.Model.Sys_UserInfo> online_ht = Application["user_online"] as List<WC.Model.Sys_UserInfo>;
            if (online_ht != null)
            {
                online_ht.Find(
                    delegate(WC.Model.Sys_UserInfo s)
                    {
                        if (s.id.ToString() == u)
                        {
                            s.IsOnline = 9; //设置删除人员 在线用户状态
                            return true;
                        }
                        else return false;
                    }
                );
            }

        }

        private void Show()
        {
            //根据分页配置文件 获取权限分页设置
            Hashtable page_ht = (Hashtable)HttpContext.Current.Application["config_fenye"];
            //每页显示数
            int page_nums = Convert.ToInt32(page_ht["fenye_commom"]);

            IList list = Sys_User.Init().GetAll(null, "order by status asc,orders asc,id asc");
            string tmp = "1=1";
            string keywords = Request.QueryString["keywords"];
            if (!string.IsNullOrEmpty(keywords)
                && WC.Tool.Utils.CheckSql(keywords))
            {
                tmp = " UserName like '%" + keywords + "%' or RealName like '%" + keywords
                + "%' or DepName like '%" + keywords + "%' ";
                list = Sys_User.Init().GetAll(tmp, "order by status asc,orders asc,id asc");
            }
            if (!string.IsNullOrEmpty(Request.QueryString["did"]))
            {
                list = new List<Sys_UserInfo>();
                GetTreeItems(Convert.ToInt32(Request.QueryString["did"]), list);
            }

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

            pds.DataSource = list;
            pds.AllowPaging = true;
            pds.PageSize = page_nums;
            pds.CurrentPageIndex = pagecount - 1;
            rpt.DataSource = pds;
            rpt.DataBind();

            if (string.IsNullOrEmpty(Request.QueryString["keywords"]) && string.IsNullOrEmpty(Request.QueryString["did"]))
                this.Page1.sty("meneame", pagecount, pds.PageCount, "?page=");
            
            if (!string.IsNullOrEmpty(Request.QueryString["keywords"]))
            {
                this.Page1.sty("meneame", pagecount, pds.PageCount, "?keywords=" + Request.QueryString["keywords"] + "&page=");
            }
            
            if (!string.IsNullOrEmpty(Request.QueryString["did"]))
            {
                this.Page1.sty("meneame", pagecount, pds.PageCount, "?did=" + Request.QueryString["did"] + "&page=");
            }
            num.InnerHtml = "当前查询条件总计 - <span style='color:#ff0000; font-weight:bold;'>" + list.Count + "</span> 条 记录数据";
        }

        private void GetTreeItems(int did,IList li)
        {
            IList list = Sys_User.Init().GetAll("DepID=" + did, "order by status asc,orders asc");
            foreach (object obj in list)
            {
                li.Add(obj);
            }

            IList father_dep_list = Sys_Dep.Init().GetAll("ParentID="+did, "order by orders asc");
            if (father_dep_list.Count != 0)
            {
                foreach (Sys_DepInfo item in father_dep_list)
                {
                    GetTreeItems(item.id, li);
                }
            }
        }

        protected string GetAges(object obj)
        {
            string str = "";
            if (obj != null)
            {
                if (!string.IsNullOrEmpty(Convert.ToString(obj)))
                {
                    str = " (" + WC.Tool.Utils.GetAgeByDatetime(obj).Split(',')[0] + ")";
                }
            }
            return str;
        }

    }
}
