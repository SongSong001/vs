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

using WC.DBUtility;
using WC.BLL;
using WC.Model;
using WC.Tool;

namespace WC.WebUI.Mobile.Tasks
{
    public partial class TaskMenu : WC.BLL.MobilePage
    {
        public string t_all, t_exeute, t_manage, t_create;
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlParameter rid = new SqlParameter();
            rid.ParameterName = "@uid";
            rid.Size = 50;
            rid.Value = Uid;

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


            SqlParameter[] sqls = { sqlpt0, sqlpt1, sqlpt2, sqlpt3, rid };
            MsSqlOperate.ExecuteNonQuery(CommandType.StoredProcedure, "Tasks_GetTaskCount", sqls);

            t_all = sqlpt0.Value + "";
            t_exeute = sqlpt1.Value + "";
            t_manage = sqlpt2.Value + "";
            t_create = sqlpt3.Value + "";
        }
    }
}