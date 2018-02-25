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
using System.IO;
using WC.BLL;
using WC.Model;
using WC.Tool;
using WC.DBUtility;

namespace WC.WebUI.Mobile.Flows
{
    public partial class FlowMenu : WC.BLL.MobilePage
    {
        public string wdpy, yjpy, wdsq, view;
        protected void Page_Load(object sender, EventArgs e)
        {             
            SqlParameter rid = new SqlParameter();
            rid.ParameterName = "@uid";
            rid.Size = 50;
            rid.Value = Uid;

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

            SqlParameter[] sqls = { sqlpt1, sqlpt2, sqlpt3, sqlpt4, rid };
            MsSqlOperate.ExecuteNonQuery(CommandType.StoredProcedure, "Flows_GetUserFlowBoxCount", sqls);
            wdpy = sqlpt1.Value + "";
            yjpy = sqlpt2.Value + "";
            wdsq = sqlpt3.Value + "";
            view = sqlpt4.Value + "";
        }
    }
}