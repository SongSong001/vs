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
using System.IO;
using WC.BLL;
using WC.Model;
using WC.Tool;
using WC.DBUtility;

namespace WC.WebUI.Manage.Flow
{
    public partial class Flow_Manage : WC.BLL.ViewPages
    {
        private int i = 1; //深度从1 开始
        private IList<Flows_Model_TypeInfo> li = new List<Flows_Model_TypeInfo>();
        protected string LoadOriginalFile = "";
        protected string doctype = "doc";
        protected string url = "";
        protected string url1 = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            //获得URL的值
            url = "http://" + Request.ServerVariables["HTTP_HOST"].ToString()
                  + Request.ServerVariables["PATH_INFO"].ToString();
            int i = url.LastIndexOf("/");
            url = url.Substring(0, i) + "/";
            url1 = url;

            if (!IsPostBack)
                Show();
        }

        private void Show()
        {
            SqlParameter rid = new SqlParameter();
            rid.ParameterName = "@uid";
            rid.Size = 50;
            rid.Value = Uid;

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

            SqlParameter sqlpt4 = new SqlParameter();
            sqlpt4.Direction = ParameterDirection.Output;
            sqlpt4.ParameterName = "@pt4";
            sqlpt4.Size = 7;

            SqlParameter[] sqls = { sqlpt1, sqlpt2, sqlpt3, sqlpt4, rid };
            MsSqlOperate.ExecuteNonQuery(CommandType.StoredProcedure, "Flows_GetUserFlowBoxCount", sqls);
            wdpy.InnerText = sqlpt1.Value + "";
            yjpy.InnerText = sqlpt2.Value + "";
            wdsq.InnerText = sqlpt3.Value + "";
            view.InnerText = sqlpt4.Value + "";


            IList fm_list = Flows_Model.Init().GetAll("IsComplete=1 and ( ShareDeps='' or ShareDeps like '%#" + DepID + "#%') ", null);
            ModelFlowList.Items.Add(new ListItem("== 请从以下列表 选择一个流程类型", ""));
            for (int i = 0; i < fm_list.Count; i++)
            {
                Flows_ModelInfo fmi = fm_list[i] as Flows_ModelInfo;
                ModelFlowList.Items.Add(new ListItem(fmi.Flow_Name, fmi.id + "," + fmi.ModelFileID));
            }

            GetFirtNode();
            Model_Type.Items.Add(new ListItem("== 请选择一个分类", "-1"));
            for (int i = 0, len = li.Count; i < len; i++)
            {
                Flows_Model_TypeInfo ti = li[i] as Flows_Model_TypeInfo;
                Model_Type.Items.Add(new ListItem(ti.Sh, ti.id + ""));
            }
            Model_Type.Items.Add(new ListItem("不属于任何分类", "0"));
        }

        protected void ModelType_btn(object sender, EventArgs e)
        {
            int mt = Convert.ToInt32(Model_Type.SelectedValue);
            if (mt == -1)
            {
                ModelFlowList.Items.Clear();
                IList fm_list = Flows_Model.Init().GetAll("IsComplete=1 and ( ShareDeps='' or ShareDeps like '%#" + DepID + "#%') ", null);
                ModelFlowList.Items.Add(new ListItem("== 请从以下列表 选择一个流程模型", ""));
                for (int i = 0; i < fm_list.Count; i++)
                {
                    Flows_ModelInfo fmi = fm_list[i] as Flows_ModelInfo;
                    ModelFlowList.Items.Add(new ListItem(fmi.Flow_Name, fmi.id + "," + fmi.ModelFileID));
                }
            }
            if (mt == 0)
            {
                ModelFlowList.Items.Clear();
                IList fm_list = Flows_Model.Init().GetAll("comid=0 and IsComplete=1 and ( ShareDeps='' or ShareDeps like '%#" + DepID + "#%') ", null);
                ModelFlowList.Items.Add(new ListItem("== 请从以下列表 选择一个流程模型", ""));
                for (int i = 0; i < fm_list.Count; i++)
                {
                    Flows_ModelInfo fmi = fm_list[i] as Flows_ModelInfo;
                    ModelFlowList.Items.Add(new ListItem(fmi.Flow_Name, fmi.id + "," + fmi.ModelFileID));
                }
            }
            if (mt > 0)
            {
                ModelFlowList.Items.Clear();
                IList fm_list = Flows_Model.Init().GetAll("comid=" + mt + " and IsComplete=1 and ( ShareDeps='' or ShareDeps like '%#" + DepID + "#%') ", null);
                ModelFlowList.Items.Add(new ListItem("== 请从以下列表 选择一个流程模型", ""));
                for (int i = 0; i < fm_list.Count; i++)
                {
                    Flows_ModelInfo fmi = fm_list[i] as Flows_ModelInfo;
                    ModelFlowList.Items.Add(new ListItem(fmi.Flow_Name, fmi.id + "," + fmi.ModelFileID));
                }
            }
            Attachword.Visible = false;
        }

