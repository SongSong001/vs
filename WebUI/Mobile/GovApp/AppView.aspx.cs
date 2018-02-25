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

namespace WC.WebUI.Mobile.GovApp
{
    public partial class AppView : WC.BLL.MobilePage
    {
        protected string fj = "<a href='/Manage/Utils/Download.aspx?destFileName={0}' ><img src='/img/mail_attachment.gif' />{1}</a>&nbsp;&nbsp;";
        protected string yjs = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!string.IsNullOrEmpty(Request.QueryString["fl"]))
                {
                    Show(Request.QueryString["fl"]);
                }
            }
        }

        protected void VerifyStep_Btn(object sender, EventArgs e)
        {
            GovInfo fii = WC.BLL.Gov.Init().GetById(Convert.ToInt32(Request.QueryString["fl"]));
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
                Gov_StepInfo fsi = ViewState["CurrentStep"] as Gov_StepInfo;
                Gov_StepActionInfo fsai = new Gov_StepActionInfo();
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
                    Gov_StepAction.Init().Add(fsai);
                    GovInfo fi = fii;
                    AddDoc(fi.id, fsai.id);
                    fi.CurrentDocPath = filepath.Value;
                    //fi.DocBody = DocBody.Value;
                    if (!IsAllVerifid()) // 全体操作才 完成公文
                    {
                        fi.HasOperatedUserList += RealName + "#" + Uid + "#" + DepName + ",";
                        fi.Flow_Files = UpdateFiles();
                        WC.BLL.Gov.Init().Update(fi);

                        WC.Tool.MessageBox.ShowAndRedirect(this, "公文成功审批!", "AppMenu.aspx");
                    }
                    else
                    {
                        fi.HasOperatedUserList += RealName + "#" + Uid + "#" + DepName + ",";
                        fi.Flow_Files = UpdateFiles();
                        WC.BLL.Gov.Init().Update(fi);
                        FinishFlow();

                        WC.Tool.MessageBox.ShowAndRedirect(this, "成功操作,公文已签发!", "AppMenu.aspx");
                    }
                }
                else
                {
                    IList mlist = Gov_Step.Init().GetAll("isact=0 and flow_id=" + Request.QueryString["fl"], "order by id asc");
                    if (mlist != null)
                    {
                        int index = 0;
                        foreach (object obj in mlist)
                        {
                            Gov_StepInfo tmp = obj as Gov_StepInfo;
                            if (tmp.Acts == fsi.Acts)
                                index = mlist.IndexOf(obj) + 1;
                        }
                        if (index != 0)
                        {
                            Gov_StepAction.Init().Add(fsai);
                            GovInfo fi = fii;
                            AddDoc(fi.id, fsai.id);
                            fi.CurrentDocPath = filepath.Value;
                            //fi.DocBody = DocBody.Value;
                            if (IsAllVerifid()) // 全体操作才 下一步骤
                            {
                                Gov_StepInfo next_fsi = MakeNewFsi((Gov_StepInfo)mlist[index]);
                                fi.CurrentStepID = next_fsi.id;
                                fi.CurrentStepName = next_fsi.Step_Name;
                                fi.CurrentStepUserList = next_fsi.userlist;

                                //短信插入代码
                                Dk.Help.GovMobleSend(next_fsi.userlist, fi.Flow_Name);
                            }
                            fi.HasOperatedUserList += RealName + "#" + Uid + "#" + DepName + ",";
                            fi.Flow_Files = UpdateFiles();
                            WC.BLL.Gov.Init().Update(fi);

                            WC.Tool.MessageBox.ShowAndRedirect(this, "已成功操作!", "AppMenu.aspx");
                        }
                    }

                }

            }

        }

        protected void RefuseStep_Btn(object sender, EventArgs e)
        {
            GovInfo fii = WC.BLL.Gov.Init().GetById(Convert.ToInt32(Request.QueryString["fl"]));
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
                Gov_StepInfo fsi = ViewState["CurrentStep"] as Gov_StepInfo;
                Gov_StepActionInfo fsai = new Gov_StepActionInfo();
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
                    Gov_StepAction.Init().Add(fsai);
                    AddDoc(fsai.FlowID, fsai.id);
                    fii.CurrentDocPath = filepath.Value;
                    //fii.DocBody = DocBody.Value;
                    WC.BLL.Gov.Init().Update(fii);
                    BackFlow();

                    WC.Tool.MessageBox.ShowAndRedirect(this, "成功操作,公文已退回拟稿人!", "AppMenu.aspx");
                }
                else
                {
                    IList mlist = Gov_Step.Init().GetAll("isact=0 and flow_id=" + Request.QueryString["fl"], "order by id asc");
                    if (mlist != null)
                    {
                        int index = -1;
                        foreach (object obj in mlist)
                        {
                            Gov_StepInfo tmp = obj as Gov_StepInfo;
                            if (tmp.Acts == fsi.Acts)
                                index = mlist.IndexOf(obj) - 1;
                        }
                        if (index >= 0)
                        {
                            Gov_StepInfo next_fsi = MakeNewFsi((Gov_StepInfo)mlist[index]);
                            Gov_StepAction.Init().Add(fsai);
                            GovInfo fi = fii;
                            AddDoc(fsai.FlowID, fsai.id);
                            fi.CurrentDocPath = filepath.Value;
                            //fi.DocBody = DocBody.Value;
                            fi.CurrentStepID = next_fsi.id;
                            fi.CurrentStepName = next_fsi.Step_Name;
                            fi.CurrentStepUserList = next_fsi.userlist;
                            fi.HasOperatedUserList += RealName + "#" + Uid + "#" + DepName + ",";
                            fi.Flow_Files = UpdateFiles();
                            WC.BLL.Gov.Init().Update(fi);
                            //短信插入代码
                            Dk.Help.GovMobleSend(next_fsi.userlist, fi.Flow_Name);
                            WC.Tool.MessageBox.ShowAndRedirect(this, "成功操作,公文已返回!", "AppMenu.aspx");

                        }

                    }

                }

            }

        }

        protected void CompleteStep_Btn(object sender, EventArgs e)
        {
            GovInfo fii = WC.BLL.Gov.Init().GetById(Convert.ToInt32(Request.QueryString["fl"]));
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
                Gov_StepInfo fsi = ViewState["CurrentStep"] as Gov_StepInfo;
                Gov_StepActionInfo fsai = new Gov_StepActionInfo();
                fsai.AddTime = DateTime.Now;
                fsai.FlowID = Convert.ToInt32(Request.QueryString["fl"]);
                fsai.Operation = 1;
                fsai.OperationStepID = fsi.id;
                fsai.OperationWord = "(同意 并签发公文) ：" + Request.Form["FlowRemark"];
                fsai.UserDepName = DepName;
                fsai.UserID = Convert.ToInt32(Uid);
                fsai.UserRealName = RealName;
                fsai.OperationStepName = fsi.Step_Name;
                //fsai.BackStepID = 0;

                Gov_StepAction.Init().Add(fsai);
                AddDoc(fsai.FlowID, fsai.id);
                fii.CurrentDocPath = filepath.Value;
                //fii.DocBody = DocBody.Value;
                WC.BLL.Gov.Init().Update(fii);

                FinishFlow();

                WC.Tool.MessageBox.ShowAndRedirect(this, "公文已操作签发!", "AppMenu.aspx");
            }
        }

        private void FinishFlow()
        {
            GovInfo fi = ViewState["Flow"] as GovInfo;
            string t = fi.HasOperatedUserList + RealName + "#" + Uid + "#" + DepName + ",";
            string sql = "update Gov set Status=1,HasOperatedUserList='" + t +
                "' where status=0 and id=" + Request.QueryString["fl"];
            MsSqlOperate.ExecuteNonQuery(CommandType.Text, sql);

            string title = "[系统通知] : 您拟稿的公文(" + fi.Flow_Name + ") 已通过审批正式签发!";
            string content = "恭喜您! 公文通过所有审核审批步骤 已成功签发!";
            int rid = fi.CreatorID;
            string userlist = fi.CreatorRealName + "#" + fi.CreatorID + "#" + fi.CreatorDepName + ",";
            string namelist = fi.CreatorRealName + "(" + fi.CreatorDepName + "),";
            WC.WebUI.Dk.Help.AdminSendMail(title, content, rid, userlist, namelist);
        }

        private void BackFlow()
        {
            GovInfo fi = ViewState["Flow"] as GovInfo;
            string t = fi.HasOperatedUserList + RealName + "#" + Uid + "#" + DepName + ",";
            string sql = "update Gov set Status=-2,HasOperatedUserList='" + t +
                "' where status=0 and id=" + Request.QueryString["fl"];
            MsSqlOperate.ExecuteNonQuery(CommandType.Text, sql);

            string title = "[系统通知] : 您拟稿的公文(" + fi.Flow_Name + ") 已被退回!";
            string content = "您拟稿的公文 没有被审核通过!";
            int rid = fi.CreatorID;
            string userlist = fi.CreatorRealName + "#" + fi.CreatorID + "#" + fi.CreatorDepName + ",";
            string namelist = fi.CreatorRealName + "(" + fi.CreatorDepName + "),";
            WC.WebUI.Dk.Help.AdminSendMail(title, content, rid, userlist, namelist);
        }

        private bool IsAllVerifid()
        {
            bool b = true;
            GovInfo fi = ViewState["Flow"] as GovInfo;
            IList list = Gov_StepAction.Init().GetAll("OperationStepID=" + fi.CurrentStepID + " and FlowID=" + fi.id, null);
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
                Gov_StepActionInfo fsai = obj as Gov_StepActionInfo;
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
            GovInfo fi = WC.BLL.Gov.Init().GetById(Convert.ToInt32(fid));

            if (fi.CurrentStepUserList.Contains("#" + Uid + "#") || fi.HasOperatedUserList.Contains("#" + Uid + "#") || (fi.CreatorID == Convert.ToInt32(Uid)) || Modules.Contains("38"))
            {
                ViewState["Flow"] = fi;
                filepath.Value = fi.CurrentDocPath;
                DocBody.InnerHtml = fi.DocBody;
                Flow_Name1.InnerText = "标题：" + fi.Flow_Name;

                ModelType.InnerText = GetModelType(fi.ComID);

                secret.InnerText = fi.Secret;


                status.InnerText = GetStatus(fi.Status);
                creator.InnerText = fi.CreatorRealName + "(" + fi.CreatorDepName + ")";
                addtime.InnerText = WC.Tool.Utils.ConvertDate2(fi.AddTime);
                DocNo.InnerText = fi.DocNo;
                vlidtime.InnerText = "自动归档";
                if (fi.IsValid == 1)
                    vlidtime.InnerText = fi.ValidTime.ToString("yyyy-MM-dd") + " 之前归档";

                currentstepname.InnerText = fi.CurrentStepName;
                if (!string.IsNullOrEmpty(fi.Remark))
                    bodys.InnerHtml = fi.Remark.Replace("\n", "<br>");

                if (!string.IsNullOrEmpty(fi.Flow_Files))
                {
                    if (fi.Flow_Files.Contains("|"))
                    {
                        List<TmpInfo> li = new List<TmpInfo>();
                        string[] array = fi.Flow_Files.Split('|');
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
                                li.Add(ti);
                            }
                        }
                        rpt.DataSource = li;
                        rpt.DataBind();
                    }
                }

                Gov_StepInfo fsi = Gov_Step.Init().GetById(fi.CurrentStepID);
                ViewState["CurrentStep"] = fsi;

                string cur = "";
                IList list1 = Gov_StepAction.Init().GetAll("OperationStepID=" + fi.CurrentStepID + " and FlowID=" + fi.id, "order by id asc");
                string[] array1 = fi.CurrentStepUserList.Split(',');
                List<string> li_user = new List<string>();
                for (int i = 0; i < array1.Length; i++)
                {
                    if (array1[i].Contains("#"))
                        li_user.Add(array1[i].Split('#')[0].Trim());
                }
                foreach (object obj in list1)
                {
                    Gov_StepActionInfo tmp = obj as Gov_StepActionInfo;
                    if (tmp.Operation == 1)
                    {
                        cur += tmp.UserRealName + "[已审/同意], ";
                        if (li_user.Contains(tmp.UserRealName.Trim()))
                            li_user.Remove(tmp.UserRealName.Trim());
                    }
                    if (tmp.Operation == -1)
                    {
                        cur += tmp.UserRealName + "[已阅/不同意], ";
                        if (li_user.Contains(tmp.UserRealName.Trim()))
                            li_user.Remove(tmp.UserRealName.Trim());
                    }
                }
                foreach (string s1 in li_user)
                {
                    cur += s1 + "[未操作], ";
                }
                currentuserlist.InnerHtml = cur;

                IList list2 = Gov_StepAction.Init().GetAll("FlowID=" + fi.id, "order by id asc");
                IList list3 = Gov_Doc.Init().GetAll("StepAction_ID=0 and flow_id=" + fi.id, null);
                Gov_DocInfo gds = list3[0] as Gov_DocInfo;
                string oridoc = Server.UrlEncode(gds.DocPath.ToString());
                yjs += "0、<u>发文拟稿</u> &nbsp;" + fi.CreatorRealName + " 在 " + WC.Tool.Utils.ConvertDate2(fi.AddTime) +
                    " 发起公文(初稿) &nbsp;<br>";
                foreach (object obj in list2)
                {
                    Gov_StepActionInfo tmp = obj as Gov_StepActionInfo;
                    IList glist = Gov_Doc.Init().GetAll("StepAction_ID=" + tmp.id, null);
                    if (glist.Count == 0)
                    {
                        yjs += list2.IndexOf(obj) + 1 + "、<u>" + tmp.OperationStepName + "</u> &nbsp;" + tmp.UserRealName
                            + " 在 " + WC.Tool.Utils.ConvertDate2(tmp.AddTime) + " 已阅 &nbsp;<strong style='color:#ff0000'>" + tmp.OperationWord + "</strong><br>";
                    }
                    else
                    {
                        Gov_DocInfo gd = glist[0] as Gov_DocInfo;
                        string docpath = Server.UrlEncode(gd.DocPath.ToString());
                        yjs += list2.IndexOf(obj) + 1 + "、<u>" + tmp.OperationStepName + "</u> &nbsp;&nbsp; " + tmp.UserRealName
                            + " 在 " + WC.Tool.Utils.ConvertDate2(tmp.AddTime) + " 已阅 &nbsp;<strong style='color:#ff0000'>" + tmp.OperationWord
                            + "</strong><br>";
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
                Response.Write("<script>alert('您没有查看权限');window.location='AppList.aspx?action=verify';</script>");
            }

        }

        private Gov_StepInfo MakeNewFsi(Gov_StepInfo fsi)
        {
            Gov_StepInfo an = new Gov_StepInfo();
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
            Gov_Step.Init().Add(an);
            return an;
        }

        private string GetStatus(int t)
        {
            if (t == 0)
            {
                return "公文审批中";
            }
            else if (t == 1)
            {
                return "公文已签发";
            }
            else if (t == -1)
            {
                return "公文已锁定";
            }
            else if (t == -2)
            {
                return "公文已退回";
            }
            else if (t == 5)
            {
                return "公文已归档";
            }
            else
            {
                return "已过期";
            }
        }

        private void AddDoc(int fid, int stepid)
        {
            GovInfo fi = ViewState["Flow"] as GovInfo;

            Gov_DocInfo gi = new Gov_DocInfo();
            gi.AddTime = DateTime.Now;
            gi.DocPath = filepath.Value;
            gi.DocBody = fi.DocBody;
            gi.Flow_ID = fid;
            gi.StepAction_ID = stepid;
            gi.UserDepName = DepName;
            gi.UserRealName = RealName;
            gi.UserID = Convert.ToInt32(Uid);
            Gov_Doc.Init().Add(gi);
        }

        //上传所有附件,并返回 文件保存位置字符串集合
        private string UpdateFiles()
        {
            string fnames = "";
            System.Web.HttpFileCollection files = System.Web.HttpContext.Current.Request.Files;

            //得到或创建 上传目录
            string timeFolder = DateTime.Now.ToString("yyMMdd");
            string path = Server.MapPath("~/Files/GovFiles/");
            string tmp = "~/Files/GovFiles/" + timeFolder + "/";
            path += timeFolder;
            if (!Directory.Exists(path))
            {
                WC.Tool.FileSystemManager.CreateFolder(timeFolder, Server.MapPath("~/Files/GovFiles"));
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

        private string GetModelType(int comid)
        {
            string r = "暂无分类";
            if (comid > 0)
            {
                IList list = Gov_Model_Type.Init().GetAll("id=" + comid, null);
                if (list.Count > 0)
                {
                    Gov_Model_TypeInfo fti = list[0] as Gov_Model_TypeInfo;
                    r = fti.TypeName;
                }
            }
            return r;
        }

    }
}