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

using WC.DBUtility;
using WC.BLL;
using WC.Model;
using WC.Tool;

namespace WC.WebUI.Manage.Tasks
{
    public partial class Task_AllList : WC.BLL.ModulePages
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

        protected void Search_Btn(object sender, EventArgs e)
        {
            string TypeID = HttpContext.Current.Server.HtmlEncode(Request.Form["TypeID"].Trim());
            string TaskName = HttpContext.Current.Server.HtmlEncode(Request.Form["TaskName"].Trim());
            string StartTime = HttpContext.Current.Server.HtmlEncode(Request.Form["StartTime"].Trim());
            string State = HttpContext.Current.Server.HtmlEncode(Request.Form["state"].Trim());
            string EndTime = HttpContext.Current.Server.HtmlEncode(Request.Form["EndTime"].Trim());

            string url = "?TypeID=" + TypeID + "&TaskName=" + TaskName + "&State=" + State
                + "&StartTime=" + StartTime + "&EndTime=" + EndTime;
            Response.Redirect("Task_AllList.aspx" + url);
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
            Show();
        }

        private void Show()
        {
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

                list = WC.BLL.Tasks.Init().GetAll(sql, "order by id desc");
            }
            else
            {
                string sql = " 1=1 ";

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
                this.Page1.sty("meneame", pagecount, pds.PageCount, "?page=");

            if (Request.QueryString["TaskName"] != null)
            {
                this.Page1.sty("meneame", pagecount, pds.PageCount, "?TaskName=" + Request.QueryString["TaskName"]
                    + "&TypeID=" + Request.QueryString["TypeID"]
                    + "&StartTime=" + Request.QueryString["StartTime"]
                    + "&EndTime=" + Request.QueryString["EndTime"]
                    + "&State=" + Request.QueryString["State"]
                    + "&page=");
            }

            num.InnerHtml = "当前查询条件总计 - <span style='color:#ff0000; font-weight:bold;'>" + list.Count + "</span> 条 记录数据";

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