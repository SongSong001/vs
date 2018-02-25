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
using System.IO;
using WC.BLL;
using WC.Model;
using WC.Tool;

namespace WC.WebUI.Manage.Common
{
    public partial class User_InfoEdit : WC.BLL.ViewPages
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                Show();
        }

        private void Show()
        {

            Sys_UserInfo su = Sys_User.Init().GetById(Convert.ToInt32(Uid));
            ViewState["su"] = su;
            PositionName.Value = su.PositionName;

            userlist.Value = su.et6;
            namelist.Value = su.et5;
            if (su.DepGUID == "no")
                zjss.Visible = false;

            Sex.SelectedValue = su.Sex + "";
            Birthday.Value = su.Birthday;
            Phone.Value = su.Phone;
            Tel.Value = su.Tel;
            HomeAddress.Value = su.HomeAddress;
            JoinTime.Value = su.JoinTime;
            Notes.Value = su.Notes;
            QQ.Value = su.QQ;
            Email.Value = su.Email;

            RoleGUID.SelectedValue = su.MsgTime + "";
            MemoShare.Checked = Convert.ToBoolean(su.MemoShare);

        }

        protected void Save_Btn(object sender, EventArgs e)
        {
            Sys_UserInfo su = ViewState["su"] as Sys_UserInfo;
            su.PositionName = PositionName.Value;
            //su.DirectSupervisor = Convert.ToInt32(Request.Form["DirectSupervisor"]);

            su.Sex = Convert.ToInt32(Sex.SelectedValue);
            su.Birthday = Birthday.Value;
            su.Phone = Phone.Value;
            su.Tel = Tel.Value;
            su.QQ = QQ.Value;
            su.Email = Email.Value;
            su.HomeAddress = HomeAddress.Value;
            su.JoinTime = JoinTime.Value;
            su.Notes = Notes.Value;
            su.MsgTime = Convert.ToInt32(RoleGUID.SelectedValue);
            su.MemoShare = Convert.ToInt32(MemoShare.Checked);

            su.et6 = userlist.Value;
            su.et5 = namelist.Value;

            if (Fup.HasFile)
            {
                FileExtension[] fe = { FileExtension.GIF, FileExtension.JPG, FileExtension.PNG, FileExtension.BMP };
                if (FileSystemManager.IsAllowedExtension(Fup, fe)) //头字节过滤非法图片 
                {
                    string name = su.UserName;
                    string doc = Server.MapPath("~/Files/common/");
                    string fileName = name + Path.GetExtension(Fup.FileName);
                    doc += fileName;
                    Fup.PostedFile.SaveAs(doc);
                    su.PerPic = fileName;
                    Fup.Dispose();
                }
            }

            Sys_User.Init().Update(su);

            //IM用户数据更新
            WC.WebUI.Dk.Help.UpdateIMUser(su);

            string words1 = HttpContext.Current.Server.HtmlEncode("您好!基本资料修改成功!");
            Response.Redirect("/InfoTip/Operate_Success.aspx?returnpage="
            + Request.Url.AbsoluteUri + "&tip=" + words1);

        }

    }
}
