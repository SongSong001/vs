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
using WC.DBUtility;
using WC.Model;

namespace WC.WebUI.Manage.Flow
{
    public partial class Flow_View : WC.BLL.ViewPages
    {
        protected string fj = "<a href='/Manage/Utils/Download.aspx?destFileName={0}' ><img src='/img/mail_attachment.gif' />{1}</a>&nbsp;&nbsp;";
        protected string yjs = "";

        protected string LoadOriginalFile = "";
        protected string doctype = "doc";
        protected string url = "";
        protected string url1 = "";
        protected string ke_isread = "";

        //protected string ke_isread = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            //获得URL的值
            url = "http://" + Request.ServerVariables["HTTP_HOST"].ToString()
                  + Request.ServerVariables["PATH_INFO"].ToString();
            int i = url.LastIndexOf("/");
            url = url.Substring(0, i) + "/";
            url1 = url;

            if (!IsPostBack)
            {
                if (!string.IsNullOrEmpty(Request.QueryString["fl"]))
                {
                    Show(Request.QueryString["fl"]);
                }
                else
                {
                    Response.Write("<script>alert('非法的请求!');window.location='Flow_Manage.aspx'</script>");
                }
            }
        }

        protected void VerifyStep_Btn(object sender, EventArgs e)
        {
            FlowsInfo fii = Flows.Init().GetById(Convert.ToInt32(Request.QueryString["fl"]));
            string uid = "";
            List<string> list_uid = new List<string>();
            if (fii.CurrentStepUserList.Contains(",") && fii.CurrentStepUserList.Contains("#") && fii.Status==0)
            {
                string[] array_t = fii.CurrentStepUserList.Split(',');
                foreach (string s in array_t)
                {
                    if (s.Contains("#"))
                    {
                        list_uid.Add(s.Split('#')[1]);
                    }
                }
            }
            if (list_uid.Contains(Uid))
                uid = Uid;

            if (uid != "")
            {
                Flows_StepInfo fsi = ViewState["CurrentStep"] as Flows_StepInfo;
                Flows_StepActionInfo fsai = new Flows_StepActionInfo();
                fsai.AddTime = DateTime.Now;
                fsai.FlowID = Convert.ToInt32(Request.QueryString["fl"]);
                fsai.Operation = 1;
                fsai.OperationStepID = fsi.id;
                fsai.OperationWord = "(同意) ：" + Request.Form["FlowRemark"];
                fsai.UserDepName = DepName;
                fsai.UserID = Convert.ToInt32(Uid);
                fsai.UserRealName = RealName;
                fsai.OperationStepName = fsi.Step_Name;
                //fsai.BackStepID = 0;

                if (fsi.IsEnd == 1)
                {
                    Flows_StepAction.Init().Add(fsai);
                    FlowsInfo fi = fii;
                    AddDoc(fi.id, fsai.id);
                    fi.CurrentDocPath = filepath.Value;
                    fi.DocBody = DocBody.Value;
                    if (!IsAllVerifid()) // 全体审批才 完成流程
                    {
                        fi.HasOperatedUserList += RealName + "#" + Uid + "#" + DepName + ",";
                        //fi.Flow_Files = UpdateFiles();
                        Flows.Init().Update(fi);
                        string words = HttpContext.Current.Server.HtmlEncode("您好!已成功审批!");
                        Response.Redirect("/InfoTip/Operate_Success.aspx?returnpage="
                        + Request.Url.AbsoluteUri + "&tip=" + words);
                    }
                    else
                    {
                        fi.HasOperatedUserList += RealName + "#" + Uid + "#" + DepName + ",";
                        //fi.Flow_Files = UpdateFiles();
                        Flows.Init().Update(fi);
                        FinishFlow();
                        string words = HttpContext.Current.Server.HtmlEncode("您好!成功审批,流程已完成!");
                        Response.Redirect("/InfoTip/Operate_Success.aspx?returnpage="
                        + Request.Url.AbsoluteUri + "&tip=" + words);
                    }
                }
                else
                {
                    IList mlist = Flows_Step.Init().GetAll("isact=0 and flow_id=" + Request.QueryString["fl"], "order by id asc");
                    if (mlist != null)
                    {
                        int index = 0;
                        foreach (object obj in mlist)
                        {
                            Flows_StepInfo tmp = obj as Flows_StepInfo;
                            if (tmp.Acts == fsi.Acts)
                                index = mlist.IndexOf(obj) + 1;
                        }
                        if (index != 0)
                        {
                            Flows_StepAction.Init().Add(fsai);
                            FlowsInfo fi = fii;
                            AddDoc(fi.id, fsai.id);
                            fi.CurrentDocPath = filepath.Value;
                            fi.DocBody = DocBody.Value;
                            if (IsAllVerifid()) // 全体审批才 下一步骤
                            {
                                Flows_StepInfo next_fsi = MakeNewFsi((Flows_StepInfo)mlist[index]);
                                fi.CurrentStepID = next_fsi.id;
                                fi.CurrentStepName = next_fsi.Step_Name;
                                fi.CurrentStepUserList = next_fsi.userlist;

                                //短信插入代码
                                Dk.Help.FlowMobleSend(next_fsi.userlist, fi.Flow_Name);
                            }
                            fi.HasOperatedUserList += RealName + "#" + Uid + "#" + DepName + ",";
                            //fi.Flow_Files = UpdateFiles();
                            Flows.Init().Update(fi);
                            string words = HttpContext.Current.Server.HtmlEncode("您好!已成功审批!");
                            Response.Redirect("/InfoTip/Operate_Success.aspx?returnpage="
                            + Request.Url.AbsoluteUri + "&tip=" + words);
                        }
                    }

                }

            }

        }

