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

namespace WC.WebUI.Manage.Gov
{
    public partial class Gov_Graph : WC.BLL.ViewPages
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

                Gov_ModelInfo fmi = Gov_Model.Init().GetById(Convert.ToInt32(Request.QueryString["fm"]));
                fm_name.InnerText = fmi.Flow_Name;

                IList list = Gov_ModelStep.Init().GetAll("Flow_ModelID=" + fmi.id, "order by id asc");
                rpt_mf.DataSource = list;
                rpt_mf.DataBind();
            }
            if (!string.IsNullOrEmpty(Request.QueryString["fl"]))
            {
                model_flow.Visible = false;
                flow.Visible = true;

                GovInfo fi = WC.BLL.Gov.Init().GetById(Convert.ToInt32(Request.QueryString["fl"]));
                fl_name.InnerText = fi.Flow_Name;
                fl_current.InnerHtml = "<u>流程状态</u>：" + GetStatus(fi.Status) + " &nbsp;&nbsp; <u>当前环节</u>：" + fi.CurrentStepName;

                IList list = Gov_Step.Init().GetAll("isact=0 and flow_id=" + fi.id, "order by id asc");
                rpt_f.DataSource = list;
                rpt_f.DataBind();
            }
        }

        private string GetStatus(int t)
        {
            if (t == 0)
            {
                return "公文审批中";
            }
            else if (t == 1)
            {
                return "公文已签发";
            }
            else if (t == -1)
            {
                return "公文已锁定";
            }
            else if (t == -2)
            {
                return "公文已退回";
            }
            else if (t == 5)
            {
                return "公文已归档";
            }
            else
            {
                return "已过期";
            }
        }
    }
}
