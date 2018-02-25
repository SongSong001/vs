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
using System.IO;
using WC.BLL;
using WC.Model;

namespace WC.WebUI.Manage.Flow
{
    public partial class Flow_ModelFileManage : WC.BLL.ModulePages
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!string.IsNullOrEmpty(Request.QueryString["fmf"]))
                {
                    Show(Request.QueryString["fmf"]);
                }
            }
        }

        private void Show(string id)
        {
            Flows_ModelFileInfo fi = Flows_ModelFile.Init().GetById(Convert.ToInt32(id));
            FormTitle.Value = fi.FormTitle;
            DocBody.Value = fi.DocBody;
            //ViewState["fi"] = fi;
        }

        protected void Save_Btn(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["fmf"]))
            {
                Flows_ModelFileInfo fi = Flows_ModelFile.Init().GetById(Convert.ToInt32(Request.QueryString["fmf"]));
                fi.FormTitle = FormTitle.Value;
                fi.AddTime = DateTime.Now;
                fi.CreatorDepName = DepName;
                fi.CreatorID = Convert.ToInt32(Uid);
                fi.CreatorRealName = RealName;
                fi.DocBody = DocBody.Value;
                Flows_ModelFile.Init().Update(fi);

                string words = HttpContext.Current.Server.HtmlEncode("您好!模板表单编辑成功!");
                Response.Redirect("/InfoTip/Operate_Success.aspx?returnpage="
                + Request.Url.AbsoluteUri + "&tip=" + words);
            }
            else
            {
                Flows_ModelFileInfo fi = new Flows_ModelFileInfo();
                fi.AddTime = DateTime.Now;
                fi.CreatorDepName = DepName;
                fi.CreatorID = Convert.ToInt32(Uid);
                fi.CreatorRealName = RealName;
                fi.FormTitle = FormTitle.Value;
                fi.DocBody = DocBody.Value;
                Flows_ModelFile.Init().Add(fi);

                string words = HttpContext.Current.Server.HtmlEncode("您好!模板表单添加成功!");
                Response.Redirect("/InfoTip/Operate_Success.aspx?returnpage="
                + Request.Url.AbsoluteUri + "&tip=" + words);
            }
        }



    }
}