        protected void RefuseStep_Btn(object sender, EventArgs e)
        {
            FlowsInfo fii = Flows.Init().GetById(Convert.ToInt32(Request.QueryString["fl"]));
            string uid = "";
            List<string> list_uid = new List<string>();
            if (fii.CurrentStepUserList.Contains(",") && fii.CurrentStepUserList.Contains("#") && fii.Status == 0)
            {
                string[] array_t = fii.CurrentStepUserList.Split(',');
                foreach (string s in array_t)
                {
                    if (s.Contains("#"))
                    {
                        list_uid.Add(s.Split('#')[1]);
                    }
                }
            }
            if (list_uid.Contains(Uid))
                uid = Uid;

            if (uid != "")
            {
                Flows_StepInfo fsi = ViewState["CurrentStep"] as Flows_StepInfo;
                Flows_StepActionInfo fsai = new Flows_StepActionInfo();
                fsai.AddTime = DateTime.Now;
                fsai.FlowID = Convert.ToInt32(Request.QueryString["fl"]);
                fsai.Operation = -1;
                fsai.OperationStepID = fsi.id;
                fsai.OperationWord = "(不同意) ：" + Request.Form["FlowRemark"];
                fsai.UserDepName = DepName;
                fsai.UserID = Convert.ToInt32(Uid);
                fsai.UserRealName = RealName;
                fsai.OperationStepName = fsi.Step_Name;

                if (fsi.IsHead == 1)
                {
                    Flows_StepAction.Init().Add(fsai);
                    AddDoc(fsai.FlowID, fsai.id);
                    fii.CurrentDocPath = filepath.Value;
                    fii.DocBody = DocBody.Value;
                    Flows.Init().Update(fii);
                    BackFlow();

                    string words = HttpContext.Current.Server.HtmlEncode("您好!操作成功,流程已退回!");
                    Response.Redirect("/InfoTip/Operate_Success.aspx?returnpage="
                    + Request.Url.AbsoluteUri + "&tip=" + words);
                }
                else
                {
                    IList mlist = Flows_Step.Init().GetAll("isact=0 and flow_id=" + Request.QueryString["fl"], "order by id asc");
                    if (mlist != null)
                    {
                        int index = -1;
                        foreach (object obj in mlist)
                        {
                            Flows_StepInfo tmp = obj as Flows_StepInfo;
                            if (tmp.Acts == fsi.Acts)
                                index = mlist.IndexOf(obj) - 1;
                        }
                        if (index >= 0)
                        {
                            Flows_StepInfo next_fsi = MakeNewFsi((Flows_StepInfo)mlist[index]);
                            Flows_StepAction.Init().Add(fsai);
                            FlowsInfo fi = fii;
                            AddDoc(fsai.FlowID, fsai.id);
                            fi.CurrentDocPath = filepath.Value;
                            fi.DocBody = DocBody.Value;
                            fi.CurrentStepID = next_fsi.id;
                            fi.CurrentStepName = next_fsi.Step_Name;
                            fi.CurrentStepUserList = next_fsi.userlist;
                            fi.HasOperatedUserList += RealName + "#" + Uid + "#" + DepName + ",";
                            //fi.Flow_Files = UpdateFiles();
                            Flows.Init().Update(fi);

                            //短信插入代码
                            Dk.Help.FlowMobleSend(next_fsi.userlist, fi.Flow_Name);

                            string words = HttpContext.Current.Server.HtmlEncode("您好!操作成功,流程已返回!");
                            Response.Redirect("/InfoTip/Operate_Success.aspx?returnpage="
                            + Request.Url.AbsoluteUri + "&tip=" + words);

                        }

                    }

                }

            }

        }