        protected void Save_Btn(object sender, EventArgs e)
        {
            if (rpt_steps.Items.Count > 0)
            {
                bool valid = true;
                for (int i = 0; i < rpt_steps.Items.Count; i++)
                {
                    Label lb_id = rpt_steps.Items[i].FindControl("stepid") as Label;
                    if (string.IsNullOrEmpty(Request.Form["namelist" + lb_id.Text]))
                        valid = false;
                }
                if (valid)
                {
                    FlowsInfo fi = new FlowsInfo();

                    if (Convert.ToInt32(Model_Type.SelectedValue) > 0)
                        fi.ComID = Convert.ToInt32(Model_Type.SelectedValue);

                    fi.ModelName = ModelFlowList.Items[ModelFlowList.SelectedIndex].Text;
                    fi.Flow_Name = Flow_Name.Value;
                    fi.CurrentDocPath = filepath.Value;
                    fi.DocBody = DocBody.Value;
                    fi.ValidTime = DateTime.Now;
                    fi.AddTime = DateTime.Now;
                    fi.ViewUserList = userlist.Value;
                    if (WC.Tool.Utils.IsDate(ValidTime.Value))
                    {
                        fi.ValidTime = Convert.ToDateTime(ValidTime.Value);
                        fi.IsValid = 1;
                    }
                    fi.Remark = FlowRemark.Value;
                    fi.CreatorID = Convert.ToInt32(Uid);
                    fi.CreatorRealName = RealName;
                    fi.CreatorDepName = DepName;
                    fi.HasOperatedUserList = "";
                    fi.Flow_Files = UpdateFiles();
                    Flows.Init().Add(fi);

                    for (int i = 0; i < rpt_steps.Items.Count; i++)
                    {
                        Label lb_id = rpt_steps.Items[i].FindControl("stepid") as Label;

                        Label lb_isuseredit = rpt_steps.Items[i].FindControl("isuseredit") as Label;

                        Label lb_IsHead = rpt_steps.Items[i].FindControl("IsHead") as Label;
                        Label lb_IsEnd = rpt_steps.Items[i].FindControl("IsEnd") as Label;
                        Label lb_MailAlert = rpt_steps.Items[i].FindControl("MailAlert") as Label;
                        Label lb_RightToFinish = rpt_steps.Items[i].FindControl("RightToFinish") as Label;
                        Label lb_Step_Orders = rpt_steps.Items[i].FindControl("Step_Orders") as Label;
                        Label lb_Step_Name = rpt_steps.Items[i].FindControl("Step_Name") as Label;
                        Label lb_IsUserFile = rpt_steps.Items[i].FindControl("IsUserFile") as Label;

                        string fmid = lb_id.Text;
                        Flows_StepInfo fsi = new Flows_StepInfo();
                        fsi.Flow_ID = fi.id;
                        fsi.IsEnd = Convert.ToInt32(lb_IsEnd.Text);
                        fsi.IsHead = Convert.ToInt32(lb_IsHead.Text);
                        fsi.IsUserEdit = Convert.ToInt32(lb_isuseredit.Text);
                        fsi.IsUserFile = Convert.ToInt32(lb_IsUserFile.Text);
                        fsi.MailAlert = Convert.ToInt32(lb_MailAlert.Text);
                        fsi.RightToFinish = Convert.ToInt32(lb_RightToFinish.Text);
                        fsi.Step_Name = lb_Step_Name.Text;
                        fsi.Step_Orders = Convert.ToInt32(lb_Step_Orders.Text);

                        fsi.userlist = Request.Form["userlist" + fmid];
                        fsi.namelist = Request.Form["namelist" + fmid];
                        fsi.Acts = Guid.NewGuid().ToString();
                        Flows_Step.Init().Add(fsi);

                        if (i == 0)
                        {
                            Flows_StepInfo an = MakeNewFsi(fsi);

                            fi.CurrentStepID = an.id;
                            fi.CurrentStepName = an.Step_Name;
                            fi.CurrentStepUserList = an.userlist;

                            //短信插入代码
                            Dk.Help.FlowMobleSend(an.userlist, fi.Flow_Name);
                        }
                    }

                    Flows.Init().Update(fi);

                    Flows_DocInfo gi = new Flows_DocInfo();
                    gi.AddTime = DateTime.Now;
                    gi.DocPath = fi.Flow_Files;
                    gi.DocBody = fi.DocBody;
                    gi.Flow_ID = fi.id;
                    gi.UserDepName = DepName;
                    gi.UserID = Convert.ToInt32(Uid);
                    gi.UserRealName = RealName;
                    Flows_Doc.Init().Add(gi);

                    string words = HttpContext.Current.Server.HtmlEncode("您好!新建工作流程成功!");
                    Response.Redirect("/InfoTip/Operate_Success.aspx?returnpage="
                    + Request.Url.AbsoluteUri + "&tip=" + words);
                }
                else
                {
                    Response.Write("<script>alert('审批人员 不能为空!')</script>");
                }

            }
            else
            {
                Response.Write("<script>alert('工作流程没有审批步骤!');window.location='Flow_Manage.aspx'</script>");
            }
        }

