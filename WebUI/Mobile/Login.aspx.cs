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
using WC.BLL;
using WC.Model;
using WC.Tool;
using WC.DBUtility;
using System.Data.SqlClient;

namespace WC.WebUI.Mobile
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Login_Btn(object sender, EventArgs e)
        {
            string u = Request.Form["UserName"].ToLower();
            string p = Request.Form["PassWord"].ToLower();
            if (u.Trim() != "" && p.Trim() != "")
            {
                string ss = CheckPass(u.ToLower(), p);
                if (ss == "0,0")
                {
                    Response.Redirect("Index.aspx");
                }
                if (ss == "n")
                {
                    Response.Write("<script>alert('用户名/密码错误!');window.location='Login.aspx'</script>");
                }
                if (ss.Contains("1"))
                {
                    if (ss.Split(',')[0] == "1")
                    {
                        Response.Write("<script>alert('该员工 已离职，无法登录!');window.location='Login.aspx'</script>");
                    }
                    if (ss.Split(',')[1] == "1")
                    {
                        Response.Write("<script>alert('该员工 已锁定，无法登录!');window.location='Login.aspx'</script>");
                    }
                }

            }

        }

        private string CheckPass(string u, string p)
        {
            //根据基本配置文件 获取用户cookie有效期限
            Hashtable page_ht = (Hashtable)HttpContext.Current.Application["stand_config"];
            //用户cookie有效期限
            double user_cookie_delay = Convert.ToDouble(page_ht["user_cookie_delay"]);

            IList list = new List<Sys_UserInfo>();

            string sql_login = "select * from sys_user where UserName=@U and PassWord=@P";
            List<SqlParameter> pt_list = new List<SqlParameter>();
            pt_list.Add(new SqlParameter("@U", u + ""));
            pt_list.Add(new SqlParameter("@P", WC.Tool.Encrypt.MD5_32(p.Trim().ToLower()) + ""));
            using (DataSet u_ds = MsSqlOperate.ExecuteDataset(CommandType.Text, sql_login, pt_list.ToArray()))
            {
                if (u_ds.Tables[0].Rows.Count > 0)
                {
                    list = (IList)WC.Tool.Utils.GetList<Sys_UserInfo>(u_ds);
                }
            }

            if (list.Count == 0)
                return "n";
            else
            {
                Sys_UserInfo su = list[0] as Sys_UserInfo;
                //dxbbs_ui = su;
                su.IsOnline = 1;
                su.CurrentLoginTime = DateTime.Now.ToString("yyMddhhmmssfff");

                string Modules = GetModuleList(su.DepID, su.RoleID); //用户权限集合
                string strcookie = su.id + "|" + su.UserName + "|" + su.RealName + "|"
                    + su.DepID + "|" + su.DepName + "|" + Modules + "|" + su.CurrentLoginTime + "|" + Request.Form["px"]+"|"+su.PositionName;
                string user_info = Encrypt.RC4_Encode(strcookie, "lazy_oa");

                HttpContext.Current.Session["UserCookies"] = strcookie;
                HttpContext.Current.Session.Timeout = Convert.ToInt32(user_cookie_delay) * 10;

                HttpCookie cookie = new HttpCookie("UserCookies");
                if (!string.IsNullOrEmpty(Request.Form["chkRemember"]))
                    cookie.Expires = DateTime.Now.AddHours(user_cookie_delay);
                cookie["key"] = user_info;
                Response.Cookies.Add(cookie);


                su.LastLoginTime = DateTime.Now;
                su.LastLoginIp = WC.Tool.RequestUtils.GetIP();
                su.LoginQuantity = su.LoginQuantity + 1;

                Sys_User.Init().Update(su);

                //用户登录后 维护在线用户列表
                IList<Sys_UserInfo> online_ht = Application["user_online"] as IList<Sys_UserInfo>;
                bool b = false;
                foreach (object obj in online_ht)
                {
                    Sys_UserInfo sm = obj as Sys_UserInfo;
                    if (sm.id == su.id)
                    {
                        b = true;
                        sm.IsOnline = 1;
                        sm.CurrentLoginTime = su.CurrentLoginTime;
                        sm.LastLoginTime = su.LastLoginTime;
                    }
                }
                if (!b)
                {
                    online_ht.Add(su);
                }

                Sys_UserLoginInfo uli = new Sys_UserLoginInfo();
                uli.UserName = su.UserName;
                uli.UserInfo = su.RealName + "(" + su.DepName + ")";
                uli.LoginIP = WC.Tool.RequestUtils.GetIP();
                uli.LoginTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
                Sys_UserLogin.Init().Add(uli);

                return su.Status + "," + su.IsLock;
            }
        }

        private string GetModuleList(int did, int rid)
        {
            IList Dep_Module = Sys_Dep_Module.Init().GetAll("DepID=" + did, null);
            IList Role_Module = Sys_Role_Module.Init().GetAll("RoleID=" + rid, null);
            List<string> list = new List<string>();
            foreach (object obj in Dep_Module)
            {
                Sys_Dep_ModuleInfo sd = obj as Sys_Dep_ModuleInfo;
                if (!list.Contains(sd.ModuleID + ""))
                    list.Add(sd.ModuleID + "");
            }
            foreach (object obj in Role_Module)
            {
                Sys_Role_ModuleInfo sd = obj as Sys_Role_ModuleInfo;
                if (!list.Contains(sd.ModuleID + ""))
                    list.Add(sd.ModuleID + "");
            }
            if (list.Count != 0)
                return string.Join(",", list.ToArray());
            else return "";
        }


    }
}