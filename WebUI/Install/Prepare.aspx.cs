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
using System.Xml;

namespace WC.WebUI.Install
{
    public partial class Prepare : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (WC.Tool.Config.CheckInstall())
            {
                //Response.Write("<script>window.location='../Default.aspx'</script>");
                Response.Redirect("~/Default.aspx");
            }

            if (System.Environment.Version.Major >= 2)
                nf.Value = "当前.NET Frameworks版本可正确运行本系统!";

            if (System.Environment.Version.Major >= 4)
            {
                nf.Value = "当前.NET Frameworks版本为4.0以上，版本过高!";
                lt.Text = "系统支持的.NET Frameworks版本为2.0/3.0/3.5，请在网站asp.net属性设置为2.0即可";
                bt.Enabled = false;
            }

            try
            {
                SetInstallValue();
                qx.Value = "程序目录权限已设置，可正确运行本系统!";
            }
            catch
            {
                lt.Text = "没有设置程序目录的IIS相关权限，点击查看<a href=qx.htm target=_blank>『如何设置程序目录权限』</a> ";
                qx.Value = "程序目录权限未设置，无法正常安装!";
                bt.Enabled = false;
            }
        }

        protected void Next_btn(object sender, EventArgs e)
        {
            Response.Redirect("Install.aspx?sf=" + Request.Form["sf"]);
        }

        private void SetInstallValue()
        {
            XmlDocument xd = new XmlDocument();
            xd.Load(HttpContext.Current.Server.MapPath("~/img/snap/ins.gif"));
            xd.SelectSingleNode("ins/install").Attributes["Value"].Value = "9C+EB11=";
            xd.Save(HttpContext.Current.Server.MapPath("~/img/snap/ins.gif"));
        }

    }
}
