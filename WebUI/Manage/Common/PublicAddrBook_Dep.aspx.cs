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
using WC.BLL;
using WC.Model;
using WC.DBUtility;

namespace WC.WebUI.Manage.Common
{
    public partial class PublicAddrBook_Dep : WC.BLL.ViewPages
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                Show();
        }

        private void Show()
        {
            IList list = Sys_Dep.Init().GetAll(null, "order by orders asc,phone desc");
            rpt_dep.DataSource = list;
            rpt_dep.DataBind();

            num.InnerHtml = "当前 总计 - <span style='color:#ff0000; font-weight:bold;'>" + list.Count + "</span> 个 记录数据";
        }

        protected void DownLoad(object sender, EventArgs e)
        {
            IList list = Sys_Dep.Init().GetAll(null, "order by orders asc,phone desc");
            string ct = "组织机构通讯录\r\n\r\n";
            string fn = "Organization ContactsBook";
            foreach (object j in list)
            {
                Sys_DepInfo si = j as Sys_DepInfo;
                if (!string.IsNullOrEmpty(si.Phone))
                    ct += si.DepName + "：" + si.Phone + "\r\n";
            }
            Response.Clear();
            Response.ClearHeaders();
            Response.Buffer = false;

            Response.AppendHeader("Content-Disposition", "attachment;filename=" + fn + ".txt");
            Response.ContentType = "application/vnd.txt";
            Response.Write(ct);
            Response.Flush();
            Response.End();
        }

    }
}
