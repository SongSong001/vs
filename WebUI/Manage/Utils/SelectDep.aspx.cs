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
    public partial class SelectDep : WC.BLL.ViewPages
    {
        private int i = 1; //深度从1 开始
        private List<Sys_DepInfo> li = new List<Sys_DepInfo>();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                Show();
        }

        protected void Search_Btn(object sender, EventArgs e)
        {
            string keywords = Request.Form["keyword"];
            string url = "?keywords=" + HttpContext.Current.Server.HtmlEncode(keywords.Trim());
            if (!string.IsNullOrEmpty(Request.QueryString["v"]))
                url += "&v=" + Request.QueryString["v"];
            Response.Redirect("SelectDeps.aspx" + url);
        }

        private void Show()
        {
            GetFirtNode();
            rpt.DataSource = li;
            rpt.DataBind();


            int n = 0;
            if (!string.IsNullOrEmpty(Request.QueryString["v"]))
            {
                string[] array = Request.QueryString["v"].Split(';');
                List<string> listr = new List<string>();
                for (int i = 0; i < array.Length; i++)
                {
                    if (array[i].Trim() != "")
                        listr.Add(array[i]);
                }
                foreach (RepeaterItem ri in rpt.Items)
                {
                    HtmlInputCheckBox hick = ri.FindControl("chk") as HtmlInputCheckBox;
                    if (listr.Contains(hick.Value.Split('#')[1]))
                    {
                        hick.Checked = true;
                        n++;
                    }
                }
            }
            number.InnerText = n + "";
            total.InnerText = li.Count + "";
        }

        #region 创建树形目录
        //创建头节点
        private void GetFirtNode()
        {
            DataSet ds = WC.DBUtility.MsSqlOperate.ExecuteDataset(CommandType.Text, "select * from Sys_Dep order by orders asc", null);

            ds.Relations.Add("sort", ds.Tables[0].Columns["id"], ds.Tables[0].Columns["ParentID"], false); //建立父子列之间关系

            foreach (DataRow dbRow in ds.Tables[0].Rows)
            {
                //1级目录没有排序，如果你愿意 可以排序。
                if (dbRow["ParentID"].ToString() == "0") //头节点 父ID为 0
                {
                    Sys_DepInfo cl = SetPram(dbRow); //将dbrow赋给对象
                    cl.Ch = "<img src=../images/ico_system.gif />"; //头节点的图标是 domain.gif
                    li.Add(cl); //头节点第一个入list

                    PopulateSubTree(dbRow, i); //从头节点开始递归查找子树
                }
            }
            ds.Dispose();
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
                    if (Convert.ToInt32(dr[k]["orders"]) > Convert.ToInt32(dr[j]["orders"]))
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
                string img = "";
                if (cl.IsPosition == 0)
                {
                    img = "<img src=../images/ico_jingpin.gif />";
                }
                else
                {
                    img = "<img src=../images/group.gif />";
                }
                if (depth == 2)
                {
                    if (ReferenceEquals(item, dr[dr.Length - 1]))
                    {
                        cl.Ch = "　└ " + img;
                    }
                    else cl.Ch = "　├ " + img;
                }
                else if (depth > 2)
                {
                    if (ReferenceEquals(item, dr[dr.Length - 1]))
                    {
                        for (int n = 1; n < depth - 1; n++)
                        {
                            cl.Ch = "　│" + cl.Ch;
                        }
                        cl.Ch += "　└ " + img;
                    }
                    else
                    {
                        for (int n = 1; n < depth - 1; n++)
                        {
                            cl.Ch = "　│" + cl.Ch;
                        }
                        cl.Ch += "　├ " + img;
                    }
                }
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
            biz.Phone = Convert.ToString(dbRow["Phone"]);
            return biz;
        }

        protected string getstr(object a, object b)
        {
            return Convert.ToString(a) + "<strong>" + Convert.ToString(b) + "</strong>";
        }

        protected string gettype(object a, object b)
        {
            if (b + "" == "0")
                return "";
            else
            {
                if (a + "" == "0")
                    return "<span style='color:blue;'>职位</span>";
                else
                    return "部门";
            }
        }

        #endregion

    }
}
