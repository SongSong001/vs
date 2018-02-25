using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;

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

namespace WC.WebUI.Manage.Tasks
{
    public partial class Task_Records : WC.BLL.ViewPages
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && !string.IsNullOrEmpty(Request.QueryString["tid"]))
            {
                string t = Request.QueryString["tid"];
                Show(t);
            }
        }

        private void Show(string tid)
        {
            TasksInfo ti = WC.BLL.Tasks.Init().GetById(Convert.ToInt32(tid));
            if (Uid == (ti.CreatorID + "") || ti.ExecuteUserList.Contains("#" + Uid + "#") || ti.ManageUserList.Contains("#" + Uid + "#") || Modules.Contains("51"))
            {
                Subject.InnerText = "任务标题：" + ti.TaskName;
                bodys.InnerHtml = ti.Records;
            }
        }

    }
}