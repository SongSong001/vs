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
using WC.Tool;

namespace WC.WebUI.Manage.Common
{
    public partial class TopicSet : WC.BLL.ViewPages
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                Show();
        }

        protected void Save_Btn(object sender, EventArgs e)
        {
            string h = t1.Value + "";
            if (WC.Tool.Utils.IsNumber(h))
            {
                int sindex = Convert.ToInt32(h);
                Sys_UserInfo ui = Sys_User.Init().GetById(Convert.ToInt32(Uid));
                if (sindex == 0)
                {
                    ui.et1 = -1;
                    ui.RoleGUID = "/wallpaper.jpg";
                }
                if (sindex != 0 && sindex != (tlist.Items.Count - 1))
                {
                    ui.et1 = 0;
                    ui.RoleGUID = tlist.SelectedValue;
                }
                if (sindex == (tlist.Items.Count - 1))
                {
                    if (Fup.HasFile)
                    {
                        FileExtension[] fe = { FileExtension.JPG };
                        if (FileSystemManager.IsAllowedExtension(Fup, fe)) //头字节过滤非法图片 
                        {
                            string name = DateTime.Now.ToString("yyMddHHmmssfff");
                            string doc = Server.MapPath("~/Files/Wall/cus/");
                            string fileName = name + Path.GetExtension(Fup.FileName);
                            doc += fileName;
                            Fup.PostedFile.SaveAs(doc);
                            ui.RoleGUID = "/Files/Wall/cus/" + name + Path.GetExtension(Fup.FileName);
                            ui.et1 = 1;
                            Fup.Dispose();
                        }
                    }
                }
                Sys_User.Init().Update(ui);
                string words1 = HttpContext.Current.Server.HtmlEncode("桌面主题设置成功!刷新生效!");
                Response.Redirect("/InfoTip/Operate_Success.aspx?returnpage="
                + Request.Url.AbsoluteUri + "&tip=" + words1);
            }
        }

        private void Show()
        {
            Sys_UserInfo ui = Sys_User.Init().GetById(Convert.ToInt32(Uid));
            ui.RoleGUID = ui.RoleGUID + "";
            tlist.Items.Clear();
            tlist.Items.Add(new ListItem("系统默认主题", "/wallpaper.jpg"));
            bool b = false;
            DirectoryInfo di = new DirectoryInfo(Server.MapPath("~/Files/Wall"));
            foreach (FileInfo fi in di.GetFiles("*.jpg"))
            {
                tlist.Items.Add(new ListItem(fi.Name, "/Files/Wall/" + fi.Name));
                if (ui.RoleGUID == "/Files/Wall/" + fi.Name)
                {
                    b = true;
                }
            }
            if (ui.RoleGUID.ToLower().Contains(".jpg") && ui.RoleGUID.ToLower().Contains("cus"))
            {
                tlist.Items.Add(new ListItem("自定义主题", ui.RoleGUID));
            }
            else
            {
                tlist.Items.Add(new ListItem("自定义主题", "/wallpaper.jpg"));
            }

            for (int i = 0; i < tlist.Items.Count; i++)
            {
                if (ui.et1 == -1)
                {
                    tlist.Items[0].Selected = true;
                }
                if (ui.et1 == 0)
                {
                    if (b)
                    {
                        if (tlist.Items[i].Value == ui.RoleGUID)
                        {
                            tlist.Items[i].Selected = true;
                        }
                    }
                    else
                    {
                        tlist.Items[0].Selected = true;
                    }
                }
                if (ui.et1 == 1)
                {
                    tlist.Items[tlist.Items.Count - 1].Selected = true;
                    display5.Visible = true;
                    //view2.Text = "当前自定义主题： " + ui.RoleGUID;
                }

            }

        }

    }
}