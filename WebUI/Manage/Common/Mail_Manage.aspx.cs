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
using WC.DBUtility;

namespace WC.WebUI.Manage.Common
{
    public partial class Mail_Manage : WC.BLL.ViewPages
    {
        private int ct = 0;
        private object tobj = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Show();

                if (!string.IsNullOrEmpty(Request.QueryString["userlist"]))
                {
                    string uid = Request.QueryString["userlist"];
                    if (WC.Tool.Utils.IsNumber(uid))
                    {
                        Sys_UserInfo ui = Sys_User.Init().GetById(Convert.ToInt32(uid));
                        userlist.Value = ui.RealName.Trim() + "#" + ui.id + "#" + ui.DepName.Trim() + ",";
                        namelist.Value = ui.RealName.Trim() + "(" + ui.DepName.Trim() + "),";
                    }
                }
                if (!string.IsNullOrEmpty(Request.QueryString["deplist"]))
                {
                    string did = Request.QueryString["deplist"];
                    if (WC.Tool.Utils.IsNumber(did))
                    {
                        IList list = new List<Sys_UserInfo>();
                        GetTreeItems(Convert.ToInt32(did), list);

                        string _userlist = "";
                        string _namelist = "";
                        foreach (object obj in list)
                        {
                            Sys_UserInfo ui = obj as Sys_UserInfo;
                            _userlist += ui.RealName.Trim() + "#" + ui.id + "#" + ui.DepName.Trim() + ",";
                            _namelist += ui.RealName.Trim() + "(" + ui.DepName.Trim() + "),";
                            userlist.Value = _userlist;
                            namelist.Value = _namelist;
                        }
                    }

                }
            }

        }

        private void GetTreeItems(int did, IList li)
        {
            IList list = Sys_User.Init().GetAll("DepID=" + did, "order by status asc,orders asc");
            foreach (object obj in list)
            {
                li.Add(obj);
            }

            IList father_dep_list = Sys_Dep.Init().GetAll("ParentID=" + did, "order by orders asc");
            if (father_dep_list.Count != 0)
            {
                foreach (Sys_DepInfo item in father_dep_list)
                {
                    GetTreeItems(item.id, li);
                }
            }
        }

        private void Show()
        {
            if (!string.IsNullOrEmpty(Uid))
            {
                SqlParameter rid = new SqlParameter();
                rid.ParameterName = "@uid";
                rid.Size = 7;
                rid.Value = Convert.ToInt32(Uid);

                SqlParameter sqlpt0 = new SqlParameter();
                sqlpt0.Direction = ParameterDirection.Output;
                sqlpt0.ParameterName = "@pt0";
                sqlpt0.Size = 7;

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

                SqlParameter[] sqls = { sqlpt0, sqlpt1, sqlpt2, sqlpt3, sqlpt4, rid };
                MsSqlOperate.ExecuteNonQuery(CommandType.StoredProcedure, "Mails_GetAllMailBoxCount", sqls);

                sjx.InnerText = sqlpt0.Value + "/" + sqlpt4.Value;
                cgx.InnerText = sqlpt1.Value + "";
                fjx.InnerText = sqlpt2.Value + "";
                ljx.InnerText = sqlpt3.Value + "";

                //回复邮件
                if (!string.IsNullOrEmpty(Request.QueryString["mid"]))
                {
                    string mid = Request.QueryString["mid"];
                    MailsInfo mi = Mails.Init().GetById(Convert.ToInt32(mid));

                    if (mi.ReceiverID == Convert.ToInt32(Uid) || mi.SenderID == Convert.ToInt32(Uid))
                    {
                        Mails_DetailInfo md = Mails_Detail.Init().GetById(mi.did);
                        Subject.Value = "回复：" + mi.Subject;

                        userlist.Value = mi.SenderRealName + "#" + mi.SenderID + "#" + mi.SenderDepName + ",";
                        namelist.Value = mi.SenderRealName + "(" + mi.SenderDepName + "),";

                        Bodys.Value = "<br><br><br><span style='font-weight:bold;color:#999999'>" + mi.SenderRealName + " (" + mi.SenderDepName + ")" + " 在 "
                            + WC.Tool.Utils.ConvertDate2(mi.SendTime) +
                            " 写道: </span><br>" + md.Bodys;

                        if (!string.IsNullOrEmpty(md.Attachments))
                        {
                            if (md.Attachments.Contains("|"))
                            {
                                Attachword.Visible = true;
                                List<TmpInfo> list = new List<TmpInfo>();
                                string[] array = md.Attachments.Split('|');
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
                                        ti.Tmp3 = fileurl;
                                        list.Add(ti);
                                    }
                                }
                                rpt.DataSource = list;
                                rpt.DataBind();
                            }
                        }
                    }

                }

                //草稿邮件
                if (!string.IsNullOrEmpty(Request.QueryString["cid"]))
                {
                    string cid = Request.QueryString["cid"];
                    MailsInfo mi = Mails.Init().GetById(Convert.ToInt32(cid));

                    if (mi.ReceiverID == Convert.ToInt32(Uid) || mi.SenderID == Convert.ToInt32(Uid))
                    {
                        Mails_DetailInfo md = Mails_Detail.Init().GetById(mi.did);
                        Subject.Value = mi.Subject;
                        if (!string.IsNullOrEmpty(md.SendIDs) && !string.IsNullOrEmpty(md.SendRealNames))
                        {
                            userlist.Value = md.SendIDs;
                            namelist.Value = md.SendRealNames;
                        }

                        if (!string.IsNullOrEmpty(md.CcIDs) && !string.IsNullOrEmpty(md.CcRealNames))
                        {
                            userlist_cc.Value = md.CcIDs;
                            namelist_cc.Value = md.CcRealNames;
                        }

                        if (!string.IsNullOrEmpty(md.BccIDs) && !string.IsNullOrEmpty(md.BccRealNames))
                        {
                            userlist_bcc.Value = md.BccIDs;
                            namelist_bcc.Value = md.BccRealNames;
                        }
                        Bodys.Value = md.Bodys;

                        if (!string.IsNullOrEmpty(md.Attachments))
                        {
                            if (md.Attachments.Contains("|"))
                            {
                                Attachword.Visible = true;
                                List<TmpInfo> list = new List<TmpInfo>();
                                string[] array = md.Attachments.Split('|');
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
                                        ti.Tmp3 = fileurl;
                                        list.Add(ti);
                                    }
                                }
                                rpt.DataSource = list;
                                rpt.DataBind();
                            }
                        }
                    }

                }

                //转发邮件
                if (!string.IsNullOrEmpty(Request.QueryString["zid"]))
                {
                    string cid = Request.QueryString["zid"];
                    MailsInfo mi = Mails.Init().GetById(Convert.ToInt32(cid));

                    if (mi.ReceiverID == Convert.ToInt32(Uid) || mi.SenderID == Convert.ToInt32(Uid))
                    {
                        Mails_DetailInfo md = Mails_Detail.Init().GetById(mi.did);
                        Subject.Value = "转发：" + mi.Subject;

                        Bodys.Value = "<br><br>" + md.Bodys;

                        if (!string.IsNullOrEmpty(md.Attachments))
                        {
                            if (md.Attachments.Contains("|"))
                            {
                                Attachword.Visible = true;
                                List<TmpInfo> list = new List<TmpInfo>();
                                string[] array = md.Attachments.Split('|');
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
                                        ti.Tmp3 = fileurl;
                                        list.Add(ti);
                                    }
                                }
                                rpt.DataSource = list;
                                rpt.DataBind();
                            }
                        }
                    }

                }

                //发送会议纪要
                if (!string.IsNullOrEmpty(Request.QueryString["meeting"]))
                {
                    MeetingInfo meet = Meeting.Init().GetById(Convert.ToInt32(Request.QueryString["meeting"]));
                    string _meet = "<br><br><table style='width:95%;' border='1' cellspacing='0' bordercolor='#c0bdbd' cellpadding='2'><tbody><tr><td style='width:95px;color:#222;font-weight:bold;'>&nbsp;会议主题：</td><td>{0}</td></tr><tr><td style='color:#222;font-weight:bold;'>&nbsp;时间/地点：</td><td>{1}</td></tr><tr><td style='color:#222;font-weight:bold;'>&nbsp;会议主持：</td><td>{2}</td></tr><tr><td style='color:#222;font-weight:bold;'>&nbsp;记录人员：</td><td>{3}</td></tr><tr><td style='color:#222;font-weight:bold;'>会议参加者：</td><td>{4}</td></tr><tr><td style='color:#222;font-weight:bold;'>会议缺席者：</td><td>{5}</td></tr><tr><td style='color:#222;font-weight:bold;'>&nbsp;会议纪要：</td><td>{6}</td></tr><tr><td style='color:#222;font-weight:bold;'>&nbsp;备注：</td><td>{7}</td></tr></tbody></table><br>";
                    Bodys.Value = string.Format(_meet, meet.MainTopics, meet.CTime + " &nbsp; &nbsp; &nbsp; " + meet.Address, meet.Chaired, meet.Recorder, meet.ListPerson, meet.AbsencePerson, meet.Bodys, meet.Remarks);

                    if (!string.IsNullOrEmpty(meet.FilePath))
                    {
                        if (meet.FilePath.Contains("|"))
                        {
                            Attachword.Visible = true;
                            List<TmpInfo> list = new List<TmpInfo>();
                            string[] array = meet.FilePath.Split('|');
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
                                    ti.Tmp3 = fileurl;
                                    list.Add(ti);
                                }
                            }
                            rpt.DataSource = list;
                            rpt.DataBind();
                        }
                    }

                }

                //发送记事便笺
                if (!string.IsNullOrEmpty(Request.QueryString["notebook"]))
                {
                    NoteBookInfo note = NoteBook.Init().GetById(Convert.ToInt32(Request.QueryString["notebook"]));
                    string _note = "<br><br><table style='width:95%;' border='1' cellspacing='0' bordercolor='#c0bdbd' cellpadding='2'><tbody><tr><td style='width:95px;color:#222;font-weight:bold;'>&nbsp;记事主题：</td><td>{0}</td></tr><tr><td style='width:95px;color:#222;font-weight:bold;'>&nbsp;记事时间：</td><td>{1}</td></tr><tr><td style='color:#222;font-weight:bold;'>&nbsp;记事内容：</td><td>{2}</td></tr><tr></tr></tbody></table><br>";
                    Bodys.Value = string.Format(_note, note.Subject, WC.Tool.Utils.ConvertDate3(note.AddTime), note.Bodys.Replace("\r\n", "<br>"));
                }

                //发送个人通讯录
                if (!string.IsNullOrEmpty(Request.QueryString["privateaddr"]))
                {
                    PhoneBookInfo pb = PhoneBook.Init().GetById(Convert.ToInt32(Request.QueryString["privateaddr"]));
                    string _addr = "<br><br><table style='width:95%;' border='1' cellspacing='0' bordercolor='#c0bdbd' cellpadding='2'><tbody><tr><td style='width:95px;color:#222;font-weight:bold;'>&nbsp;姓名：</td><td>{0}</td></tr><tr><td style='color:#222;font-weight:bold;'>&nbsp;标签：</td><td>{1}</td></tr><tr></tr><tr><td style='color:#222;font-weight:bold;'>&nbsp;电话：</td><td>{2}</td></tr><tr></tr><tr><td style='color:#222;font-weight:bold;'>&nbsp;备注：</td><td>{3}</td></tr><tr></tr></tbody></table><br>";
                    Bodys.Value = string.Format(_addr, pb.Person, pb.TagName, pb.Phone, pb.Notes.Replace("\r\n", "<br>"));
                }

            }
            else
            {
                Response.Write("<script>alert('会话已过期,请重新登录!');" +
                "window.location='/InfoTip/Operate_Nologin.aspx?ReturnUrl="
                        + Request.Url.AbsoluteUri + "'</script>");
            }
        }

        protected void Save_Btn(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Uid) && !string.IsNullOrEmpty(RealName) && !string.IsNullOrEmpty(DepName))
            {
                string sendids = "", sendnames = "", ccids = "", ccnames = "",
                bccids = "", bccnames = "", attachments = "";
                int sendtype = 0; //0普通发送 1草稿 2抄送 3密送 4保存发件箱 5回复 -1系统信件
                // mails表 FolderType字段  0收件箱 1草稿箱 2发件箱 3垃圾箱
                int count = 0; //统计邮件发送数量
                attachments = UpdateFiles();

                List<string> total = new List<string>();
                List<string> list = new List<string>();
                List<string> list_cc = new List<string>();
                List<string> list_bcc = new List<string>();

                if (!string.IsNullOrEmpty(userlist_bcc.Value))
                {
                    string[] arr_bcc = userlist_bcc.Value.Split(',');
                    sendtype = 3; //密送
                    foreach (string s in arr_bcc)
                    {
                        if (s.Trim() != "")
                        {
                            string h = s.Split('#')[1];
                            list_bcc.Add(h);

                            string tmp = s.Split('#')[1] + "|" + sendtype;
                            if (!total.Contains(tmp))
                                total.Add(tmp);
                        }
                    }
                    bccids = string.Join(",", list_bcc.ToArray());
                    bccnames = namelist_bcc.Value;
                }

                if (!string.IsNullOrEmpty(userlist_cc.Value))
                {
                    string[] arr_cc = userlist_cc.Value.Split(',');
                    sendtype = 2; //抄送
                    foreach (string s in arr_cc)
                    {
                        if (s.Trim() != "")
                        {
                            string h = s.Split('#')[1];
                            list_cc.Add(h);

                            string tmp = s.Split('#')[1] + "|" + sendtype;
                            if (!total.Contains(tmp))
                                total.Add(tmp);
                        }
                    }
                    ccids = string.Join(",", list_cc.ToArray());
                    ccnames = namelist_cc.Value;
                }

                if (!string.IsNullOrEmpty(userlist.Value))
                {
                    string[] arr = userlist.Value.Split(',');
                    sendtype = 0; //普通发送
                    foreach (string s in arr)
                    {
                        if (s.Trim() != "")
                        {
                            string h = s.Split('#')[1];
                            list.Add(h);

                            string tmp = s.Split('#')[1] + "|" + sendtype;
                            if (!total.Contains(tmp))
                                total.Add(tmp);
                        }
                    }
                    sendids = string.Join(",", list.ToArray());
                    sendnames = namelist.Value;
                }
                
                //发送邮件
                string[] sids = total.ToArray();
                List<string> uid_list = new List<string>();
                for (int i = 0; i < sids.Length; i++)
                {
                    if (WC.Tool.Utils.IsNumber(sids[i].Split('|')[0]) )
                    {
                        uid_list.Add(sids[i].Split('|')[0]);

                        AddMail(0, Convert.ToInt32(sids[i].Split('|')[1]), Convert.ToInt32(sids[i].Split('|')[0]), 
                        Uid, RealName,DepName, userlist.Value, sendnames, userlist_cc.Value, ccnames, userlist_bcc.Value, bccnames, attachments);
                        count++;
                    }
                }

                //保存至发件箱
                if (IsSave.Checked)
                {
                    AddMail(2, 4, Convert.ToInt32(Uid),Uid,
                    RealName, DepName, userlist.Value, sendnames, userlist_cc.Value, ccnames, userlist_bcc.Value, bccnames, attachments);
                }

                //发送手机短信
                if (uid_list.Count > 0 && IsSms.Checked)
                {
                    Dk.Help.MailMobleSend(uid_list, Subject.Value);
                }

                string words = HttpContext.Current.Server.HtmlEncode("您好!邮件发送成功!");
                Response.Redirect("/InfoTip/Operate_Success.aspx?returnpage="
                + Request.Url.AbsoluteUri + "&tip=" + words);

            }
            else
            {
                Response.Write("<script>alert('会话已过期,请重新登录!');" +
                "window.location='/InfoTip/Operate_Nologin.aspx?ReturnUrl="
                        + Request.Url.AbsoluteUri + "'</script>");
            }
        }

        protected void Caogao_Btn(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Uid) && !string.IsNullOrEmpty(RealName) && !string.IsNullOrEmpty(DepName))
            {
                string sendids = "", sendnames = "", ccids = "", ccnames = "",
                bccids = "", bccnames = "", attachments = "";
                int sendtype = 0; //0普通发送 1草稿 2抄送 3密送 4保存发件箱 5回复
                // mails表 FolderType字段  0收件箱 1草稿箱 2发件箱 3垃圾箱
                attachments = UpdateFiles();

                List<string> total = new List<string>();
                List<string> list = new List<string>();
                List<string> list_cc = new List<string>();
                List<string> list_bcc = new List<string>();

                if (!string.IsNullOrEmpty(userlist_bcc.Value))
                {
                    string[] arr_bcc = userlist_bcc.Value.Split(',');
                    sendtype = 3; //密送
                    foreach (string s in arr_bcc)
                    {
                        if (s.Trim() != "")
                        {
                            string h = s.Split('#')[1];
                            list_bcc.Add(h);

                            string tmp = s.Split('#')[1] + "|" + sendtype;
                            if (!total.Contains(tmp))
                                total.Add(tmp);
                        }
                    }
                    bccids = string.Join(",", list_bcc.ToArray());
                    bccnames = namelist_bcc.Value;
                }

                if (!string.IsNullOrEmpty(userlist_cc.Value))
                {
                    string[] arr_cc = userlist_cc.Value.Split(',');
                    sendtype = 2; //抄送
                    foreach (string s in arr_cc)
                    {
                        if (s.Trim() != "")
                        {
                            string h = s.Split('#')[1];
                            list_cc.Add(h);

                            string tmp = s.Split('#')[1] + "|" + sendtype;
                            if (!total.Contains(tmp))
                                total.Add(tmp);
                        }
                    }
                    ccids = string.Join(",", list_cc.ToArray());
                    ccnames = namelist_cc.Value;
                }

                if (!string.IsNullOrEmpty(userlist.Value))
                {
                    string[] arr = userlist.Value.Split(',');
                    sendtype = 0; //普通发送
                    foreach (string s in arr)
                    {
                        if (s.Trim() != "")
                        {
                            string h = s.Split('#')[1];
                            list.Add(h);

                            string tmp = s.Split('#')[1] + "|" + sendtype;
                            if (!total.Contains(tmp))
                                total.Add(tmp);
                        }
                    }
                    sendids = string.Join(",", list.ToArray());
                    sendnames = namelist.Value;
                }

                AddMail(1, 1,Convert.ToInt32(Uid) ,Uid, RealName, DepName, userlist.Value, sendnames, 
                    userlist_cc.Value, ccnames, userlist_bcc.Value, bccnames, attachments);

                string words = HttpContext.Current.Server.HtmlEncode("您好!邮件已成功保存到草稿箱!");
                Response.Redirect("/InfoTip/Operate_Success.aspx?returnpage="
                + Request.Url.AbsoluteUri + "&tip=" + words);
            }
            else
            {
                Response.Write("<script>alert('会话已过期,请重新登录!');" +
                "window.location='/InfoTip/Operate_Nologin.aspx?ReturnUrl="
                        + Request.Url.AbsoluteUri + "'</script>");
            }
        }

        //发送(转发)、存为草稿 (单封邮件)
        private void AddMail(int type,int sendtype, int ReceiverID, string uid, 
            string realname, string depname, string sendids, 
            string sendnames, string ccids, string ccnames, 
            string bccids, string bccnames, string attachments)
        {
            if (ct == 0)
            {
                Mails_DetailInfo md = new Mails_DetailInfo();
                md.Attachments = attachments;
                md.Bodys = Bodys.Value;
                md.SendIDs = sendids;
                md.SendRealNames = sendnames;
                md.CcIDs = ccids;
                md.CcRealNames = ccnames;
                md.BccIDs = bccids;
                md.BccRealNames = bccnames;
                ct++;
                Mails_Detail.Init().Add(md);
                tobj = md;
            }
            if (tobj.GetType().ToString().Contains("fo")) //判断类型是否 Mails_DetailInfo
            {
                Mails_DetailInfo md = tobj as Mails_DetailInfo;
                MailsInfo mi = new MailsInfo();
                mi.ReceiverID = ReceiverID;
                mi.SenderID = Convert.ToInt32(uid);
                mi.SenderRealName = realname;
                mi.SenderDepName = depname;
                mi.SendType = sendtype;
                mi.Subject = Subject.Value;
                mi.FolderType = type;
                mi.SendTime = DateTime.Now;
                mi.did = md.id;

                if (ReadBack.Checked)
                    mi.SenderGUID = "1";
                else mi.SenderGUID = "";

                Mails.Init().Add(mi);
            }
        }

        //上传所有附件,并返回 文件保存位置字符串集合
        private string UpdateFiles()
        {
            string fnames = "";
            System.Web.HttpFileCollection files = System.Web.HttpContext.Current.Request.Files;

            //得到或创建 上传目录
            string timeFolder = DateTime.Now.ToString("yyMMdd");
            string path = Server.MapPath("~/Files/MailFiles/");
            string tmp = "~/Files/MailFiles/" + timeFolder + "/";
            path += timeFolder; 
            if (!Directory.Exists(path))
            {
                WC.Tool.FileSystemManager.CreateFolder(timeFolder, Server.MapPath("~/Files/MailFiles"));
            }

            try
            {
                string old = "";
                if (Attachword.Visible == true)
                {
                    foreach (RepeaterItem item in rpt.Items)
                    {
                        HtmlInputCheckBox hick = item.FindControl("chk") as HtmlInputCheckBox;
                        if (hick.Checked)
                        {
                            old += hick.Value + "|";
                        }
                    }
                }

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

    }
}
