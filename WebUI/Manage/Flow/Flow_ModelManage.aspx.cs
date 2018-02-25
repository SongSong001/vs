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
    public partial class Flow_ModelManage : WC.BLL.ModulePages
    {
        private int i = 1; //深度从1 开始
        private IList<Flows_Model_TypeInfo> li = new List<Flows_Model_TypeInfo>();
        protected string showobj = "-1";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Show();
                if (!string.IsNullOrEmpty(Request.QueryString["fm"]))
                {
                    ViewState["fm"] = Request.QueryString["fm"];
                    ShowData(0);
                    BindRpt(Request.QueryString["fm"]);

                    save1.Enabled = true;
                    add1.Enabled = true;
                }
            }
        }

        protected void AddStep_Btn(object sender, EventArgs e)
        {
            if (ModelName.Visible == true)
            {
                ModelName.Visible = false;
                ModelStep.Visible = true;
            }
            save1.Enabled = true;
            add1.Enabled = false;

            int count = GetMaxIndex() + 1;
            ViewState["max count"] = count;
            ViewState["current count"] = count;
            StepNo.InnerText = "第 " + count + " 步骤";
            ClearStepViewData();
            BindRpt(ViewState["fm"] + "");
            ViewState["isadd"] = 0;
        }

        protected void SaveStep_Btn(object sender, EventArgs e)
        {
            string sql = "update Flows_Model set IsComplete=0 where id=" + ViewState["fm"];
            MsSqlOperate.ExecuteNonQuery(CommandType.Text, sql);

            if (ModelName.Visible == true)
            {
                ModelName.Visible = true;
                ModelStep.Visible = false;

                SaveModelFlow();
            }
            else
            {
                SaveSetpFlow();
            }
            save1.Enabled = true;
            add1.Enabled = true;
            BindRpt(ViewState["fm"] + "");
        }

        protected void Finish_Btn(object sender, EventArgs e)
        {
            if (ViewState["fm"] + "" != "0" && ViewState["fm"] != null)
            {
                string sql0 = "update flows_modelstep set isend=0,ishead=0 where Flow_ModelID=" + ViewState["fm"] + ";";
                string sql = "update Flows_Model set iscomplete=1 where id=" + ViewState["fm"] + ";";
                string sql1 = "update Flows_ModelStep set isend=1 where Flow_ModelID=" + ViewState["fm"] + " and id = (select max(id) from Flows_ModelStep where Flow_ModelID=" + ViewState["fm"] + ");";
                string sql2 = "update Flows_ModelStep set ishead=1 where Flow_ModelID=" + ViewState["fm"] + " and id = (select min(id) from Flows_ModelStep where Flow_ModelID=" + ViewState["fm"] + ");";
                MsSqlOperate.ExecuteNonQuery(CommandType.Text, sql0 + sql + sql1 + sql2);
                string words = HttpContext.Current.Server.HtmlEncode("您好!模型工作流程设计完成!");
                Response.Redirect("/InfoTip/Operate_Success.aspx?returnpage="
                + "/manage/flow/Flow_ModelList.aspx" + "&tip=" + words);
            }
        }

        protected void Cancer_Btn(object sender, EventArgs e)
        {
            if (ViewState["fm"] + "" != "0" && ViewState["fm"] != null)
            {
                string sql0 = "delete from Flows_Model where id=" + ViewState["fm"];
                string sql = "delete from Flows_ModelStep where Flow_ModelID=" + ViewState["fm"];
                MsSqlOperate.ExecuteNonQuery(CommandType.Text, sql0);
                MsSqlOperate.ExecuteNonQuery(CommandType.Text, sql);
            }
            Response.Redirect("Flow_ModelList.aspx");
        }

        protected void Rpt_Edit(object sender, EventArgs e)
        {
            LinkButton lb = sender as LinkButton;
            string name = lb.CommandArgument;
            int count = 0;
            if (name.Contains("flow"))
            {
                ShowData(count);
            }
            if (name.Contains("step"))
            {
                RepeaterItem item = lb.Parent as RepeaterItem;
                Label l = item.FindControl("lab") as Label;
                Label labid = item.FindControl("labid") as Label;
                Label labdiv = item.FindControl("showdiv") as Label;
                ViewState["step"] = labid.Text;
                showobj = labdiv.Text;
                StepNo.InnerText = "第 " + l.Text + " 步骤";

                count = Convert.ToInt32(name.Split('p')[1]);
                ShowData(count);
            }
            ViewState["current count"] = count;
            BindRpt(ViewState["fm"] + "");

            save1.Enabled = true;
            add1.Enabled = true;
        }

        protected void Rpt_Drop(object sender, EventArgs e)
        {
            ImageButton ib = sender as ImageButton;
            string name = ib.CommandArgument;
            if (name.Contains("step"))
            {
                Label lb = ib.Parent.FindControl("labid") as Label;
                Flows_ModelStep.Init().Delete(Convert.ToInt32(lb.Text));
            }
            ShowData(0);
            BindRpt(ViewState["fm"] + "");
            ViewState["max count"] = GetMaxIndex();
        }

        private void Show()
        {
            if (ModelName.Visible == true)
            {
                IList list = Flows_ModelFile.Init().GetAll(null, null);
                ModelFileList.Items.Add(new ListItem("请从以下 模板表单库中 选择一项 (酌情 可不选) ", "0"));
                foreach (object item in list)
                {
                    Flows_ModelFileInfo fi = item as Flows_ModelFileInfo;
                    ModelFileList.Items.Add(new ListItem(fi.FormTitle, fi.id + ""));
                }

                GetFirtNode();
                Model_Type.Items.Add(new ListItem("不属于任何分类", "0"));
                for (int i = 0, len = li.Count; i < len; i++)
                {
                    Flows_Model_TypeInfo ti = li[i] as Flows_Model_TypeInfo;
                    Model_Type.Items.Add(new ListItem(ti.Sh, ti.id + ""));
                }

                ViewState["max count"] = 0;
                ViewState["current count"] = 0;
                ViewState["isadd"] = 0;
                ViewState["fm"] = 0;
            }
        }

        private void SaveModelFlow()
        {
            int isadd = Convert.ToInt32(ViewState["isadd"]);
            if (isadd == 0)
            {
                Flows_ModelInfo fmi = new Flows_ModelInfo();
                fmi.AddTime = DateTime.Now;
                fmi.CreatorDepName = DepName;
                fmi.CreatorID = Convert.ToInt32(Uid);
                fmi.CreatorRealName = RealName;
                fmi.Flow_Name = Flow_Name.Value;
                fmi.ModelFileID = ModelFileList.SelectedValue;
                fmi.Remark = FlowRemark.Value;
                fmi.ShareDeps = userlist_deps.Value;
                fmi.namelist = namelist_deps.Value;

                fmi.ComID = Convert.ToInt32(Model_Type.SelectedValue);

                Flows_Model.Init().Add(fmi);
                ViewState["fm"] = fmi.id;
            }
            else
            {
                Flows_ModelInfo fmi = Flows_Model.Init().GetById(Convert.ToInt32(ViewState["fm"]));
                fmi.CreatorDepName = DepName;
                fmi.CreatorID = Convert.ToInt32(Uid);
                fmi.CreatorRealName = RealName;
                fmi.Flow_Name = Flow_Name.Value;
                fmi.ModelFileID = ModelFileList.SelectedValue;
                fmi.Remark = FlowRemark.Value;
                fmi.ShareDeps = userlist_deps.Value;
                fmi.namelist = namelist_deps.Value;

                fmi.ComID = Convert.ToInt32(Model_Type.SelectedValue);

                Flows_Model.Init().Update(fmi);
                ViewState["fm"] = fmi.id;
            }
        }

        private void SaveSetpFlow()
        {
            int isadd = Convert.ToInt32(ViewState["isadd"]);
            int current_count = Convert.ToInt32(ViewState["current count"]);
            if (isadd == 0)
            {
                Flows_ModelStepInfo fsi = new Flows_ModelStepInfo();
                fsi.Flow_ModelID = Convert.ToInt32(ViewState["fm"]);
                fsi.Step_Remark = StepRemark.Value;
                fsi.Step_Name = Step_Name.Value;

                fsi.Step_Type = Convert.ToInt32(Request.Form["step_type"]);
                fsi.UserList = userlist.Value;
                fsi.NameList = namelist.Value;
                fsi.NameList_dep = namelist_dep.Value;
                fsi.UserList_dep = userlist_dep.Value;

                fsi.IsUserEdit = Convert.ToInt32(IsUserEdit.Checked);
                fsi.IsUserFile = Convert.ToInt32(IsUserFile.Checked);
                fsi.MailAlert = Convert.ToInt32(MailAlert.Checked);
                fsi.RightToFinish = Convert.ToInt32(RightToFinish.Checked);

                fsi.Step_Orders = current_count;

                Flows_ModelStep.Init().Add(fsi);
            }
            else
            {
                Flows_ModelStepInfo fsi = Flows_ModelStep.Init().GetById(Convert.ToInt32(ViewState["step"]));
                fsi.Step_Remark = StepRemark.Value;
                fsi.Step_Name = Step_Name.Value;

                fsi.Step_Type = Convert.ToInt32(Request.Form["step_type"]);
                fsi.UserList = userlist.Value;
                fsi.NameList = namelist.Value;
                fsi.NameList_dep = namelist_dep.Value;
                fsi.UserList_dep = userlist_dep.Value;

                fsi.IsUserEdit = Convert.ToInt32(IsUserEdit.Checked);
                fsi.IsUserFile = Convert.ToInt32(IsUserFile.Checked);
                fsi.MailAlert = Convert.ToInt32(MailAlert.Checked);
                fsi.RightToFinish = Convert.ToInt32(RightToFinish.Checked);

                fsi.Step_Orders = current_count;

                Flows_ModelStep.Init().Update(fsi);
            }
        }

        private void ShowData(int step)
        {
            Flows_ModelInfo fmi = Flows_Model.Init().GetById(Convert.ToInt32(ViewState["fm"]));
            if (step > 0)
            {
                ModelName.Visible = false;
                ModelStep.Visible = true;

                Flows_ModelStepInfo fsi = Flows_ModelStep.Init().GetById(Convert.ToInt32(ViewState["step"]));
                Step_Name.Value = fsi.Step_Name;
                This_FolwName.Text = fmi.Flow_Name;
                userlist.Value = fsi.UserList;
                namelist.Value = fsi.NameList;
                userlist_dep.Value = fsi.UserList_dep;
                namelist_dep.Value = fsi.NameList_dep;
                IsUserEdit.Checked = Convert.ToBoolean(fsi.IsUserEdit);
                IsUserFile.Checked = Convert.ToBoolean(fsi.IsUserFile);
                RightToFinish.Checked = Convert.ToBoolean(fsi.RightToFinish);
                MailAlert.Checked = Convert.ToBoolean(fsi.MailAlert);
                StepRemark.Value = fsi.Step_Remark;

            }
            else
            {
                ModelName.Visible = true;
                ModelStep.Visible = false;

                Flow_Name.Value = fmi.Flow_Name;
                ModelFileList.SelectedValue = fmi.ModelFileID;
                FlowRemark.Value = fmi.Remark;
                userlist_deps.Value = fmi.ShareDeps;
                namelist_deps.Value = fmi.namelist;
                Model_Type.SelectedValue = fmi.ComID + "";
            }
            ViewState["isadd"] = 1;
        }

        private void BindRpt(string fmid)
        {
            Flows_ModelInfo fmi = Flows_Model.Init().GetById(Convert.ToInt32(ViewState["fm"]));
            This_FolwName.Text = fmi.Flow_Name;
            IList li = Flows_ModelStep.Init().GetAll("Flow_ModelID=" + ViewState["fm"], "order by id asc");
            List<TmpInfo> list = new List<TmpInfo>();
            TmpInfo t = new TmpInfo();
            t.Tmp1 = "<strong>模型流程基本信息:</strong> &nbsp;&nbsp; " + fmi.Flow_Name;
            t.Tmp2 = "flow";
            t.Tmp3 = "0";
            list.Add(t);
            for (int i = 0; i < li.Count; i++)
            {
                Flows_ModelStepInfo fsi = li[i] as Flows_ModelStepInfo;
                TmpInfo tmp = new TmpInfo();
                int j = i + 1;
                tmp.Tmp1 = "<strong>第 " + j + " 步 : </strong> &nbsp;&nbsp; " + fsi.Step_Name;
                tmp.Tmp2 = "step" + j;
                tmp.Tmp3 = j + "";
                tmp.Tmp4 = fsi.id + "";
                tmp.Tmp5 = fsi.Step_Type + "";
                list.Add(tmp);
            }
            rpt.DataSource = list;
            rpt.DataBind();
        }

        private int GetMaxIndex()
        {
            string where = "Flow_ModelID=" + ViewState["fm"];
            IList list = Flows_ModelStep.Init().GetAll(where, null);
            return list.Count;
        }

        private void ClearStepViewData()
        {
            if (ModelStep.Visible == true)
            {
                Step_Name.Value = "";
                userlist.Value = "";
                namelist.Value = "";
                userlist_dep.Value = "";
                namelist_dep.Value = "";
                IsUserEdit.Checked = true;
                RightToFinish.Checked = false;
                MailAlert.Checked = false;
                StepRemark.Value = "";

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
