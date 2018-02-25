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

namespace WC.WebUI.Manage.Sys
{
    public partial class Dep_Manage : WC.BLL.ModulePages
    {
        private int i = 1; //深度从1 开始
        private IList<Sys_DepInfo> li = new List<Sys_DepInfo>();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                IList list = Sys_Module.Init().GetAll(null, "order by TypeName,Orders");
                for (int i = 0; i < list.Count; i++)
                {
                    Sys_ModuleInfo sm = list[i] as Sys_ModuleInfo;
                    powerList.Items.Add(new ListItem("【" + sm.TypeName + "】 - " + sm.ModuleName, sm.id + ""));
                }
                if (!string.IsNullOrEmpty(Request.QueryString["did"]))
                {
                    GetFirtNode();
                    parentID.DataSource = li;
                    parentID.DataTextField = "Sh";
                    parentID.DataValueField = "ID";
                    parentID.DataBind();
                    Show(Request.QueryString["did"]);
                }
                else
                {
                    GetFirtNode();
                    parentID.DataSource = li;
                    parentID.DataTextField = "Sh";
                    parentID.DataValueField = "ID";
                    parentID.DataBind();
                }
            }
        }

        protected void Save_Btn(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["did"]))
            {
                int rid = Convert.ToInt32(Request.QueryString["did"]);
                Sys_DepInfo sd = ViewState["sd"] as Sys_DepInfo;

                sd.DepName = UDepName.Value.Replace("#", "").Replace(",", "");
                sd.IsPosition = Convert.ToInt32(IsPosition.SelectedValue);
                sd.Orders = Convert.ToInt32(Orders.Value);
                sd.Notes = Notes.Value;
                sd.Phone = Phone.Value;
                if (sd.ParentID != 0)
                    sd.ParentID = Convert.ToInt32(parentID.SelectedValue);
                Sys_Dep.Init().Update(sd);

                string sql_update = "update Sys_User set DepName='" + sd.DepName + "' where DepID=" + sd.id;
                MsSqlOperate.ExecuteNonQuery(CommandType.Text, sql_update, null);

                List<string> old_module = ViewState["old_module"] as List<string>;
                List<string> new_module = new List<string>();
                for (int i = 0; i < powerList.Items.Count; i++)
                {
                    if (powerList.Items[i].Selected)
                    {
                        new_module.Add(powerList.Items[i].Value);
                    }
                }
                for (int i = 0; i < old_module.Count; i++)
                {
                    if (!new_module.Contains(old_module[i]))
                    {
                        string sql = "delete from Sys_Dep_Module where DepID="
                            + rid + " and ModuleID=" + old_module[i];
                        MsSqlOperate.ExecuteNonQuery(CommandType.Text, sql, null);
                    }
                }
                for (int i = 0; i < new_module.Count; i++)
                {
                    if (!old_module.Contains(new_module[i]))
                    {
                        Sys_Dep_ModuleInfo srm = new Sys_Dep_ModuleInfo();
                        srm.ModuleID = Convert.ToInt32(new_module[i]);
                        srm.DepID = rid;
                        Sys_Dep_Module.Init().Add(srm);
                    }
                }

                string words = HttpContext.Current.Server.HtmlEncode("您好!部门/职位已编辑成功!");
                Response.Redirect("/InfoTip/Operate_Success.aspx?returnpage="
                + Request.Url.AbsoluteUri + "&tip=" + words);
            }
            else
            {
                Sys_DepInfo sd = new Sys_DepInfo();
                sd.DepName = UDepName.Value.Replace("#", "").Replace(",", "");
                sd.IsPosition = Convert.ToInt32(IsPosition.SelectedValue);
                sd.Orders = Convert.ToInt32(Orders.Value);
                sd.Notes = Notes.Value;
                sd.Phone = Phone.Value;

                sd.ParentID = Convert.ToInt32(parentID.SelectedValue);
                Sys_Dep.Init().Add(sd);

                for (int i = 0; i < powerList.Items.Count; i++)
                {
                    if (powerList.Items[i].Selected)
                    {
                        Sys_Dep_ModuleInfo srm = new Sys_Dep_ModuleInfo();
                        srm.ModuleID = Convert.ToInt32(powerList.Items[i].Value);
                        srm.DepID = sd.id;
                        Sys_Dep_Module.Init().Add(srm);
                    }
                }

                string words = HttpContext.Current.Server.HtmlEncode("您好!部门/职位已添加成功!");
                Response.Redirect("/InfoTip/Operate_Success.aspx?returnpage="
                + Request.Url.AbsoluteUri + "&tip=" + words);
            }
        }

        private void Show(string did)
        {
            Sys_DepInfo sd = Sys_Dep.Init().GetById(Convert.ToInt32(did));
            ViewState["sd"] = sd;
            parentID.SelectedValue = sd.ParentID + "";
            UDepName.Value = sd.DepName;
            Notes.Value = sd.Notes;
            IsPosition.SelectedValue = sd.IsPosition + "";
            Orders.Value = sd.Orders + "";
            Phone.Value = sd.Phone;

            IList list = Sys_Dep_Module.Init().GetAll("DepID=" + did, null);
            List<string> old_module = new List<string>();
            for (int i = 0; i < list.Count; i++)
            {
                Sys_Dep_ModuleInfo srm = list[i] as Sys_Dep_ModuleInfo;
                old_module.Add(srm.ModuleID + "");
            }
            ViewState["old_module"] = old_module;
            powerListBind(list, powerList);
        }

        private void powerListBind(IList list, CheckBoxList cbList)
        {
            for (int i = 0; i < cbList.Items.Count; i++)
            {
                for (int j = 0; j < list.Count; j++)
                {
                    Sys_Dep_ModuleInfo sr = list[j] as Sys_Dep_ModuleInfo;
                    if (cbList.Items[i].Value == sr.ModuleID + "")
                        cbList.Items[i].Selected = true;
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
