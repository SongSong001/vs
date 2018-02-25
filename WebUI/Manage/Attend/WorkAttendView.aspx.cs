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

using WC.BLL;
using WC.Model;
using WC.DBUtility;

namespace WC.WebUI.Manage.Attend
{
    public partial class WorkAttendView : WC.BLL.ViewPages
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && !string.IsNullOrEmpty(Request.QueryString["wid"]))
            {
                Show(Request.QueryString["wid"]);

            }
        }

        private void Show(string wid)
        {
            Work_AttendInfo wi = Work_Attend.Init().GetById(Convert.ToInt32(wid));
            WorkNote.Text = wi.Notes;
            WorkPeople.Text = wi.RealName + "(" + wi.DepName + ")";
            WorkDate.Text = WC.Tool.Utils.ConvertDate4(wi.AddTime);

            switch (wi.AttendType)
            {
                case 1: WorkType.InnerText = "上下班考勤"; WorkInfo.Text = wi.StandardNames + ": " + wi.SignTimes + " &nbsp; (" + wi.SignJudge + " " + wi.StandardTimes + ")"; break;
                case 2: WorkType.InnerText = "外出"; WorkInfo.Text = WC.Tool.Utils.ConvertDate0(wi.BeginTime) + " " + wi.B1 + ":" + wi.B2 + "&nbsp; - &nbsp;" + WC.Tool.Utils.ConvertDate0(wi.EndTime) + " " + wi.E1 + ":" + wi.E2; break;
                case 3: WorkType.InnerText = "请假"; WorkInfo.Text = WC.Tool.Utils.ConvertDate0(wi.BeginTime) + " " + wi.B1 + ":" + wi.B2 + "&nbsp; - &nbsp;" + WC.Tool.Utils.ConvertDate0(wi.EndTime) + " " + wi.E1 + ":" + wi.E2; break;
                case 4: WorkType.InnerText = "出差"; WorkInfo.Text = WC.Tool.Utils.ConvertDate0(wi.BeginTime) + " " + wi.B1 + ":" + wi.B2 + "&nbsp; - &nbsp;" + WC.Tool.Utils.ConvertDate0(wi.EndTime) + " " + wi.E1 + ":" + wi.E2; break;
                default: break;
            }

        }
    }
}