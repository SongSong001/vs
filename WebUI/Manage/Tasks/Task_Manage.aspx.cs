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
using WC.BLL;
using WC.Model;
using WC.DBUtility;
using WC.Tool;
using System.IO;

namespace WC.WebUI.Manage.Tasks
{
    public partial class Task_Manage : WC.BLL.ViewPages
    {
        private int i = 1; //深度从1 开始
        private IList<Tasks_TypeInfo> li = new List<Tasks_TypeInfo>();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Show();
            }
        }

        private void Show()
        {
            SqlParameter rid = new SqlParameter();
            rid.ParameterName = "@uid";
            rid.Size = 50;
            rid.Value = Uid;

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


            SqlParameter[] sqls = { sqlpt0, sqlpt1, sqlpt2, sqlpt3, rid };
            MsSqlOperate.ExecuteNonQuery(CommandType.StoredProcedure, "Tasks_GetTaskCount", sqls);

            t_all.InnerText = sqlpt0.Value + "";
            t_exeute.InnerText = sqlpt1.Value + "";
            t_manage.InnerText = sqlpt2.Value + "";
            t_create.InnerText = sqlpt3.Value + "";

            GetFirtNode();
            TypeID.DataSource = li;
            TypeID.DataTextField = "Sh";
            TypeID.DataValueField = "ID";
            TypeID.DataBind();

            if (!string.IsNullOrEmpty(Request.QueryString["tid"]))
            {
                user_manager.Disabled = true;
                user_exec.Disabled = true;

                TasksInfo ti = WC.BLL.Tasks.Init().GetById(Convert.ToInt32(Request.QueryString["tid"]));

                if (ti.ManageUserList.Contains("#"+Uid+"#"))
                {
                    ViewState["ti"] = ti;
                    TaskName.Value = ti.TaskName;
                    TypeID.SelectedValue = ti.TypeID + "";
                    userlist.Value = ti.ManageUserList;
                    namelist.Value = ti.ManageNameList;
                    userlist_cc.Value = ti.ExecuteUserList;
                    namelist_cc.Value = ti.ExecuteNameList;
                    Bodys.Value = ti.Notes;
                    ExpectTime.Value = ti.ExpectTime;
                    Important.Value = ti.Important;
                    IsOtherSee.Checked = Convert.ToBoolean(ti.IsOtherSee);
                    OnceSubmit.Checked = Convert.ToBoolean(ti.OnceSubmit);

                    if (!string.IsNullOrEmpty(ti.FilePath))
                    {
                        if (ti.FilePath.Contains("|"))
                        {
                            Attachword.Visible = true;
                            List<TmpInfo> list = new List<TmpInfo>();
                            string[] array = ti.FilePath.Split('|');
                            for (int i = 0; i < array.Length; i++)
                            {
                                if (array[i].Trim() != "")
                                {
                                    TmpInfo tis = new TmpInfo();
                                    int t = array[i].LastIndexOf('/') + 1;
                                    string filename = array[i].Substring(t, array[i].Length - t);
                                    string fileurl = array[i].ToString();
                                    tis.Tmp1 = array[i];
                                    tis.Tmp2 = filename;
                                    tis.Tmp3 = fileurl;
                                    list.Add(tis);
                                }
                            }
                            rpt.DataSource = list;
                            rpt.DataBind();
                        }
                    }
                }

            }
        }

        protected void Save_Btn(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(Request.QueryString["tid"]))
            {
                TasksInfo ti = new TasksInfo();
                ti.TaskName = TaskName.Value;
                ti.TypeID = Convert.ToInt32(Request.Form["TypeID"]);
                ti.TypeName = ClearLeaf(TypeID.Items[TypeID.SelectedIndex].Text);
                ti.Important = Request.Form["Important"];
                ti.Status = 1;
                ti.IsOtherSee = Convert.ToInt32(IsOtherSee.Checked);
                ti.OnceSubmit = Convert.ToInt32(OnceSubmit.Checked);

                ti.CreatorID = Convert.ToInt32(Uid);
                ti.CreatorRealName = RealName;
                ti.CreatorDepName = DepName;

                ti.AddTime = DateTime.Now.ToString("yyyy-MM-dd");
                ti.UpdateTime = DateTime.Now.ToString("yy-M-dd HH:mm");
                ti.ExpectTime = ExpectTime.Value;
                ti.Notes = Bodys.Value;
                ti.FilePath = UpdateFiles();
                ti.Records += "<font color='#006600'>[创建人]</font> <strong>" + RealName + "(" + DepName + ")</strong> 在 "
                    + WC.Tool.Utils.ConvertDate3(DateTime.Now)
                    + " <strong style='color:#ff0000'>创建了任务</strong> <br><br>";

                ti.ManageUserList = userlist.Value;
                ti.ManageNameList = namelist.Value;
                ti.ExecuteUserList = userlist_cc.Value;
                ti.ExecuteNameList = namelist_cc.Value;

                WC.BLL.Tasks.Init().Add(ti);
                
                SendManageMail(true, ti.ManageUserList, ti.ManageUserList, ti);
                AddTasksUser(ti.ExecuteUserList, ti.id,ti);

                string words = HttpContext.Current.Server.HtmlEncode("您好!工作任务已新建成功!");
                Response.Redirect("/InfoTip/Operate_Success.aspx?returnpage="
                + Request.Url.AbsoluteUri + "&tip=" + words);
            }
            else
            {
                TasksInfo ti = ViewState["ti"] as TasksInfo;

                if (ti.ManageUserList.Contains("#" + Uid + "#"))
                {
                    ti.TaskName = TaskName.Value;
                    ti.TypeID = Convert.ToInt32(TypeID.SelectedValue);
                    ti.TypeName = ClearLeaf(TypeID.Items[TypeID.SelectedIndex].Text);
                    ti.Important = Request.Form["Important"];
                    ti.Status = 1;
                    ti.IsOtherSee = Convert.ToInt32(IsOtherSee.Checked);
                    ti.OnceSubmit = Convert.ToInt32(OnceSubmit.Checked);

                    ti.UpdateTime = DateTime.Now.ToString("yy-M-dd HH:mm");
                    ti.ExpectTime = ExpectTime.Value;
                    ti.Notes = Bodys.Value;
                    ti.FilePath = UpdateFiles();
                    ti.Records += "<font color='#006600'>[管理者]</font> <strong>" + RealName + "(" + DepName + ")</strong> 在 "
                        + WC.Tool.Utils.ConvertDate3(DateTime.Now)
                        + " <strong style='color:#ff0000'>重新编辑了任务</strong> <br><br>";

                    string old = ti.ExecuteUserList;
                    string old1 = ti.ManageUserList;

                    ti.ManageUserList = userlist.Value;
                    ti.ManageNameList = namelist.Value;
                    ti.ExecuteUserList = userlist_cc.Value;
                    ti.ExecuteNameList = namelist_cc.Value;

                    WC.BLL.Tasks.Init().Update(ti);

                    SendManageMail(false, old1, ti.ManageUserList, ti);
                    UpdateTasksUser(old, userlist_cc.Value, ti);

                    string words = HttpContext.Current.Server.HtmlEncode("您好!工作任务已重新编辑!");
                    Response.Redirect("/InfoTip/Operate_Success.aspx?returnpage="
                    + Request.Url.AbsoluteUri + "&tip=" + words);
                }
            }

        }

        private void AddTasksUser(string ulist,int tid,TasksInfo tk)
        {
            if (ulist.Contains(","))
            {
                string[] arr = ulist.Split(',');
                for (int i = 0, len = arr.Length; i < len; i++)
                {
                    if (arr[i].Contains("#"))
                    {
                        Tasks_UserInfo tui = new Tasks_UserInfo();
                        tui.TaskID = tid;
                        tui.RealName = arr[i].Split('#')[0];
                        tui.UserID = Convert.ToInt32(arr[i].Split('#')[1]);
                        tui.DepName = arr[i].Split('#')[2];
                        tui.AddTime = "";
                        tui.WorkTag = -1;
                        tui.Instruction = "";
                        Tasks_User.Init().Add(tui);

                        string title = "[系统通知] : " + tui.RealName + ", 您好! 您有新工作任务需要执行!";
                        string content = "任务名称：<strong>" + tk.TaskName + "</strong><br>任务分类：" + tk.TypeName + " <br>任务级别：" + tk.Important + "<br>任务管理者：" + tk.ManageNameList + "<br>";
                        int rid = tui.UserID;
                        string uclist = tui.RealName + "#" + tui.id + "#" + tui.DepName + ",";
                        string nclist = tui.RealName + "(" + tui.DepName + "),";
                        WC.WebUI.Dk.Help.AdminSendMail(title, content, rid, uclist, nclist);

                    }
                }
            }
        }

        private void SendManageMail(bool isadd,string old_str, string new_str, TasksInfo tk)
        {
            if (isadd)
            {
                if (old_str.Contains(","))
                { 
                    string[] arr = old_str.Split(',');
                    for (int i = 0, len = arr.Length; i < len; i++)
                    {
                        if (arr[i].Contains("#"))
                        {
                            string title = "[系统通知] : " + arr[i].Split('#')[0] + ", 您好! 您有新工作任务需要管理!";
                            string content = "任务名称：<strong>" + tk.TaskName + "</strong><br>任务分类：" + tk.TypeName + " <br>任务级别：" + tk.Important + "<br>任务管理者：" + tk.ManageNameList + "<br>";
                            int rid = Convert.ToInt32(arr[i].Split('#')[1]);
                            string uclist = arr[i].Split('#')[0] + "#" + arr[i].Split('#')[1] + "#" + arr[i].Split('#')[2] + ",";
                            string nclist = arr[i].Split('#')[0] + "(" + arr[i].Split('#')[2] + "),";
                            WC.WebUI.Dk.Help.AdminSendMail(title, content, rid, uclist, nclist);
                        }
                    }
                }
            }
            else
            {
                List<string> list_old = new List<string>(); List<string> list_new = new List<string>();
                List<string> list_more = new List<string>();
                if (old_str.Contains(","))
                {
                    string[] arr = old_str.Split(',');
                    for (int i = 0, len = arr.Length; i < len; i++)
                    {
                        if (arr[i].Contains("#"))
                            list_old.Add(arr[i]);
                    }
                }
                if (new_str.Contains(","))
                {
                    string[] arr = new_str.Split(',');
                    for (int i = 0, len = arr.Length; i < len; i++)
                    {
                        if (arr[i].Contains("#"))
                            list_new.Add(arr[i]);
                    }
                }
                string od = string.Join("!", list_old.ToArray());
                string nw = string.Join("!", list_new.ToArray());
                string[] b = list_new.ToArray();
                for (int i = 0; i < b.Length; i++)
                {
                    if (od.IndexOf(b[i]) == -1)
                        list_more.Add(b[i]);
                }
                foreach (string s in list_more)
                {
                    if (s.Contains("#"))
                    {
                        string title = "[系统通知] : " + s.Split('#')[0] + ", 您好! 您有新工作任务需要管理!";
                        string content = "任务名称：<strong>" + tk.TaskName + "</strong><br>任务分类：" + tk.TypeName + " <br>任务级别：" + tk.Important + "<br>任务管理者：" + tk.ManageNameList + "<br>";
                        int rid = Convert.ToInt32(s.Split('#')[1]);
                        string uclist = s.Split('#')[0] + "#" + s.Split('#')[1] + "#" + s.Split('#')[2] + ",";
                        string nclist = s.Split('#')[0] + "(" + s.Split('#')[2] + "),";
                        WC.WebUI.Dk.Help.AdminSendMail(title, content, rid, uclist, nclist);
                    }
                }
            }
        }

        private void UpdateTasksUser(string old_str, string new_str, TasksInfo tk)
        {
            List<string> list_old = new List<string>(); List<string> list_new = new List<string>();
            List<string> list_more = new List<string>(); List<string> list_less = new List<string>();
            if (old_str.Contains(","))
            {
                string[] arr = old_str.Split(',');
                for (int i = 0, len = arr.Length; i < len; i++)
                {
                    if (arr[i].Contains("#"))
                        list_old.Add(arr[i]);
                }
            }
            if (new_str.Contains(","))
            {
                string[] arr = new_str.Split(',');
                for (int i = 0, len = arr.Length; i < len; i++)
                {
                    if (arr[i].Contains("#"))
                        list_new.Add(arr[i]);
                }
            }
            string od = string.Join("!", list_old.ToArray());
            string nw = string.Join("!", list_new.ToArray());
            string[] a = list_old.ToArray(), b = list_new.ToArray();
            for (int i = 0; i < a.Length; i++)
            {
                if (nw.IndexOf(a[i]) == -1)
                    list_less.Add(a[i]);
            }
            for (int i = 0; i < b.Length; i++)
            {
                if (od.IndexOf(b[i]) == -1)
                    list_more.Add(b[i]);
            }

            foreach (string s in list_more)
            {
                if (s.Contains("#"))
                {
                    Tasks_UserInfo tui = new Tasks_UserInfo();
                    tui.TaskID = tk.id;
                    tui.RealName = s.Split('#')[0];
                    tui.UserID = Convert.ToInt32(s.Split('#')[1]);
                    tui.DepName = s.Split('#')[2];
                    tui.AddTime = "";
                    tui.WorkTag = -1;
                    tui.Instruction = "";
                    Tasks_User.Init().Add(tui);

                    string title = "[系统通知] : " + tui.RealName + ", 您好! 您有新工作任务需要执行!";
                    string content = "任务名称：<strong>" + tk.TaskName + "</strong><br>任务分类：" + tk.TypeName + " <br>任务级别：" + tk.Important + "<br>任务管理者：" + tk.ManageNameList + "<br>";
                    int rid = tui.UserID;
                    string uclist = tui.RealName + "#" + tui.id + "#" + tui.DepName + ",";
                    string nclist = tui.RealName + "(" + tui.DepName + "),";
                    WC.WebUI.Dk.Help.AdminSendMail(title, content, rid, uclist, nclist);
                }
            }

            foreach (string s in list_less)
            {
                if (s.Contains("#"))
                {
                    IList tmp_list = Tasks_User.Init().GetAll("UserID=" + s.Split('#')[1], null);

                    foreach (object j in tmp_list)
                    {
                        Tasks_UserInfo tui = j as Tasks_UserInfo;
                        try
                        {
                            Dk.Help.DeleteFiles(tui.FilePath);
                        }
                        catch { }
                        Tasks_User.Init().Delete(tui.id);
                    }
                }
            }
        }

        //上传所有附件,并返回 文件保存位置字符串集合
        private string UpdateFiles()
        {
            string fnames = "";
            System.Web.HttpFileCollection files = System.Web.HttpContext.Current.Request.Files;

            //得到或创建 上传目录
            string timeFolder = DateTime.Now.ToString("yyMMdd");
            string path = Server.MapPath("~/Files/OfficeFiles/");
            string tmp = "~/Files/OfficeFiles/" + timeFolder + "/";
            path += timeFolder;
            if (!Directory.Exists(path))
            {
                WC.Tool.FileSystemManager.CreateFolder(timeFolder, Server.MapPath("~/Files/OfficeFiles"));
            }

            try
            {
                string old = "";
                if (Attachword.Visible == true)
                {
                    foreach (RepeaterItem item in rpt.Items)
                    {
                        HtmlInputCheckBox hick = item.FindControl("chk") as HtmlInputCheckBox;
                        if (hick.Checked)
                        {
                            old += hick.Value + "|";
                        }
                    }
                }

                for (int i = 0; i < files.Count; i++)
                {
                    System.Web.HttpPostedFile f = files[i];
                    if (WC.Tool.Config.IsValidFile(f))
                    {
                        string fileName = Path.GetFileName(f.FileName);
                        string name = tmp + fileName;
                        string doc = path + "\\" + fileName;
                        if (File.Exists(doc))
                        {
                            string rd = DateTime.Now.ToString("HHmmssfff") + WC.Tool.Utils.CreateRandomStr(3) + Uid + i;
                            doc = path + "\\" + rd + "@" + WC.Tool.Utils.GetFileExtension(fileName);
                            name = tmp + rd + "@" + WC.Tool.Utils.GetFileExtension(fileName);
                        }

                        f.SaveAs(doc);
                        fnames += name + "|";
                    }
                }
                fnames = old + fnames;

            }
            catch (IOException ex)
            {
                throw ex;
            }

            return fnames;
        }

        private string ClearLeaf(string text)
        {
            string[] array = { "　", "└", "├", "│", "└" };
            for (int i = 0; i < array.Length; i++)
            {
                if (text.Contains(array[i]))
                    text = text.Replace(array[i], "");
            }
            return text.Trim();
        }

        #region 创建树形目录
        //创建头节点
        private void GetFirtNode()
        {
            DataSet ds = WC.DBUtility.MsSqlOperate.ExecuteDataset(CommandType.Text, "select * from Tasks_Type", null);

            ds.Relations.Add("sort", ds.Tables[0].Columns["id"], ds.Tables[0].Columns["ParentID"], false); //建立父子列之间关系

            foreach (DataRow dbRow in ds.Tables[0].Rows)
            {
                //1级目录没有排序，如果你愿意 可以排序。
                if (dbRow["ParentID"].ToString() == "0") //头节点 父ID为 0
                {
                    Tasks_TypeInfo cl = SetPram(dbRow); //将dbrow赋给对象
                    cl.Ch = "";
                    cl.Sh = cl.TypeName; //第一行只显示FolderName
                    li.Add(cl); //头节点第一个入list

                    PopulateSubTree(dbRow, i); //从头节点开始递归查找子树
                }
            }
        }

        //递归遍历子树 排序并放入list
        private void PopulateSubTree(DataRow dbRow, int depth)
        {
            ++depth; //树深度
            DataRow[] dr = dbRow.GetChildRows("sort"); //获取子树数组

            #region 选择排序 按照Px
            int k; // 存放最小FolderOrder的 下标
            int j; //遍历数组次数
            object tmp; //临时交换的DataRow
            for (int i = 0; i < dr.Length - 1; i++)
            {
                for (k = i, j = i + 1; j < dr.Length; j++) // 找出最小FolderOrder的 下标
                {
                    if (Convert.ToInt32(dr[k]["Orders"]) > Convert.ToInt32(dr[j]["Orders"]))
                    {
                        k = j;
                    }
                }
                if (k != i) //交换位置
                {
                    tmp = dr[i];
                    dr[i] = dr[k];
                    dr[k] = (DataRow)tmp;
                }
            }
            #endregion

            //对数组中已排序的 每一节点进行操作
            foreach (DataRow item in dr)
            {
                Tasks_TypeInfo cl = SetPram(item);
                if (depth == 2)
                {
                    if (ReferenceEquals(item, dr[dr.Length - 1]))
                    {
                        cl.Ch = "　└ ";
                    }
                    else cl.Ch = "　├ ";
                }
                else if (depth > 2)
                {
                    if (ReferenceEquals(item, dr[dr.Length - 1]))
                    {
                        for (int n = 1; n < depth - 1; n++)
                        {
                            cl.Ch = "　│" + cl.Ch;
                        }
                        cl.Ch += "　└ ";
                    }
                    else
                    {
                        for (int n = 1; n < depth - 1; n++)
                        {
                            cl.Ch = "　│" + cl.Ch;
                        }
                        cl.Ch += "　├ ";
                    }
                }
                cl.Sh = cl.Ch + cl.TypeName;
                li.Add(cl); //子节点入list
                PopulateSubTree(item, depth); //递归操作子树
            }
        }

        private Tasks_TypeInfo SetPram(DataRow dbRow)
        {
            Tasks_TypeInfo biz = new Tasks_TypeInfo();
            biz.id = Convert.ToInt32(dbRow["id"]);
            biz.TypeName = Convert.ToString(dbRow["TypeName"]);
            biz.ParentID = Convert.ToInt32(dbRow["ParentID"]);
            biz.Orders = Convert.ToInt32(dbRow["Orders"]);
            return biz;
        }

        #endregion

    }
}