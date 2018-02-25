using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using WC.DBUtility;
using System.IO;

namespace WC.WebUI.Manage.Sys
{
    public partial class DbBackup : WC.BLL.ModulePages
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Submit(object sender, EventArgs e)
        {
            Hashtable ht = Application["hbm"] as Hashtable;
            string c = ht["hibernate.connection.connection_string"] + "";
            string dbname = WC.Tool.Utils.GetMulti(c, "initial catalog=", ";")[0];

            string path = Server.MapPath("~/Files");
            string name = DateTime.Now.ToString("yyMddHHmmss") + ".rar";
            string path1 = "'" + path + "\\" + name + "'";
            string sql = "BACKUP DATABASE " + dbname + " TO DISK=" + path1;
            MsSqlOperate.ExecuteNonQuery(CommandType.Text, sql, null);

            if (File.Exists(path + "\\" + name))
            {
                Response.Write("<script>window.alert('数据库备份成功！')</script>");
                l1.Visible = true;
                l1.Text = "<a href='/Files/" + name + "' target='_blank'><b>点击下载</b></a>";
            }
        }

        protected void ClearIMData(object sender, EventArgs e)
        {
            string sql = "delete from WM_Message where datediff(d,CreatedTime,getdate())>90";
            MsSqlOperate.ExecuteNonQuery(CommandType.Text, sql, null);
            Response.Write("<script>alert('3个月以前的IM数据已成功清理！');window.location='DbBackup.aspx';</script>");
        }

    }
}