        protected void Select_btn(object sender, EventArgs e)
        {
            DropDownList ddl = sender as DropDownList;

            kind_show.Visible = true;

            if (ddl.SelectedValue.Contains(","))
            {
                Attachword.Visible = true;
                string fmid = ddl.SelectedValue.Split(',')[0];
                string fmfid = ddl.SelectedValue.Split(',')[1];

                if (fmfid != "0")
                {
                    Flows_ModelFileInfo fmfi = Flows_ModelFile.Init().GetById(Convert.ToInt32(fmfid));
                    DocBody.Value = fmfi.DocBody;
                    if (fmfi.FilePath.Contains("|"))
                    {
                        List<TmpInfo> tmplist = new List<TmpInfo>();
                        string formtitle = fmfi.FormTitle;
                        string[] files = fmfi.FilePath.Split('|');
                        for (int i = 0; i < files.Length; i++)
                        {
                            if (files[i].Trim() != "")
                            {
                                TmpInfo ti = new TmpInfo();
                                int t = files[i].LastIndexOf('/') + 1;
                                string filename = files[i].Substring(t, files[i].Length - t);
                                string fileurl = files[i].ToString();

                                ti.Tmp1 = formtitle;
                                ti.Tmp2 = filename;
                                ti.Tmp3 = fileurl;
                                tmplist.Add(ti);

                                if (LoadOriginalFile == "" && filename.Contains("."))
                                {
                                    string[] arr = filename.Split('.');
                                    if (arr[arr.Length - 1].ToLower().Contains("doc"))
                                    {
                                        url = url.ToLower().Replace("/manage/flow", "");
                                        LoadOriginalFile = url + fileurl;
                                    }
                                }
                            }
                        }
                        //rpt_modelfile.DataSource = tmplist;
                        //rpt_modelfile.DataBind();
                    }

                }

                IList fmsteplist = Flows_ModelStep.Init().GetAll("Flow_ModelID=" + fmid, "order by id asc");
                Flows_ModelInfo f1 = Flows_Model.Init().GetById(Convert.ToInt32(fmid));
                if (!string.IsNullOrEmpty(f1.Remark))
                {
                    nts.Visible = true;
                    nts.Attributes.Add("title", f1.Remark);
                }

                rpt_steps.DataSource = fmsteplist;
                rpt_steps.DataBind();

            }

        }

