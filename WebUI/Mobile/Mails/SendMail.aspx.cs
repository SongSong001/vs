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

namespace WC.WebUI.Mobile.Mails
{
    public partial class SendMail : WC.BLL.MobilePage
    {
        private int ct = 0;
        private object tobj = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void Save_Btn(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Subject.Value) && !string.IsNullOrEmpty(userlist.Value))
            {
                string sendids = "", sendnames = "", ccnames = "",
                bccnames = "", attachments = "";
                int sendtype = 0; //0普通发送 1草稿 2抄送 3密送 4保存发件箱 5回复 -1系统信件
                // mails表 FolderType字段  0收件箱 1草稿箱 2发件箱 3垃圾箱
                int count = 0; //统计邮件发送数量
                attachments = UpdateFiles();

                List<string> total = new List<string>();
                List<string> list = new List<string>();

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
                    if (WC.Tool.Utils.IsNumber(sids[i].Split('|')[0]))
                    {
                        AddMail(0, Convert.ToInt32(sids[i].Split('|')[1]), Convert.ToInt32(sids[i].Split('|')[0]),
                        Uid, RealName, DepName, userlist.Value, sendnames, "", ccnames, "", bccnames, attachments);
                        count++;
                    }
                }

                //保存至发件箱
                AddMail(2, 4, Convert.ToInt32(Uid), Uid,
                    RealName, DepName, userlist.Value, sendnames, "", ccnames, "", bccnames, attachments);

                WC.Tool.MessageBox.ShowAndRedirect(this, "邮件发送成功!", "SendMail.aspx");

            }

            else
            {
                WC.Tool.MessageBox.ShowAndRedirect(this, "必填项不能为空!", "SendMail.aspx");
            }
        }

        protected void Caogao_Btn(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Subject.Value))
            {
                string sendids = "", sendnames = "", ccnames = "",
                bccnames = "", attachments = "";
                int sendtype = 0; //0普通发送 1草稿 2抄送 3密送 4保存发件箱 5回复
                // mails表 FolderType字段  0收件箱 1草稿箱 2发件箱 3垃圾箱
                attachments = UpdateFiles();

                List<string> total = new List<string>();
                List<string> list = new List<string>();

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

                AddMail(1, 1, Convert.ToInt32(Uid), Uid, RealName, DepName, userlist.Value, sendnames,
                    "", ccnames, "", bccnames, attachments);

                WC.Tool.MessageBox.ShowAndRedirect(this, "已成功保存到草稿箱!", "SendMail.aspx");
            }

            else
            {
                WC.Tool.MessageBox.ShowAndRedirect(this, "必填项不能为空!", "SendMail.aspx");
            }

        }

        //发送(转发)、存为草稿 (单封邮件)
        private void AddMail(int type, int sendtype, int ReceiverID, string uid,
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

                mi.SenderGUID = "";

                WC.BLL.Mails.Init().Add(mi);
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
                if (Attachwords.Visible == true)
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
            catch (IOException ex)
            {
                throw ex;
            }

            return fnames;
        }

    }
}