        protected void CompleteStep_Btn(object sender, EventArgs e)
        {
            FlowsInfo fii = Flows.Init().GetById(Convert.ToInt32(Request.QueryString["fl"]));
            string uid = "";
            List<string> list_uid = new List<string>();
            if (fii.CurrentStepUserList.Contains(",") && fii.CurrentStepUserList.Contains("#") && fii.Status == 0)
            {
                string[] array_t = fii.CurrentStepUserList.Split(',');
                foreach (string s in array_t)
                {
                    if (s.Contains("#"))
                    {
                        list_uid.Add(s.Split('#')[1]);
                    }
                }
            }
            if (list_uid.Contains(Uid))
                uid = Uid;

            if (uid != "")
            {
                Flows_StepInfo fsi = ViewState["CurrentStep"] as Flows_StepInfo;
                Flows_StepActionInfo fsai = new Flows_StepActionInfo();
                fsai.AddTime = DateTime.Now;
                fsai.FlowID = Convert.ToInt32(Request.QueryString["fl"]);
                fsai.Operation = 1;
                fsai.OperationStepID = fsi.id;
                fsai.OperationWord = "(同意 并完成结束整个流程) ：" + Request.Form["FlowRemark"];
                fsai.UserDepName = DepName;
                fsai.UserID = Convert.ToInt32(Uid);
                fsai.UserRealName = RealName;
                fsai.OperationStepName = fsi.Step_Name;
                //fsai.BackStepID = 0;

                Flows_StepAction.Init().Add(fsai);
                AddDoc(fsai.FlowID, fsai.id);
                fii.CurrentDocPath = filepath.Value;
                fii.DocBody = DocBody.Value;
                WC.BLL.Flows.Init().Update(fii);

                FinishFlow();
                string words = HttpContext.Current.Server.HtmlEncode("您好!工作流程已审批完成!");
                Response.Redirect("/InfoTip/Operate_Success.aspx?returnpage="
                + Request.Url.AbsoluteUri + "&tip=" + words);
            }
        }

        private void FinishFlow()
        {
            FlowsInfo fi = ViewState["Flow"] as FlowsInfo;
            string t = fi.HasOperatedUserList + RealName + "#" + Uid + "#" + DepName + ",";
            string sql = "update Flows set Status=1,HasOperatedUserList='" + t +
                "' where status=0 and id=" + Request.QueryString["fl"];
            MsSqlOperate.ExecuteNonQuery(CommandType.Text, sql);

            string title = "[系统通知] : 您申请的工作流程(" + fi.Flow_Name + ") 已成功审批完成!";
            string content = "恭喜您! 审批流程成功完成!";
            int rid = fi.CreatorID;
            string userlist = fi.CreatorRealName + "#" + fi.CreatorID + "#" + fi.CreatorDepName + ",";
            string namelist = fi.CreatorRealName + "(" + fi.CreatorDepName + "),";
            WC.WebUI.Dk.Help.AdminSendMail(title, content, rid, userlist, namelist);
        }

        private void BackFlow()
        {
            FlowsInfo fi = ViewState["Flow"] as FlowsInfo;
            string t = fi.HasOperatedUserList + RealName + "#" + Uid + "#" + DepName + ",";
            string sql = "update Flows set Status=-2,HasOperatedUserList='" + t +
                "' where status=0 and id=" + Request.QueryString["fl"];
            MsSqlOperate.ExecuteNonQuery(CommandType.Text, sql);

            string title = "[系统通知] : 您申请的工作流程(" + fi.Flow_Name + ") 已被退回!";
            string content = "您的审批流程 没有被通过!";
            int rid = fi.CreatorID;
            string userlist = fi.CreatorRealName + "#" + fi.CreatorID + "#" + fi.CreatorDepName + ",";
            string namelist = fi.CreatorRealName + "(" + fi.CreatorDepName + "),";
            WC.WebUI.Dk.Help.AdminSendMail(title, content, rid, userlist, namelist);            
        }

