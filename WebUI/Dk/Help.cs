using System;
using System.Data;
using System.Data.SqlClient;
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
using System.Net;
using DXBBS.Business;
using DXBBS.Components;
using DXBBS.Controls;
using DXBBS.DataProviders;
using DXBBS.Service;
using System.Text.RegularExpressions;

namespace WC.WebUI.Dk
{
    public class Help
    {

        public static string GetMemoConn()
        {
            try
            {
                Hashtable ht = HttpContext.Current.Application["hbm"] as Hashtable;
                return ht["hibernate.connection.connection_string"] + "";
            }
            catch { return ""; }
        }

        static public void SetDXBBSConn()
        {
            string conn = GetMemoConn();
            XmlDocument xd = new XmlDocument();
            xd.Load(HttpContext.Current.Server.MapPath("~/bbs/config/Forum.config"));
            string t = xd.SelectSingleNode("ForumConfig/DataBase").Attributes["Value"].Value;
            if (t != conn && conn != "")
            {
                xd.SelectSingleNode("ForumConfig/DataBase").Attributes["Value"].Value = conn;
                xd.Save(HttpContext.Current.Server.MapPath("~/bbs/config/Forum.config"));
            }
        }

        static public void AdminSendMail(string title,string content,int receiverid,string userlist,string namelist)
        {
            MailsInfo mi = new MailsInfo();
            Mails_DetailInfo md = new Mails_DetailInfo();
            md.Bodys = content;
            md.SendIDs = userlist;
            md.SendRealNames = namelist;
            Mails_Detail.Init().Add(md);

            mi.ReceiverID = receiverid;
            mi.SenderDepName = "系统通知";
            mi.SenderID = 31;
            mi.SenderRealName = "系统管理员";
            mi.SendTime = DateTime.Now;
            mi.SendType = -1;
            mi.Subject = title;
            mi.did = md.id;

            Mails.Init().Add(mi);
            
        }

        /// <summary>
        /// 删除物理文件 (例如：~/Files/DocsFiles/100719/工作日志.xls| 等等)
        /// </summary>
        /// <param name="f"></param>
        static public void DeleteFiles(string f)
        {
            try
            {
                if (!string.IsNullOrEmpty(f))
                {
                    if (f.Contains("|"))
                    {
                        string[] arr = f.Split('|');
                        for (int i = 0; i < arr.Length; i++)
                        {
                            if (arr[i].Contains("~/"))
                                WC.Tool.FileSystemManager.DeleteFile(HttpContext.Current.Server.MapPath(arr[i]));
                        }

                    }
                    if (f.Contains("~/") && !f.Contains("|"))
                    {
                        WC.Tool.FileSystemManager.DeleteFile(HttpContext.Current.Server.MapPath(f));
                    }
                }
            }
            catch { }

        }

