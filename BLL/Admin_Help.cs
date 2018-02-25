using System;
using System.Data;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.IO;
using System.Text;
using System.Xml;
using System.Collections.Specialized;
using WC.BLL;
using WC.Model;
using WC.DBUtility;
using WC.Tool;

namespace WC.BLL
{
    public class Admin_Help
    {
        static public Hashtable GetHbmHash()
        {
            Hashtable ht = new Hashtable();
            XmlDocument xd = new XmlDocument();
            xd.Load(HttpContext.Current.Server.MapPath("~/Job18.config"));
            ht.Add("hibernate.connection.provider", xd.SelectSingleNode("Job18/hibernate.connection.provider").Attributes["Value"].Value);
            ht.Add("hibernate.dialect", xd.SelectSingleNode("Job18/hibernate.dialect").Attributes["Value"].Value);
            ht.Add("hibernate.connection.driver_class", xd.SelectSingleNode("Job18/hibernate.connection.driver_class").Attributes["Value"].Value);
            ht.Add("hibernate.connection.connection_string", xd.SelectSingleNode("Job18/hibernate.connection.connection_string").Attributes["Value"].Value);
            ht.Add("hibernate.cache.provider_class", xd.SelectSingleNode("Job18/hibernate.cache.provider_class").Attributes["Value"].Value);
            ht.Add("hibernate.cache.use_query_cache", xd.SelectSingleNode("Job18/hibernate.cache.use_query_cache").Attributes["Value"].Value);

            return ht;
        }

        static public Hashtable GetSMSHash()
        {
            Hashtable ht = new Hashtable();
            XmlDocument xd = new XmlDocument();
            xd.Load(HttpContext.Current.Server.MapPath("~/sms.config"));
            ht.Add("sms_url", xd.SelectSingleNode("sms/sms_url").Attributes["Value"].Value);
            ht.Add("sms_user", xd.SelectSingleNode("sms/sms_user").Attributes["Value"].Value);
            ht.Add("sms_pwd", xd.SelectSingleNode("sms/sms_pwd").Attributes["Value"].Value);
            ht.Add("cont_f", xd.SelectSingleNode("sms/cont_f").Attributes["Value"].Value);
            ht.Add("cont_g", xd.SelectSingleNode("sms/cont_g").Attributes["Value"].Value);
            ht.Add("cont_n", xd.SelectSingleNode("sms/cont_n").Attributes["Value"].Value);
            ht.Add("cont_m", xd.SelectSingleNode("sms/cont_m").Attributes["Value"].Value);

            ht.Add("cont_f_e", xd.SelectSingleNode("sms/cont_f").Attributes["Enable"].Value);
            ht.Add("cont_g_e", xd.SelectSingleNode("sms/cont_g").Attributes["Enable"].Value);
            ht.Add("cont_n_e", xd.SelectSingleNode("sms/cont_n").Attributes["Enable"].Value);
            ht.Add("cont_m_e", xd.SelectSingleNode("sms/cont_m").Attributes["Enable"].Value);

            return ht;

        }

        static public Hashtable GetModuleHash()
        {
            Hashtable ht = new Hashtable();
            IList list = Sys_Module.Init().GetAll(null, null);
            foreach (object obj in list)
            {
                Sys_ModuleInfo sm = obj as Sys_ModuleInfo;
                ht.Add(sm.id.ToString(), sm.ModuleUrl);
            }

            return ht;
        }

        static public List<Sys_UserInfo> GetUserHash()
        {
            IList list = Sys_User.Init().GetAll(null, null);
            List<Sys_UserInfo> li = new List<Sys_UserInfo>();
            foreach (object obj in list)
            {
                Sys_UserInfo sm = obj as Sys_UserInfo;
                //ht.Add(sm.id.ToString(), sm);
                li.Add(sm);
            }

            return li;
        }

        static public object GetComInfo()
        {
            return Bas_Com.Init().GetAll(null, null)[0];
        }

        static public void UpdateApp()
        {
            if (System.Web.HttpContext.Current.Application["hbm"] == null || System.Web.HttpContext.Current.Application["user_online"] == null)
            {
                if (!WC.Tool.Config.CheckInstall())
                {
                    System.Web.HttpContext.Current.Response.Redirect("~/Install/Default.aspx");
                }
                else
                {
                    HttpContext.Current.Application["hbm"] = GetHbmHash();
                    HttpContext.Current.Application["stand_config"] = WC.Tool.Config.GetConfigByFileName("~/DK_Config/config_stand.cfgg");
                    HttpContext.Current.Application["config_fenye"] = WC.Tool.Config.GetConfigByFileName("~/DK_Config/config_fenye.cfgg");
                    HttpContext.Current.Application["cominfo"] = GetComInfo();
                    HttpContext.Current.Application["moduleid_moduleurl"] = GetModuleHash();
                    HttpContext.Current.Application["user_online"] = GetUserHash();
                    HttpContext.Current.Application["sms"] = GetSMSHash();
                }
            }
        }



    }
}