        protected string GetStepNames(object userlist, object namelist, object userlist_dep, object step_type)
        {
            string names = "";
            if (step_type.ToString() == "0")
            {
                names = namelist + "";
            }
            if (step_type.ToString() == "1")
            {
                string deps = userlist_dep + "";
                if (deps.Contains(","))
                {
                    string[] dep = deps.Split(',');
                    List<Sys_UserInfo> ulist = new List<Sys_UserInfo>();
                    for (int i = 0; i < dep.Length; i++)
                    {
                        if (dep[i].Trim() != "")
                        {
                            string id = dep[i].Split('#')[1];
                            IList list = Sys_User.Init().GetAll("depid=" + id, null);
                            foreach (object obj in list)
                            {
                                Sys_UserInfo item = obj as Sys_UserInfo;
                                if (!ulist.Contains(item))
                                    ulist.Add(item);
                            }
                        }
                    }
                    for (int i = 0; i < ulist.Count; i++)
                    {
                        names += ulist[i].RealName + "(" + ulist[i].DepName + "),";
                    }
                }
            }
            return names;
        }

        protected string GetStepUsers(object userlist, object namelist, object userlist_dep, object step_type)
        {
            string names = "";
            if (step_type.ToString() == "0")
            {
                names = userlist + "";
            }
            if (step_type.ToString() == "1")
            {
                string deps = userlist_dep + "";
                if (deps.Contains(","))
                {
                    string[] dep = deps.Split(',');
                    List<Sys_UserInfo> ulist = new List<Sys_UserInfo>();
                    for (int i = 0; i < dep.Length; i++)
                    {
                        if (dep[i].Trim() != "")
                        {
                            string id = dep[i].Split('#')[1];
                            IList list = Sys_User.Init().GetAll("depid=" + id, null);
                            foreach (object obj in list)
                            {
                                Sys_UserInfo item = obj as Sys_UserInfo;
                                if (!ulist.Contains(item))
                                    ulist.Add(item);
                            }
                        }
                    }
                    for (int i = 0; i < ulist.Count; i++)
                    {
                        names += ulist[i].RealName + "#" + ulist[i].id + "#" + ulist[i].DepName + ",";
                    }
                }
            }
            return names;
        }

        protected void OnDataBind(object sender, RepeaterItemEventArgs e)
        {
            Label isedit = e.Item.FindControl("isuseredit") as Label;
            HtmlControl pal = e.Item.FindControl("isedit") as HtmlControl;
            if (isedit.Text == "1")
                pal.Visible = true;
        }

        private Flows_StepInfo MakeNewFsi(Flows_StepInfo fsi)
        {
            Flows_StepInfo an = new Flows_StepInfo();
            an.Flow_ID = fsi.Flow_ID;
            an.IsAct = 1;
            an.IsEnd = fsi.IsEnd;
            an.IsHead = fsi.IsHead;
            an.IsUserEdit = fsi.IsUserEdit;
            an.IsUserFile = fsi.IsUserFile;
            an.MailAlert = fsi.MailAlert;
            an.namelist = fsi.namelist;
            an.RightToFinish = fsi.RightToFinish;
            an.Step_Name = fsi.Step_Name;
            an.Step_Orders = 1;
            an.Step_Remark = fsi.Step_Remark;
            an.userlist = fsi.userlist;
            an.Acts = fsi.Acts;
            Flows_Step.Init().Add(an);
            return an;
        }

        //上传所有附件,并返回 文件保存位置字符串集合
        private string UpdateFiles()
        {
            string fnames = "";
            System.Web.HttpFileCollection files = System.Web.HttpContext.Current.Request.Files;

            //得到或创建 上传目录
            string timeFolder = DateTime.Now.ToString("yyMMdd");
            string path = Server.MapPath("~/Files/FlowFiles/");
            string tmp = "~/Files/FlowFiles/" + timeFolder + "/";
            path += timeFolder;
            if (!Directory.Exists(path))
            {
                WC.Tool.FileSystemManager.CreateFolder(timeFolder, Server.MapPath("~/Files/FlowFiles"));
            }

            try
            {
                string old = "";
                //if (Attachword.Visible == true)
                //{
                //    foreach (RepeaterItem item in rpt.Items)
                //    {
                //        HtmlInputCheckBox hick = item.FindControl("chk") as HtmlInputCheckBox;
                //        if (hick.Checked)
                //        {
                //            old += hick.Value + "|";
                //        }
                //    }
                //}

                for (int i = 0; i < files.Count; i++)
                {
                    System.Web.HttpPostedFile f = files[i];
                    if(WC.Tool.Config.IsValidFile(f))
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

        protected string GetStepNotes(object t)
        {
            if (!string.IsNullOrEmpty(t + ""))
            {
                return "(<a href=# title='" + t + "' >说明</a>)";
            }
            else return "";
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
