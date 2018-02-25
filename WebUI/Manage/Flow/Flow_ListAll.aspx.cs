using System;
using System.Collections;
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
using System.Collections.Generic;

namespace WC.WebUI.Manage.Flow
{
    public partial class Flow_ListAll : WC.BLL.ModulePages
    {
        private int i = 1; //深度从1 开始
        private IList<Flows_Model_TypeInfo> li = new List<Flows_Model_TypeInfo>();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                Show();
        }

        protected void Search_Btn(object sender, EventArgs e)
        {
            string keywords = HttpContext.Current.Server.HtmlEncode(Request.Form["keyword"].Trim());
            string md = HttpContext.Current.Server.HtmlEncode(Request.Form["Model"]);
            string st = HttpContext.Current.Server.HtmlEncode(Request.Form["StartTime"].Trim());
            string et = HttpContext.Current.Server.HtmlEncode(Request.Form["EndTime"].Trim());
            string stt = HttpContext.Current.Server.HtmlEncode(Request.Form["state"].Trim());
            string url = "?keywords=" + keywords + "&stt=" + stt + "&md=" + md + "&st=" + st + "&et=" + et;
            Response.Redirect("Flow_ListAll.aspx" + url);
        }

        protected void ModelType_btn(object sender, EventArgs e)
        {
            int mt = Convert.ToInt32(Model_Type.SelectedValue);
            if (mt == -1)
            {
                Model.Items.Clear();
                IList fm_list = Flows_Model.Init().GetAll("IsComplete=1 and ( ShareDeps='' or ShareDeps like '%#" + DepID + "#%') ", null);
                Model.Items.Add(new ListItem("所有流程模型", ""));
                for (int i = 0; i < fm_list.Count; i++)
                {
                    Flows_ModelInfo fmi = fm_list[i] as Flows_ModelInfo;
                    Model.Items.Add(new ListItem(fmi.Flow_Name, fmi.Flow_Name));
                }
            }
            if (mt == 0)
            {
                Model.Items.Clear();
                IList fm_list = Flows_Model.Init().GetAll("comid=0 and IsComplete=1 and ( ShareDeps='' or ShareDeps like '%#" + DepID + "#%') ", null);
                Model.Items.Add(new ListItem("所有流程模型", ""));
                for (int i = 0; i < fm_list.Count; i++)
                {
                    Flows_ModelInfo fmi = fm_list[i] as Flows_ModelInfo;
                    Model.Items.Add(new ListItem(fmi.Flow_Name, fmi.Flow_Name));
                }
            }
            if (mt > 0)
            {
                Model.Items.Clear();
                IList fm_list = Flows_Model.Init().GetAll("comid=" + mt + " and IsComplete=1 and ( ShareDeps='' or ShareDeps like '%#" + DepID + "#%') ", null);
                Model.Items.Add(new ListItem("所有流程模型", ""));
                for (int i = 0; i < fm_list.Count; i++)
                {
                    Flows_ModelInfo fmi = fm_list[i] as Flows_ModelInfo;
                    Model.Items.Add(new ListItem(fmi.Flow_Name, fmi.Flow_Name));
                }
            }
        }

        protected void Del(object sender, EventArgs e)
        {
            LinkButton lb = sender as LinkButton;
            RepeaterItem item = lb.Parent as RepeaterItem;
            HtmlInputCheckBox hick = item.FindControl("chk") as HtmlInputCheckBox;
            string fid = hick.Value;

            //删除物理文件
            try
            {
                int fd = Convert.ToInt32(fid);
                FlowsInfo gi = WC.BLL.Flows.Init().GetById(fd);
                if (gi != null)
                {
                    Dk.Help.DeleteFiles(gi.Flow_Files);
                    Dk.Help.DeleteFiles(gi.CurrentDocPath);
                }
                IList list = Flows_Doc.Init().GetAll("flow_id=" + fd, null);
                if (list != null)
                {
                    if (list.Count > 0)
                    {
                        foreach (object obj in list)
                        {
                            Flows_DocInfo di = obj as Flows_DocInfo;
                            Dk.Help.DeleteFiles(di.DocPath);
                        }
                    }
                }
            }
            catch { }

            string sql1 = "delete from flows where id=" + fid + ";";
            string sql2 = "delete from Flows_Step where Flow_ID=" + fid + ";";
            string sql3 = "delete from Flows_StepAction where FlowID=" + fid + ";";
            string sql4 = "delete from Flows_Doc where Flow_ID=" + fid + ";";
            MsSqlOperate.ExecuteNonQuery(CommandType.Text, sql1 + sql2 + sql3 + sql4);

            Show();
        }

