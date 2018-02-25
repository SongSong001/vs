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

namespace WC.WebUI.Mobile.Flows
{
    public partial class FlowView : WC.BLL.MobilePage
    {
        protected string fj = "<a href='/Manage/Utils/Download.aspx?destFileName={0}' ><img src='/img/mail_attachment.gif' />{1}</a>&nbsp;&nbsp;";
        protected string yjs = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["fl"]) && !IsPostBack)
            {
                Show(Request.QueryString["fl"]);
            }
            
        }

        protected void VerifyStep_Btn(object sender, EventArgs e)
        {
            FlowsInfo fii = WC.BLL.Flows.Init().GetById(Convert.ToInt32(Request.QueryString["fl"]));
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
                    //fi.DocBody = DocBody.Value;
                    if (!IsAllVerifid()) // 全体审批才 完成流程
                    {
                        fi.HasOperatedUserList += RealName + "#" + Uid + "#" + DepName + ",";
                        //fi.Flow_Files = UpdateFiles();
                        WC.BLL.Flows.Init().Update(fi);

                        WC.Tool.MessageBox.ShowAndRedirect(this, "成功审批!", "FlowMenu.aspx");
                    }
                    else
                    {
                        fi.HasOperatedUserList += RealName + "#" + Uid + "#" + DepName + ",";
                        //fi.Flow_Files = UpdateFiles();
                        WC.BLL.Flows.Init().Update(fi);
                        FinishFlow();
                        WC.Tool.MessageBox.ShowAndRedirect(this, "成功审批!流程已全部完成!", "FlowMenu.aspx");
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
                            WC.BLL.Flows.Init().Update(fi);

                            WC.Tool.MessageBox.ShowAndRedirect(this, "成功审批!", "FlowMenu.aspx");
                        }
                    }

                }

            }

        }

        protected void RefuseStep_Btn(object sender, EventArgs e)
        {
            FlowsInfo fii = WC.BLL.Flows.Init().GetById(Convert.ToInt32(Request.QueryString["fl"]));
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
                    WC.BLL.Flows.Init().Update(fii);
                    BackFlow();

                    WC.Tool.MessageBox.ShowAndRedirect(this, "操作成功,流程已退回!", "FlowMenu.aspx");
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
                            fi.CurrentStepID = next_fsi.id;
                            fi.CurrentStepName = next_fsi.Step_Name;
                            fi.CurrentStepUserList = next_fsi.userlist;
                            fi.HasOperatedUserList += RealName + "#" + Uid + "#" + DepName + ",";
                            //fi.Flow_Files = UpdateFiles();
                            WC.BLL.Flows.Init().Update(fi);

                            //短信插入代码
                            Dk.Help.FlowMobleSend(next_fsi.userlist, fi.Flow_Name);

                            WC.Tool.MessageBox.ShowAndRedirect(this, "操作成功,流程已返回上个环节!", "FlowMenu.aspx");
                        }

                    }

                }

            }

        }

        protected void CompleteStep_Btn(object sender, EventArgs e)
        {
            FlowsInfo fii = WC.BLL.Flows.Init().GetById(Convert.ToInt32(Request.QueryString["fl"]));
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
                WC.BLL.Flows.Init().Update(fii);

                FinishFlow();

                WC.Tool.MessageBox.ShowAndRedirect(this, "工作流程已审批完成!", "FlowMenu.aspx");
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
            FlowsInfo fi = WC.BLL.Flows.Init().GetById(Convert.ToInt32(fid));

            if (fi.CurrentStepUserList.Contains("#" + Uid + "#") || fi.HasOperatedUserList.Contains("#" + Uid + "#") || fi.ViewUserList.Contains("#" + Uid + "#") || (fi.CreatorID == Convert.ToInt32(Uid)) || Modules.Contains("28"))
            {
                ViewState["Flow"] = fi;
                filepath.Value = fi.CurrentDocPath;
                DocBody.InnerHtml = fi.DocBody;
                Flow_Name1.InnerText ="标题："+fi.Flow_Name;


                status.InnerText = GetStatus(fi.Status);
                creator.InnerText = fi.CreatorRealName + "(" + fi.CreatorDepName + ")";
                addtime.InnerText = WC.Tool.Utils.ConvertDate1(fi.AddTime);
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
                for (int j = 0; j < list_flowdoc.Count; j++)
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
                                ti.Tmp4 = "<span style='color:#999'>(" + dc.UserRealName + "&nbsp;" + WC.Tool.Utils.ConvertDate1(dc.AddTime) + ")</span>";
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
                                ti.Tmp4 = "<span style='color:#999'>(" + ti_last.UserRealName + "&nbsp;" + WC.Tool.Utils.ConvertDate1(ti_last.AddTime) + ")</span>";
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
                yjs += "0、<u>流程申请</u> &nbsp; " + fi.CreatorRealName + " 在 " + WC.Tool.Utils.ConvertDate2(fi.AddTime) +
                    " 发起流程(申请人) <br>";
                foreach (object obj in list2)
                {
                    Flows_StepActionInfo tmp = obj as Flows_StepActionInfo;
                    IList glist = Flows_Doc.Init().GetAll("StepAction_ID=" + tmp.id, null);
                    if (glist.Count == 0)
                    {
                        yjs += list2.IndexOf(obj) + 1 + "、<u>" + tmp.OperationStepName + "</u> &nbsp; " + tmp.UserRealName
                            + " 在 " + WC.Tool.Utils.ConvertDate2(tmp.AddTime) + " 已审 &nbsp;<strong style='color:#ff0000'>" + tmp.OperationWord + "</strong><br>";
                    }
                    else
                    {
                        Flows_DocInfo gd = glist[0] as Flows_DocInfo;
                        string docpath = Server.UrlEncode(gd.DocPath.ToString());
                        yjs += list2.IndexOf(obj) + 1 + "、<u>" + tmp.OperationStepName + "</u> &nbsp; " + tmp.UserRealName
                            + " 在 " + WC.Tool.Utils.ConvertDate2(tmp.AddTime) + " 已审 " + tmp.OperationWord + "<br>";
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
                    displays.Visible = true;

                    b1.Enabled = true;
                    b2.Enabled = true;

                    if (fsi.RightToFinish == 1)
                    {
                        b3.Visible = true;
                        b3.Enabled = true;
                    }
                }

            }

            else
            {
                Response.Write("<script>alert('您没有查看权限');window.location='FlowList.aspx?action=verify';</script>");
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

        private void AddDoc(int fid, int stepid)
        {
            FlowsInfo fi = ViewState["Flow"] as FlowsInfo;

            Flows_DocInfo gi = new Flows_DocInfo();
            gi.AddTime = DateTime.Now;
            gi.DocPath = UpdateFiles();
            gi.DocBody = fi.DocBody;
            gi.Flow_ID = fid;
            gi.StepAction_ID = stepid;
            gi.UserDepName = DepName;
            gi.UserRealName = RealName;
            gi.UserID = Convert.ToInt32(Uid);
            Flows_Doc.Init().Add(gi);
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

                if (displays.Visible == true)
                {
                    for (int i = 0; i < files.Count; i++)
                    {
                        System.Web.HttpPostedFile f = files[i];
                        if (WC.Tool.Config.IsValidFile(f))
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

    }
}