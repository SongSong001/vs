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
using WC.DBUtility;

namespace WC.WebUI.Manage.Utils
{
    public partial class SelectPeople_cc : WC.BLL.ViewPages
    {
        private int i = 1; //深度从1 开始
        private IList<Sys_DepInfo> li = new List<Sys_DepInfo>();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                InitData();
                Show();
            }
        }

        private void InitData()
        {
            GetFirtNode();
            DepTree.DataSource = li;
            DepTree.DataTextField = "Sh";
            DepTree.DataValueField = "ID";
            DepTree.DataBind();
            DepTree.SelectedValue = "" + DepID;
        }

        protected void SelectDep(object sender, EventArgs e)
        {
            DropDownList ddl = sender as DropDownList;
            string did = ddl.SelectedValue;
            List<Sys_UserInfo> list = new List<Sys_UserInfo>();
            GetTreeItems(Convert.ToInt32(did), list);
            rpt.DataSource = list;
            rpt.DataBind();

            //int n = 0;
            //if (!string.IsNullOrEmpty(Request.QueryString["v"]))
            //{
            //    string[] array = Request.QueryString["v"].Split(';');
            //    List<string> listr = new List<string>();
            //    for (int i = 0; i < array.Length; i++)
            //    {
            //        if (array[i].Trim() != "")
            //            listr.Add(array[i]);
            //    }
            //    foreach (RepeaterItem ri in rpt.Items)
            //    {
            //        HtmlInputCheckBox hick = ri.FindControl("chk") as HtmlInputCheckBox;
            //        if (listr.Contains(hick.Value.Split('#')[1]))
            //        {
            //            hick.Checked = true;
            //            n++;
            //        }
            //    }
            //}
            //number.InnerText = n + "";
            total.InnerText = list.Count + "";
        }

        protected void Search_Btn(object sender, EventArgs e)
        {
            string keywords = Request.Form["keyword"];
            string url = "?keywords=" + HttpContext.Current.Server.HtmlEncode(keywords.Trim());
            if (!string.IsNullOrEmpty(Request.QueryString["v"]))
                url += "&v=" + Request.QueryString["v"];
            Response.Redirect("SelectPeople_cc.aspx" + url);
        }

        //protected void Sel_btn(object sender, EventArgs e)
        //{
        //    int n = 0;
        //    LinkButton lb = sender as LinkButton;
        //    string did = lb.CommandArgument;
        //    foreach (RepeaterItem item in rpt.Items)
        //    {
        //        LinkButton tmp = item.FindControl("cc") as LinkButton;
        //        HtmlInputCheckBox hic = item.FindControl("chk") as HtmlInputCheckBox;
        //        if (tmp.CommandArgument == did)
        //        {
        //            hic.Checked = true;
        //        }
        //        if (hic.Checked == true)
        //            n++;
        //    }
        //    number.InnerText = n + "";
        //}

        private void Show()
        {
            IList alllist = Sys_User.Init().GetAll("Status=0 and IsLock=0 ", "order by orders asc");
            allcount.Value = alllist.Count + "";
            alluserlist.Value = "";
            allnamelist.Value = "";
            foreach (object obj in alllist)
            {
                Sys_UserInfo su = obj as Sys_UserInfo;
                alluserlist.Value += su.RealName + "#" + su.id + "#" + su.DepName + ",";
                allnamelist.Value += su.RealName + "(" + su.DepName + "),";
            }

            IList list = Sys_User.Init().GetAll("Status=0 and IsLock=0 and depid=" + DepID, "order by orders asc");
            string tmp = "Status=0 and IsLock=0 and ";

            string keywords = Request.QueryString["keywords"];
            if (!string.IsNullOrEmpty(keywords)
                && WC.Tool.Utils.CheckSql(keywords))
            {
                tmp += " (UserName like '%" + keywords + "%' or RealName like '%" + keywords
                + "%' or DepName like '%" + keywords + "%' ) ";
                list = Sys_User.Init().GetAll(tmp, "order by depid,orders asc");
            }
            if (!string.IsNullOrEmpty(Request.QueryString["did"]))
            {
                list = new List<Sys_UserInfo>();
                GetTreeItems(Convert.ToInt32(Request.QueryString["did"]), list);
            }

            rpt.DataSource = list;
            rpt.DataBind();


            //int n = 0;
            //if (!string.IsNullOrEmpty(Request.QueryString["v"]))
            //{
            //    string[] array = Request.QueryString["v"].Split(';');
            //    List<string> listr = new List<string>();
            //    for (int i = 0; i < array.Length; i++)
            //    {
            //        if (array[i].Trim() != "")
            //            listr.Add(array[i]);
            //    }
            //    foreach (RepeaterItem ri in rpt.Items)
            //    {
            //        HtmlInputCheckBox hick = ri.FindControl("chk") as HtmlInputCheckBox;
            //        if (listr.Contains(hick.Value.Split('#')[1]))
            //        {
            //            hick.Checked = true;
            //            n++;
            //        }
            //    }
            //}
            //number.InnerText = n + "";
            total.InnerText = list.Count + "";
        }


        private void GetTreeItems(int did, IList li)
        {
            IList list = Sys_User.Init().GetAll("Status=0 and IsLock=0 and DepID=" + did, "order by status asc,orders asc");
            foreach (object obj in list)
            {
                if (!li.Contains(obj))
                    li.Add(obj);
            }

            IList father_dep_list = Sys_Dep.Init().GetAll("ParentID=" + did, "order by orders asc");
            if (father_dep_list.Count != 0)
            {
                foreach (Sys_DepInfo item in father_dep_list)
                {
                    GetTreeItems(item.id, li);
                }
            }
        }

        #region 创建树形目录
        //创建头节点
        private void GetFirtNode()
        {
            DataSet ds = WC.DBUtility.MsSqlOperate.ExecuteDataset(CommandType.Text, "select * from Sys_Dep", null);

            ds.Relations.Add("sort", ds.Tables[0].Columns["id"], ds.Tables[0].Columns["ParentID"], false); //建立父子列之间关系

            foreach (DataRow dbRow in ds.Tables[0].Rows)
            {
                //1级目录没有排序，如果你愿意 可以排序。
                if (dbRow["ParentID"].ToString() == "0") //头节点 父ID为 0
                {
                    Sys_DepInfo cl = SetPram(dbRow); //将dbrow赋给对象
                    cl.Ch = "";
                    cl.Sh = cl.DepName; //第一行只显示FolderName
                    li.Add(cl); //头节点第一个入list

                    PopulateSubTree(dbRow, i); //从头节点开始递归查找子树
                }
            }
        }

        //递归遍历子树 排序并放入list
        private void PopulateSubTree(DataRow dbRow, int depth)
        {
            ++depth; //树深度
            //foreach(DataRow ChildRow in dbRow.GetChildRows("sort"))
            //{     
            //}
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
                Sys_DepInfo cl = SetPram(item);
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
                cl.Sh = cl.Ch + cl.DepName;
                li.Add(cl); //子节点入list
                PopulateSubTree(item, depth); //递归操作子树
            }
        }

        private Sys_DepInfo SetPram(DataRow dbRow)
        {
            Sys_DepInfo biz = new Sys_DepInfo();
            biz.id = Convert.ToInt32(dbRow["id"]);
            biz.DepName = Convert.ToString(dbRow["DepName"]);
            biz.ParentID = Convert.ToInt32(dbRow["ParentID"]);
            biz.Orders = Convert.ToInt32(dbRow["Orders"]);
            biz.IsPosition = Convert.ToInt32(dbRow["IsPosition"]);
            return biz;
        }

        #endregion

    }
}
