using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Text;
using WC.BLL;
using WC.Model;
using WC.DBUtility;

namespace WC.WebUI.Manage
{
    public partial class default1 : WC.BLL.ViewPages
    {
        protected string logo = "";
        protected string comname = "";
        protected string weburl = "";
        protected string power_menu = "";

        protected string mail_sjx = "";
        protected string mail_cgx = "";
        protected string mail_fjx = "";
        protected string mail_ljx = "";
        protected string news_type = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            power_menu = GetUserPowerMenu(Modules);

            if (!string.IsNullOrEmpty(Uid))
            {
                uid.Value = Uid;

                Bas_ComInfo bi = HttpContext.Current.Application["cominfo"] as Bas_ComInfo;
                comname = bi.ComName;
                weburl = bi.WebUrl;
                logo = bi.Logo;

                //是否开启消息提示
                if (bi.MsgState != 1)
                {
                    message_div.Visible = false;
                }
                else
                {
                    try
                    {
                        Sys_UserInfo ui = Sys_User.Init().GetById(Convert.ToInt32(Uid));

                        int t = ui.MsgTime;
                        if (t == -1)
                            message_div.Visible = false;
                        if (t > -1)
                        {
                            t = t * 60 * 1000;
                            notice_time.Value = t + "";
                            stay_time.Value = "30000";
                        }

                    }
                    catch { }
                }

                //是否开启论坛
                if (bi.BBSState == 1)
                {
                    dxbbs_div.Visible = true;
                    sys_div3.Visible = true;
                    sys_div4.Visible = true;
                }
                else
                {
                    dxbbs_div.Visible = false;
                    sys_div3.Visible = false;
                    sys_div4.Visible = false;
                }

                //显示邮件数量
                SqlParameter rid = new SqlParameter();
                rid.ParameterName = "@uid";
                rid.Size = 7;
                rid.Value = Convert.ToInt32(Uid);

                SqlParameter sqlpt0 = new SqlParameter();
                sqlpt0.Direction = ParameterDirection.Output;
                sqlpt0.ParameterName = "@pt0";
                sqlpt0.Size = 7;

                SqlParameter sqlpt1 = new SqlParameter();
                sqlpt1.Direction = ParameterDirection.Output;
                sqlpt1.ParameterName = "@pt1";
                sqlpt1.Size = 7;

                SqlParameter sqlpt2 = new SqlParameter();
                sqlpt2.Direction = ParameterDirection.Output;
                sqlpt2.ParameterName = "@pt2";
                sqlpt2.Size = 7;

                SqlParameter sqlpt3 = new SqlParameter();
                sqlpt3.Direction = ParameterDirection.Output;
                sqlpt3.ParameterName = "@pt3";
                sqlpt3.Size = 7;

                SqlParameter sqlpt4 = new SqlParameter();
                sqlpt4.Direction = ParameterDirection.Output;
                sqlpt4.ParameterName = "@pt4";
                sqlpt4.Size = 7;

                SqlParameter[] sqls = { sqlpt0, sqlpt1, sqlpt2, sqlpt3, sqlpt4, rid };
                MsSqlOperate.ExecuteNonQuery(CommandType.StoredProcedure, "Mails_GetAllMailBoxCount", sqls);

                mail_sjx = sqlpt0.Value + "/" + sqlpt4.Value;
                mail_cgx = sqlpt1.Value + "";
                mail_fjx = sqlpt2.Value + "";
                mail_ljx = sqlpt3.Value + "";

                //显示资讯分类
                IList list = News_Type.Init().GetAll(null, " order by orders asc");
                for (int i = 0; i < list.Count; i++)
                {
                    News_TypeInfo nt = list[i] as News_TypeInfo;
                    news_type += ",\n";
                    news_type += "{\n";
                    news_type += "'menuid': '" + (220 + i) + "',\n";
                    news_type += "'menuname': '" + nt.TypeName + "',\n";
                    news_type += "'icon': 'icon-jingpin',\n";
                    news_type += "'url': '/Manage/News/News_List.aspx?tid=" + nt.id + "'\n";
                    news_type += "}\n";
                }

            }

        }