        private bool IsAllVerifid()
        {
            bool b = true; 
            FlowsInfo fi = ViewState["Flow"] as FlowsInfo;
            IList list = Flows_StepAction.Init().GetAll("OperationStepID=" + fi.CurrentStepID + " and FlowID=" + fi.id, null);
            string[] array = fi.CurrentStepUserList.Split(',');
            List<string> li_user = new List<string>();
            List<string> li_step = new List<string>();
            for (int i = 0; i < array.Length; i++)
            {
                if (array[i].Contains("#"))
                    li_user.Add(array[i].Split('#')[1]);
            }
            foreach (object obj in list)
            {
                Flows_StepActionInfo fsai = obj as Flows_StepActionInfo;
                li_step.Add(fsai.UserID.ToString());
            }
            if (li_step.Count != li_user.Count)
                return false;
            foreach (string ss in li_user)
            {
                if (!li_step.Contains(ss))
                    return false;
            }
            return b;
        }

        private void Show(string fid)
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


            FlowsInfo fi = Flows.Init().GetById(Convert.ToInt32(fid));

            if (fi.CurrentStepUserList.Contains("#" + Uid + "#") || fi.HasOperatedUserList.Contains("#" + Uid + "#") || fi.ViewUserList.Contains("#" + Uid + "#") || (fi.CreatorID == Convert.ToInt32(Uid)) || Modules.Contains("28"))
            {
                ViewState["Flow"] = fi;
                filepath.Value = fi.CurrentDocPath;
                DocBody.Value = fi.DocBody;
                Flow_Name1.InnerText = fi.Flow_Name;

                ModelType.InnerText = GetModelType(fi.ComID);

                ke_isread = "true";

                url = url.ToLower().Replace("/manage/flow", "");
                LoadOriginalFile = url + fi.CurrentDocPath.ToString();

                tuli.InnerHtml = " <a href='Flow_Graph.aspx?fl=" + fi.id + "' target=_blank>[点击查看]</a>";
                flowNo.InnerText = fi.AddTime.Year + "-" + (100000 + fi.id);

                status.InnerText = GetStatus(fi.Status);
                creator.InnerText = fi.CreatorRealName + "(" + fi.CreatorDepName + ")";
                addtime.InnerText = WC.Tool.Utils.ConvertDate2(fi.AddTime);
                vlidtime.InnerText = "永不过期";
                if (fi.IsValid == 1)
                    vlidtime.InnerText = fi.ValidTime.ToString("yyyy-MM-dd") + " 之前";

                currentstepname.InnerText = fi.CurrentStepName;
                if (!string.IsNullOrEmpty(fi.Remark))
                    bodys.InnerHtml = fi.Remark.Replace("\n", "<br>");

                IList list_flowdoc = Flows_Doc.Init().GetAll("flow_id=" + fi.id, "order by id asc");
                List<TmpInfo> li = new List<TmpInfo>();
                List<TmpInfo> li_last = new List<TmpInfo>();
                List<TmpInfo> li_final = new List<TmpInfo>();
                Flows_DocInfo ti_last = null;
                for(int j=0;j<list_flowdoc.Count;j++)
                {
                    Flows_DocInfo dc = list_flowdoc[j] as Flows_DocInfo;
                    if (j == list_flowdoc.Count - 1) { ti_last = dc; }
                    if (dc.DocPath.Contains("|"))
                    {
                        string[] array = dc.DocPath.Split('|');
                        for (int i = 0; i < array.Length; i++)
                        {
                            if (array[i].Trim() != "")
                            {
                                TmpInfo ti = new TmpInfo();
                                int t = array[i].LastIndexOf('/') + 1;
                                string filename = array[i].Substring(t, array[i].Length - t);
                                string fileurl = array[i].ToString();
                                ti.Tmp1 = array[i];
                                ti.Tmp2 = filename;
                                ti.Tmp3 = Server.UrlEncode(fileurl);
                                ti.Tmp4 = " &nbsp;&nbsp; <span style='color:#999'> &nbsp; - (" + dc.UserRealName + "&nbsp;" + WC.Tool.Utils.ConvertDate1(dc.AddTime) + ")</span>";
                                li.Add(ti);
                            }
                        }
                    }
                }

                if (ti_last != null)
                {
                    if (ti_last.DocPath.Contains("|"))
                    {
                        string[] array = ti_last.DocPath.Split('|');
                        for (int i = 0; i < array.Length; i++)
                        {
                            if (array[i].Trim() != "")
                            {
                                TmpInfo ti = new TmpInfo();
                                int t = array[i].LastIndexOf('/') + 1;
                                string filename = array[i].Substring(t, array[i].Length - t);
                                string fileurl = array[i].ToString();
                                ti.Tmp1 = array[i];
                                ti.Tmp2 = filename;
                                ti.Tmp3 = Server.UrlEncode(fileurl);
                                ti.Tmp4 = " &nbsp;&nbsp; <span style='color:#999'> &nbsp; - (" + ti_last.UserRealName + "&nbsp;" + WC.Tool.Utils.ConvertDate1(ti_last.AddTime) + ")</span>";
                                li_last.Add(ti);
                            }
                        }
                    }

                }

                for (int i = 0; i < li_last.Count; i++)
                {
                    TmpInfo t_last = li_last[i];
                    for (int j = 0; j < li.Count; j++)
                    {
                        TmpInfo t_li = li[j];
                        if (t_last.Tmp1 == t_li.Tmp1)
                        {
                            t_last.Tmp4 = t_li.Tmp4;
                            break;
                        }
                    }
                    li_final.Add(t_last);
                }

                if (li_final.Count > 0)
                {
                    rpt.DataSource = li_final;
                    rpt.DataBind();
                }

                Flows_StepInfo fsi = Flows_Step.Init().GetById(fi.CurrentStepID);
                ViewState["CurrentStep"] = fsi;

                string cur = "";
                IList list1 = Flows_StepAction.Init().GetAll("OperationStepID=" + fi.CurrentStepID + " and FlowID=" + fi.id, "order by id asc");
                string[] array1 = fi.CurrentStepUserList.Split(',');
                List<string> li_user = new List<string>();
                for (int i = 0; i < array1.Length; i++)
                {
                    if (array1[i].Contains("#"))
                        li_user.Add(array1[i].Split('#')[0].Trim());
                }
                foreach (object obj in list1)
                {
                    Flows_StepActionInfo tmp = obj as Flows_StepActionInfo;
                    if (tmp.Operation == 1)
                    {
                        cur += tmp.UserRealName + "[已签/同意], ";
                        if (li_user.Contains(tmp.UserRealName.Trim()))
                            li_user.Remove(tmp.UserRealName.Trim());
                    }
                    if (tmp.Operation == -1)
                    {
                        cur += tmp.UserRealName + "[已签/不同意], ";
                        if (li_user.Contains(tmp.UserRealName.Trim()))
                            li_user.Remove(tmp.UserRealName.Trim());
                    }
                }
                foreach (string s1 in li_user)
                {
                    cur += s1 + "[未审批], ";
                }
                currentuserlist.InnerHtml = cur;

                IList list2 = Flows_StepAction.Init().GetAll("FlowID=" + fi.id, "order by id asc");
                IList list3 = Flows_Doc.Init().GetAll("StepAction_ID=0 and flow_id=" + fi.id, null);
                Flows_DocInfo gds = list3[0] as Flows_DocInfo;
                string oridoc = Server.UrlEncode(gds.DocPath.ToString());
                yjs += "0、<u>流程申请</u> &nbsp;&nbsp; " + fi.CreatorRealName + " 在 " + WC.Tool.Utils.ConvertDate2(fi.AddTime) +
                    " 发起流程(申请人) &nbsp;&nbsp; <a href='/Manage/Flow/DocBodyView.aspx?gid=" + gds.id + "' target='_blank' ><strong>查看申请人原件</strong></a> <br>";
                foreach (object obj in list2)
                {
                    Flows_StepActionInfo tmp = obj as Flows_StepActionInfo;
                    IList glist = Flows_Doc.Init().GetAll("StepAction_ID=" + tmp.id, null);
                    if (glist.Count == 0)
                    {
                        yjs += list2.IndexOf(obj) + 1 + "、<u>" + tmp.OperationStepName + "</u> &nbsp;&nbsp; " + tmp.UserRealName
                            + " 在 " + WC.Tool.Utils.ConvertDate2(tmp.AddTime) + " 已审  &nbsp;&nbsp;<strong style='color:#ff0000'>" + tmp.OperationWord + "</strong><br>";
                    }
                    else
                    {
                        Flows_DocInfo gd = glist[0] as Flows_DocInfo;
                        string docpath = Server.UrlEncode(gd.DocPath.ToString());
                        yjs += list2.IndexOf(obj) + 1 + "、<u>" + tmp.OperationStepName + "</u> &nbsp;&nbsp; " + tmp.UserRealName
                            + " 在 " + WC.Tool.Utils.ConvertDate2(tmp.AddTime) + " 已审 " + tmp.OperationWord
                            + " &nbsp;&nbsp; <a href='/Manage/Flow/DocBodyView.aspx?gid=" + gd.id + "' target='_blank' ><strong>查看文件变动</strong></a> "
                            + "<br>";
                    }
                }

                if (fi.ViewUserList.Contains(","))
                {
                    string[] array_view = fi.ViewUserList.Split(',');
                    for (int i = 0; i < array_view.Length; i++)
                    {
                        if (array_view[i].Contains("#"))
                        {
                            viewuserlist.InnerText += array_view[i].Split('#')[0] + ",";
                        }
                    }
                }

                if (li_user.Contains(RealName.Trim()) && fi.Status == 0)
                {
                    ke_isread = "false";

                    display.Visible = true;
                    //wordedit1.Visible = true;
                    b1.Enabled = true;
                    b2.Enabled = true;

                    IList list_seal = Sys_Seal.Init().GetAll("uid=" + Uid + " and status=1", null);
                    if (list_seal.Count > 0)
                    {
                        seal.Visible = true;
                        seallist.DataSource = list_seal;
                        seallist.DataTextField = "SealName";
                        seallist.DataValueField = "id";
                        seallist.DataBind();
                    }

                    if (fsi.RightToFinish == 1)
                        b3.Enabled = true;
                    if (fsi.IsUserFile == 1)
                    {
                        for (int i = 0; i < this.rpt.Items.Count; i++)
                        {
                            HtmlInputCheckBox cb = this.rpt.Items[i].FindControl("chk") as HtmlInputCheckBox;
                            cb.Disabled = false;
                        }
                    }
                }
            }

