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
using WC.Tool;
using System.IO;

namespace WC.WebUI.Manage.Sys
{
    public partial class Seal_Manage : WC.BLL.ModulePages
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                IList userlist = Sys_User.Init().GetAll(null, "order by depid asc,orders asc");
                uids.Items.Add(new ListItem("请选择 印章/签名使用者", ""));
                for (int i = 0; i < userlist.Count; i++)
                {
                    Sys_UserInfo ui = userlist[i] as Sys_UserInfo;
                    uids.Items.Add(new ListItem(ui.RealName + " (" + ui.DepName + ")", ui.id + ""));
                }
            }

            if (!string.IsNullOrEmpty(Request.QueryString["mid"]) && !IsPostBack)
            {
                Show(Request.QueryString["mid"]);
            }
        }

        private void Show(string id)
        {

            Sys_SealInfo sm = Sys_Seal.Init().GetById(Convert.ToInt32(id));
            ViewState["sm"] = sm;
            Status.Checked = Convert.ToBoolean(sm.Status);
            SealName.Value = sm.SealName;
            TagName.Value = sm.TagName;
            Notes.Value = sm.Notes;
            if (sm.Uid > 0)
                uids.SelectedValue = sm.Uid + "";
            if (!string.IsNullOrEmpty(sm.FilePath))
                PerPic.ImageUrl = sm.FilePath;
        }

        protected void Save_Btn(object obj, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["mid"]))
            {
                UpDate();
            }
            else
            {
                if (PWD.Value.Trim() == "")
                    Response.Write("<script>alert('使用者密码不能为空!');window.location='" + Request.Url.AbsoluteUri + "'</script>");
                else
                {
                    if (!Fup.HasFile)
                        Response.Write("<script>alert('上传图片不能为空!');window.location='" + Request.Url.AbsoluteUri + "'</script>");
                    else
                        AddSeal();
                }

            }
        }

        private void UpDate()
        {
            Sys_SealInfo sm = ViewState["sm"] as Sys_SealInfo;
            sm.Status = Convert.ToInt32(Status.Checked);
            sm.AddTime = DateTime.Now;
            sm.Notes = Notes.Value;
            if (PWD.Value.Trim() != "")
                sm.PWD = PWD.Value.Trim();
            sm.SealName = SealName.Value;
            sm.TagName = TagName.Value;
            sm.Uid = Convert.ToInt32(Request.Form["uids"]);

            if (Fup.HasFile)
            {
                sm.FilePath = SaveJPG(Fup);
            }

            Sys_Seal.Init().Update(sm);

            string words = HttpContext.Current.Server.HtmlEncode("您好!印章/签名已编辑成功!");
            Response.Redirect("/InfoTip/Operate_Success.aspx?returnpage="
            + Request.Url.AbsoluteUri + "&tip=" + words);
        }

        private void AddSeal()
        {
            Sys_SealInfo sm = new Sys_SealInfo();
            sm.Status = Convert.ToInt32(Status.Checked);
            sm.AddTime = DateTime.Now;
            sm.Notes = Notes.Value;
            if (PWD.Value.Trim() != "")
                sm.PWD = PWD.Value.Trim();
            sm.SealName = SealName.Value;
            sm.TagName = TagName.Value;
            sm.Uid = Convert.ToInt32(Request.Form["uids"]);

            if (Fup.HasFile)
            {
                sm.FilePath = SaveJPG(Fup);
            }

            Sys_Seal.Init().Add(sm);

            string words = HttpContext.Current.Server.HtmlEncode("您好!印章/签名已添加成功!");
            Response.Redirect("/InfoTip/Operate_Success.aspx?returnpage="
            + Request.Url.AbsoluteUri + "&tip=" + words);
        }

        private string SaveJPG(FileUpload f)
        {
            string pic = "";
            if (f.HasFile)
            {
                FileExtension[] fe = { FileExtension.JPG, FileExtension.GIF, FileExtension.PNG };
                if (FileSystemManager.IsAllowedExtension(f, fe)) //头字节过滤非法图片 
                {
                    string doc = Server.MapPath("~/Files/SealFiles/");
                    string fileName = DateTime.Now.ToString("yyMddhhmmssfff") + Path.GetExtension(Fup.FileName);
                    doc += fileName;
                    Fup.PostedFile.SaveAs(doc);
                    pic = "~/Files/SealFiles/" + fileName;
                    Fup.Dispose();
                }
            }
            return pic;
        }

    }
}