        private string GetUserPowerMenu(string m)
        {
            StringBuilder p = new StringBuilder();
            if (string.IsNullOrEmpty(m))
                return "";
            else
            {
                p.Append(",\n");
                p.Append("{\n");
                p.Append("'menuid': '1000',\n");
                p.Append("'icon': 'icon-usergrade',\n");
                p.Append("'menuname': '系统管理',\n");
                p.Append("'menus': [\n\n");

                if (GetValidPower(m, "14|43") != "")
                {
                    p.Append("{\n");
                    p.Append("'menuid': '10001',\n");
                    p.Append("'menuname': '系统设置',\n");
                    p.Append("'icon': 'icon-settings',\n");
                    p.Append("'child': [\n");

                    string t = GetValidPower(m, "14|43");
                    if (t.Contains(":"))
                    {
                        string[] a = t.Split(':');
                        for (int i = 0; i < a.Length; i++)
                        {
                            string w = a[i];
                            if (i != a.Length - 1)
                            {
                                if (w == "14")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100011',\n");
                                    p.Append("'menuname': '基本信息',\n");
                                    p.Append("'icon': 'icon-log',\n");
                                    p.Append("'url': '/Manage/sys/Com_Basic.aspx'\n");
                                    p.Append("},\n");
                                }
                                if (w == "43")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100012',\n");
                                    p.Append("'menuname': '数据库备份',\n");
                                    p.Append("'icon': 'icon-db',\n");
                                    p.Append("'url': '/Manage/sys/DbBackup.aspx'\n");
                                    p.Append("},\n");
                                }

                            }
                            else
                            {
                                if (w == "14")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100011',\n");
                                    p.Append("'menuname': '基本信息',\n");
                                    p.Append("'icon': 'icon-log',\n");
                                    p.Append("'url': '/Manage/sys/Com_Basic.aspx'\n");
                                    p.Append("}\n");
                                }
                                if (w == "43")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100012',\n");
                                    p.Append("'menuname': '数据库备份',\n");
                                    p.Append("'icon': 'icon-db',\n");
                                    p.Append("'url': '/Manage/sys/DbBackup.aspx'\n");
                                    p.Append("}\n");
                                }

                            }
                        }

                    }
                    else
                    {
                        if (t == "14")
                        {
                            p.Append("{\n");
                            p.Append("'menuid': '100011',\n");
                            p.Append("'menuname': '基本信息',\n");
                            p.Append("'icon': 'icon-log',\n");
                            p.Append("'url': '/Manage/sys/Com_Basic.aspx'\n");
                            p.Append("}\n");
                        }
                        if (t == "43")
                        {
                            p.Append("{\n");
                            p.Append("'menuid': '100012',\n");
                            p.Append("'menuname': '数据库备份',\n");
                            p.Append("'icon': 'icon-db',\n");
                            p.Append("'url': '/Manage/sys/DbBackup.aspx'\n");
                            p.Append("}\n");
                        }
                    }
                    p.Append("]\n");
                    p.Append("},\n\n");
                }

                if (GetValidPower(m, "22|21") != "")
                {
                    p.Append("{\n");
                    p.Append("'menuid': '10002',\n");
                    p.Append("'menuname': '组织机构管理',\n");
                    p.Append("'icon': 'icon-exam',\n");
                    p.Append("'child': [\n");

                    string t = GetValidPower(m, "22|21");
                    if (t.Contains(":"))
                    {
                        string[] a = t.Split(':');
                        for (int i = 0; i < a.Length; i++)
                        {
                            string w = a[i];
                            if (i != a.Length - 1)
                            {
                                if (w == "22")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100021',\n");
                                    p.Append("'menuname': '组织机构列表',\n");
                                    p.Append("'icon': 'icon-template',\n");
                                    p.Append("'url': '/Manage/sys/Dep_List.aspx'\n");
                                    p.Append("},\n");
                                }
                                if (w == "21")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100022',\n");
                                    p.Append("'menuname': '新增组织机构',\n");
                                    p.Append("'icon': 'icon-addnew',\n");
                                    p.Append("'url': '/Manage/sys/Dep_Manage.aspx'\n");
                                    p.Append("},\n");
                                }

                            }
                            else
                            {
                                if (w == "22")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100021',\n");
                                    p.Append("'menuname': '组织机构列表',\n");
                                    p.Append("'icon': 'icon-template',\n");
                                    p.Append("'url': '/Manage/sys/Dep_List.aspx'\n");
                                    p.Append("}\n");
                                }
                                if (w == "21")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100022',\n");
                                    p.Append("'menuname': '新增组织机构',\n");
                                    p.Append("'icon': 'icon-addnew',\n");
                                    p.Append("'url': '/Manage/sys/Dep_Manage.aspx'\n");
                                    p.Append("}\n");
                                }

                            }
                        }
                    }
                    else
                    {
                        if (t == "22")
                        {
                            p.Append("{\n");
                            p.Append("'menuid': '100021',\n");
                            p.Append("'menuname': '组织机构列表',\n");
                            p.Append("'icon': 'icon-template',\n");
                            p.Append("'url': '/Manage/sys/Dep_List.aspx'\n");
                            p.Append("}\n");
                        }
                        if (t == "21")
                        {
                            p.Append("{\n");
                            p.Append("'menuid': '100022',\n");
                            p.Append("'menuname': '新增组织机构',\n");
                            p.Append("'icon': 'icon-addnew',\n");
                            p.Append("'url': '/Manage/sys/Dep_Manage.aspx'\n");
                            p.Append("}\n");
                        }
                    }
                    p.Append("]\n");
                    p.Append("},\n\n");
                }

                if (GetValidPower(m, "20|19|18|17|46|47") != "")
                {
                    p.Append("{\n");
                    p.Append("'menuid': '10003',\n");
                    p.Append("'menuname': '人事管理',\n");
                    p.Append("'icon': 'icon-user',\n");
                    p.Append("'child': [\n");

                    string t = GetValidPower(m, "20|19|18|17|46|47");
                    if (t.Contains(":"))
                    {
                        string[] a = t.Split(':');
                        for (int i = 0; i < a.Length; i++)
                        {
                            string w = a[i];
                            if (i != a.Length - 1)
                            {
                                if (w == "20")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100031',\n");
                                    p.Append("'menuname': '用户列表',\n");
                                    p.Append("'icon': 'icon-usergroup',\n");
                                    p.Append("'url': '/Manage/sys/User_List.aspx'\n");
                                    p.Append("},\n");
                                }
                                if (w == "19")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100032',\n");
                                    p.Append("'menuname': '新增用户',\n");
                                    p.Append("'icon': 'icon-addnew',\n");
                                    p.Append("'url': '/Manage/sys/User_Manage.aspx'\n");
                                    p.Append("},\n");
                                }
                                if (w == "18")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100033',\n");
                                    p.Append("'menuname': '角色列表',\n");
                                    p.Append("'icon': 'icon-userclass',\n");
                                    p.Append("'url': '/Manage/sys/Role_List.aspx'\n");
                                    p.Append("},\n");
                                }
                                if (w == "17")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100034',\n");
                                    p.Append("'menuname': '新增角色',\n");
                                    p.Append("'icon': 'icon-addnew',\n");
                                    p.Append("'url': '/Manage/sys/Role_Manage.aspx'\n");
                                    p.Append("},\n");
                                }
                                if (w == "46")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100035',\n");
                                    p.Append("'menuname': '设置考勤时间',\n");
                                    p.Append("'icon': 'icon-calendar1',\n");
                                    p.Append("'url': '/Manage/Attend/WorkSet.aspx?type=edit'\n");
                                    p.Append("},\n");
                                }
                                if (w == "47")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100036',\n");
                                    p.Append("'menuname': '考勤统计',\n");
                                    p.Append("'icon': 'icon-template',\n");
                                    p.Append("'url': '/Manage/Attend/WorkList.aspx?type=1'\n");
                                    p.Append("},\n");
                                }

                            }
                            else
                            {
                                if (w == "20")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100031',\n");
                                    p.Append("'menuname': '用户列表',\n");
                                    p.Append("'icon': 'icon-usergroup',\n");
                                    p.Append("'url': '/Manage/sys/User_List.aspx'\n");
                                    p.Append("}\n");
                                }
                                if (w == "19")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100032',\n");
                                    p.Append("'menuname': '新增用户',\n");
                                    p.Append("'icon': 'icon-addnew',\n");
                                    p.Append("'url': '/Manage/sys/User_Manage.aspx'\n");
                                    p.Append("}\n");
                                }
                                if (w == "18")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100033',\n");
                                    p.Append("'menuname': '角色列表',\n");
                                    p.Append("'icon': 'icon-userclass',\n");
                                    p.Append("'url': '/Manage/sys/Role_List.aspx'\n");
                                    p.Append("}\n");
                                }
                                if (w == "17")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100034',\n");
                                    p.Append("'menuname': '新增角色',\n");
                                    p.Append("'icon': 'icon-addnew',\n");
                                    p.Append("'url': '/Manage/sys/Role_Manage.aspx'\n");
                                    p.Append("}\n");
                                }
                                if (w == "46")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100035',\n");
                                    p.Append("'menuname': '设置考勤时间',\n");
                                    p.Append("'icon': 'icon-calendar1',\n");
                                    p.Append("'url': '/Manage/Attend/WorkSet.aspx?type=edit'\n");
                                    p.Append("}\n");
                                }
                                if (w == "47")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100036',\n");
                                    p.Append("'menuname': '考勤统计',\n");
                                    p.Append("'icon': 'icon-template',\n");
                                    p.Append("'url': '/Manage/Attend/WorkList.aspx?type=1'\n");
                                    p.Append("}\n");
                                }
                            }
                        }
                    }
                    else
                    {
                        if (t == "20")
                        {
                            p.Append("{\n");
                            p.Append("'menuid': '100031',\n");
                            p.Append("'menuname': '用户列表',\n");
                            p.Append("'icon': 'icon-usergroup',\n");
                            p.Append("'url': '/Manage/sys/User_List.aspx'\n");
                            p.Append("}\n");
                        }
                        if (t == "19")
                        {
                            p.Append("{\n");
                            p.Append("'menuid': '100032',\n");
                            p.Append("'menuname': '新增用户',\n");
                            p.Append("'icon': 'icon-addnew',\n");
                            p.Append("'url': '/Manage/sys/User_Manage.aspx'\n");
                            p.Append("}\n");
                        }
                        if (t == "18")
                        {
                            p.Append("{\n");
                            p.Append("'menuid': '100033',\n");
                            p.Append("'menuname': '角色列表',\n");
                            p.Append("'icon': 'icon-userclass',\n");
                            p.Append("'url': '/Manage/sys/Role_List.aspx'\n");
                            p.Append("}\n");
                        }
                        if (t == "17")
                        {
                            p.Append("{\n");
                            p.Append("'menuid': '100034',\n");
                            p.Append("'menuname': '新增角色',\n");
                            p.Append("'icon': 'icon-addnew',\n");
                            p.Append("'url': '/Manage/sys/Role_Manage.aspx'\n");
                            p.Append("}\n");
                        }
                        if (t == "46")
                        {
                            p.Append("{\n");
                            p.Append("'menuid': '100035',\n");
                            p.Append("'menuname': '设置考勤时间',\n");
                            p.Append("'icon': 'icon-calendar1',\n");
                            p.Append("'url': '/Manage/Attend/WorkSet.aspx?type=edit'\n");
                            p.Append("}\n");
                        }
                        if (t == "47")
                        {
                            p.Append("{\n");
                            p.Append("'menuid': '100036',\n");
                            p.Append("'menuname': '考勤统计',\n");
                            p.Append("'icon': 'icon-template',\n");
                            p.Append("'url': '/Manage/Attend/WorkList.aspx?type=1'\n");
                            p.Append("}\n");
                        }
                    }
                    p.Append("]\n");
                    p.Append("},\n\n");
                }

                if (GetValidPower(m, "29|30|31|32|42|41") != "")
                {
                    p.Append("{\n");
                    p.Append("'menuid': '10005',\n");
                    p.Append("'menuname': '资讯管理',\n");
                    p.Append("'icon': 'icon-paste',\n");
                    p.Append("'child': [\n");

                    string t = GetValidPower(m, "29|30|31|32|42|41");
                    if (t.Contains(":"))
                    {
                        string[] a = t.Split(':');
                        for (int i = 0; i < a.Length; i++)
                        {
                            string w = a[i];
                            if (i != a.Length - 1)
                            {
                                if (w == "29")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100051',\n");
                                    p.Append("'menuname': '所有资讯列表',\n");
                                    p.Append("'icon': 'icon-guestbook',\n");
                                    p.Append("'url': '/manage/news/News_AllList.aspx'\n");
                                    p.Append("},\n");
                                }
                                if (w == "30")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100052',\n");
                                    p.Append("'menuname': '发布资讯',\n");
                                    p.Append("'icon': 'icon-addnew',\n");
                                    p.Append("'url': '/manage/news/News_Manage.aspx'\n");
                                    p.Append("},\n");
                                }
                                if (w == "31")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100053',\n");
                                    p.Append("'menuname': '资讯分类列表',\n");
                                    p.Append("'icon': 'icon-jingpin',\n");
                                    p.Append("'url': '/manage/news/NewsType_List.aspx'\n");
                                    p.Append("},\n");
                                }
                                if (w == "32")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100054',\n");
                                    p.Append("'menuname': '添加资讯分类',\n");
                                    p.Append("'icon': 'icon-addnew',\n");
                                    p.Append("'url': '/manage/news/NewsType_Manage.aspx'\n");
                                    p.Append("},\n");
                                }
                                if (w == "42")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100055',\n");
                                    p.Append("'menuname': '滚动公告列表',\n");
                                    p.Append("'icon': 'icon-other',\n");
                                    p.Append("'url': '/manage/news/Tips_List.aspx'\n");
                                    p.Append("},\n");
                                }
                                if (w == "41")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100056',\n");
                                    p.Append("'menuname': '添加滚动公告',\n");
                                    p.Append("'icon': 'icon-addnew',\n");
                                    p.Append("'url': '/manage/news/Tips_Manage.aspx'\n");
                                    p.Append("},\n");
                                }

                            }
                            else
                            {
                                if (w == "29")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100051',\n");
                                    p.Append("'menuname': '所有资讯列表',\n");
                                    p.Append("'icon': 'icon-guestbook',\n");
                                    p.Append("'url': '/manage/news/News_AllList.aspx'\n");
                                    p.Append("}\n");
                                }
                                if (w == "30")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100052',\n");
                                    p.Append("'menuname': '发布资讯',\n");
                                    p.Append("'icon': 'icon-addnew',\n");
                                    p.Append("'url': '/manage/news/News_Manage.aspx'\n");
                                    p.Append("}\n");
                                }
                                if (w == "31")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100053',\n");
                                    p.Append("'menuname': '资讯分类列表',\n");
                                    p.Append("'icon': 'icon-jingpin',\n");
                                    p.Append("'url': '/manage/news/NewsType_List.aspx'\n");
                                    p.Append("}\n");
                                }
                                if (w == "32")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100054',\n");
                                    p.Append("'menuname': '添加资讯分类',\n");
                                    p.Append("'icon': 'icon-addnew',\n");
                                    p.Append("'url': '/manage/news/NewsType_Manage.aspx'\n");
                                    p.Append("}\n");
                                }
                                if (w == "42")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100055',\n");
                                    p.Append("'menuname': '滚动公告列表',\n");
                                    p.Append("'icon': 'icon-other',\n");
                                    p.Append("'url': '/manage/news/Tips_List.aspx'\n");
                                    p.Append("}\n");
                                }
                                if (w == "41")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100056',\n");
                                    p.Append("'menuname': '添加滚动公告',\n");
                                    p.Append("'icon': 'icon-addnew',\n");
                                    p.Append("'url': '/manage/news/Tips_Manage.aspx'\n");
                                    p.Append("}\n");
                                }

                            }
                        }
                    }
                    else
                    {
                        if (t == "29")
                        {
                            p.Append("{\n");
                            p.Append("'menuid': '100051',\n");
                            p.Append("'menuname': '所有资讯列表',\n");
                            p.Append("'icon': 'icon-guestbook',\n");
                            p.Append("'url': '/manage/news/News_AllList.aspx'\n");
                            p.Append("}\n");
                        }
                        if (t == "30")
                        {
                            p.Append("{\n");
                            p.Append("'menuid': '100052',\n");
                            p.Append("'menuname': '发布资讯',\n");
                            p.Append("'icon': 'icon-addnew',\n");
                            p.Append("'url': '/manage/news/News_Manage.aspx'\n");
                            p.Append("}\n");
                        }
                        if (t == "31")
                        {
                            p.Append("{\n");
                            p.Append("'menuid': '100053',\n");
                            p.Append("'menuname': '资讯分类列表',\n");
                            p.Append("'icon': 'icon-jingpin',\n");
                            p.Append("'url': '/manage/news/NewsType_List.aspx'\n");
                            p.Append("}\n");
                        }
                        if (t == "32")
                        {
                            p.Append("{\n");
                            p.Append("'menuid': '100054',\n");
                            p.Append("'menuname': '添加资讯分类',\n");
                            p.Append("'icon': 'icon-addnew',\n");
                            p.Append("'url': '/manage/news/NewsType_Manage.aspx'\n");
                            p.Append("}\n");
                        }
                        if (t == "42")
                        {
                            p.Append("{\n");
                            p.Append("'menuid': '100055',\n");
                            p.Append("'menuname': '滚动公告列表',\n");
                            p.Append("'icon': 'icon-other',\n");
                            p.Append("'url': '/manage/news/Tips_List.aspx'\n");
                            p.Append("}\n");
                        }
                        if (t == "41")
                        {
                            p.Append("{\n");
                            p.Append("'menuid': '100056',\n");
                            p.Append("'menuname': '添加滚动公告',\n");
                            p.Append("'icon': 'icon-addnew',\n");
                            p.Append("'url': '/manage/news/Tips_Manage.aspx'\n");
                            p.Append("}\n");
                        }
                    }
                    p.Append("]\n");
                    p.Append("},\n\n");
                }

                if (GetValidPower(m, "49|50|51") != "")
                {
                    p.Append("{\n");
                    p.Append("'menuid': '300001',\n");
                    p.Append("'menuname': '工作任务管理',\n");
                    p.Append("'icon': 'icon-task',\n");
                    p.Append("'child': [\n");

                    string t = GetValidPower(m, "49|50|51");
                    if (t.Contains(":"))
                    {
                        string[] a = t.Split(':');
                        for (int i = 0; i < a.Length; i++)
                        {
                            string w = a[i];
                            if (i != a.Length - 1)
                            {
                                if (w == "49")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '300002',\n");
                                    p.Append("'menuname': '任务分类列表',\n");
                                    p.Append("'icon': 'icon-theme',\n");
                                    p.Append("'url': '/Manage/Tasks/TaskType_List.aspx'\n");
                                    p.Append("},\n");
                                }
                                if (w == "50")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '300003',\n");
                                    p.Append("'menuname': '新增任务分类',\n");
                                    p.Append("'icon': 'icon-addnew',\n");
                                    p.Append("'url': '/Manage/Tasks/TaskType_Manage.aspx'\n");
                                    p.Append("},\n");
                                }
                                if (w == "51")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '300006',\n");
                                    p.Append("'menuname': '所有任务列表',\n");
                                    p.Append("'icon': 'icon-folder',\n");
                                    p.Append("'url': '/Manage/Tasks/Task_AllList.aspx'\n");
                                    p.Append("},\n");
                                }

                            }
                            else
                            {
                                if (w == "49")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '300002',\n");
                                    p.Append("'menuname': '任务分类列表',\n");
                                    p.Append("'icon': 'icon-theme',\n");
                                    p.Append("'url': '/Manage/Tasks/TaskType_List.aspx'\n");
                                    p.Append("}\n");
                                }
                                if (w == "50")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '300003',\n");
                                    p.Append("'menuname': '新增任务分类',\n");
                                    p.Append("'icon': 'icon-addnew',\n");
                                    p.Append("'url': '/Manage/Tasks/TaskType_Manage.aspx'\n");
                                    p.Append("}\n");
                                }
                                if (w == "51")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '300006',\n");
                                    p.Append("'menuname': '所有任务列表',\n");
                                    p.Append("'icon': 'icon-folder',\n");
                                    p.Append("'url': '/Manage/Tasks/Task_AllList.aspx'\n");
                                    p.Append("}\n");
                                }

                            }
                        }
                    }
                    else
                    {
                        if (t == "49")
                        {
                            p.Append("{\n");
                            p.Append("'menuid': '300002',\n");
                            p.Append("'menuname': '任务分类列表',\n");
                            p.Append("'icon': 'icon-theme',\n");
                            p.Append("'url': '/Manage/Tasks/TaskType_List.aspx'\n");
                            p.Append("}\n");
                        }
                        if (t == "50")
                        {
                            p.Append("{\n");
                            p.Append("'menuid': '300003',\n");
                            p.Append("'menuname': '新增任务分类',\n");
                            p.Append("'icon': 'icon-addnew',\n");
                            p.Append("'url': '/Manage/Tasks/TaskType_Manage.aspx'\n");
                            p.Append("}\n");
                        }
                        if (t == "51")
                        {
                            p.Append("{\n");
                            p.Append("'menuid': '300006',\n");
                            p.Append("'menuname': '所有任务列表',\n");
                            p.Append("'icon': 'icon-folder',\n");
                            p.Append("'url': '/Manage/Tasks/Task_AllList.aspx'\n");
                            p.Append("}\n");
                        }

                    }
                    p.Append("]\n");
                    p.Append("},\n\n");
                }

                if (GetValidPower(m, "24|25|26|27|28|57|58") != "")
                {
                    p.Append("{\n");
                    p.Append("'menuid': '10006',\n");
                    p.Append("'menuname': '流程管理',\n");
                    p.Append("'icon': 'icon-html',\n");
                    p.Append("'child': [\n");

                    string t = GetValidPower(m, "24|25|26|27|28|57|58");
                    if (t.Contains(":"))
                    {
                        string[] a = t.Split(':');
                        for (int i = 0; i < a.Length; i++)
                        {
                            string w = a[i];
                            if (i != a.Length - 1)
                            {
                                if (w == "24")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100061',\n");
                                    p.Append("'menuname': '流程模型列表',\n");
                                    p.Append("'icon': 'icon-mdb',\n");
                                    p.Append("'url': '/Manage/Flow/Flow_ModelList.aspx'\n");
                                    p.Append("},\n");
                                }
                                if (w == "25")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100062',\n");
                                    p.Append("'menuname': '新增流程模型',\n");
                                    p.Append("'icon': 'icon-addnew',\n");
                                    p.Append("'url': '/Manage/Flow/Flow_ModelManage.aspx'\n");
                                    p.Append("},\n");
                                }
                                if (w == "26")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100063',\n");
                                    p.Append("'menuname': '模板表单列表',\n");
                                    p.Append("'icon': 'icon-mde',\n");
                                    p.Append("'url': '/Manage/Flow/Flow_ModelFileList.aspx'\n");
                                    p.Append("},\n");
                                }
                                if (w == "27")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100064',\n");
                                    p.Append("'menuname': '新增模板表单',\n");
                                    p.Append("'icon': 'icon-addnew',\n");
                                    p.Append("'url': '/Manage/Flow/Flow_ModelFileManage.aspx'\n");
                                    p.Append("},\n");
                                }
                                if (w == "28")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100065',\n");
                                    p.Append("'menuname': '所有流程监控',\n");
                                    p.Append("'icon': 'icon-new2',\n");
                                    p.Append("'url': '/Manage/flow/Flow_ListAll.aspx'\n");
                                    p.Append("},\n");
                                }
                                if (w == "57")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100066',\n");
                                    p.Append("'menuname': '添加模型分类',\n");
                                    p.Append("'icon': 'icon-addnew',\n");
                                    p.Append("'url': '/Manage/Flow/FlowType_Manage.aspx'\n");
                                    p.Append("},\n");
                                }
                                if (w == "58")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100067',\n");
                                    p.Append("'menuname': '流程模型分类',\n");
                                    p.Append("'icon': 'icon-jingpin',\n");
                                    p.Append("'url': '/Manage/Flow/FlowType_List.aspx'\n");
                                    p.Append("},\n");
                                }
                            }
                            else
                            {
                                if (w == "24")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100061',\n");
                                    p.Append("'menuname': '流程模型列表',\n");
                                    p.Append("'icon': 'icon-mdb',\n");
                                    p.Append("'url': '/Manage/Flow/Flow_ModelList.aspx'\n");
                                    p.Append("}\n");
                                }
                                if (w == "25")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100062',\n");
                                    p.Append("'menuname': '新增流程模型',\n");
                                    p.Append("'icon': 'icon-addnew',\n");
                                    p.Append("'url': '/Manage/Flow/Flow_ModelManage.aspx'\n");
                                    p.Append("}\n");
                                }
                                if (w == "26")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100063',\n");
                                    p.Append("'menuname': '模板表单列表',\n");
                                    p.Append("'icon': 'icon-mde',\n");
                                    p.Append("'url': '/Manage/Flow/Flow_ModelFileList.aspx'\n");
                                    p.Append("}\n");
                                }
                                if (w == "27")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100064',\n");
                                    p.Append("'menuname': '新增模板表单',\n");
                                    p.Append("'icon': 'icon-addnew',\n");
                                    p.Append("'url': '/Manage/Flow/Flow_ModelFileManage.aspx'\n");
                                    p.Append("}\n");
                                }
                                if (w == "28")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100065',\n");
                                    p.Append("'menuname': '所有流程监控',\n");
                                    p.Append("'icon': 'icon-new2',\n");
                                    p.Append("'url': '/Manage/flow/Flow_ListAll.aspx'\n");
                                    p.Append("}\n");
                                }
                                if (w == "57")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100066',\n");
                                    p.Append("'menuname': '添加模型分类',\n");
                                    p.Append("'icon': 'icon-addnew',\n");
                                    p.Append("'url': '/Manage/Flow/FlowType_Manage.aspx'\n");
                                    p.Append("}\n");
                                }
                                if (w == "58")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100067',\n");
                                    p.Append("'menuname': '流程模型分类',\n");
                                    p.Append("'icon': 'icon-jingpin',\n");
                                    p.Append("'url': '/Manage/Flow/FlowType_List.aspx'\n");
                                    p.Append("}\n");
                                }
                            }
                        }
                    }
                    else
                    {
                        if (t == "24")
                        {
                            p.Append("{\n");
                            p.Append("'menuid': '100061',\n");
                            p.Append("'menuname': '流程模型列表',\n");
                            p.Append("'icon': 'icon-mdb',\n");
                            p.Append("'url': '/Manage/Flow/Flow_ModelList.aspx'\n");
                            p.Append("}\n");
                        }
                        if (t == "25")
                        {
                            p.Append("{\n");
                            p.Append("'menuid': '100062',\n");
                            p.Append("'menuname': '新增流程模型',\n");
                            p.Append("'icon': 'icon-addnew',\n");
                            p.Append("'url': '/Manage/Flow/Flow_ModelManage.aspx'\n");
                            p.Append("}\n");
                        }
                        if (t == "26")
                        {
                            p.Append("{\n");
                            p.Append("'menuid': '100063',\n");
                            p.Append("'menuname': '模板表单列表',\n");
                            p.Append("'icon': 'icon-mde',\n");
                            p.Append("'url': '/Manage/Flow/Flow_ModelFileList.aspx'\n");
                            p.Append("}\n");
                        }
                        if (t == "27")
                        {
                            p.Append("{\n");
                            p.Append("'menuid': '100064',\n");
                            p.Append("'menuname': '新增模板表单',\n");
                            p.Append("'icon': 'icon-addnew',\n");
                            p.Append("'url': '/Manage/Flow/Flow_ModelFileManage.aspx'\n");
                            p.Append("}\n");
                        }
                        if (t == "28")
                        {
                            p.Append("{\n");
                            p.Append("'menuid': '100065',\n");
                            p.Append("'menuname': '所有流程监控',\n");
                            p.Append("'icon': 'icon-new2',\n");
                            p.Append("'url': '/Manage/flow/Flow_ListAll.aspx'\n");
                            p.Append("}\n");
                        }
                        if (t == "57")
                        {
                            p.Append("{\n");
                            p.Append("'menuid': '100066',\n");
                            p.Append("'menuname': '添加模型分类',\n");
                            p.Append("'icon': 'icon-addnew',\n");
                            p.Append("'url': '/Manage/Flow/FlowType_Manage.aspx'\n");
                            p.Append("}\n");
                        }
                        if (t == "58")
                        {
                            p.Append("{\n");
                            p.Append("'menuid': '100067',\n");
                            p.Append("'menuname': '流程模型分类',\n");
                            p.Append("'icon': 'icon-jingpin',\n");
                            p.Append("'url': '/Manage/Flow/FlowType_List.aspx'\n");
                            p.Append("}\n");
                        }
                    }
                    p.Append("]\n");
                    p.Append("},\n\n");
                }

                if (GetValidPower(m, "44|34|35|36|37|38|59|60") != "")
                {
                    p.Append("{\n");
                    p.Append("'menuid': '10007',\n");
                    p.Append("'menuname': '公文管理',\n");
                    p.Append("'icon': 'icon-ett',\n");
                    p.Append("'child': [\n");

                    string t = GetValidPower(m, "44|34|35|36|37|38|59|60");
                    if (t.Contains(":"))
                    {
                        string[] a = t.Split(':');
                        for (int i = 0; i < a.Length; i++)
                        {
                            string w = a[i];
                            if (i != a.Length - 1)
                            {
                                if (w == "44")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100071',\n");
                                    p.Append("'menuname': '发文拟稿',\n");
                                    p.Append("'icon': 'icon-addnew',\n");
                                    p.Append("'url': '/manage/gov/Gov_Manage.aspx'\n");
                                    p.Append("},\n");
                                }
                                if (w == "34")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100072',\n");
                                    p.Append("'menuname': '公文模型列表',\n");
                                    p.Append("'icon': 'icon-pub',\n");
                                    p.Append("'url': '/manage/gov/gov_ModelList.aspx'\n");
                                    p.Append("},\n");
                                }
                                if (w == "35")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100073',\n");
                                    p.Append("'menuname': '新增公文模型',\n");
                                    p.Append("'icon': 'icon-addnew',\n");
                                    p.Append("'url': '/manage/gov/gov_ModelManage.aspx'\n");
                                    p.Append("},\n");
                                }
                                if (w == "36")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100074',\n");
                                    p.Append("'menuname': '公文表单列表',\n");
                                    p.Append("'icon': 'icon-txt',\n");
                                    p.Append("'url': '/manage/gov/gov_ModelFileList.aspx'\n");
                                    p.Append("},\n");
                                }
                                if (w == "37")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100075',\n");
                                    p.Append("'menuname': '新增公文表单',\n");
                                    p.Append("'icon': 'icon-addnew',\n");
                                    p.Append("'url': '/manage/gov/gov_ModelFileManage.aspx'\n");
                                    p.Append("},\n");
                                }
                                if (w == "38")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100076',\n");
                                    p.Append("'menuname': '所有公文监控',\n");
                                    p.Append("'icon': 'icon-new2',\n");
                                    p.Append("'url': '/manage/gov/gov_ListAll.aspx'\n");
                                    p.Append("},\n");
                                }
                                if (w == "59")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100077',\n");
                                    p.Append("'menuname': '新增模型分类',\n");
                                    p.Append("'icon': 'icon-addnew',\n");
                                    p.Append("'url': '/Manage/Gov/GovType_Manage.aspx'\n");
                                    p.Append("},\n");
                                }
                                if (w == "60")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100078',\n");
                                    p.Append("'menuname': '公文模型分类',\n");
                                    p.Append("'icon': 'icon-folder',\n");
                                    p.Append("'url': '/Manage/Gov/GovType_List.aspx'\n");
                                    p.Append("},\n");
                                }
                            }
                            else
                            {
                                if (w == "44")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100071',\n");
                                    p.Append("'menuname': '发文拟稿',\n");
                                    p.Append("'icon': 'icon-addnew',\n");
                                    p.Append("'url': '/manage/gov/Gov_Manage.aspx'\n");
                                    p.Append("}\n");
                                }
                                if (w == "34")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100072',\n");
                                    p.Append("'menuname': '公文模型列表',\n");
                                    p.Append("'icon': 'icon-pub',\n");
                                    p.Append("'url': '/manage/gov/gov_ModelList.aspx'\n");
                                    p.Append("}\n");
                                }
                                if (w == "35")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100073',\n");
                                    p.Append("'menuname': '新增公文模型',\n");
                                    p.Append("'icon': 'icon-addnew',\n");
                                    p.Append("'url': '/manage/gov/gov_ModelManage.aspx'\n");
                                    p.Append("}\n");
                                }
                                if (w == "36")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100074',\n");
                                    p.Append("'menuname': '公文表单列表',\n");
                                    p.Append("'icon': 'icon-txt',\n");
                                    p.Append("'url': '/manage/gov/gov_ModelFileList.aspx'\n");
                                    p.Append("}\n");
                                }
                                if (w == "37")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100075',\n");
                                    p.Append("'menuname': '新增公文表单',\n");
                                    p.Append("'icon': 'icon-addnew',\n");
                                    p.Append("'url': '/manage/gov/gov_ModelFileManage.aspx'\n");
                                    p.Append("}\n");
                                }
                                if (w == "38")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100076',\n");
                                    p.Append("'menuname': '所有公文监控',\n");
                                    p.Append("'icon': 'icon-new2',\n");
                                    p.Append("'url': '/manage/gov/gov_ListAll.aspx'\n");
                                    p.Append("}\n");
                                }
                                if (w == "59")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100077',\n");
                                    p.Append("'menuname': '新增模型分类',\n");
                                    p.Append("'icon': 'icon-addnew',\n");
                                    p.Append("'url': '/Manage/Gov/GovType_Manage.aspx'\n");
                                    p.Append("}\n");
                                }
                                if (w == "60")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100078',\n");
                                    p.Append("'menuname': '公文模型分类',\n");
                                    p.Append("'icon': 'icon-folder',\n");
                                    p.Append("'url': '/Manage/Gov/GovType_List.aspx'\n");
                                    p.Append("}\n");
                                }
                            }
                        }
                    }
                    else
                    {
                        if (t == "44")
                        {
                            p.Append("{\n");
                            p.Append("'menuid': '100071',\n");
                            p.Append("'menuname': '发文拟稿',\n");
                            p.Append("'icon': 'icon-addnew',\n");
                            p.Append("'url': '/manage/gov/Gov_Manage.aspx'\n");
                            p.Append("}\n");
                        }
                        if (t == "34")
                        {
                            p.Append("{\n");
                            p.Append("'menuid': '100072',\n");
                            p.Append("'menuname': '公文模型列表',\n");
                            p.Append("'icon': 'icon-pub',\n");
                            p.Append("'url': '/manage/gov/gov_ModelList.aspx'\n");
                            p.Append("}\n");
                        }
                        if (t == "35")
                        {
                            p.Append("{\n");
                            p.Append("'menuid': '100073',\n");
                            p.Append("'menuname': '新增公文模型',\n");
                            p.Append("'icon': 'icon-addnew',\n");
                            p.Append("'url': '/manage/gov/gov_ModelManage.aspx'\n");
                            p.Append("}\n");
                        }
                        if (t == "36")
                        {
                            p.Append("{\n");
                            p.Append("'menuid': '100074',\n");
                            p.Append("'menuname': '公文表单列表',\n");
                            p.Append("'icon': 'icon-txt',\n");
                            p.Append("'url': '/manage/gov/gov_ModelFileList.aspx'\n");
                            p.Append("}\n");
                        }
                        if (t == "37")
                        {
                            p.Append("{\n");
                            p.Append("'menuid': '100075',\n");
                            p.Append("'menuname': '新增公文表单',\n");
                            p.Append("'icon': 'icon-addnew',\n");
                            p.Append("'url': '/manage/gov/gov_ModelFileManage.aspx'\n");
                            p.Append("}\n");
                        }
                        if (t == "38")
                        {
                            p.Append("{\n");
                            p.Append("'menuid': '100076',\n");
                            p.Append("'menuname': '所有公文监控',\n");
                            p.Append("'icon': 'icon-new2',\n");
                            p.Append("'url': '/manage/gov/gov_ListAll.aspx'\n");
                            p.Append("}\n");
                        }
                        if (t == "59")
                        {
                            p.Append("{\n");
                            p.Append("'menuid': '100077',\n");
                            p.Append("'menuname': '新增模型分类',\n");
                            p.Append("'icon': 'icon-addnew',\n");
                            p.Append("'url': '/Manage/Gov/GovType_Manage.aspx'\n");
                            p.Append("}\n");
                        }
                        if (t == "60")
                        {
                            p.Append("{\n");
                            p.Append("'menuid': '100078',\n");
                            p.Append("'menuname': '公文模型分类',\n");
                            p.Append("'icon': 'icon-folder',\n");
                            p.Append("'url': '/Manage/Gov/GovType_List.aspx'\n");
                            p.Append("}\n");
                        }
                    }
                    p.Append("]\n");
                    p.Append("},\n\n");
                }

                if (GetValidPower(m, "52|53|54|55|56") != "")
                {
                    p.Append("{\n");
                    p.Append("'menuid': '600001',\n");
                    p.Append("'menuname': '电子档案管理',\n");
                    p.Append("'icon': 'icon-ppt',\n");
                    p.Append("'child': [\n");

                    string t = GetValidPower(m, "52|53|54|55|56");
                    if (t.Contains(":"))
                    {
                        string[] a = t.Split(':');
                        for (int i = 0; i < a.Length; i++)
                        {
                            string w = a[i];
                            if (i != a.Length - 1)
                            {
                                if (w == "52")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '600002',\n");
                                    p.Append("'menuname': '新增电子档案',\n");
                                    p.Append("'icon': 'icon-addnew',\n");
                                    p.Append("'url': '/Manage/Paper/PaperManage.aspx'\n");
                                    p.Append("},\n");
                                }
                                if (w == "53")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '600003',\n");
                                    p.Append("'menuname': '所有电子档案',\n");
                                    p.Append("'icon': 'icon-guestbook',\n");
                                    p.Append("'url': '/Manage/Paper/PaperAllList.aspx'\n");
                                    p.Append("},\n");
                                }
                                if (w == "56")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '600004',\n");
                                    p.Append("'menuname': '档案下载记录',\n");
                                    p.Append("'icon': 'icon-all',\n");
                                    p.Append("'url': '/Manage/Paper/DownLoadList.aspx'\n");
                                    p.Append("},\n");
                                }
                                if (w == "54")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '600005',\n");
                                    p.Append("'menuname': '新增档案分类',\n");
                                    p.Append("'icon': 'icon-addnew',\n");
                                    p.Append("'url': '/Manage/Paper/PaperType_Manage.aspx'\n");
                                    p.Append("},\n");
                                }
                                if (w == "55")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '600006',\n");
                                    p.Append("'menuname': '档案分类列表',\n");
                                    p.Append("'icon': 'icon-jingpin',\n");
                                    p.Append("'url': '/Manage/Paper/PaperType_List.aspx'\n");
                                    p.Append("},\n");
                                }

                            }
                            else
                            {
                                if (w == "52")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '600002',\n");
                                    p.Append("'menuname': '新增电子档案',\n");
                                    p.Append("'icon': 'icon-addnew',\n");
                                    p.Append("'url': '/Manage/Paper/PaperManage.aspx'\n");
                                    p.Append("}\n");
                                }
                                if (w == "53")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '600003',\n");
                                    p.Append("'menuname': '所有电子档案',\n");
                                    p.Append("'icon': 'icon-guestbook',\n");
                                    p.Append("'url': '/Manage/Paper/PaperAllList.aspx'\n");
                                    p.Append("}\n");
                                }
                                if (w == "56")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '600004',\n");
                                    p.Append("'menuname': '档案下载记录',\n");
                                    p.Append("'icon': 'icon-all',\n");
                                    p.Append("'url': '/Manage/Paper/DownLoadList.aspx'\n");
                                    p.Append("}\n");
                                }
                                if (w == "54")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '600005',\n");
                                    p.Append("'menuname': '新增档案分类',\n");
                                    p.Append("'icon': 'icon-addnew',\n");
                                    p.Append("'url': '/Manage/Paper/PaperType_Manage.aspx'\n");
                                    p.Append("}\n");
                                }
                                if (w == "55")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '600006',\n");
                                    p.Append("'menuname': '档案分类列表',\n");
                                    p.Append("'icon': 'icon-jingpin',\n");
                                    p.Append("'url': '/Manage/Paper/PaperType_List.aspx'\n");
                                    p.Append("}\n");
                                }

                            }
                        }
                    }
                    else
                    {
                        if (t == "52")
                        {
                            p.Append("{\n");
                            p.Append("'menuid': '600002',\n");
                            p.Append("'menuname': '新增电子档案',\n");
                            p.Append("'icon': 'icon-addnew',\n");
                            p.Append("'url': '/Manage/Paper/PaperManage.aspx'\n");
                            p.Append("}\n");
                        }
                        if (t == "53")
                        {
                            p.Append("{\n");
                            p.Append("'menuid': '600003',\n");
                            p.Append("'menuname': '所有电子档案',\n");
                            p.Append("'icon': 'icon-guestbook',\n");
                            p.Append("'url': '/Manage/Paper/PaperAllList.aspx'\n");
                            p.Append("}\n");
                        }
                        if (t == "56")
                        {
                            p.Append("{\n");
                            p.Append("'menuid': '600004',\n");
                            p.Append("'menuname': '档案下载记录',\n");
                            p.Append("'icon': 'icon-all',\n");
                            p.Append("'url': '/Manage/Paper/DownLoadList.aspx'\n");
                            p.Append("}\n");
                        }
                        if (t == "54")
                        {
                            p.Append("{\n");
                            p.Append("'menuid': '600005',\n");
                            p.Append("'menuname': '新增档案分类',\n");
                            p.Append("'icon': 'icon-addnew',\n");
                            p.Append("'url': '/Manage/Paper/PaperType_Manage.aspx'\n");
                            p.Append("}\n");
                        }
                        if (t == "55")
                        {
                            p.Append("{\n");
                            p.Append("'menuid': '600006',\n");
                            p.Append("'menuname': '档案分类列表',\n");
                            p.Append("'icon': 'icon-jingpin',\n");
                            p.Append("'url': '/Manage/Paper/PaperType_List.aspx'\n");
                            p.Append("}\n");
                        }

                    }
                    p.Append("]\n");
                    p.Append("},\n\n");
                }

                if (GetValidPower(m, "63|64|65") != "")
                {
                    p.Append("{\n");
                    p.Append("'menuid': '400001',\n");
                    p.Append("'menuname': '手机短信管理',\n");
                    p.Append("'icon': 'icon-phone',\n");
                    p.Append("'child': [\n");

                    string t = GetValidPower(m, "63|64|65");
                    if (t.Contains(":"))
                    {
                        string[] a = t.Split(':');
                        for (int i = 0; i < a.Length; i++)
                        {
                            string w = a[i];
                            if (i != a.Length - 1)
                            {
                                if (w == "63")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '400002',\n");
                                    p.Append("'menuname': '短信发送记录',\n");
                                    p.Append("'icon': 'icon-theme',\n");
                                    p.Append("'url': '/Manage/sms/SMS_AllList.aspx'\n");
                                    p.Append("},\n");
                                }
                                if (w == "64")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '400003',\n");
                                    p.Append("'menuname': '短信设置',\n");
                                    p.Append("'icon': 'icon-settings',\n");
                                    p.Append("'url': '/Manage/sms/SMS_SetUp.aspx'\n");
                                    p.Append("},\n");
                                }
                                if (w == "65")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '400006',\n");
                                    p.Append("'menuname': '发送手机短信',\n");
                                    p.Append("'icon': 'icon-phone',\n");
                                    p.Append("'url': '/Manage/sms/SMS_Send.aspx'\n");
                                    p.Append("},\n");
                                }

                            }
                            else
                            {
                                if (w == "63")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '400002',\n");
                                    p.Append("'menuname': '短信发送记录',\n");
                                    p.Append("'icon': 'icon-theme',\n");
                                    p.Append("'url': '/Manage/sms/SMS_AllList.aspx'\n");
                                    p.Append("}\n");
                                }
                                if (w == "64")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '400003',\n");
                                    p.Append("'menuname': '短信设置',\n");
                                    p.Append("'icon': 'icon-settings',\n");
                                    p.Append("'url': '/Manage/sms/SMS_SetUp.aspx'\n");
                                    p.Append("}\n");
                                }
                                if (w == "65")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '400006',\n");
                                    p.Append("'menuname': '发送手机短信',\n");
                                    p.Append("'icon': 'icon-phone',\n");
                                    p.Append("'url': '/Manage/sms/SMS_Send.aspx'\n");
                                    p.Append("}\n");
                                }

                            }
                        }
                    }
                    else
                    {
                        if (t == "63")
                        {
                            p.Append("{\n");
                            p.Append("'menuid': '400002',\n");
                            p.Append("'menuname': '短信发送记录',\n");
                            p.Append("'icon': 'icon-theme',\n");
                            p.Append("'url': '/Manage/sms/SMS_AllList.aspx'\n");
                            p.Append("}\n");
                        }
                        if (t == "64")
                        {
                            p.Append("{\n");
                            p.Append("'menuid': '400003',\n");
                            p.Append("'menuname': '短信设置',\n");
                            p.Append("'icon': 'icon-settings',\n");
                            p.Append("'url': '/Manage/sms/SMS_SetUp.aspx'\n");
                            p.Append("}\n");
                        }
                        if (t == "65")
                        {
                            p.Append("{\n");
                            p.Append("'menuid': '400006',\n");
                            p.Append("'menuname': '发送手机短信',\n");
                            p.Append("'icon': 'icon-phone',\n");
                            p.Append("'url': '/Manage/sms/SMS_Send.aspx'\n");
                            p.Append("}\n");
                        }

                    }
                    p.Append("]\n");
                    p.Append("},\n\n");
                }

                if (GetValidPower(m, "39|40") != "")
                {
                    p.Append("{\n");
                    p.Append("'menuid': '10008',\n");
                    p.Append("'menuname': '印章/签名管理',\n");
                    p.Append("'icon': 'icon-sitemap',\n");
                    p.Append("'child': [\n");

                    string t = GetValidPower(m, "39|40");
                    if (t.Contains(":"))
                    {
                        string[] a = t.Split(':');
                        for (int i = 0; i < a.Length; i++)
                        {
                            string w = a[i];
                            if (i != a.Length - 1)
                            {
                                if (w == "39")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100081',\n");
                                    p.Append("'menuname': '印章/签名列表',\n");
                                    p.Append("'icon': 'icon-img',\n");
                                    p.Append("'url': '/Manage/Sys/Seal_List.aspx'\n");
                                    p.Append("},\n");
                                }
                                if (w == "40")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100082',\n");
                                    p.Append("'menuname': '新增印章/签名',\n");
                                    p.Append("'icon': 'icon-addnew',\n");
                                    p.Append("'url': '/manage/sys/Seal_Manage.aspx'\n");
                                    p.Append("},\n");
                                }

                            }
                            else
                            {
                                if (w == "39")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100081',\n");
                                    p.Append("'menuname': '印章/签名列表',\n");
                                    p.Append("'icon': 'icon-img',\n");
                                    p.Append("'url': '/Manage/Sys/Seal_List.aspx'\n");
                                    p.Append("}\n");
                                }
                                if (w == "40")
                                {
                                    p.Append("{\n");
                                    p.Append("'menuid': '100082',\n");
                                    p.Append("'menuname': '新增印章/签名',\n");
                                    p.Append("'icon': 'icon-addnew',\n");
                                    p.Append("'url': '/manage/sys/Seal_Manage.aspx'\n");
                                    p.Append("}\n");
                                }

                            }
                        }
                    }
                    else
                    {
                        if (t == "39")
                        {
                            p.Append("{\n");
                            p.Append("'menuid': '100081',\n");
                            p.Append("'menuname': '印章/签名列表',\n");
                            p.Append("'icon': 'icon-img',\n");
                            p.Append("'url': '/Manage/Sys/Seal_List.aspx'\n");
                            p.Append("}\n");
                        }
                        if (t == "40")
                        {
                            p.Append("{\n");
                            p.Append("'menuid': '100082',\n");
                            p.Append("'menuname': '新增印章/签名',\n");
                            p.Append("'icon': 'icon-addnew',\n");
                            p.Append("'url': '/manage/sys/Seal_Manage.aspx'\n");
                            p.Append("}\n");
                        }
                    }
                    p.Append("]\n");
                    p.Append("},\n\n");
                }


                if (m.Contains("45"))
                {
                    p.Append("{\n");
                    p.Append("'menuid': '11000',\n");
                    p.Append("'menuname': '投票管理',\n");
                    p.Append("'icon': 'icon-app',\n");
                    p.Append("'url': '/Manage/Common/Vote_AllList.aspx'\n");
                    p.Append("}\n");
                    p.Append(",\n\n");
                }

                if (m.Contains("48"))
                {
                    p.Append("{\n");
                    p.Append("'menuid': '11100',\n");
                    p.Append("'menuname': '系统登录记录',\n");
                    p.Append("'icon': 'icon-com',\n");
                    p.Append("'url': '/Manage/sys/User_LoginList.aspx'\n");
                    p.Append("}\n");
                    p.Append(",\n\n");
                }

                p.Append("{\n");
                p.Append("'menuid': '10009',\n");
                p.Append("'menuname': '个人登陆记录',\n");
                p.Append("'icon': 'icon-user1',\n");
                p.Append("'url': '/manage/Common/User_LoginList.aspx'\n");
                p.Append("}]\n");
                p.Append("}\n");

                return p.ToString();
            }

        }


        /// <summary>
        /// s: "1,3,4,5,6,7,8"  arr: "2|5|6"  return "5:6"
        /// </summary>
        /// <param name="s"></param>
        /// <param name="arr"></param>
        /// <returns></returns>
        private string GetValidPower(string s, string arr)
        {
            string[] a = arr.Split('|');
            List<string> list = new List<string>();
            for (int i = 0; i < a.Length; i++)
            {
                if (s.IndexOf(a[i]) != -1)
                {
                    list.Add(a[i]);
                }
            }
            return string.Join(":", list.ToArray());
        }
    }
}