﻿using System;
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

namespace WC.WebUI.Manage.Flow
{
    public partial class Flow_ViewTable : WC.BLL.ViewPages
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && !string.IsNullOrEmpty(Request.QueryString["fl"]))
            {
                Show(Request.QueryString["fl"]);
            }
        }

        private void Show(string fl)
        {
            FlowsInfo fi = WC.BLL.Flows.Init().GetById(Convert.ToInt32(fl));
            if (fi.id > 0)
            {
                string yjs = "";
                yjs += "<p>0、<b>流程申请</b> &nbsp;&nbsp; " + fi.CreatorRealName + " 在 " + WC.Tool.Utils.ConvertDate2(fi.AddTime) +
                " 发起流程(申请人) </p>";

                Flow_Name.InnerHtml = fi.Flow_Name + " &nbsp; (流水编号:" + fi.AddTime.Year + "-" + (100000 + fi.id) + ")";
                CreatorRealName.InnerText = fi.CreatorRealName;
                CreatorDepName.InnerText = fi.CreatorDepName;
                AddTime.InnerText = fi.AddTime.ToString("yyyy-MM-dd");
                Remark.InnerHtml = "<br>" + fi.Remark.Replace("\n", "<br>");
                IList list2 = Flows_StepAction.Init().GetAll("FlowID=" + fi.id, "order by id asc");
                foreach (object obj in list2)
                {
                    Flows_StepActionInfo tmp = obj as Flows_StepActionInfo;
                    yjs += "<p>"+(list2.IndexOf(obj) + 1) + "、<b>" + tmp.OperationStepName + "</b> &nbsp;&nbsp; " + tmp.UserRealName
                        + " 在 " + WC.Tool.Utils.ConvertDate2(tmp.AddTime) + " 已审 " + tmp.OperationWord + "</p>";
                }
                content.InnerHtml = "<br>" + yjs +"<br>";
            }
        }

    }
}
