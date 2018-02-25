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

namespace WC.WebUI.Manage.Flow
{
    public partial class Flow_Graph : WC.BLL.ViewPages
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Show();
        }

        private void Show()
        {
            if (!string.IsNullOrEmpty(Request.QueryString["fm"]))
            {
                model_flow.Visible = true;
                flow.Visible = false;

                Flows_ModelInfo fmi = Flows_Model.Init().GetById(Convert.ToInt32(Request.QueryString["fm"]));
                fm_name.InnerText = fmi.Flow_Name;

                IList list = Flows_ModelStep.Init().GetAll("Flow_ModelID=" + fmi.id, "order by id asc");
                rpt_mf.DataSource = list;
                rpt_mf.DataBind();
            }
            if (!string.IsNullOrEmpty(Request.QueryString["fl"]))
            {
                model_flow.Visible = false;
                flow.Visible = true;

                FlowsInfo fi = Flows.Init().GetById(Convert.ToInt32(Request.QueryString["fl"]));
                fl_name.InnerText = fi.Flow_Name;
                fl_current.InnerHtml = "<u>流程状态</u>：" + GetStatus(fi.Status) + " &nbsp;&nbsp; <u>当前环节</u>：" + fi.CurrentStepName;

                IList list = Flows_Step.Init().GetAll("isact=0 and flow_id=" + fi.id, "order by id asc");
                rpt_f.DataSource = list;
                rpt_f.DataBind();
            }
        }

        private string GetStatus(int t)
        {
            if (t == 0)
            {
                return "审批中";
            }
            else if (t == 1)
            {
                return "已完成";
            }
            else if (t == -1)
            {
                return "已锁定";
            }
            else if (t == -2)
            {
                return "已退回";
            }
            else
            {
                return "已过期";
            }
        }

    }
}
