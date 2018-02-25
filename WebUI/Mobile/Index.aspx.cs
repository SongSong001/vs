using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Text;
using WC.BLL;
using WC.Model;
using WC.DBUtility;

namespace WC.WebUI.Mobile
{
    public partial class Index : WC.BLL.MobilePage
    {
        protected string news_num = "0";
        protected string mails_num1 = "0";
        protected string mails_num2 = "0";
        protected string flows_num1 = "0";
        protected string flows_num2 = "0";
        protected string calendar_num = "0";
        protected string note_num = "0";
        protected string mydoc_num = "0";
        protected string shared_num = "0";
        protected string shared_num2 = "0";

        protected string exe_num = "0";
        protected string man_num = "0";

        protected string work_num1 = "0";
        protected string work_num2 = "0";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && !string.IsNullOrEmpty(Uid))
                Show();
        }

        private void Show()
        {
            SqlParameter rid = new SqlParameter();
            rid.ParameterName = "@uid";
            rid.Size = 50;
            rid.Value = Uid;

            SqlParameter rid2 = new SqlParameter();
            rid2.ParameterName = "@depid";
            rid2.Size = 50;
            rid2.Value = DepID;

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

            SqlParameter sqlpt5 = new SqlParameter();
            sqlpt5.Direction = ParameterDirection.Output;
            sqlpt5.ParameterName = "@pt5";
            sqlpt5.Size = 7;

            SqlParameter sqlpt6 = new SqlParameter();
            sqlpt6.Direction = ParameterDirection.Output;
            sqlpt6.ParameterName = "@pt6";
            sqlpt6.Size = 7;

            SqlParameter sqlpt7 = new SqlParameter();
            sqlpt7.Direction = ParameterDirection.Output;
            sqlpt7.ParameterName = "@pt7";
            sqlpt7.Size = 7;

            SqlParameter sqlpt8 = new SqlParameter();
            sqlpt8.Direction = ParameterDirection.Output;
            sqlpt8.ParameterName = "@pt8";
            sqlpt8.Size = 7;

            SqlParameter sqlpt10 = new SqlParameter();
            sqlpt10.Direction = ParameterDirection.Output;
            sqlpt10.ParameterName = "@pt10";
            sqlpt10.Size = 7;

            SqlParameter sqlpt11 = new SqlParameter();
            sqlpt11.Direction = ParameterDirection.Output;
            sqlpt11.ParameterName = "@pt11";
            sqlpt11.Size = 7;

            SqlParameter sqlpt12 = new SqlParameter();
            sqlpt12.Direction = ParameterDirection.Output;
            sqlpt12.ParameterName = "@pt12";
            sqlpt12.Size = 7;

            SqlParameter sqlpt13 = new SqlParameter();
            sqlpt13.Direction = ParameterDirection.Output;
            sqlpt13.ParameterName = "@pt13";
            sqlpt13.Size = 7;

            SqlParameter[] sqls = { sqlpt1, sqlpt2, sqlpt3, sqlpt4, sqlpt5, sqlpt6, sqlpt7, sqlpt8, sqlpt10, sqlpt11, sqlpt12, sqlpt13, rid, rid2 };
            using (DataSet ds = MsSqlOperate.ExecuteDataset(CommandType.StoredProcedure, "Global_GetDesktopData", sqls))
            {
                news_num = sqlpt1.Value + "";
                mails_num1 = sqlpt2.Value + "";
                mails_num2 = sqlpt3.Value + "";
                flows_num1 = sqlpt4.Value + "";
                flows_num2 = sqlpt5.Value + "";
                calendar_num = sqlpt6.Value + "";
                note_num = sqlpt7.Value + "";
                mydoc_num = sqlpt8.Value + "";
                shared_num = sqlpt10.Value + "";
                shared_num2 = sqlpt11.Value + "";
                exe_num = sqlpt12.Value + "";
                man_num = sqlpt13.Value + "";

                work_num1 = MsSqlOperate.ExecuteScalar(CommandType.Text, "select count(id) from worklog where CreatorID=" + Uid) + "";
                work_num2 = MsSqlOperate.ExecuteScalar(CommandType.Text, "select count(id) from worklog where " + " CreatorID<>" + Uid + " and ShareUsers like '%#" + Uid + "#%' ") + "";


            }

        }
    }
}