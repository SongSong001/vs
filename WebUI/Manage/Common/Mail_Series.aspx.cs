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
    public partial class Mail_Series : WC.BLL.ViewPages
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!string.IsNullOrEmpty(Request.QueryString["bet"]) &&
                    !string.IsNullOrEmpty(Uid)
                    )
                    Show(Request.QueryString["bet"]);
                else
                    Response.Write("<script>alert('您查找的链接不存在!');window.location='../DeskTop.aspx';</script>");
            }
        }

        protected void Search_Btn(object sender, EventArgs e)
        {
            string keywords = Request.Form["keyword"];
            string url = "?fid=0&keywords=" + keywords;
            Response.Redirect("Mail_List.aspx" + url);
        }

        private void Show(string fid)
        {
            SqlParameter rid = new SqlParameter();
            rid.ParameterName = "@uid";
            rid.Size = 7;
            rid.Value = Convert.ToInt32(Uid);

            SqlParameter sqlpt0 = new SqlParameter();
            sqlpt0.Direction = ParameterDirection.Output;
            sqlpt0.ParameterName = "@pt0";
            sqlpt0.Size = 7;

            SqlParameter sqlpt1 = new SqlParameter();
            sqlpt1.Direction = ParameterDirection.Output;
            sqlpt1.ParameterName = "@pt1";
            sqlpt1.Size = 7;

            SqlParameter sqlpt2 = new SqlParameter();
            sqlpt2.Direction = ParameterDirection.Output;
            sqlpt2.ParameterName = "@pt2";
            sqlpt2.Size = 7;

            SqlParameter sqlpt3 = new SqlParameter();
            sqlpt3.Direction = ParameterDirection.Output;
            sqlpt3.ParameterName = "@pt3";
            sqlpt3.Size = 7;

            SqlParameter sqlpt4 = new SqlParameter();
            sqlpt4.Direction = ParameterDirection.Output;
            sqlpt4.ParameterName = "@pt4";
            sqlpt4.Size = 7;

            SqlParameter[] sqls = { sqlpt0, sqlpt1, sqlpt2, sqlpt3, sqlpt4, rid };
            MsSqlOperate.ExecuteNonQuery(CommandType.StoredProcedure, "Mails_GetAllMailBoxCount", sqls);

            sjx.InnerText = sqlpt0.Value + "/" + sqlpt4.Value;
            cgx.InnerText = sqlpt1.Value + "";
            fjx.InnerText = sqlpt2.Value + "";
            ljx.InnerText = sqlpt3.Value + "";

            //根据分页配置文件 获取权限分页设置
            Hashtable page_ht = (Hashtable)HttpContext.Current.Application["config_fenye"];
            //每页显示数
            int page_nums = Convert.ToInt32(page_ht["fenye_mail"]);

            string where = " ( FolderType=0 and SenderID=" + fid.Split(';')[0] + " and ReceiverID=" + fid.Split(';')[1] +
                ") or ( FolderType=0 and SenderID=" + fid.Split(';')[1] + " and ReceiverID=" + fid.Split(';')[0] + ")";
            IList list = Mails.Init().GetAll(where, "order by id desc");

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
            this.Page1.sty("meneame", pagecount, pds.PageCount, "?bet=" + Request.QueryString["bet"] + "&page=");

            rpt.DataSource = pds;
            rpt.DataBind();
            num.InnerHtml = "当前查询条件总计 - <span style='color:#ff0000; font-weight:bold;'>" + list.Count + "</span> 条 记录数据";
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
    }
}
