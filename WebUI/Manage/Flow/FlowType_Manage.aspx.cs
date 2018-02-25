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

namespace WC.WebUI.Manage.Flow
{
    public partial class FlowType_Manage : WC.BLL.ModulePages
    {
        private int i = 1; //深度从1 开始
        private IList<Flows_Model_TypeInfo> li = new List<Flows_Model_TypeInfo>();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetFirtNode();

                parentID.Items.Add(new ListItem("作为根分类", "0"));
                for (int i = 0, len = li.Count; i < len; i++)
                {
                    Flows_Model_TypeInfo ti = li[i] as Flows_Model_TypeInfo;
                    parentID.Items.Add(new ListItem(ti.Sh, ti.id + ""));
                }

                if (!string.IsNullOrEmpty(Request.QueryString["tid"]))
                {
                    Show(Request.QueryString["tid"]);
                }
            }
        }

        private void Show(string did)
        {
            Flows_Model_TypeInfo sd = Flows_Model_Type.Init().GetById(Convert.ToInt32(did));
            ViewState["sd"] = sd;
            parentID.SelectedValue = sd.ParentID + "";
            TypeName.Value = sd.TypeName;
            Notes.Value = sd.Notes;
            Orders.Value = sd.Orders + "";

        }


        #region 创建树形目录
        //创建头节点
        private void GetFirtNode()
        {
            DataSet ds = WC.DBUtility.MsSqlOperate.ExecuteDataset(CommandType.Text, "select * from Flows_Model_Type", null);

            ds.Relations.Add("sort", ds.Tables[0].Columns["id"], ds.Tables[0].Columns["ParentID"], false); //建立父子列之间关系

            foreach (DataRow dbRow in ds.Tables[0].Rows)
            {
                //1级目录没有排序，如果你愿意 可以排序。
                if (dbRow["ParentID"].ToString() == "0") //头节点 父ID为 0
                {
                    Flows_Model_TypeInfo cl = SetPram(dbRow); //将dbrow赋给对象
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
                Flows_Model_TypeInfo cl = SetPram(item);
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

        private Flows_Model_TypeInfo SetPram(DataRow dbRow)
        {
            Flows_Model_TypeInfo biz = new Flows_Model_TypeInfo();
            biz.id = Convert.ToInt32(dbRow["id"]);
            biz.TypeName = Convert.ToString(dbRow["TypeName"]);
            biz.ParentID = Convert.ToInt32(dbRow["ParentID"]);
            biz.Orders = Convert.ToInt32(dbRow["Orders"]);
            return biz;
        }

        #endregion

        protected void Save_Btn(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["tid"]))
            {
                Flows_Model_TypeInfo ni = ViewState["sd"] as Flows_Model_TypeInfo;
                ni.Notes = Notes.Value;
                ni.TypeName = TypeName.Value.Replace("#", "").Replace(",", "");
                ni.Orders = Convert.ToInt32(Orders.Value);

                if (Convert.ToInt32(parentID.SelectedValue) != ni.id)
                    ni.ParentID = Convert.ToInt32(parentID.SelectedValue);

                Flows_Model_Type.Init().Update(ni);
            }
            else
            {
                Flows_Model_TypeInfo ni = new Flows_Model_TypeInfo();
                ni.TypeName = TypeName.Value.Replace("#", "").Replace(",", "");
                ni.Notes = Notes.Value;
                ni.Orders = Convert.ToInt32(Orders.Value);
                ni.ParentID = Convert.ToInt32(parentID.SelectedValue);
                Flows_Model_Type.Init().Add(ni);
            }
            string words = HttpContext.Current.Server.HtmlEncode("您好!流程模型分类保存成功!");
            Response.Redirect("/InfoTip/Operate_Success.aspx?returnpage="
            + "/Manage/Flow/FlowType_List.aspx" + "&tip=" + words);

        }
    }
}