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
using WC.Model;
using WC.BLL;

namespace WC.WebUI.Manage.Attend
{
    public partial class WorkSet : WC.BLL.ModulePages
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && !string.IsNullOrEmpty(Request.QueryString["type"]))
            {
                if (Request.QueryString["type"] == "edit")
                {
                    Edit_Show();
                }
                if (Request.QueryString["type"] == "del" && !string.IsNullOrEmpty(Request.QueryString["manage"]))
                {
                    int wid = Convert.ToInt32(Request.QueryString["manage"]);
                    Work_AttendSet.Init().Delete(wid);
                    Response.Redirect("WorkSet.aspx?type=edit");
                }

            }

        }

        private void Edit_Show()
        {
            p_edit.Visible = true;
            p_list.Visible = true;

            if (!string.IsNullOrEmpty(Request.QueryString["manage"]))
            {
                Work_AttendSetInfo wi = Work_AttendSet.Init().GetById(Convert.ToInt32(Request.QueryString["manage"]));
                ViewState["wi"] = wi;
                AttendNames1.SelectedValue = wi.AttendNames;
                if (wi.AttendTimes.Contains(":"))
                {
                    ddl_hour.SelectedValue = wi.AttendTimes.Split(':')[0];
                    ddl_minute.SelectedValue = wi.AttendTimes.Split(':')[1];
                }
            }
            IList list = Work_AttendSet.Init().GetAll(null, null);
            rpt.DataSource = list;
            rpt.DataBind();

            num.InnerHtml = "当前 总计 - <span style='color:#ff0000; font-weight:bold;'>" + list.Count + "</span> 个 记录数据";
        }

        protected void Save_Btn(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["manage"]))
            {
                Work_AttendSetInfo wi = ViewState["wi"] as Work_AttendSetInfo;
                wi.AttendNames = AttendNames1.SelectedValue;
                wi.AttendTimes = ddl_hour.SelectedValue + ":" + ddl_minute.SelectedValue;
                Work_AttendSet.Init().Update(wi);
                Response.Write("<script>alert('编辑上下班时间成功!');window.location='WorkSet.aspx?type=edit'</script>");
            }
            else
            {
                Work_AttendSetInfo wi = new Work_AttendSetInfo();
                wi.AttendNames = AttendNames1.SelectedValue;
                wi.AttendTimes = ddl_hour.SelectedValue + ":" + ddl_minute.SelectedValue;
                Work_AttendSet.Init().Add(wi);
                Response.Write("<script>alert('添加上下班时间成功!');window.location='WorkSet.aspx?type=edit'</script>");
            }

        }

    }
}