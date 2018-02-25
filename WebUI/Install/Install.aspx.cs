using System;
using System.Collections;
using System.Configuration;
using System.Data;

using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

using System.IO;
using System.Data.SqlClient;
using System.Xml;

namespace WC.WebUI.Install
{
    public partial class Install : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (WC.Tool.Config.CheckInstall())
            {
                //Response.Write("<script>window.location='../Default.aspx'</script>");
                Response.Redirect("~/Default.aspx");
            }

            if (!string.IsNullOrEmpty(Request.QueryString["sf"]))
            {
                string sf = Request.QueryString["sf"];
                if (sf == "2005")
                    lt.Text = "准备工作：请使用SqlServer2005（或以上版本）新建一个空数据库<br>提示信息：如果数据库服务器为本机安装,请填写(local)";
                if (sf == "2000")
                    lt.Text = "准备工作：请使用SqlServer2000新建一个空数据库<br>提示信息：如果数据库服务器为本机安装,请填写(local)";            
            }
            else
                Response.Write("<script>alert('您还没选择数据库版本!');window.location='Prepare.aspx'</script>");

        }

        protected void Complete_btn(object sender, EventArgs e)
        {
            string c = GetConn(); bool b = true;
            SqlConnection conn = new SqlConnection(c);
            try
            {
                conn.Open();
                if (b)
                {
                    string table = "";

                    if (!string.IsNullOrEmpty(Request.QueryString["sf"]))
                    {
                        string sf = Request.QueryString["sf"];
                        if (sf == "2005")
                            table = File.ReadAllText(Server.MapPath("script/table_2005.sql"), System.Text.Encoding.UTF8);
                        if (sf == "2000")
                            table = File.ReadAllText(Server.MapPath("script/table_2000.sql"), System.Text.Encoding.UTF8);
                    }

                    string p0 = File.ReadAllText(Server.MapPath("script/Procedure0.sql"), System.Text.Encoding.UTF8);
                    string p1 = File.ReadAllText(Server.MapPath("script/Procedure1.sql"), System.Text.Encoding.UTF8);
                    string p2 = File.ReadAllText(Server.MapPath("script/Procedure2.sql"), System.Text.Encoding.UTF8);
                    string p3 = File.ReadAllText(Server.MapPath("script/Procedure3.sql"), System.Text.Encoding.UTF8);
                    string p4 = File.ReadAllText(Server.MapPath("script/Procedure4.sql"), System.Text.Encoding.UTF8);
                    string p5 = File.ReadAllText(Server.MapPath("script/Procedure5.sql"), System.Text.Encoding.UTF8);
                    string p6 = File.ReadAllText(Server.MapPath("script/Procedure6.sql"), System.Text.Encoding.UTF8);

                    string p7 = File.ReadAllText(Server.MapPath("script/Procedure7.sql"), System.Text.Encoding.UTF8);

                    string e1 = File.ReadAllText(Server.MapPath("script/pros/p001.sql"), System.Text.Encoding.UTF8);
                    string e2 = File.ReadAllText(Server.MapPath("script/pros/p002.sql"), System.Text.Encoding.UTF8);
                    string e3 = File.ReadAllText(Server.MapPath("script/pros/p003.sql"), System.Text.Encoding.UTF8);
                    string e4 = File.ReadAllText(Server.MapPath("script/pros/p004.sql"), System.Text.Encoding.UTF8);
                    string e5 = File.ReadAllText(Server.MapPath("script/pros/p005.sql"), System.Text.Encoding.UTF8);
                    string e6 = File.ReadAllText(Server.MapPath("script/pros/p006.sql"), System.Text.Encoding.UTF8);
                    string e7 = File.ReadAllText(Server.MapPath("script/pros/p007.sql"), System.Text.Encoding.UTF8);
                    string e8 = File.ReadAllText(Server.MapPath("script/pros/p008.sql"), System.Text.Encoding.UTF8);
                    string e9 = File.ReadAllText(Server.MapPath("script/pros/p009.sql"), System.Text.Encoding.UTF8);
                    string e10 = File.ReadAllText(Server.MapPath("script/pros/p010.sql"), System.Text.Encoding.UTF8);

                    string e11 = File.ReadAllText(Server.MapPath("script/pros/p011.sql"), System.Text.Encoding.UTF8);
                    string e12 = File.ReadAllText(Server.MapPath("script/pros/p012.sql"), System.Text.Encoding.UTF8);
                    string e13 = File.ReadAllText(Server.MapPath("script/pros/p013.sql"), System.Text.Encoding.UTF8);
                    string e14 = File.ReadAllText(Server.MapPath("script/pros/p014.sql"), System.Text.Encoding.UTF8);
                    string e15 = File.ReadAllText(Server.MapPath("script/pros/p015.sql"), System.Text.Encoding.UTF8);
                    string e16 = File.ReadAllText(Server.MapPath("script/pros/p016.sql"), System.Text.Encoding.UTF8);
                    string e17 = File.ReadAllText(Server.MapPath("script/pros/p017.sql"), System.Text.Encoding.UTF8);
                    string e18 = File.ReadAllText(Server.MapPath("script/pros/p018.sql"), System.Text.Encoding.UTF8);
                    string e19 = File.ReadAllText(Server.MapPath("script/pros/p019.sql"), System.Text.Encoding.UTF8);
                    string e20 = File.ReadAllText(Server.MapPath("script/pros/p020.sql"), System.Text.Encoding.UTF8);

                    string e21 = File.ReadAllText(Server.MapPath("script/pros/p021.sql"), System.Text.Encoding.UTF8);
                    string e22 = File.ReadAllText(Server.MapPath("script/pros/f001.sql"), System.Text.Encoding.UTF8);
                    string e23 = File.ReadAllText(Server.MapPath("script/pros/f002.sql"), System.Text.Encoding.UTF8);

                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = conn;

                    //安装表格数据
                    cmd.CommandText = table;
                    cmd.ExecuteNonQuery();
                    //安装存储过程
                    cmd.CommandText = p0;
                    cmd.ExecuteNonQuery();

                    cmd.CommandText = p1;
                    cmd.ExecuteNonQuery();

                    cmd.CommandText = p2;
                    cmd.ExecuteNonQuery();

                    cmd.CommandText = p3;
                    cmd.ExecuteNonQuery();

                    cmd.CommandText = p4;
                    cmd.ExecuteNonQuery();

                    cmd.CommandText = p5;
                    cmd.ExecuteNonQuery();

                    cmd.CommandText = p6;
                    cmd.ExecuteNonQuery();

                    cmd.CommandText = p7;
                    cmd.ExecuteNonQuery();

                    cmd.CommandText = e1;
                    cmd.ExecuteNonQuery();
                    cmd.CommandText = e2;
                    cmd.ExecuteNonQuery();
                    cmd.CommandText = e3;
                    cmd.ExecuteNonQuery();
                    cmd.CommandText = e4;
                    cmd.ExecuteNonQuery();
                    cmd.CommandText = e5;
                    cmd.ExecuteNonQuery();
                    cmd.CommandText = e6;
                    cmd.ExecuteNonQuery();
                    cmd.CommandText = e7;
                    cmd.ExecuteNonQuery();
                    cmd.CommandText = e8;
                    cmd.ExecuteNonQuery();
                    cmd.CommandText = e9;
                    cmd.ExecuteNonQuery();
                    cmd.CommandText = e10;
                    cmd.ExecuteNonQuery();

                    cmd.CommandText = e11;
                    cmd.ExecuteNonQuery();
                    cmd.CommandText = e12;
                    cmd.ExecuteNonQuery();
                    cmd.CommandText = e13;
                    cmd.ExecuteNonQuery();
                    cmd.CommandText = e14;
                    cmd.ExecuteNonQuery();
                    cmd.CommandText = e15;
                    cmd.ExecuteNonQuery();
                    cmd.CommandText = e16;
                    cmd.ExecuteNonQuery();
                    cmd.CommandText = e17;
                    cmd.ExecuteNonQuery();
                    cmd.CommandText = e18;
                    cmd.ExecuteNonQuery();
                    cmd.CommandText = e19;
                    cmd.ExecuteNonQuery();
                    cmd.CommandText = e20;
                    cmd.ExecuteNonQuery();

                    cmd.CommandText = e21;
                    cmd.ExecuteNonQuery();
                    cmd.CommandText = e22;
                    cmd.ExecuteNonQuery();
                    cmd.CommandText = e23;
                    cmd.ExecuteNonQuery();


                    cmd.Dispose();
                    conn.Close();
                    conn.Dispose();

                    if (b)
                    {
                        SetJob18(c);
                        SetInstallValue();

                        WC.BLL.Admin_Help.UpdateApp();
                        Dk.Help.SetDXBBSConn();
                        //Dk.Help.GlobalOperateSql();
                        //HttpContext.Current.Application["isinstall"] = "1";

                        string words = HttpContext.Current.Server.HtmlEncode("系统已安装成功!谢谢您的使用!");
                        Response.Redirect("/InfoTip/Operate_Install.aspx?returnpage="
                        + "/Default.aspx" + "&tip=" + words);
                    }


                }
            }
            catch(Exception ex)
            {
                b = false;
                lt.Text = "<font color=#ff0000>失败：1 请检查 您填写的资料是否正确. <br>2 数据库是否为 混合验证模式(默认用户sa)<br>3 数据库服务器如果为IP地址,请开启SqlServer远程连接功能<br>4 程序主目录是否配置IIS操作文件夹权限(参考系统安装手册)</font><br>错误信息：" + ex.Message;
            }

        }

        private void SetJob18(string cn)
        {
            XmlDocument xd = new XmlDocument();
            xd.Load(HttpContext.Current.Server.MapPath("~/Job18.config"));
            xd.SelectSingleNode("Job18/hibernate.connection.connection_string").Attributes["Value"].Value = cn;
            xd.Save(HttpContext.Current.Server.MapPath("~/Job18.config"));
        }

        private void SetInstallValue()
        {
            XmlDocument xd = new XmlDocument();
            xd.Load(HttpContext.Current.Server.MapPath("~/img/snap/ins.gif"));
            xd.SelectSingleNode("ins/install").Attributes["Value"].Value = "9C+EB60=";
            xd.Save(HttpContext.Current.Server.MapPath("~/img/snap/ins.gif"));
        }

        private string GetConn()
        {
            string f = "Server={0};initial catalog={1};uid={2};pwd={3};Max Pool size=3500;Min Pool Size=13;";
            string host = Request.Form["addr"];
            string name = Request.Form["name"];
            string sa = Request.Form["sa"];
            string pwd = Request.Form["pwd"];

            return string.Format(f, host, name, sa, pwd);
        }

    }
}
