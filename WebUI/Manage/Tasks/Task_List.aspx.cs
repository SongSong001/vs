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

using WC.DBUtility;
using WC.BLL;
using WC.Model;
using WC.Tool;

namespace WC.WebUI.Manage.Tasks
{
    public partial class Task_List : WC.BLL.ViewPages
    {
        private int i = 1; //深度从1 开始
        private IList<Tasks_TypeInfo> li = new List<Tasks_TypeInfo>();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && !string.IsNullOrEmpty(Request.QueryString["type"]))
            {
                string t = Request.QueryString["type"];
                if (t == "all" || t == "exeute" || t == "manage" || t == "create")
                    Show(t);
            }
        }

        protected void Search_Btn(object sender, EventArgs e)
        {
            string TypeID = HttpContext.Current.Server.HtmlEncode(Request.Form["TypeID"].Trim());
            string TaskName = HttpContext.Current.Server.HtmlEncode(Request.Form["TaskName"].Trim());
            string StartTime = HttpContext.Current.Server.HtmlEncode(Request.Form["StartTime"].Trim());
            string State = HttpContext.Current.Server.HtmlEncode(Request.Form["state"].Trim());
            string EndTime = HttpContext.Current.Server.HtmlEncode(Request.Form["EndTime"].Trim());

            string url = "?TypeID=" + TypeID + "&TaskName=" + TaskName + "&State=" + State
                + "&StartTime=" + StartTime + "&EndTime=" + EndTime + "&type=" + Request.QueryString["type"];
            Response.Redirect("Task_List.aspx" + url);
        }

        protected void Del_Btn(object obj, EventArgs e)
        {
            LinkButton lb = obj as LinkButton;
            RepeaterItem ri = lb.Parent as RepeaterItem;
            HtmlInputCheckBox hick = ri.FindControl("chk") as HtmlInputCheckBox;
            int rid = Convert.ToInt32(hick.Value);
            TasksInfo ni = WC.BLL.Tasks.Init().GetById(rid);

            IList list = WC.BLL.Tasks_User.Init().GetAll("TaskID=" + ni.id, null);
            if (list.Count > 0)
            {
                for (int i = 0, len = list.Count; i < len; i++)
                {
                    Tasks_UserInfo tui = list[i] as Tasks_UserInfo;
                    try
                    {
                        Dk.Help.DeleteFiles(tui.FilePath);
                    }
                    catch { }
                }
                string sql = "delete from Tasks_User where TaskID=" + ni.id;
                MsSqlOperate.ExecuteNonQuery(CommandType.Text, sql);
            }

            try
            {
                Dk.Help.DeleteFiles(ni.FilePath);
            }
            catch { }
            WC.BLL.Tasks.Init().Delete(rid);
            Show(Request.QueryString["type"]);
        }

        private void Show(string tp)
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

            IList list = null;

            if (!string.IsNullOrEmpty(Request.QueryString["TypeID"]) || !string.IsNullOrEmpty(Request.QueryString["TaskName"])
                || !string.IsNullOrEmpty(Request.QueryString["State"])
                || !string.IsNullOrEmpty(Request.QueryString["StartTime"])
                || !string.IsNullOrEmpty(Request.QueryString["EndTime"]))
            {
                string TypeID1 = Request.QueryString["TypeID"];
                string TaskName1 = Request.QueryString["TaskName"];
                string st = Request.QueryString["StartTime"];
                string et = Request.QueryString["EndTime"];
                string state = Request.QueryString["State"];

                string sql = " 1=1 ";

                if (!string.IsNullOrEmpty(TypeID1))
                { sql += " and (TypeID=" + TypeID1 + ") "; }

                if (!string.IsNullOrEmpty(state))
                { sql += " and (Status=" + state + ") "; }

                if (!string.IsNullOrEmpty(TaskName1))
                { sql += " and (TaskName like '%" + TaskName1 + "%') "; }

                if (!string.IsNullOrEmpty(st) && !string.IsNullOrEmpty(et))
                    sql += " and (AddTime between '" + st + "' and '" + et + "') ";

                if (tp == "all")
                {
                    sql += " and ( ManageUserList like '%#" + Uid + "#%' or ExecuteUserList like '%#" + Uid + "#%' )";
                }
                if (tp == "exeute")
                {
                    sql += " and ( ExecuteUserList like '%#" + Uid + "#%' )";
                }
                if (tp == "manage")
                {
                    sql += " and ( ManageUserList like '%#" + Uid + "#%' )";
                }
                if (tp == "create")
                {
                    sql += " and ( CreatorID=" + Uid + " )";
                }

                list = WC.BLL.Tasks.Init().GetAll(sql, "order by id desc");
            }
            else
            {
                string sql = " 1=1 and ";
                if (tp == "all")
                {
                    if (!string.IsNullOrEmpty(Request.QueryString["td"]))
                    {
                        if (WC.Tool.Utils.IsNumber(Request.QueryString["td"]))
                        {
                            sql += " ( TypeID=" + Request.QueryString["td"]
                                + " ) and ( ManageUserList like '%#" + Uid + "#%' or ExecuteUserList like '%#" + Uid + "#%' )";
                        }
                    }
                    else
                        sql += " ( ManageUserList like '%#" + Uid + "#%' or ExecuteUserList like '%#" + Uid + "#%' )";
                }
                if (tp == "exeute")
                    sql += " ( ExecuteUserList like '%#" + Uid + "#%' )";
                if (tp == "manage")
                    sql += " ( ManageUserList like '%#" + Uid + "#%' )";
                if (tp == "create")
                    sql += " ( CreatorID=" + Uid + " )";

                list = WC.BLL.Tasks.Init().GetAll(sql, "order by id desc");
            }

            //根据分页配置文件 获取权限分页设置
            Hashtable page_ht = (Hashtable)HttpContext.Current.Application["config_fenye"];
            //每页显示数
            int page_nums = Convert.ToInt32(page_ht["fenye_commom"]);

            int pagecount = 0;
            try
            {
                if (!string.IsNullOrEmpty(Request.QueryString["page"]))
                    pagecount = Convert.ToInt32(Request.QueryString["page"]);
            }
            catch { }
            if (pagecount == 0)
            {
                pagecount = 1;
            }
            PagedDataSource pds = new PagedDataSource();

            pds.DataSource = list;
            pds.AllowPaging = true;
            pds.PageSize = page_nums;
            pds.CurrentPageIndex = pagecount - 1;
            rpt.DataSource = pds;
            rpt.DataBind();

            if (Request.QueryString["TaskName"] == null)
                this.Page1.sty("meneame", pagecount, pds.PageCount, "?type=" + tp + "&page=");

            if (Request.QueryString["TaskName"] != null)
            {
                this.Page1.sty("meneame", pagecount, pds.PageCount, "?TaskName=" + Request.QueryString["TaskName"]
                    + "&TypeID=" + Request.QueryString["TypeID"]
                    + "&StartTime=" + Request.QueryString["StartTime"]
                    + "&EndTime=" + Request.QueryString["EndTime"]
                    + "&State=" + Request.QueryString["State"]
                    + "&type=" + tp
                    + "&page=");
            }

            num.InnerHtml = "当前查询条件总计 - <span style='color:#ff0000; font-weight:bold;'>" + list.Count + "</span> 条 记录数据";

        }

        protected void RowDataBind(object sender, RepeaterItemEventArgs e)
        {
            LinkButton lb1 = e.Item.FindControl("b1") as LinkButton;
            LinkButton lb2 = e.Item.FindControl("b2") as LinkButton;

            if (lb1.CommandArgument.Contains("*" + Uid + "*"))
                lb1.Visible = true;
            else lb1.Visible = false;

            if (lb2.CommandArgument.Contains("*" + Uid + "*"))
                lb2.Visible = true;
            else lb2.Visible = false;
        }

        protected void Edit_Btn(object sender, EventArgs e)
        {
            LinkButton lb = sender as LinkButton;
            RepeaterItem ri = lb.Parent as RepeaterItem;
            HtmlInputCheckBox hick = ri.FindControl("chk") as HtmlInputCheckBox;
            int rid = Convert.ToInt32(hick.Value);
            Response.Redirect("Task_Manage.aspx?tid=" + rid);
        }

        protected string GetManageUserList(object obj)
        {
            string ulist = obj + "", t = "";
            if (ulist.Contains(","))
            {
                string[] arr = ulist.Split(',');
                for (int i = 0, len = arr.Length; i < len; i++)
                {
                    if (arr[i].Contains("#"))
                        t += "*" + arr[i].Split('#')[1] + "*";
                }
            }
            return t;
        }

        protected string GetStatus(object obj)
        {
            string r = "";
            switch (obj + "")
            {
                case "-1": r = "<strong style='color:#000'>已停止</strong>"; break;
                case "1": r = "<strong style='color:#ff0000'>进行中</strong>"; break;
                case "2": r = "<strong style='color:#006600'>已完成</strong>"; break;
                default: r = ""; break;
            }
            return r;
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