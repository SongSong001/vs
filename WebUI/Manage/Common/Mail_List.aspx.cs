using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
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

namespace WC.WebUI.Manage.Common
{
    public partial class Mail_List : WC.BLL.ViewPages
    {
        protected string mail_tags = "";
        protected string fid = "0";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["fid"]))
            {
                fid = Request.QueryString["fid"];
                switch (fid)
                {
                    case "0": mail_tags = "收件箱"; break;
                    case "1": mail_tags = "草稿箱"; break;
                    case "2": mail_tags = "发件箱"; break;
                    case "3": mail_tags = "垃圾箱"; break;
                    default: mail_tags = "收件箱"; break;

                }
            }
            if (!IsPostBack)
            {
                if (!string.IsNullOrEmpty(Request.QueryString["fid"]) &&
                    !string.IsNullOrEmpty(Uid)
                    )
                    Show(Request.QueryString["fid"]);
                else
                    Response.Write("<script>alert('您查找的链接不存在!');window.location='../DeskTop.aspx';</script>");
            }
        }

        protected void Search_Btn(object sender, EventArgs e)
        {
            string keywords = Request.Form["keyword"];
            string url = "?fid=" + Request.QueryString["fid"] + "&keywords=" + keywords;
            Response.Redirect("Mail_List.aspx" + url);          
        }

        protected void Del_All(object sender, EventArgs e)
        {
            foreach (RepeaterItem item in rpt.Items)
            {
                HtmlInputCheckBox hick = item.FindControl("chk") as HtmlInputCheckBox;
                if (hick.Checked)
                {
                    int id = Convert.ToInt32(hick.Value);
                    Mails.Init().Delete(id);
                }
            }

            string words = HttpContext.Current.Server.HtmlEncode("您好!邮件已彻底删除!");
            Response.Redirect("/InfoTip/Operate_Success.aspx?returnpage="
            + Request.Url.AbsoluteUri + "&tip=" + words);        
        }

        protected void MoveToLJ(object sender, EventArgs e)
        {
            if (Request.QueryString["fid"] != "3")
            {
                foreach (RepeaterItem item in rpt.Items)
                {
                    HtmlInputCheckBox hick = item.FindControl("chk") as HtmlInputCheckBox;
                    if (hick.Checked)
                    {
                        int id = Convert.ToInt32(hick.Value);
                        string sql = "update mails set FolderType=3 where id=" + id;
                        MsSqlOperate.ExecuteNonQuery(CommandType.Text, sql);
                    }
                }

                string words = HttpContext.Current.Server.HtmlEncode("您好!邮件已删除至垃圾箱!");
                Response.Redirect("/InfoTip/Operate_Success.aspx?returnpage="
                + Request.Url.AbsoluteUri + "&tip=" + words);
            }
        }

        private void Show(string fid)
        {
            //根据分页配置文件 获取权限分页设置
            Hashtable page_ht = (Hashtable)HttpContext.Current.Application["config_fenye"];
            //每页显示数
            int page_nums = Convert.ToInt32(page_ht["fenye_mail"]);

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


            int nums = page_nums * (pagecount - 1);
            string tmp = "FolderType=" + fid + " and ReceiverID=" + Uid;
            string keywords = Request.QueryString["keywords"];
            if (!string.IsNullOrEmpty(keywords)
                && WC.Tool.Utils.CheckSql(keywords))
            {
                tmp += " and (SenderRealName like '%" + keywords + "%' or SenderDepName like '%" + keywords
                + "%' or Subject like '%" + keywords + "%') ";
            }
            int count = Convert.ToInt32(MsSqlOperate.ExecuteScalar(CommandType.Text,
                        "select count(*) from Mails where " + tmp, null));
            num.InnerHtml = "当前查询条件总计 - <span style='color:#ff0000; font-weight:bold;'>" + count + "</span> 条 记录数据";

            string sql_rpt = "select top " + page_nums + " * from Mails where "
                            + tmp + " order by id desc";

            if (pagecount != 1)
                sql_rpt = "SELECT TOP " + page_nums
                    + " * FROM Mails WHERE id<(SELECT MIN(id) FROM (SELECT TOP "
                    + nums.ToString() + " id FROM Mails WHERE (" + tmp + " ) ORDER BY id DESC) T1) AND ("
                    + tmp + " ) ORDER BY id DESC";

            Bind(sql_rpt, rpt);
            if (string.IsNullOrEmpty(Request.QueryString["keywords"]))
            {
                this.Page1.sty("meneame", pagecount, GetCountPage(count, page_nums), "?fid=" + Request.QueryString["fid"] + "&page=");
            }
            if (!string.IsNullOrEmpty(Request.QueryString["keywords"]))
            {
                this.Page1.sty("meneame", pagecount, GetCountPage(count, page_nums), "?fid=" + Request.QueryString["fid"] + "&keywords=" + keywords + "&page=");
            }


        }

        private int GetCountPage(int count, int pageSize)
        {
            if (count <= pageSize)
                return 1;
            else
            {
                if (count % pageSize == 0)
                    return count / pageSize;
                else
                    return count / pageSize + 1;
            }
        }

        private void Bind(string sql, Repeater r)
        {
            using (DataSet ds = MsSqlOperate.ExecuteDataset(CommandType.Text, sql, null))
            {
                r.DataSource = ds.Tables[0].DefaultView;
                r.DataBind();
            }
        }

        protected string GetSendTypeName(object obj)
        {
            string ss = "";
            string tmp = Convert.ToString(obj);
            if (tmp == "1")
                ss = "[草稿]&nbsp;&nbsp;";
            if (tmp == "2")
                ss = "[抄送]&nbsp;&nbsp;";
            if (tmp == "3")
                ss = "[密送]&nbsp;&nbsp;";
            if (tmp == "4")
                ss = "[已发送]&nbsp;&nbsp;";
            return ss;
        }

        protected string GetSelected(int i)
        {
            string f = Request.QueryString["fid"] + "";
            if (f == i + "")
                return "class='selected'";
            else return "";
        }

    }
}