            else
            {
                Response.Write("<script>alert('您没有查看权限');window.location='Flow_List.aspx?action=verify';</script>");
            }

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
            an.Step_Orders = fsi.Step_Orders;
            an.Step_Remark = fsi.Step_Remark;
            an.userlist = fsi.userlist;
            an.Acts = fsi.Acts;
            Flows_Step.Init().Add(an);
            return an;
        }

        private string GetStatus(int t)
        {
            if (t == 0)
            {
                return "流程审批中";
            }
            else if (t == 1)
            {
                return "流程已完成";
            }
            else if (t == -1)
            {
                return "流程已锁定";
            }
            else if (t == -2)
            {
                return "流程已退回";
            }
            else
            {
                return "已过期";
            }
        }

        private void AddDoc(int fid, int stepid)
        {
            Flows_DocInfo gi = new Flows_DocInfo();
            gi.AddTime = DateTime.Now;
            gi.DocPath = UpdateFiles();
            gi.DocBody = DocBody.Value;
            gi.Flow_ID = fid;
            gi.StepAction_ID = stepid;
            gi.UserDepName = DepName;
            gi.UserRealName = RealName;
            gi.UserID = Convert.ToInt32(Uid);
            Flows_Doc.Init().Add(gi);
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

                foreach (RepeaterItem item in rpt.Items)
                {
                    HtmlInputCheckBox hick = item.FindControl("chk") as HtmlInputCheckBox;
                    if (hick.Checked)
                    {
                        old += hick.Value + "|";
                    }
                }

                if (display.Visible == true)
                {
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
            }
            catch (IOException ex)
            {
                throw ex;
            }

            return fnames;
        }

        protected bool IsOfficeFile(string filename)
        {
            bool b = false;
            if (filename.Contains("."))
            {
                string t = filename.Split('.')[1].ToLower();
                if (t.Contains("doc") || t.Contains("xls"))
                {
                    b = true;
                }
            }
            return b;
        }

        private string GetModelType(int comid)
        {
            string r = "暂无分类";
            if (comid > 0)
            {
                IList list = Flows_Model_Type.Init().GetAll("id=" + comid, null);
                if (list.Count > 0)
                {
                    Flows_Model_TypeInfo fti = list[0] as Flows_Model_TypeInfo;
                    r = fti.TypeName;
                }
            }
            return r;
        }

    }
}
