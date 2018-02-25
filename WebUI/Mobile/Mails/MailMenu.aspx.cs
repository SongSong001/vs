using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WC.DBUtility;

namespace WC.WebUI.Mobile.Mails
{
    public partial class MailMenu : WC.BLL.MobilePage
    {
        public string cgx, fjx, ljx;
        protected void Page_Load(object sender, EventArgs e)
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
            cgx = sqlpt1.Value + "";
            fjx = sqlpt2.Value + "";
            ljx = sqlpt3.Value + "";
        }
    }
}