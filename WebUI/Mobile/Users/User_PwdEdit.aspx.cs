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

namespace WC.WebUI.Mobile.Users
{
    public partial class User_PwdEdit : WC.BLL.MobilePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                Show();
        }

        private void Show()
        {
            Uname.InnerText = UserName;
            Urealname.InnerText = RealName;
        }

        protected void Save_Btn(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Oldpwd.Value) && !string.IsNullOrEmpty(newpwd.Value))
            {
                if (newpwd.Value.Trim() == newpwd1.Value.Trim())
                {
                    IList list = Sys_User.Init().GetAll("id=" + Uid + " and password='" + WC.Tool.Encrypt.MD5_32(Oldpwd.Value.Trim().ToLower()) + "'", null);
                    if (list.Count > 0)
                    {
                        Sys_UserInfo ui = list[0] as Sys_UserInfo;
                        ui.PassWord = WC.Tool.Encrypt.MD5_32(newpwd.Value.Trim().ToLower());
                        Sys_User.Init().Update(ui);

                        //IM用户数据更新
                        WC.WebUI.Dk.Help.UpdateIMUser(ui);

                        WC.Tool.MessageBox.ShowAndRedirect(this, "密码修改成功!", "UserMenu.aspx");
                        //Response.Write("<script>alert('密码修改成功!');window.location='UserMenu.aspx'</script>");
                    }
                    else
                    {
                        WC.Tool.MessageBox.ShowAndRedirect(this, "原密码不正确,重新输入!", "User_PwdEdit.aspx");
                        //Response.Write("<script>alert('原密码不正确,重新输入!');window.location='User_PwdEdit.aspx'</script>");
                    }
                }
                else
                {
                    WC.Tool.MessageBox.ShowAndRedirect(this, "确认密码不一致,重新输入!", "User_PwdEdit.aspx");
                    //Response.Write("<script>alert('确认密码不一致,重新输入!');window.location='User_PwdEdit.aspx'</script>");
                }
            }
            else
            {
                WC.Tool.MessageBox.ShowAndRedirect(this, "新旧密码不能为空!", "User_PwdEdit.aspx");
            }

        }

    }
}