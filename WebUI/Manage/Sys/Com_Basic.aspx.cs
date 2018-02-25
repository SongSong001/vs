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
using System.Xml;
using System.IO;
using WC.BLL;
using WC.Model;
using System.Net;
using System.Text;

namespace WC.WebUI.Manage.Sys
{
    public partial class Com_Basic : WC.BLL.ModulePages
    {
        private int nums = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                Show();
        }

        private void Show()
        {
            IList list = Bas_Com.Init().GetAll(null, "order by id asc");
            if (list.Count > 0)
            {
                Bas_ComInfo bi = list[0] as Bas_ComInfo;
                ViewState["Bas_Com"] = bi;
                TypeID.Value = bi.MsgState + "";
                et3.Value = bi.et3 + "";
                ComName.Value = bi.ComName;
                Notes.Value = bi.Notes;
                BBSState.Checked = Convert.ToBoolean(bi.BBSState);
                TipsState.Checked = Convert.ToBoolean(bi.TipsState);
                ValidCodeState.Checked = Convert.ToBoolean(bi.ValidCodeState);

                WebUrl.Value = bi.WebUrl;

                Logo.Value = bi.Logo;

                et4.Value = bi.et4;

                nums = 1;
                ViewState["nums"] = nums;
            }

        }

        protected void Save_Btn(object sender, EventArgs e)
        {
            nums = Convert.ToInt32(ViewState["nums"]);
            if (nums == 0)
            {
                Bas_ComInfo bi = new Bas_ComInfo();
                bi.MsgState = Convert.ToInt32(TypeID.Value);
                bi.et3 = Convert.ToInt32(et3.Value);
                bi.ComName = ComName.Value.Replace("#", "").Replace(",", "");
                bi.Notes = Notes.Value;
                bi.AddTime = DateTime.Now;
                bi.BBSState = Convert.ToInt32(BBSState.Checked);
                bi.ValidCodeState = Convert.ToInt32(ValidCodeState.Checked);
                bi.TipsState = Convert.ToInt32(TipsState.Checked);

                bi.WebUrl = "http://" + WebUrl.Value.ToLower().Replace("http://", "");

                bi.Logo = Logo.Value;
                bi.et4 = et4.Value;
                Bas_Com.Init().Add(bi);

                Sys_DepInfo sd = new Sys_DepInfo();
                sd.DepName = bi.ComName.Replace("#", "").Replace(",", "");
                sd.Notes = bi.Notes;
                sd.ParentID = 0;
                sd.Orders = 0;
                sd.ComID = bi.id;
                sd.ComGUID = bi.guid;
                
                Sys_Dep.Init().Add(sd);

                HttpContext.Current.Application["cominfo"] = bi;
                
                string words = HttpContext.Current.Server.HtmlEncode("您好!企业信息已成功保存!");
                Response.Redirect("/InfoTip/Operate_Success.aspx?returnpage="
                + Request.Url.AbsoluteUri + "&tip=" + words);
            }
            else
            {
                Bas_ComInfo bi = ViewState["Bas_Com"] as Bas_ComInfo;
                bi.MsgState = Convert.ToInt32(TypeID.Value);
                bi.et3 = Convert.ToInt32(et3.Value);
                bi.ComName = ComName.Value.Replace("#", "").Replace(",", "");
                bi.Notes = Notes.Value;
                bi.BBSState = Convert.ToInt32(BBSState.Checked);
                bi.ValidCodeState = Convert.ToInt32(ValidCodeState.Checked);
                bi.TipsState = Convert.ToInt32(TipsState.Checked);

                bi.WebUrl = "http://" + WebUrl.Value.ToLower().Replace("http://", "");

                bi.Logo = Logo.Value;
                bi.et4 = et4.Value;
                Bas_Com.Init().Update(bi);

                HttpContext.Current.Application["cominfo"] = bi;

                IList list = Sys_Dep.Init().GetAll("ComID=" + bi.id, null);
                if (list.Count != 0)
                {
                    Sys_DepInfo sd = list[0] as Sys_DepInfo;
                    sd.DepName = bi.ComName.Replace("#", "").Replace(",", "");
                    sd.Notes = bi.Notes;
                    sd.ParentID = 0;
                    sd.Orders = 0;
                    sd.ComID = bi.id;
                    sd.ComGUID = bi.guid;
                    Sys_Dep.Init().Update(sd);

                    IList ul = Sys_User.Init().GetAll("depid=" + sd.id, null);
                    foreach (object j in ul)
                    {
                        Sys_UserInfo ui = j as Sys_UserInfo;
                        ui.DepName = sd.DepName.Replace("#", "").Replace(",", "");
                        Sys_User.Init().Update(ui);
                    }

                }

                string words = HttpContext.Current.Server.HtmlEncode("您好!企业信息已成功保存!");
                Response.Redirect("/InfoTip/Operate_Success.aspx?returnpage="
                + Request.Url.AbsoluteUri + "&tip=" + words);
            }


        }


    }
}
