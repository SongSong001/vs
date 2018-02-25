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

namespace WC.WebUI.Manage.Sys
{
    public partial class Role_Manage : WC.BLL.ModulePages
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                IList list = Sys_Module.Init().GetAll(null, "order by TypeName,Orders");
                for (int i = 0; i < list.Count; i++)
                {
                    Sys_ModuleInfo sm = list[i] as Sys_ModuleInfo;
                    powerList.Items.Add(new ListItem("<" + sm.TypeName + "> - " + sm.ModuleName, sm.id + ""));
                }
                if (!string.IsNullOrEmpty(Request.QueryString["rid"]))
                {
                    Show(Request.QueryString["rid"]);
                }
            }
        }

        protected void Save_Btn(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["rid"]))
            {
                int rid = Convert.ToInt32(Request.QueryString["rid"]);
                Sys_RoleInfo sr = ViewState["sr"] as Sys_RoleInfo;
                sr.RoleName = RoleName.Value;
                sr.Notes = Notes.Value;
                Sys_Role.Init().Update(sr);
                List<string> old_module = ViewState["old_module"] as List<string>;
                List<string> new_module = new List<string>();
                for (int i = 0; i < powerList.Items.Count; i++)
                {
                    if (powerList.Items[i].Selected)
                    {
                        new_module.Add(powerList.Items[i].Value);
                    }
                }
                for (int i = 0; i < old_module.Count; i++)
                {
                    if (!new_module.Contains(old_module[i]))
                    {
                        string sql = "delete from Sys_Role_Module where RoleID=" 
                            + rid + " and ModuleID=" + old_module[i];
                        MsSqlOperate.ExecuteNonQuery(CommandType.Text, sql, null);
                    }
                }
                for (int i = 0; i < new_module.Count; i++)
                {
                    if (!old_module.Contains(new_module[i]))
                    {
                        Sys_Role_ModuleInfo srm = new Sys_Role_ModuleInfo();
                        srm.ModuleID = Convert.ToInt32(new_module[i]);
                        srm.RoleID = rid;
                        Sys_Role_Module.Init().Add(srm);
                    }
                }

                string words = HttpContext.Current.Server.HtmlEncode("您好!角色已编辑成功!");
                Response.Redirect("/InfoTip/Operate_Success.aspx?returnpage="
                + Request.Url.AbsoluteUri + "&tip=" + words);
            }
            else
            {
                Sys_RoleInfo sr = new Sys_RoleInfo();
                sr.RoleName = RoleName.Value;
                sr.Notes = Notes.Value;
                Sys_Role.Init().Add(sr);
                for (int i = 0; i < powerList.Items.Count; i++)
                {
                    if (powerList.Items[i].Selected)
                    {
                        Sys_Role_ModuleInfo srm = new Sys_Role_ModuleInfo();
                        srm.ModuleID = Convert.ToInt32(powerList.Items[i].Value);
                        srm.RoleID = sr.id;
                        Sys_Role_Module.Init().Add(srm);
                    }
                }

                string words = HttpContext.Current.Server.HtmlEncode("您好!角色已添加成功!");
                Response.Redirect("/InfoTip/Operate_Success.aspx?returnpage="
                + Request.Url.AbsoluteUri + "&tip=" + words);
            }
            
        }

        private void Show(string id)
        {
            Sys_RoleInfo sr = Sys_Role.Init().GetById(Convert.ToInt32(id));
            ViewState["sr"] = sr;
            RoleName.Value = sr.RoleName;
            Notes.Value = sr.Notes;
            IList list = Sys_Role_Module.Init().GetAll("RoleID=" + id, null);
            List<string> old_module = new List<string>();
            for (int i = 0; i < list.Count; i++)
            {
                Sys_Role_ModuleInfo srm = list[i] as Sys_Role_ModuleInfo;
                old_module.Add(srm.ModuleID + "");
            }
            ViewState["old_module"] = old_module;
            powerListBind(list, powerList);
        }

        private void powerListBind(IList list, CheckBoxList cbList)
        {
            for (int i = 0; i < cbList.Items.Count; i++)
            {
                for (int j = 0; j < list.Count; j++)
                {
                    Sys_Role_ModuleInfo sr = list[j] as Sys_Role_ModuleInfo;
                    if (cbList.Items[i].Value == sr.ModuleID + "")
                        cbList.Items[i].Selected = true;
                }
            }
        }
    }
}
