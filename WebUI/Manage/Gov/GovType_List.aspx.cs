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

namespace WC.WebUI.Manage.Gov
{
    public partial class GovType_List : WC.BLL.ModulePages
    {
        private int i = 1; //深度从1 开始
        private List<Gov_Model_TypeInfo> li = new List<Gov_Model_TypeInfo>();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                Show();
        }

        private void Show()
        {
            GetFirtNode();
            rpt.DataSource = li;
            rpt.DataBind();
        }

        protected void Del_Btn(object sender, EventArgs e)
        {
            LinkButton lb = sender as LinkButton;
            string did = lb.CommandArgument;
            Gov_Model_TypeInfo sdi = Gov_Model_Type.Init().GetById(Convert.ToInt32(did));

            DeleteDep(sdi);
            Show();
        }

        private void DeleteDep(Gov_Model_TypeInfo sdi)
        {
            IList list = Gov_Model_Type.Init().GetAll("ParentID=" + sdi.id, null);
            for (int i = 0; i < list.Count; i++)
            {
                Gov_Model_TypeInfo item = list[i] as Gov_Model_TypeInfo;
                DeleteDep(item);
            }
            //DeletePaper(sdi.id);
            string sql = "delete from Gov_Model where comid=" + sdi.id;
            MsSqlOperate.ExecuteNonQuery(CommandType.Text, sql);
            Gov_Model_Type.Init().Delete(sdi.id);
        }


        #region 创建树形目录
        //创建头节点
        private void GetFirtNode()
        {
            DataSet ds = WC.DBUtility.MsSqlOperate.ExecuteDataset(CommandType.Text, "select * from Gov_Model_Type order by orders asc", null);

            ds.Relations.Add("sort", ds.Tables[0].Columns["id"], ds.Tables[0].Columns["ParentID"], false); //建立父子列之间关系

            foreach (DataRow dbRow in ds.Tables[0].Rows)
            {
                //1级目录没有排序，如果你愿意 可以排序。
                if (dbRow["ParentID"].ToString() == "0") //头节点 父ID为 0
                {
                    Gov_Model_TypeInfo cl = SetPram(dbRow); //将dbrow赋给对象
                    cl.Ch = "<img src=../images/ico_browsefolder.gif />"; //头节点的图标是 domain.gif
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
                Gov_Model_TypeInfo cl = SetPram(item);
                string img = "";

                img = "<img src=../images/ico_intro.gif />";

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

        private Gov_Model_TypeInfo SetPram(DataRow dbRow)
        {
            Gov_Model_TypeInfo biz = new Gov_Model_TypeInfo();
            biz.id = Convert.ToInt32(dbRow["id"]);
            biz.TypeName = Convert.ToString(dbRow["TypeName"]);
            biz.ParentID = Convert.ToInt32(dbRow["ParentID"]);
            biz.Orders = Convert.ToInt32(dbRow["Orders"]);

            return biz;
        }

        #endregion
    }
}