        protected void Lock(object sender, EventArgs e)
        {
            LinkButton lb = sender as LinkButton;
            RepeaterItem item = lb.Parent as RepeaterItem;
            HtmlInputCheckBox hick = item.FindControl("chk") as HtmlInputCheckBox;
            string fid = hick.Value;
            string st = lb.CommandArgument;
            if (st == "-1" || st == "0")
            {
                string tmp = "";
                if (st == "-1")
                    tmp = "0";
                if (st == "0")
                    tmp = "-1";
                string sql = "update flows set status=" + tmp + " where id=" + fid;
                MsSqlOperate.ExecuteNonQuery(CommandType.Text, sql);
            }
            Show();
        }

        //protected void Complete(object sender, EventArgs e)
        //{
        //    LinkButton lb = sender as LinkButton;
        //    RepeaterItem item = lb.Parent as RepeaterItem;
        //    HtmlInputCheckBox hick = item.FindControl("chk") as HtmlInputCheckBox;
        //    string fid = hick.Value;
        //    string sql = "";
        //    MsSqlOperate.ExecuteNonQuery(CommandType.Text, sql);
        //}

        private void Show()
        {
            GetFirtNode();
            Model_Type.Items.Add(new ListItem("== 列出所有流程模型分类", "-1"));
            for (int i = 0, len = li.Count; i < len; i++)
            {
                Flows_Model_TypeInfo ti = li[i] as Flows_Model_TypeInfo;
                Model_Type.Items.Add(new ListItem(ti.Sh, ti.id + ""));
            }
            Model_Type.Items.Add(new ListItem("不属于任何分类", "0"));

            IList mlist = Flows_Model.Init().GetAll(null, null);
            Model.Items.Clear();
            Model.Items.Add(new ListItem("所有流程模型", ""));
            foreach (object obj in mlist)
            {
                Flows_ModelInfo fmi = obj as Flows_ModelInfo;
                Model.Items.Add(new ListItem(fmi.Flow_Name, fmi.Flow_Name));
            }

            IList list = null;
            if (!string.IsNullOrEmpty(Request.QueryString["keywords"]) || !string.IsNullOrEmpty(Request.QueryString["md"])
                 || !string.IsNullOrEmpty(Request.QueryString["st"]) || !string.IsNullOrEmpty(Request.QueryString["et"])
                || !string.IsNullOrEmpty(Request.QueryString["stt"]))
            {
                string key = Request.QueryString["keywords"];
                string where = " (flow_name like '%" + key 
                    + "%' or CurrentStepName like '%" + key + "%' or CreatorRealName like '%" 
                    + key + "%' ) ";
                string md = Request.QueryString["md"];
                string st = Request.QueryString["st"];
                string et = Request.QueryString["et"];
                string stt = Request.QueryString["stt"];

                if (string.IsNullOrEmpty(key)) where = " 1=1 ";

                if (!string.IsNullOrEmpty(stt))
                    where += " and (status=" + stt + ") ";

                if (!string.IsNullOrEmpty(md))
                    where += " and (ModelName='" + md + "') ";

                if (!string.IsNullOrEmpty(st) && !string.IsNullOrEmpty(et))
                    where += " and (addtime between '" + st + "' and '" + et + "')";

                if(!string.IsNullOrEmpty(st) && string.IsNullOrEmpty(et))
                    where += " and (addtime between '" + st + "' and getdate())";

                if (string.IsNullOrEmpty(st) && !string.IsNullOrEmpty(et))
                    where += " and (addtime between getdate() and '" + et + "')";

                list = Flows.Init().GetAll(where, "order by id desc");
            }
            else
            {
                list = Flows.Init().GetAll(null, "order by id desc");
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

            if (Request.QueryString["keywords"] == null)
                this.Page1.sty("meneame", pagecount, pds.PageCount, "?page=");

            if (Request.QueryString["keywords"] != null)
            {
                this.Page1.sty("meneame", pagecount, pds.PageCount, "?keywords=" + Request.QueryString["keywords"]
                    + "&stt=" + Request.QueryString["stt"]
                    + "&md=" + Request.QueryString["md"]
                    + "&st=" + Request.QueryString["st"]
                    + "&et=" + Request.QueryString["et"]
                    + "&page=");
            }

            num.InnerHtml = "当前查询条件总计 - <span style='color:#ff0000; font-weight:bold;'>" + list.Count + "</span> 条 记录数据";

        }

        protected string GetStatus(object obj)
        {
            int t = Convert.ToInt32(obj);
            if (t == 0)
            {
                return "<span style='color:#ff0000;'>审批中</span>";
            }
            else if (t == 1)
            {
                return "<span style='color:#006600;font-weight:bold'>已完成</span>";
            }
            else if (t == -1)
            {
                return "<span style='color:#999999;font-weight:bold'>已锁定</span>";
            }
            else if (t == -2)
            {
                return "<span style='color:black;font-weight:bold'>已退回</span>";
            }
            else
            {
                return "<span style='color:blue;'>已过期</span>";
            }
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

    }
}
