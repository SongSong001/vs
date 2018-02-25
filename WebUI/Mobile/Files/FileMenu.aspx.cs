using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WC.DBUtility;

namespace WC.WebUI.Mobile.Files
{
    public partial class FileMenu : WC.BLL.MobilePage
    {
        protected string num1 = "0", num2 = "0";

        protected void Page_Load(object sender, EventArgs e)
        {
            string sql1 = "select count(id) from Docs_Doc where CreatorID=" + Uid;
            string sql2 = "select count(id) from Docs_Doc where CreatorID<>" + Uid
                + " and IsShare=1 and ShareUsers like '%#" + Uid + "#%' ";

            num1 = MsSqlOperate.ExecuteScalar(CommandType.Text,
            sql1, null) + "";

            num2 = MsSqlOperate.ExecuteScalar(CommandType.Text,
            sql2, null) + "";

        }
    }
}