        //IM用户数据更新
        static public void UpdateIMUser(Sys_UserInfo ui)
        {
            try
            {

                string sql_find = "select [Key] from WM_Users where Name='" + ui.UserName + "'";
                string r = WC.DBUtility.MsSqlOperate.ExecuteScalar(CommandType.Text, sql_find) + "";
                if (WC.Tool.Utils.IsNumber(r))
                {
                    string sql_edit = "update WM_Users set Nickname='" + ui.RealName + "',Password='" + ui.PassWord + "',EMail='" + ui.Email + "',Phone='" + ui.Phone + "',TelPhone='" + ui.Tel + "' where Name='" + ui.UserName + "';";
                    string sql = string.Format("DELETE FROM WM_UDD WHERE uid={1} ; INSERT INTO WM_UDD(did,uid,tid)VALUES({0},{1},0) ", ui.DepID, r);
                    sql = sql_edit + sql;
                    WC.DBUtility.MsSqlOperate.ExecuteNonQuery(CommandType.Text, sql);
                    Core.AccountImpl.Instance._RefreshUserInfo(Convert.ToInt64(r));
                }
                else
                {
                    Core.AccountImpl.Instance.AddUser(ui.UserName, ui.RealName, ui.PassWord, ui.Email, ui.Phone, ui.Tel);

                    string sql_find1 = "select [Key] from WM_Users where Name='" + ui.UserName + "'";
                    string r1 = WC.DBUtility.MsSqlOperate.ExecuteScalar(CommandType.Text, sql_find1) + "";
                    if (WC.Tool.Utils.IsNumber(r1))
                    {
                        string sql = string.Format("DELETE FROM WM_UDD WHERE uid={1} ; INSERT INTO WM_UDD(did,uid,tid)VALUES({0},{1},0) ", ui.DepID, r1);
                        WC.DBUtility.MsSqlOperate.ExecuteNonQuery(CommandType.Text, sql);
                    }
                }

            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        //删除IM用户
        static public void DeleteIMUser(int uid)
        {
            try
            {
                IList list = Sys_User.Init().GetAll("id=" + uid, null);
                if (list.Count > 0)
                {
                    Sys_UserInfo ui = list[0] as Sys_UserInfo;
                    string sql_find = "select [Key] from WM_Users where Name='" + ui.UserName + "'";
                    string r = WC.DBUtility.MsSqlOperate.ExecuteScalar(CommandType.Text, sql_find) + "";
                    if (WC.Tool.Utils.IsNumber(r))
                    {
                        long id = Convert.ToInt64(r);
                        Core.AccountInfo userInfo = Core.AccountImpl.Instance.GetUserInfo(id);
                        if (userInfo.Name.ToLower() != "manager")
                        {
                            Core.AccountImpl.Instance.DeleteUser(userInfo.Name);
                            string[] friends = userInfo.Friends;
                            foreach (string friend in friends)
                            {
                                if (Core.AccountImpl.Instance.GetUserInfo(friend).Type == 0)
                                {
                                    Core.SessionManagement.Instance.Send(friend, "GLOBAL:REFRESH_FIRENDS", null);
                                }
                            }
                            WC.DBUtility.MsSqlOperate.ExecuteNonQuery(CommandType.Text, "delete from WM_UDD where uid=" + r);
                        }
                    }
                }

            }
            catch (Exception ex)
            {
                throw ex;
            }

        }


        public static void BBS_Check(string u)
        {
            IList list = Sys_User.Init().GetAll("id=" + Convert.ToInt32(u), null);
            if (list.Count > 0)
            {
                Sys_UserInfo su = list[0] as Sys_UserInfo;
                BBS_Update(su.UserName, su.PassWord, su);
                BBS_Login(su.UserName, su.PassWord);
            }
        }

        private static void BBS_Login(string u, string p)
        {
            string UserName = u;
            string UserPass = p.Substring(8, 16).ToLower();

            int CookiesDay = 2;
            HttpCookie cookie = new HttpCookie("DXBBS");
            cookie["UserName"] = Filter.Encode(UserName, ForumConfig.ReadConfigInfo().SecureKey);
            cookie["UserPass"] = Filter.Encode(UserPass, ForumConfig.ReadConfigInfo().SecureKey);
            cookie["Key"] = Filter.Encode(Clients.CookiesKey, ForumConfig.ReadConfigInfo().SecureKey);
            if (CookiesDay != 0)
            {
                cookie.Expires = DateTime.Now.AddDays(CookiesDay);
            }
            cookie["IsHide"] = "false";
            HttpContext.Current.Response.Cookies.Add(cookie);

            //连接数据库读取数据，为Sessions.UserID 和 Sessions.UserName 赋值

            string sqlstrr = "select a.*,b.LevelName from WC_Forum_User a,WC_Forum_Level b where username=@u and a.LevelID=b.id";
            DataSet DSS = MsSqlOperate.ExecuteDataset(CommandType.Text, sqlstrr, new SqlParameter("@u", u));
            int suerid = 0;
            int.TryParse(DSS.Tables[0].Rows[0]["ID"].ToString(), out suerid);
            if (suerid > 0)
            {
                Sessions.UserID = suerid;
                Sessions.UserName = UserName;
                Sessions.LevelID = Convert.ToInt32(DSS.Tables[0].Rows[0]["LevelID"]);
                Sessions.LevelName = DSS.Tables[0].Rows[0]["LevelName"] + "";
            }
            DSS.Dispose();

        }

        private static void BBS_Update(string u, string p, Sys_UserInfo dxbbs_ui)
        {
            Sys_UserInfo ui = dxbbs_ui;
            if (ui != null)
            {
                string pwd = p.Substring(8, 16).ToLower();

                string sql_finduser = "select * from WC_Forum_User where username=@u";
                DataSet ds = MsSqlOperate.ExecuteDataset(CommandType.Text, sql_finduser, new SqlParameter("@u", u));

                string UserPass = pwd;
                int Sex = Math.Abs(ui.Sex - 1);
                string photo = "";
                if (Sex != 1)
                    photo = "userface/girl.jpg";
                else
                    photo = "userface/boy.jpg";
                string NickName = ui.RealName;
                string LoginIP = WC.Tool.RequestUtils.GetIP();

                if (ds.Tables[0].Rows.Count > 0)
                {
                    //更新BBS用户
                    string sql_updateuser = "";
                    if (ui.RoleID != 4)
                        sql_updateuser = "update WC_Forum_User set UserPass='" + UserPass + "'," +
                            "sex=" + Sex + ",NickName='" + NickName + "'," +
                            "LoginIP='" + LoginIP + "'," + "LoginTime=getdate() where username='" + u.Trim() + "';";
                    else
                        sql_updateuser = "update WC_Forum_User set UserPass='" + UserPass + "'," +
                            "sex=" + Sex + ",NickName='" + NickName + "'," +
                            "LoginIP='" + LoginIP + "',LevelID=1," + "LoginTime=getdate() where username='" + u.Trim() + "';";
                    MsSqlOperate.ExecuteNonQuery(CommandType.Text, sql_updateuser);
                }
                else
                {
                    //添加BBS用户
                    string sql_reguser = "";
                    if (ui.RoleID != 4)
                    {
                        sql_reguser = "insert into WC_Forum_User(UserName,UserPass,PasswordType,Question,Answer,Email,Sex,Photo,PhotoWidth,PhotoHeight,NickName,LevelID,RegTime,UploadTime,LoginTime,LevelType,ip)" +
                            " values('" + u + "','" + UserPass + "',1,'123','456','123@123.com'," + Sex + ",'" + photo + "',100,100,'" + NickName + "',7,getdate(),getdate(),getdate(),5,'" + LoginIP + "');";
                    }
                    else
                    {
                        sql_reguser = "insert into WC_Forum_User(UserName,UserPass,PasswordType,Question,Answer,Email,Sex,Photo,PhotoWidth,PhotoHeight,NickName,LevelID,RegTime,UploadTime,LoginTime,LevelType,ip)" +
                            " values('" + u + "','" + UserPass + "',1,'123','456','123@123.com'," + Sex + ",'" + photo + "',100,100,'" + NickName + "',1,getdate(),getdate(),getdate(),1,'" + LoginIP + "');";
                    }
                    MsSqlOperate.ExecuteNonQuery(CommandType.Text, sql_reguser);
                }
                ds.Dispose();
            }

        }


        public static void CommonMobleSend(List<string> list, string common_title, bool islongsms)
        {
            Bas_ComInfo bi = HttpContext.Current.Application["cominfo"] as Bas_ComInfo;
            if (bi.et2 == 1) //短信接口开关
            {
                //读取sms基本配置文件
                Hashtable hs = (Hashtable)HttpContext.Current.Application["sms"];
                string sms_url = hs["sms_url"] + "";
                string sms_user = hs["sms_user"] + "";
                string sms_pwd = hs["sms_pwd"] + "";
                string cont_f = hs["cont_f"] + "";
                string cont_g = hs["cont_g"] + "";
                string cont_n = hs["cont_n"] + "";
                string cont_m = hs["cont_m"] + "";

                string cont_f_e = hs["cont_f_e"] + "";
                string cont_g_e = hs["cont_g_e"] + "";
                string cont_n_e = hs["cont_n_e"] + "";
                string cont_m_e = hs["cont_m_e"] + "";

                string[] arr = list.ToArray();
                int splitSize = 40;
                Object[] orr = SplitAry(arr, splitSize);
                foreach (Object j in orr)
                {
                    string[] aryItem = (string[])j;
                    string phone = string.Join(",", aryItem);

                    string Sms_url = sms_url;
                    string Sms_cont = common_title;

                    string Sms_user = sms_user;
                    string Sms_pwd = sms_pwd;

                    try
                    {
                        string url = Sms_url + "/?Uid=" + Sms_user + "&Key=" + Sms_pwd
                            + "&smsMob=" + phone + "&smsText="
                            + HttpUtility.UrlEncode(Sms_cont, Encoding.GetEncoding("GBK"));


                        string targeturl = url.Trim().ToString();
                        System.Net.WebRequest wReq = System.Net.WebRequest.Create(targeturl);
                        System.Net.WebResponse wResp = wReq.GetResponse();
                        System.IO.Stream respStream = wResp.GetResponseStream();
                        using (System.IO.StreamReader reader = new System.IO.StreamReader(respStream, Encoding.GetEncoding("GBK")))
                        {
                            reader.ReadToEnd();
                        }


                    }
                    catch { }


                }
            }
        }

        public static void FlowMobleSend(string userlist, string flow_title)
        {
            Bas_ComInfo bi = HttpContext.Current.Application["cominfo"] as Bas_ComInfo;
            if (bi.et2 == 1) //短信接口开关
            {
                if (userlist.Contains(","))
                {
                    string[] arr = userlist.Split(',');
                    for (int i = 0; i < arr.Length; i++)
                    {
                        if (arr[i].Contains("#"))
                        {
                            Sys_UserInfo ui = Sys_User.Init().GetById(Convert.ToInt32(arr[i].Split('#')[1]));
                            SMS_Send_Flow(ui, flow_title);
                        }
                    }
                }
            }
        }

        public static void GovMobleSend(string userlist, string flow_title)
        {
            Bas_ComInfo bi = HttpContext.Current.Application["cominfo"] as Bas_ComInfo;
            if (bi.et2 == 1) //短信接口开关
            {
                if (userlist.Contains(","))
                {
                    string[] arr = userlist.Split(',');
                    for (int i = 0; i < arr.Length; i++)
                    {
                        if (arr[i].Contains("#"))
                        {
                            Sys_UserInfo ui = Sys_User.Init().GetById(Convert.ToInt32(arr[i].Split('#')[1]));
                            SMS_Send_Gov(ui, flow_title);
                        }
                    }
                }
            }
        }

        public static void NewsMobleSend(List<string> list, string news_title)
        {
            Bas_ComInfo bi = HttpContext.Current.Application["cominfo"] as Bas_ComInfo;
            if (bi.et2 == 1) //短信接口开关
            {
                //读取sms基本配置文件
                Hashtable hs = (Hashtable)HttpContext.Current.Application["sms"];
                string sms_url = hs["sms_url"] + "";
                string sms_user = hs["sms_user"] + "";
                string sms_pwd = hs["sms_pwd"] + "";
                string cont_f = hs["cont_f"] + "";
                string cont_g = hs["cont_g"] + "";
                string cont_n = hs["cont_n"] + "";
                string cont_m = hs["cont_m"] + "";

                string cont_f_e = hs["cont_f_e"] + "";
                string cont_g_e = hs["cont_g_e"] + "";
                string cont_n_e = hs["cont_n_e"] + "";
                string cont_m_e = hs["cont_m_e"] + "";

                string[] arr = list.ToArray();
                int splitSize = 40;
                Object[] orr = SplitAry(arr, splitSize);
                foreach (Object j in orr)
                {
                    string[] aryItem = (string[])j;
                    string phone = string.Join(",", aryItem);

                    string Sms_url = sms_url;
                    string Sms_cont = cont_n;

                    string Sms_user = sms_user;
                    string Sms_pwd = sms_pwd;
                    Sms_cont = Sms_cont.Replace("t", news_title);

                    if (cont_n_e == "1")
                    {
                        try
                        {
                            string url = Sms_url + "/?Uid=" + Sms_user + "&Key=" + Sms_pwd
                                + "&smsMob=" + phone + "&smsText="
                                + HttpUtility.UrlEncode(Sms_cont, Encoding.GetEncoding("GBK"));

                            string targeturl = url.Trim().ToString();
                            System.Net.WebRequest wReq = System.Net.WebRequest.Create(targeturl);
                            System.Net.WebResponse wResp = wReq.GetResponse();
                            System.IO.Stream respStream = wResp.GetResponseStream();
                            using (System.IO.StreamReader reader = new System.IO.StreamReader(respStream, Encoding.GetEncoding("GBK")))
                            {
                                reader.ReadToEnd();
                            }


                        }
                        catch { }
                    }
                }
            }
        }

        public static void MailMobleSend(List<string> uidlist, string mail_title)
        {
            Bas_ComInfo bi = HttpContext.Current.Application["cominfo"] as Bas_ComInfo;
            if (bi.et2 == 1) //短信接口开关
            {
                //读取sms基本配置文件
                Hashtable hs = (Hashtable)HttpContext.Current.Application["sms"];
                string sms_url = hs["sms_url"] + "";
                string sms_user = hs["sms_user"] + "";
                string sms_pwd = hs["sms_pwd"] + "";
                string cont_f = hs["cont_f"] + "";
                string cont_g = hs["cont_g"] + "";
                string cont_n = hs["cont_n"] + "";
                string cont_m = hs["cont_m"] + "";

                string cont_f_e = hs["cont_f_e"] + "";
                string cont_g_e = hs["cont_g_e"] + "";
                string cont_n_e = hs["cont_n_e"] + "";
                string cont_m_e = hs["cont_m_e"] + "";

                List<string> list = new List<string>();
                foreach (string uid in uidlist)
                {
                    Sys_UserInfo ui = Sys_User.Init().GetById(Convert.ToInt32(uid));
                    if (ValidateMobile(ui.Phone))
                    {
                        list.Add(ui.Phone);
                    }
                }

                string[] arr = list.ToArray();
                int splitSize = 40;
                Object[] orr = SplitAry(arr, splitSize);
                foreach (Object j in orr)
                {
                    string[] aryItem = (string[])j;
                    string phone = string.Join(",", aryItem);

                    string Sms_url = sms_url;
                    string Sms_cont = cont_m;

                    string Sms_user = sms_user;
                    string Sms_pwd = sms_pwd;
                    Sms_cont = Sms_cont.Replace("t", mail_title);

                    if (cont_m_e == "1")
                    {
                        try
                        {
                            string url = Sms_url + "/?Uid=" + Sms_user + "&Key=" + Sms_pwd
                                + "&smsMob=" + phone + "&smsText="
                                + HttpUtility.UrlEncode(Sms_cont, Encoding.GetEncoding("GBK"));

                            string targeturl = url.Trim().ToString();
                            System.Net.WebRequest wReq = System.Net.WebRequest.Create(targeturl);
                            System.Net.WebResponse wResp = wReq.GetResponse();
                            System.IO.Stream respStream = wResp.GetResponseStream();
                            using (System.IO.StreamReader reader = new System.IO.StreamReader(respStream, Encoding.GetEncoding("GBK")))
                            {
                                reader.ReadToEnd();
                            }
                        }
                        catch { }
                    }
                }
            }
        }

        private static void SMS_Send_Flow(Sys_UserInfo ui, string flow_title)
        {
            //读取sms基本配置文件
            Hashtable hs = (Hashtable)HttpContext.Current.Application["sms"];
            string sms_url = hs["sms_url"] + "";
            string sms_user = hs["sms_user"] + "";
            string sms_pwd = hs["sms_pwd"] + "";
            string cont_f = hs["cont_f"] + "";
            string cont_g = hs["cont_g"] + "";
            string cont_n = hs["cont_n"] + "";
            string cont_m = hs["cont_m"] + "";

            string cont_f_e = hs["cont_f_e"] + "";
            string cont_g_e = hs["cont_g_e"] + "";
            string cont_n_e = hs["cont_n_e"] + "";
            string cont_m_e = hs["cont_m_e"] + "";

            if (ValidateMobile(ui.Phone))
            {
                string Sms_url = sms_url;
                string Sms_cont = cont_f;

                string Sms_user = sms_user;
                string Sms_pwd = sms_pwd;
                Sms_cont = Sms_cont.Replace("x", ui.RealName).Replace("t", flow_title).Replace("p", ui.PositionName);

                if (cont_f_e == "1")
                {
                    try
                    {
                        string url = Sms_url + "/?Uid=" + Sms_user + "&Key=" + Sms_pwd
                            + "&smsMob=" + ui.Phone + "&smsText="
                            + HttpUtility.UrlEncode(Sms_cont, Encoding.GetEncoding("GBK"));

                        string targeturl = url.Trim().ToString();
                        System.Net.WebRequest wReq = System.Net.WebRequest.Create(targeturl);
                        System.Net.WebResponse wResp = wReq.GetResponse();
                        System.IO.Stream respStream = wResp.GetResponseStream();
                        using (System.IO.StreamReader reader = new System.IO.StreamReader(respStream, Encoding.GetEncoding("GBK")))
                        {
                            reader.ReadToEnd();
                        }
                    }
                    catch { }
                }
            }

        }

        private static void SMS_Send_Gov(Sys_UserInfo ui, string flow_title)
        {
            //读取sms基本配置文件
            Hashtable hs = (Hashtable)HttpContext.Current.Application["sms"];
            string sms_url = hs["sms_url"] + "";
            string sms_user = hs["sms_user"] + "";
            string sms_pwd = hs["sms_pwd"] + "";
            string cont_f = hs["cont_f"] + "";
            string cont_g = hs["cont_g"] + "";
            string cont_n = hs["cont_n"] + "";
            string cont_m = hs["cont_m"] + "";

            string cont_f_e = hs["cont_f_e"] + "";
            string cont_g_e = hs["cont_g_e"] + "";
            string cont_n_e = hs["cont_n_e"] + "";
            string cont_m_e = hs["cont_m_e"] + "";

            if (ValidateMobile(ui.Phone))
            {
                string Sms_url = sms_url;
                string Sms_cont = cont_g;

                string Sms_user = sms_user;
                string Sms_pwd = sms_pwd;
                Sms_cont = Sms_cont.Replace("x", ui.RealName).Replace("t", flow_title).Replace("p", ui.PositionName);

                if (cont_g_e == "1")
                {
                    try
                    {
                        string url = Sms_url + "/?Uid=" + Sms_user + "&Key=" + Sms_pwd
                            + "&smsMob=" + ui.Phone + "&smsText="
                            + HttpUtility.UrlEncode(Sms_cont, Encoding.GetEncoding("GBK"));

                        string targeturl = url.Trim().ToString();
                        System.Net.WebRequest wReq = System.Net.WebRequest.Create(targeturl);
                        System.Net.WebResponse wResp = wReq.GetResponse();
                        System.IO.Stream respStream = wResp.GetResponseStream();
                        using (System.IO.StreamReader reader = new System.IO.StreamReader(respStream, Encoding.GetEncoding("GBK")))
                        {
                            reader.ReadToEnd();
                        }
                    }
                    catch { }
                }
            }

        }


        public static bool ValidateMobile(string mobile)
        {
            if (string.IsNullOrEmpty(mobile))
                return false;

            return Regex.IsMatch(mobile, @"^(11|12|13|14|15|16|17|18|19)\d{9}$");
        }

        private static Object[] SplitAry(string[] ary, int subSize)
        {
            int count = ary.Length % subSize == 0 ? ary.Length / subSize : ary.Length / subSize + 1;

            List<List<string>> subAryList = new List<List<string>>();

            for (int i = 0; i < count; i++)
            {
                int index = i * subSize;

                List<string> list = new List<string>();
                int j = 0;
                while (j < subSize && index < ary.Length)
                {
                    list.Add(ary[index++]);
                    j++;
                }

                subAryList.Add(list);
            }

            Object[] subAry = new Object[subAryList.Count];

            for (int i = 0; i < subAryList.Count; i++)
            {
                List<string> subList = subAryList[i];

                string[] subAryItem = new string[subList.Count];
                for (int j = 0; j < subList.Count; j++)
                {
                    subAryItem[j] = subList[j];
                }

                subAry[i] = subAryItem;
            }

            return subAry;
        }  

    }
}
