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
    public partial class _default : WC.BLL.ViewPages
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
        protected string news_type1 = "";

        protected string wallpaper = "myLib.desktop.wallpaper.init('themes/default/images/wallpaper.jpg');";

        private string ft = "'{0}': {{'WindowTitle': '{1}','iframSrc': '{2}','WindowWidth': mw}},";
        private string ft1 = "<li class='desktop_icon' id='{0}'> <span class='icon'><img src='icon/01/001.png'/></span> <div class='text'>{1}<s></s></div> </li>";

        protected void Page_Load(object sender, EventArgs e)
        {
            power_menu = GetUserPowerMenu(Modules);
            //显示资讯分类
            IList list = News_Type.Init().GetAll(null, " order by orders asc");
            for (int i = 0; i < list.Count; i++)
            {
                News_TypeInfo nt = list[i] as News_TypeInfo;
                news_type += string.Format(ft, "nn" + (i + 1), nt.TypeName, "News/News_List.aspx?tid=" + nt.id);
                news_type1 += string.Format(ft1, "nn" + (i + 1), nt.TypeName);
            }

            uid.Value = Uid;

            Bas_ComInfo bi = HttpContext.Current.Application["cominfo"] as Bas_ComInfo;
            comname = bi.ComName;
            weburl = bi.WebUrl;
            logo = bi.Logo;

            Sys_UserInfo ui = Sys_User.Init().GetById(Convert.ToInt32(Uid));
            ui.RoleGUID = ui.RoleGUID + "";
            if (!string.IsNullOrEmpty(ui.RoleGUID))
            {
                if (ui.RoleGUID.ToLower().Contains(".jpg"))
                    wallpaper = "myLib.desktop.wallpaper.init('" + ui.RoleGUID + "');";
            }

            //是否开启消息提示
            if (bi.MsgState != 1)
            {
                message_div.Visible = false;
            }
            else
            {
                try
                {
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

            if (bi.BBSState == 1)
            {
                dxbbs_div.Visible = true;
            }

        }

        private string GetUserPowerMenu(string m)
        {
            StringBuilder p = new StringBuilder();
            if (string.IsNullOrEmpty(m))
            {
                p.Append("myLib.desktop.startBtn.init([ \n");
                p.Append("[{id:'pslogin1',text:'个人登录记录',icon:'icon/login.png',func:function(){runWin('个人登录记录','Common/User_LoginList.aspx','pslogin2');} }],\n[{id:'logout1',text:'安全退出',icon:'icon/out.png',func:function(){logout(); } }] ]);\n");
                
            }
            else
            {
                p.Append("myLib.desktop.startBtn.init([ \n");
                if (GetValidPower(m, "14|43|21|22") != "")
                {
                    p.Append("[{\n");
                    p.Append("id: 'sys1',\n");
                    p.Append("text: '系统基础设置',\n");
                    p.Append("icon: 'icon/config.png',\n");
                    p.Append("func: function () { },\n");
                    p.Append("childItem: [\n");

                    string t = GetValidPower(m, "14|21|22|43");
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
                                    p.Append("[{id:'1014',text:'基本信息',icon:'icon/item0.png',func:function(){runWin('基本信息','sys/Com_Basic.aspx','d1014'); }}],\n");
                                }
                                if (w == "21")
                                {
                                    p.Append("[{id:'1021',text:'组织机构添加',icon:'icon/add.png',func:function(){runWin('组织机构添加','sys/Dep_Manage.aspx','d1021'); }}],\n");
                                }
                                if (w == "22")
                                {
                                    p.Append("[{id:'1022',text:'组织机构管理',icon:'icon/item0.png',func:function(){runWin('组织机构管理','sys/Dep_List.aspx','d1022'); }}],\n");
                                }
                                if (w == "43")
                                {
                                    p.Append("[{id:'1043',text:'数据库备份',icon:'icon/item0.png',func:function(){runWin('数据库备份','sys/DbBackup.aspx','d1043'); }}],\n");
                                }
                            }
                            else
                            {
                                if (w == "14")
                                {
                                    p.Append("[{id:'1014',text:'基本信息',icon:'icon/item0.png',func:function(){runWin('基本信息','sys/Com_Basic.aspx','d1014'); }}]\n");
                                }
                                if (w == "21")
                                {
                                    p.Append("[{id:'1021',text:'组织机构添加',icon:'icon/add.png',func:function(){runWin('组织机构添加','sys/Dep_Manage.aspx','d1021'); }}]\n");
                                }
                                if (w == "22")
                                {
                                    p.Append("[{id:'1022',text:'组织机构管理',icon:'icon/item0.png',func:function(){runWin('组织机构管理','sys/Dep_List.aspx','d1022'); }}]\n");
                                }
                                if (w == "43")
                                {
                                    p.Append("[{id:'1043',text:'数据库备份',icon:'icon/item0.png',func:function(){runWin('数据库备份','sys/DbBackup.aspx','d1043'); }}]\n");
                                }
                            }
                        }

                    }
                    else
                    {
                        if (t == "14")
                        {
                            p.Append("[{id:'1014',text:'基本信息',icon:'icon/item0.png',func:function(){runWin('基本信息','sys/Com_Basic.aspx','d1014'); }}]\n");
                        }
                        if (t== "21")
                        {
                            p.Append("[{id:'1021',text:'组织机构添加',icon:'icon/add.png',func:function(){runWin('组织机构添加','sys/Dep_Manage.aspx','d1021'); }}]\n");
                        }
                        if (t == "22")
                        {
                            p.Append("[{id:'1022',text:'组织机构管理',icon:'icon/item0.png',func:function(){runWin('组织机构管理','sys/Dep_List.aspx','d1022'); }}]\n");
                        }
                        if (t == "43")
                        {
                            p.Append("[{id:'1043',text:'数据库备份',icon:'icon/item0.png',func:function(){runWin('数据库备份','sys/DbBackup.aspx','d1043'); }}]\n");
                        }
                    }
                    p.Append("]\n");
                    p.Append("}],\n\n");
                }

                if (GetValidPower(m, "19|20|17|18|46|47") != "")
                {
                    p.Append("[{\n");
                    p.Append("id: 'user1',\n");
                    p.Append("text: '人事管理',\n");
                    p.Append("icon: 'icon/users.png',\n");
                    p.Append("func: function () { },\n");
                    p.Append("childItem: [\n");

                    string t = GetValidPower(m, "19|20|17|18|46|47");
                    if (t.Contains(":"))
                    {
                        string[] a = t.Split(':');
                        for (int i = 0; i < a.Length; i++)
                        {
                            string w = a[i];
                            if (i != a.Length - 1)
                            {
                                if (w == "19")
                                {
                                    p.Append("[{id:'1019',text:'新增用户',icon:'icon/add.png',func:function(){runWin('新增用户','sys/User_Manage.aspx','d1019'); }}],\n");
                                }
                                if (w == "20")
                                {
                                    p.Append("[{id:'1020',text:'用户列表',icon:'icon/item0.png',func:function(){runWin('用户列表','sys/User_List.aspx','d1020'); }}],\n");
                                }
                                if (w == "17")
                                {
                                    p.Append("[{id:'1017',text:'新增角色',icon:'icon/add.png',func:function(){runWin('新增角色','sys/Role_Manage.aspx','d1017'); }}],\n");
                                }
                                if (w == "18")
                                {
                                    p.Append("[{id:'1018',text:'角色列表',icon:'icon/item0.png',func:function(){runWin('角色列表','sys/Role_List.aspx','d1018'); }}],\n");
                                }
                                if (w == "46")
                                {
                                    p.Append("[{id:'1046',text:'设置考勤时间',icon:'icon/item0.png',func:function(){runWin('设置考勤时间','Attend/WorkSet.aspx?type=edit','d1046'); }}],\n");
                                }
                                if (w == "47")
                                {
                                    p.Append("[{id:'1047',text:'考勤统计',icon:'icon/item0.png',func:function(){runWin('考勤统计','Attend/WorkList.aspx?type=1','d1047'); }}],\n");
                                }
                            }
                            else
                            {
                                if (w == "19")
                                {
                                    p.Append("[{id:'1019',text:'新增用户',icon:'icon/add.png',func:function(){runWin('新增用户','sys/User_Manage.aspx','d1019'); }}]\n");
                                }
                                if (w == "20")
                                {
                                    p.Append("[{id:'1020',text:'用户列表',icon:'icon/item0.png',func:function(){runWin('用户列表','sys/User_List.aspx','d1020'); }}]\n");
                                }
                                if (w == "17")
                                {
                                    p.Append("[{id:'1017',text:'新增角色',icon:'icon/add.png',func:function(){runWin('新增角色','sys/Role_Manage.aspx','d1017'); }}]\n");
                                }
                                if (w == "18")
                                {
                                    p.Append("[{id:'1018',text:'角色列表',icon:'icon/item0.png',func:function(){runWin('角色列表','sys/Role_List.aspx','d1018'); }}]\n");
                                }
                                if (w == "46")
                                {
                                    p.Append("[{id:'1046',text:'设置考勤时间',icon:'icon/item0.png',func:function(){runWin('设置考勤时间','Attend/WorkSet.aspx?type=edit','d1046'); }}]\n");
                                }
                                if (w == "47")
                                {
                                    p.Append("[{id:'1047',text:'考勤统计',icon:'icon/item0.png',func:function(){runWin('考勤统计','Attend/WorkList.aspx?type=1','d1047'); }}]\n");
                                }
                            }
                        }
                    }
                    else
                    {
                        if (t == "19")
                        {
                            p.Append("[{id:'1019',text:'新增用户',icon:'icon/add.png',func:function(){runWin('新增用户','sys/User_Manage.aspx','d1019'); }}]\n");
                        }
                        if (t == "20")
                        {
                            p.Append("[{id:'1020',text:'用户列表',icon:'icon/item0.png',func:function(){runWin('用户列表','sys/User_List.aspx','d1020'); }}]\n");
                        }
                        if (t == "17")
                        {
                            p.Append("[{id:'1017',text:'新增角色',icon:'icon/add.png',func:function(){runWin('新增角色','sys/Role_Manage.aspx','d1017'); }}]\n");
                        }
                        if (t == "18")
                        {
                            p.Append("[{id:'1018',text:'角色列表',icon:'icon/item0.png',func:function(){runWin('角色列表','sys/Role_List.aspx','d1018'); }}]\n");
                        }
                        if (t == "46")
                        {
                            p.Append("[{id:'1046',text:'设置考勤时间',icon:'icon/item0.png',func:function(){runWin('设置考勤时间','Attend/WorkSet.aspx?type=edit','d1046'); }}]\n");
                        }
                        if (t == "47")
                        {
                            p.Append("[{id:'1047',text:'考勤统计',icon:'icon/item0.png',func:function(){runWin('考勤统计','Attend/WorkList.aspx?type=1','d1047'); }}]\n");
                        }
                    }
                    p.Append("]\n");
                    p.Append("}],\n\n");
                }

                if (GetValidPower(m, "29|30|31|32|41|42") != "")
                {
                    p.Append("[{\n");
                    p.Append("id: 'news1',\n");
                    p.Append("text: '资讯管理',\n");
                    p.Append("icon: 'icon/news.png',\n");
                    p.Append("func: function () { },\n");
                    p.Append("childItem: [\n");

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
                                    p.Append("[{id:'1029',text:'所有资讯列表',icon:'icon/item0.png',func:function(){runWin('所有资讯列表','news/News_AllList.aspx','d1029'); }}],\n");
                                }
                                if (w == "30")
                                {
                                    p.Append("[{id:'1030',text:'发布资讯',icon:'icon/add.png',func:function(){runWin('发布资讯','news/News_Manage.aspx','d1030'); }}],\n");
                                }
                                if (w == "31")
                                {
                                    p.Append("[{id:'1031',text:'资讯分类列表',icon:'icon/item0.png',func:function(){runWin('资讯分类列表','news/NewsType_List.aspx','d1031'); }}],\n");
                                }
                                if (w == "32")
                                {
                                    p.Append("[{id:'1032',text:'添加资讯分类',icon:'icon/add.png',func:function(){runWin('添加资讯分类','news/NewsType_Manage.aspx','d1032'); }}],\n");
                                }
                                if (w == "42")
                                {
                                    p.Append("[{id:'1042',text:'滚动公告列表',icon:'icon/item0.png',func:function(){runWin('滚动公告列表','news/Tips_List.aspx','d1042'); }}],\n");
                                }
                                if (w == "41")
                                {
                                    p.Append("[{id:'1041',text:'添加滚动公告',icon:'icon/add.png',func:function(){runWin('添加滚动公告','news/Tips_Manage.aspx','d1041'); }}],\n");
                                }
                            }
                            else
                            {
                                if (w == "29")
                                {
                                    p.Append("[{id:'1029',text:'所有资讯列表',icon:'icon/item0.png',func:function(){runWin('所有资讯列表','news/News_AllList.aspx','d1029'); }}]\n");
                                }
                                if (w == "30")
                                {
                                    p.Append("[{id:'1030',text:'发布资讯',icon:'icon/add.png',func:function(){runWin('发布资讯','news/News_Manage.aspx','d1030'); }}]\n");
                                }
                                if (w == "31")
                                {
                                    p.Append("[{id:'1031',text:'资讯分类列表',icon:'icon/item0.png',func:function(){runWin('资讯分类列表','news/NewsType_List.aspx','d1031'); }}]\n");
                                }
                                if (w == "32")
                                {
                                    p.Append("[{id:'1032',text:'添加资讯分类',icon:'icon/add.png',func:function(){runWin('添加资讯分类','news/NewsType_Manage.aspx','d1032'); }}]\n");
                                }
                                if (w == "42")
                                {
                                    p.Append("[{id:'1042',text:'滚动公告列表',icon:'icon/item0.png',func:function(){runWin('滚动公告列表','news/Tips_List.aspx','d1042'); }}]\n");
                                }
                                if (w == "41")
                                {
                                    p.Append("[{id:'1041',text:'添加滚动公告',icon:'icon/add.png',func:function(){runWin('添加滚动公告','news/Tips_Manage.aspx','d1041'); }}]\n");
                                }

                            }
                        }
                    }
                    else
                    {
                        if (t == "29")
                        {
                            p.Append("[{id:'1029',text:'所有资讯列表',icon:'icon/item0.png',func:function(){runWin('所有资讯列表','news/News_AllList.aspx','d1029'); }}]\n");
                        }
                        if (t == "30")
                        {
                            p.Append("[{id:'1030',text:'发布资讯',icon:'icon/add.png',func:function(){runWin('发布资讯','news/News_Manage.aspx','d1030'); }}]\n");
                        }
                        if (t == "31")
                        {
                            p.Append("[{id:'1031',text:'资讯分类列表',icon:'icon/item0.png',func:function(){runWin('资讯分类列表','news/NewsType_List.aspx','d1031'); }}]\n");
                        }
                        if (t == "32")
                        {
                            p.Append("[{id:'1032',text:'添加资讯分类',icon:'icon/add.png',func:function(){runWin('添加资讯分类','news/NewsType_Manage.aspx','d1032'); }}]\n");
                        }
                        if (t == "42")
                        {
                            p.Append("[{id:'1042',text:'滚动公告列表',icon:'icon/item0.png',func:function(){runWin('滚动公告列表','news/Tips_List.aspx','d1042'); }}]\n");
                        }
                        if (t == "41")
                        {
                            p.Append("[{id:'1041',text:'添加滚动公告',icon:'icon/add.png',func:function(){runWin('添加滚动公告','news/Tips_Manage.aspx','d1041'); }}]\n");
                        }

                    }
                    p.Append("]\n");
                    p.Append("}],\n\n");
                }

                if (GetValidPower(m, "24|25|26|27|57|58|28") != "")
                {
                    p.Append("[{\n");
                    p.Append("id: 'flow1',\n");
                    p.Append("text: '流程管理',\n");
                    p.Append("icon: 'icon/flow.png',\n");
                    p.Append("func: function () { },\n");
                    p.Append("childItem: [\n");

                    string t1 = GetValidPower(m, "24|25");
                    string t2 = GetValidPower(m, "26|27");
                    string t3 = GetValidPower(m, "58|57");

                    if (t1 != "")
                    {
                        p.Append("[{\n");
                        p.Append("id: 'flowmodel1',\n");
                        p.Append("text: '流程模型管理',\n");
                        p.Append("icon: 'icon/item3.png',\n");
                        p.Append("func: function () { },\n");
                        p.Append("childItem: [\n");
                        if (t1.Contains(":"))
                        {
                            string[] a = t1.Split(':');
                            for (int i = 0; i < a.Length; i++)
                            {
                                string w = a[i];
                                if (w == "24")
                                {
                                    p.Append("[{id:'1024',text:'流程模型列表',icon:'icon/item0.png',func:function(){runWin('流程模型列表','Flow/Flow_ModelList.aspx','d1024'); }}],\n");
                                }
                                if (w == "25")
                                {
                                    p.Append("[{id:'1025',text:'新增流程模型',icon:'icon/add.png',func:function(){runWin('新增流程模型','Flow/Flow_ModelManage.aspx','d1025'); }}]\n");
                                }
                            }
                        }
                        else
                        {
                            if (t1 == "24")
                            {
                                p.Append("[{id:'1024',text:'流程模型列表',icon:'icon/item0.png',func:function(){runWin('流程模型列表','Flow/Flow_ModelList.aspx','d1024'); }}]\n");
                            }
                            if (t1 == "25")
                            {
                                p.Append("[{id:'1025',text:'新增流程模型',icon:'icon/add.png',func:function(){runWin('新增流程模型','Flow/Flow_ModelManage.aspx','d1025'); }}]\n");
                            }
                        }

                        string r = GetValidPower(m, "26|27|58|57|28");
                        if (r != "")
                        {
                            p.Append("]\n");
                            p.Append("}],\n\n");
                        }
                        else
                        {
                            p.Append("]\n");
                            p.Append("}]\n\n");
                        }

                    }
                    if (t2 != "")
                    {
                        p.Append("[{\n");
                        p.Append("id: 'flowmodel2',\n");
                        p.Append("text: '模板表单管理',\n");
                        p.Append("icon: 'icon/item3.png',\n");
                        p.Append("func: function () { },\n");
                        p.Append("childItem: [\n");
                        if (t2.Contains(":"))
                        {
                            string[] a = t2.Split(':');
                            for (int i = 0; i < a.Length; i++)
                            {
                                string w = a[i];
                                if (w == "26")
                                {
                                    p.Append("[{id:'1026',text:'模板表单列表',icon:'icon/item0.png',func:function(){runWin('模板表单列表','Flow/Flow_ModelFileList.aspx','d1026'); }}],\n");
                                }
                                if (w == "27")
                                {
                                    p.Append("[{id:'1027',text:'新增模板表单',icon:'icon/add.png',func:function(){runWin('新增模板表单','Flow/Flow_ModelFileManage.aspx','d1027'); }}]\n");
                                }
                            }
                        }
                        else
                        {
                            if (t2 == "26")
                            {
                                p.Append("[{id:'1026',text:'模板表单列表',icon:'icon/item0.png',func:function(){runWin('模板表单列表','Flow/Flow_ModelFileList.aspx','d1026'); }}]\n");
                            }
                            if (t2 == "27")
                            {
                                p.Append("[{id:'1027',text:'新增模板表单',icon:'icon/add.png',func:function(){runWin('新增模板表单','Flow/Flow_ModelFileManage.aspx','d1027'); }}]\n");
                            }
                        }

                        string r = GetValidPower(m, "57|58|28");
                        if (r != "")
                        {
                            p.Append("]\n");
                            p.Append("}],\n\n");
                        }
                        else
                        {
                            p.Append("]\n");
                            p.Append("}]\n\n");
                        }
                    }
                    if (t3 != "")
                    {
                        p.Append("[{\n");
                        p.Append("id: 'flowtype1',\n");
                        p.Append("text: '流程模型分类',\n");
                        p.Append("icon: 'icon/item3.png',\n");
                        p.Append("func: function () { },\n");
                        p.Append("childItem: [\n");
                        if (t3.Contains(":"))
                        {
                            string[] a = t3.Split(':');
                            for (int i = 0; i < a.Length; i++)
                            {
                                string w = a[i];
                                if (w == "58")
                                {
                                    p.Append("[{id:'1058',text:'模型分类列表',icon:'icon/item0.png',func:function(){runWin('模型分类列表','Flow/FlowType_List.aspx','d1058'); }}],\n");
                                }
                                if (w == "57")
                                {
                                    p.Append("[{id:'1057',text:'新增模型分类',icon:'icon/add.png',func:function(){runWin('新增模型分类','Flow/FlowType_Manage.aspx','d1057'); }}]\n");
                                }
                            }
                        }
                        else
                        {
                            if (t3 == "58")
                            {
                                p.Append("[{id:'1058',text:'模型分类列表',icon:'icon/item0.png',func:function(){runWin('模型分类列表','Flow/FlowType_List.aspx','d1058'); }}]\n");
                            }
                            if (t3 == "57")
                            {
                                p.Append("[{id:'1057',text:'新增模型分类',icon:'icon/add.png',func:function(){runWin('新增模型分类','Flow/FlowType_Manage.aspx','d1057'); }}]\n");
                            }
                        }

                        string r = GetValidPower(m, "28");
                        if (r != "")
                        {
                            p.Append("]\n");
                            p.Append("}],\n\n");
                        }
                        else
                        {
                            p.Append("]\n");
                            p.Append("}]\n\n");
                        }
                    }

                    if (GetValidPower(m, "28") == "28")
                    {
                        p.Append("[{id:'1028',text:'所有流程监控',icon:'icon/item0.png',func:function(){runWin('所有流程监控','flow/Flow_ListAll.aspx','d1028'); }}]\n");
                    }

                    p.Append("]\n");
                    p.Append("}],\n\n");
                }

                if (GetValidPower(m, "44|34|35|36|37|59|60|38") != "")
                {
                    p.Append("[{\n");
                    p.Append("id: 'gov1',\n");
                    p.Append("text: '公文管理',\n");
                    p.Append("icon: 'icon/gov.png',\n");
                    p.Append("func: function () { },\n");
                    p.Append("childItem: [\n");

                    string t = GetValidPower(m, "44|34|35|36|37|38|59|60");
                    if (t.Contains("44"))
                    {
                        p.Append("[{id:'1044',text:'发文拟稿',icon:'icon/add.png',func:function(){runWin('发文拟稿','gov/Gov_Manage.aspx','d1044'); }}]\n");
                        string r = GetValidPower(m, "34|35|36|37|38|59|60");
                        if (r != "")
                        {
                            p.Append(",\n");
                        }
                    }

                    string t1 = GetValidPower(m, "34|35");
                    string t2 = GetValidPower(m, "36|37");
                    string t3 = GetValidPower(m, "60|59");

                    if (t1 != "")
                    {
                        p.Append("[{\n");
                        p.Append("id: 'govmodel1',\n");
                        p.Append("text: '公文模型管理',\n");
                        p.Append("icon: 'icon/item3.png',\n");
                        p.Append("func: function () { },\n");
                        p.Append("childItem: [\n");
                        if (t1.Contains(":"))
                        {
                            string[] a = t1.Split(':');
                            for (int i = 0; i < a.Length; i++)
                            {
                                string w = a[i];
                                if (w == "34")
                                {
                                    p.Append("[{id:'1034',text:'公文模型列表',icon:'icon/item0.png',func:function(){runWin('公文模型列表','gov/gov_ModelList.aspx','d1034'); }}],\n");
                                }
                                if (w == "35")
                                {
                                    p.Append("[{id:'1035',text:'新增公文模型',icon:'icon/add.png',func:function(){runWin('新增公文模型','gov/gov_ModelManage.aspx','d1035'); }}]\n");
                                }
                            }
                        }
                        else
                        {
                            if (t1 == "34")
                            {
                                p.Append("[{id:'1034',text:'公文模型列表',icon:'icon/item0.png',func:function(){runWin('公文模型列表','gov/gov_ModelList.aspx','d1034'); }}]\n");
                            }
                            if (t1 == "35")
                            {
                                p.Append("[{id:'1035',text:'新增公文模型',icon:'icon/add.png',func:function(){runWin('新增公文模型','gov/gov_ModelManage.aspx','d1035'); }}]\n");
                            }
                        }

                        string r = GetValidPower(m, "36|37|38|59|60");
                        if (r != "")
                        {
                            p.Append("]\n");
                            p.Append("}],\n\n");
                        }
                        else
                        {
                            p.Append("]\n");
                            p.Append("}]\n\n");
                        }

                    }

                    if (t2 != "")
                    {
                        p.Append("[{\n");
                        p.Append("id: 'govmodel2',\n");
                        p.Append("text: '模板表单管理',\n");
                        p.Append("icon: 'icon/item3.png',\n");
                        p.Append("func: function () { },\n");
                        p.Append("childItem: [\n");
                        if (t2.Contains(":"))
                        {
                            string[] a = t2.Split(':');
                            for (int i = 0; i < a.Length; i++)
                            {
                                string w = a[i];
                                if (w == "36")
                                {
                                    p.Append("[{id:'1036',text:'公文表单列表',icon:'icon/item0.png',func:function(){runWin('公文表单列表','gov/gov_ModelFileList.aspx','d1036'); }}],\n");
                                }
                                if (w == "37")
                                {
                                    p.Append("[{id:'1037',text:'新增公文表单',icon:'icon/add.png',func:function(){runWin('新增公文表单','gov/gov_ModelFileManage.aspx','d1037'); }}]\n");
                                }
                            }
                        }
                        else
                        {
                            if (t2 == "36")
                            {
                                p.Append("[{id:'1036',text:'公文表单列表',icon:'icon/item0.png',func:function(){runWin('公文表单列表','gov/gov_ModelFileList.aspx','d1036'); }}]\n");
                            }
                            if (t2 == "37")
                            {
                                p.Append("[{id:'1037',text:'新增公文表单',icon:'icon/add.png',func:function(){runWin('新增公文表单','gov/gov_ModelFileManage.aspx','d1037'); }}]\n");
                            }
                        }

                        string r = GetValidPower(m, "38|59|60");
                        if (r != "")
                        {
                            p.Append("]\n");
                            p.Append("}],\n\n");
                        }
                        else
                        {
                            p.Append("]\n");
                            p.Append("}]\n\n");
                        }
                    }

                    if (t3 != "")
                    {
                        p.Append("[{\n");
                        p.Append("id: 'govtype1',\n");
                        p.Append("text: '公文模型分类',\n");
                        p.Append("icon: 'icon/item3.png',\n");
                        p.Append("func: function () { },\n");
                        p.Append("childItem: [\n");
                        if (t3.Contains(":"))
                        {
                            string[] a = t3.Split(':');
                            for (int i = 0; i < a.Length; i++)
                            {
                                string w = a[i];
                                if (w == "60")
                                {
                                    p.Append("[{id:'1060',text:'公文分类列表',icon:'icon/item0.png',func:function(){runWin('公文分类列表','Gov/GovType_List.aspx','d1060'); }}],\n");
                                }
                                if (w == "59")
                                {
                                    p.Append("[{id:'1059',text:'新增公文分类',icon:'icon/add.png',func:function(){runWin('新增公文分类','Gov/GovType_Manage.aspx','d1059'); }}]\n");
                                }
                            }
                        }
                        else
                        {
                            if (t3 == "60")
                            {
                                p.Append("[{id:'1060',text:'公文分类列表',icon:'icon/item0.png',func:function(){runWin('公文分类列表','Gov/GovType_List.aspx','d1060'); }}]\n");
                            }
                            if (t3 == "59")
                            {
                                p.Append("[{id:'1059',text:'新增公文分类',icon:'icon/add.png',func:function(){runWin('新增公文分类','Gov/GovType_Manage.aspx','d1059'); }}]\n");
                            }
                        }

                        string r = GetValidPower(m, "38");
                        if (r != "")
                        {
                            p.Append("]\n");
                            p.Append("}],\n\n");
                        }
                        else
                        {
                            p.Append("]\n");
                            p.Append("}]\n\n");
                        }
                    }

                    if (GetValidPower(m, "38") == "38")
                    {
                        p.Append("[{id:'1038',text:'所有公文监控',icon:'icon/item0.png',func:function(){runWin('所有公文监控','gov/gov_ListAll.aspx','d1038'); }}]\n");
                    }

                    p.Append("]\n");
                    p.Append("}],\n\n");

                }

                if (GetValidPower(m, "49|50|51") != "")
                {
                    p.Append("[{\n");
                    p.Append("id: 'work1',\n");
                    p.Append("text: '工作任务管理',\n");
                    p.Append("icon: 'icon/task.png',\n");
                    p.Append("func: function () { },\n");
                    p.Append("childItem: [\n");

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
                                    p.Append("[{id:'1049',text:'工作任务分类',icon:'icon/item0.png',func:function(){runWin('工作任务分类','Tasks/TaskType_List.aspx','d1049'); }}],\n");
                                }
                                if (w == "50")
                                {
                                    p.Append("[{id:'1050',text:'新增任务分类',icon:'icon/add.png',func:function(){runWin('新增任务分类','Tasks/TaskType_Manage.aspx','d1050'); }}],\n");
                                }
                                if (w == "51")
                                {
                                    p.Append("[{id:'1051',text:'所有工作任务',icon:'icon/item0.png',func:function(){runWin('所有工作任务','Tasks/Task_AllList.aspx','d1051'); }}],\n");
                                }
                            }
                            else
                            {
                                if (w == "49")
                                {
                                    p.Append("[{id:'1049',text:'工作任务分类',icon:'icon/item0.png',func:function(){runWin('工作任务分类','Tasks/TaskType_List.aspx','d1049'); }}]\n");
                                }
                                if (w == "50")
                                {
                                    p.Append("[{id:'1050',text:'新增任务分类',icon:'icon/add.png',func:function(){runWin('新增任务分类','Tasks/TaskType_Manage.aspx','d1050'); }}]\n");
                                }
                                if (w == "51")
                                {
                                    p.Append("[{id:'1051',text:'所有工作任务',icon:'icon/item0.png',func:function(){runWin('所有工作任务','Tasks/Task_AllList.aspx','d1051'); }}]\n");
                                }                    
                            }
                        }
                    }
                    else
                    {
                        if (t == "49")
                        {
                            p.Append("[{id:'1049',text:'工作任务分类',icon:'icon/item0.png',func:function(){runWin('工作任务分类','Tasks/TaskType_List.aspx','d1049'); }}]\n");
                        }
                        if (t == "50")
                        {
                            p.Append("[{id:'1050',text:'新增任务分类',icon:'icon/add.png',func:function(){runWin('新增任务分类','Tasks/TaskType_Manage.aspx','d1050'); }}]\n");
                        }
                        if (t == "51")
                        {
                            p.Append("[{id:'1051',text:'所有工作任务',icon:'icon/item0.png',func:function(){runWin('所有工作任务','Tasks/Task_AllList.aspx','d1051'); }}]\n");
                        }
                    }
                    p.Append("]\n");
                    p.Append("}],\n\n");
                }

                if (GetValidPower(m, "63|64|65") != "")
                {
                    p.Append("[{\n");
                    p.Append("id: 'sms1',\n");
                    p.Append("text: '手机短信管理',\n");
                    p.Append("icon: 'icon/sms.png',\n");
                    p.Append("func: function () { },\n");
                    p.Append("childItem: [\n");

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
                                    p.Append("[{id:'1063',text:'短信发送记录',icon:'icon/item0.png',func:function(){runWin('短信发送记录','/Manage/sms/SMS_AllList.aspx','d1063'); }}],\n");
                                }
                                if (w == "64")
                                {
                                    p.Append("[{id:'1064',text:'短信设置',icon:'icon/item0.png',func:function(){runWin('短信设置','/Manage/sms/SMS_SetUp.aspx','d1064'); }}],\n");
                                }
                                if (w == "65")
                                {
                                    p.Append("[{id:'1065',text:'发送手机短信',icon:'icon/add.png',func:function(){runWin('发送手机短信','/Manage/sms/SMS_Send.aspx','d1065'); }}],\n");
                                }
                            }
                            else
                            {
                                if (w == "63")
                                {
                                    p.Append("[{id:'1063',text:'短信发送记录',icon:'icon/item0.png',func:function(){runWin('短信发送记录','/Manage/sms/SMS_AllList.aspx','d1063'); }}]\n");
                                }
                                if (w == "64")
                                {
                                    p.Append("[{id:'1064',text:'短信设置',icon:'icon/item0.png',func:function(){runWin('短信设置','/Manage/sms/SMS_SetUp.aspx','d1064'); }}]\n");
                                }
                                if (w == "65")
                                {
                                    p.Append("[{id:'1065',text:'发送手机短信',icon:'icon/add.png',func:function(){runWin('发送手机短信','/Manage/sms/SMS_Send.aspx','d1065'); }}]\n");
                                }
                            }
                        }
                    }
                    else
                    {
                        if (t == "63")
                        {
                            p.Append("[{id:'1063',text:'短信发送记录',icon:'icon/item0.png',func:function(){runWin('短信发送记录','/Manage/sms/SMS_AllList.aspx','d1063'); }}]\n");
                        }
                        if (t == "64")
                        {
                            p.Append("[{id:'1064',text:'短信设置',icon:'icon/item0.png',func:function(){runWin('短信设置','/Manage/sms/SMS_SetUp.aspx','d1064'); }}]\n");
                        }
                        if (t == "65")
                        {
                            p.Append("[{id:'1065',text:'发送手机短信',icon:'icon/add.png',func:function(){runWin('发送手机短信','/Manage/sms/SMS_Send.aspx','d1065'); }}]\n");
                        }
                    }
                    p.Append("]\n");
                    p.Append("}],\n\n");
                }

                if (GetValidPower(m, "52|53|54|55|56|39|40|45|48") != "")
                {
                    p.Append("[{\n");
                    p.Append("id: 'other1',\n");
                    p.Append("text: '其他功能管理',\n");
                    p.Append("icon: 'icon/other.png',\n");
                    p.Append("func: function () { },\n");
                    p.Append("childItem: [\n");

                    string t1 = GetValidPower(m, "52|55|54|53|56");
                    string t2 = GetValidPower(m, "39|40");
                    
                    if (t1 != "")
                    {
                        p.Append("[{\n");
                        p.Append("id: 'paper1',\n");
                        p.Append("text: '电子档案管理',\n");
                        p.Append("icon: 'icon/item3.png',\n");
                        p.Append("func: function () { },\n");
                        p.Append("childItem: [\n");
                        if (t1.Contains(":"))
                        {
                            string[] a = t1.Split(':');
                            for (int i = 0; i < a.Length; i++)
                            {
                                string w = a[i];
                                if (i != a.Length - 1)
                                {
                                    if (w == "52")
                                    {
                                        p.Append("[{id:'1052',text:'新增电子档案',icon:'icon/add.png',func:function(){runWin('新增电子档案','Paper/PaperManage.aspx','d1052'); }}],\n");
                                    }
                                    if (w == "55")
                                    {
                                        p.Append("[{id:'1055',text:'电子档案分类',icon:'icon/item0.png',func:function(){runWin('电子档案分类','Paper/PaperType_List.aspx','d1055'); }}],\n");
                                    }
                                    if (w == "54")
                                    {
                                        p.Append("[{id:'1054',text:'新增档案分类',icon:'icon/add.png',func:function(){runWin('新增档案分类','Paper/PaperType_Manage.aspx','d1054'); }}],\n");
                                    }
                                    if (w == "53")
                                    {
                                        p.Append("[{id:'1053',text:'所有电子档案',icon:'icon/item0.png',func:function(){runWin('所有电子档案','Paper/PaperAllList.aspx','d1053'); }}],\n");
                                    }
                                    if (w == "56")
                                    {
                                        p.Append("[{id:'1056',text:'档案下载记录',icon:'icon/item0.png',func:function(){runWin('档案下载记录','Paper/DownLoadList.aspx','d1056'); }}],\n");
                                    }
                                }
                                else
                                {
                                    if (w == "52")
                                    {
                                        p.Append("[{id:'1052',text:'新增电子档案',icon:'icon/add.png',func:function(){runWin('新增电子档案','Paper/PaperManage.aspx','d1052'); }}]\n");
                                    }
                                    if (w == "55")
                                    {
                                        p.Append("[{id:'1055',text:'电子档案分类',icon:'icon/item0.png',func:function(){runWin('电子档案分类','Paper/PaperType_List.aspx','d1055'); }}]\n");
                                    }
                                    if (w == "54")
                                    {
                                        p.Append("[{id:'1054',text:'新增档案分类',icon:'icon/add.png',func:function(){runWin('新增档案分类','Paper/PaperType_Manage.aspx','d1054'); }}]\n");
                                    }
                                    if (w == "53")
                                    {
                                        p.Append("[{id:'1053',text:'所有电子档案',icon:'icon/item0.png',func:function(){runWin('所有电子档案','Paper/PaperAllList.aspx','d1053'); }}]\n");
                                    }
                                    if (w == "56")
                                    {
                                        p.Append("[{id:'1056',text:'档案下载记录',icon:'icon/item0.png',func:function(){runWin('档案下载记录','Paper/DownLoadList.aspx','d1056'); }}]\n");
                                    }
                                }
                            }
                        }
                        else
                        {
                            if (t1 == "52")
                            {
                                p.Append("[{id:'1052',text:'新增电子档案',icon:'icon/add.png',func:function(){runWin('新增电子档案','Paper/PaperManage.aspx','d1052'); }}]\n");
                            }
                            if (t1 == "55")
                            {
                                p.Append("[{id:'1055',text:'电子档案分类',icon:'icon/item0.png',func:function(){runWin('电子档案分类','Paper/PaperType_List.aspx','d1055'); }}]\n");
                            }
                            if (t1 == "54")
                            {
                                p.Append("[{id:'1054',text:'新增档案分类',icon:'icon/add.png',func:function(){runWin('新增档案分类','Paper/PaperType_Manage.aspx','d1054'); }}]\n");
                            }
                            if (t1 == "53")
                            {
                                p.Append("[{id:'1053',text:'所有电子档案',icon:'icon/item0.png',func:function(){runWin('所有电子档案','Paper/PaperAllList.aspx','d1053'); }}]\n");
                            }
                            if (t1 == "56")
                            {
                                p.Append("[{id:'1056',text:'档案下载记录',icon:'icon/item0.png',func:function(){runWin('档案下载记录','Paper/DownLoadList.aspx','d1056'); }}]\n");
                            }
                        }

                        string r = GetValidPower(m, "39|40|45|48");
                        if (r != "")
                        {
                            p.Append("]\n");
                            p.Append("}],\n\n");
                        }
                        else
                        {
                            p.Append("]\n");
                            p.Append("}]\n\n");
                        }

                    }

                    if (t2 != "")
                    {
                        p.Append("[{\n");
                        p.Append("id: 'sign1',\n");
                        p.Append("text: '印章签名管理',\n");
                        p.Append("icon: 'icon/item3.png',\n");
                        p.Append("func: function () { },\n");
                        p.Append("childItem: [\n");
                        if (t2.Contains(":"))
                        {
                            string[] a = t2.Split(':');
                            for (int i = 0; i < a.Length; i++)
                            {
                                string w = a[i];
                                if (w == "39")
                                {
                                    p.Append("[{id:'1039',text:'印章签名列表',icon:'icon/item0.png',func:function(){runWin('印章签名列表','Sys/Seal_List.aspx','d1039'); }}],\n");
                                }
                                if (w == "40")
                                {
                                    p.Append("[{id:'1040',text:'新增印章签名',icon:'icon/add.png',func:function(){runWin('新增印章签名','sys/Seal_Manage.aspx','d1040'); }}]\n");
                                }
                            }
                        }
                        else
                        {
                            if (t2 == "39")
                            {
                                p.Append("[{id:'1039',text:'印章签名列表',icon:'icon/item0.png',func:function(){runWin('印章签名列表','Sys/Seal_List.aspx','d1039'); }}]\n");
                            }
                            if (t2 == "40")
                            {
                                p.Append("[{id:'1040',text:'新增印章签名',icon:'icon/add.png',func:function(){runWin('新增印章签名','sys/Seal_Manage.aspx','d1040'); }}]\n");
                            }
                        }

                        string r = GetValidPower(m, "45|48");
                        if (r != "")
                        {
                            p.Append("]\n");
                            p.Append("}],\n\n");
                        }
                        else
                        {
                            p.Append("]\n");
                            p.Append("}]\n\n");
                        }
                    }

                    if (GetValidPower(m, "45") == "45")
                    {
                        if (GetValidPower(m, "48") != "")
                            p.Append("[{id:'1045',text:'投票管理',icon:'icon/item0.png',func:function(){runWin('投票管理','Common/Vote_AllList.aspx','d1045'); }}],\n");
                        else
                            p.Append("[{id:'1045',text:'投票管理',icon:'icon/item0.png',func:function(){runWin('投票管理','Common/Vote_AllList.aspx','d1045'); }}]\n");
                    }

                    if (GetValidPower(m, "48") == "48")
                    {
                        p.Append("[{id:'1048',text:'系统登录记录',icon:'icon/item0.png',func:function(){runWin('系统登录记录','sys/User_LoginList.aspx','d1048'); }}]\n");
                    }

                    p.Append("]\n");
                    p.Append("}],\n\n");
                }

                p.Append("[{id:'pslogin1',text:'个人登录记录',icon:'icon/login.png',func:function(){runWin('个人登录记录','Common/User_LoginList.aspx','pslogin2');} }],\n[{id:'logout1',text:'安全退出',icon:'icon/out.png',func:function(){logout(); } }] ]);\n");

            }

            return p.ToString();
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
