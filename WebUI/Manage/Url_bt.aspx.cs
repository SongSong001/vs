using System;
using System.Collections.Generic;

using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WC.BLL;
using WC.Model;
using WC.Tool;
using WC.DBUtility;

namespace WC.WebUI.Manage
{
    public partial class Url_bt : System.Web.UI.Page
    {
        private Bas_ComInfo bi = HttpContext.Current.Application["cominfo"] as Bas_ComInfo;
        protected void Page_Load(object sender, EventArgs e)
        {
            string u = WC.Tool.Utils.GetRequestHostUrl().ToLower().Replace("/manage/", "");
            bi = HttpContext.Current.Application["cominfo"] as Bas_ComInfo;

            Response.Clear();
            Response.ContentType = "APPLICATION/OCTET-STREAM";

            //解决中文乱码 
            Response.Buffer = true;
            Response.Charset = "gb2312";
            Response.ContentEncoding = System.Text.Encoding.GetEncoding("GB2312");
            Response.AppendHeader("content-disposition", "attachment;filename=\"" + System.Web.HttpUtility.UrlEncode(bi.ComName + "_办公系统", System.Text.Encoding.UTF8) + ".url\"");

            Response.Write("[InternetShortcut] \r\n");
            Response.Write("URL=" + u + "/ \r\n"); //链接 
            Response.Write("IDList= \r\n");
            Response.Write("IconFile= \r\n"); //图标文件 
            Response.Write("IconIndex=1 \r\n");
            Response.Write("[{000214A0-0000-0000-C000-000000000046}] \r\n");
            Response.Write("Prop3=19,2 \r\n");
            Response.End();


        }
    }
}