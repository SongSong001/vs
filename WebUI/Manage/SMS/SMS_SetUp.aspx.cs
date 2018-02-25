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
using System.Text;
using System.Net;

namespace WC.WebUI.Manage.SMS
{
    public partial class SMS_SetUp : BLL.ModulePages
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Bas_ComInfo bi = HttpContext.Current.Application["cominfo"] as Bas_ComInfo;
                et2.Checked = Convert.ToBoolean(bi.et2);

                //读取sms基本配置文件
                Hashtable hs = (Hashtable)HttpContext.Current.Application["sms"];
                string sms_url1 = hs["sms_url"] + "";
                string sms_user1 = hs["sms_user"] + "";
                string sms_pwd1 = hs["sms_pwd"] + "";
                string cont_f1 = hs["cont_f"] + "";
                string cont_g1 = hs["cont_g"] + "";
                string cont_n1 = hs["cont_n"] + "";
                string cont_m1 = hs["cont_m"] + "";

                sms_url.Value = sms_url1;
                sms_user.Value = sms_user1;
                sms_pwd.Value = sms_pwd1;
                cont_f.Value = cont_f1;
                cont_g.Value = cont_g1;
                cont_n.Value = cont_n1;
                cont_m.Value = cont_m1;

                //短信查询余额
                try
                {
                    string Sms_url = sms_url1;

                    string Sms_user = sms_user1;
                    string Sms_pwd = sms_pwd1;

                    string url = "http://sms.webchinese.cn/web_api/SMS/GBK/?Action=SMS_Num&Uid=" + Sms_user + "&Key=" + Sms_pwd;
                    

                    string targeturl = url.Trim().ToString();
                    HttpWebRequest hr = (HttpWebRequest)WebRequest.Create(targeturl);
                    hr.UserAgent = "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)";
                    hr.Method = "GET";
                    hr.Timeout = 30 * 60 * 1000;
                    WebResponse hss = hr.GetResponse();
                    Stream sr = hss.GetResponseStream();
                    StreamReader ser = new StreamReader(sr, Encoding.GetEncoding("GBK"));
                    string strRet = ser.ReadToEnd();

                    DXYE.Text = strRet;
                }
                catch { DXYE.Text = "短信查询接口繁忙"; }
            }
        }

        protected void Save_Btn(object sender, EventArgs e)
        {
            //读取sms基本配置文件
            Hashtable hs = (Hashtable)HttpContext.Current.Application["sms"];
            hs["sms_url"] = sms_url.Value;
            hs["sms_user"] = sms_user.Value;
            hs["sms_pwd"] = sms_pwd.Value;
            hs["cont_f"] = cont_f.Value;
            hs["cont_g"] = cont_g.Value;
            hs["cont_n"] = cont_n.Value;
            hs["cont_m"] = cont_m.Value;

            XmlDocument xd = new XmlDocument();
            xd.Load(HttpContext.Current.Server.MapPath("~/sms.config"));
            xd.SelectSingleNode("sms/sms_url").Attributes["Value"].Value = sms_url.Value;
            xd.SelectSingleNode("sms/sms_user").Attributes["Value"].Value = sms_user.Value;
            xd.SelectSingleNode("sms/sms_pwd").Attributes["Value"].Value = sms_pwd.Value;

            xd.SelectSingleNode("sms/cont_f").Attributes["Value"].Value = cont_f.Value;
            xd.SelectSingleNode("sms/cont_g").Attributes["Value"].Value = cont_g.Value;
            xd.SelectSingleNode("sms/cont_n").Attributes["Value"].Value = cont_n.Value;
            xd.SelectSingleNode("sms/cont_m").Attributes["Value"].Value = cont_m.Value;
            xd.Save(HttpContext.Current.Server.MapPath("~/sms.config"));

            Bas_ComInfo bi = HttpContext.Current.Application["cominfo"] as Bas_ComInfo;
            bi.et2 = Convert.ToInt32(et2.Checked);
            HttpContext.Current.Application["cominfo"] = bi;

            Bas_Com.Init().Update(bi);

            string words = HttpContext.Current.Server.HtmlEncode("您好!短信设置修改已成功!");
            Response.Redirect("/InfoTip/Operate_Success.aspx?returnpage="
            + Request.Url.AbsoluteUri + "&tip=" + words);

        }

    }
}