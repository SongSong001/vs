using System;
using System.Collections.Generic;
using System.Collections;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WC.BLL;
using WC.Model;

namespace WC.WebUI.Manage.SMS
{
    public partial class SMS_Send : WC.BLL.ModulePages
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Save_Btn(object sender, EventArgs e)
        {
            Bas_ComInfo bi = HttpContext.Current.Application["cominfo"] as Bas_ComInfo;
            if (bi.et2 == 1)
            {
                string t = Subject.Value;
                string ulist = PhoneList.Value;

                Sms_DataInfo sd = new Sms_DataInfo();
                sd.UserID = Convert.ToInt32(Uid);
                sd.DepName = DepName;
                sd.RealName = RealName;
                sd.AddTime = DateTime.Now.ToString("yyyy-MM-dd");
                //sd.PhoneList = PhoneList.Value;
                sd.IsLongMessage = Convert.ToInt32(IsLongMessage.Checked);
                sd.Subject = t;

                List<string> list = GetPhoneList(PhoneList.Value, userlist.Value);
                sd.PhoneList = string.Join(",", list.ToArray());

                Dk.Help.CommonMobleSend(list, t, IsLongMessage.Checked);
                Sms_Data.Init().Add(sd);

                string words = HttpContext.Current.Server.HtmlEncode("您好!短信已发送!");
                Response.Redirect("/InfoTip/Operate_Success.aspx?returnpage="
                + Request.Url.AbsoluteUri + "&tip=" + words);
            }
            else
            {
                Response.Write("<script>alert('短信网关没有启用！请在[短信设置]开启相关功能！');window.location.href='SMS_Send.aspx';</script>");
            }

        }

        private List<string> GetPhoneList(string ulist,string userlist)
        {
            List<string> list = new List<string>();
            if (ulist.Contains(","))
            {
                string[] arr = ulist.Split(',');
                for (int i = 0, len = arr.Length; i < len; i++)
                {
                    if (Dk.Help.ValidateMobile(arr[i]))
                    {
                        list.Add(arr[i]);
                    }
                }
            }
            else
            {
                if (Dk.Help.ValidateMobile(ulist))
                { list.Add(ulist); }
            }

            if (userlist.Contains(","))
            {
                string[] arr = userlist.Split(',');
                for (int i = 0, len = arr.Length; i < len; i++)
                {
                    if (arr[i].Contains("#"))
                    {
                        string uid = arr[i].Split('#')[1];
                        Sys_UserInfo ui = Sys_User.Init().GetById(Convert.ToInt32(uid));
                        if (Dk.Help.ValidateMobile(ui.Phone))
                        {
                            list.Add(ui.Phone);
                        }
                    }
                }

            }
            return list;
        }

    }
}