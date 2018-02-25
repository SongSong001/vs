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

namespace WC.WebUI.Mobile.Mails
{
    public partial class MailView : WC.BLL.MobilePage
    {
        protected string mid = "";
        protected string bet = "";
        protected string fjs = "";
        protected string fj = "<span>{1}</span> &nbsp;&nbsp;&nbsp;&nbsp;<a href='/Manage/Utils/Download.aspx?destFileName={0}' ><img src='/img/mail_attachment.gif' />下载</a><br>";

        protected string csr = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["fid"] == "1")
            {
                Response.Write("<script>window.location='Mail_Manage.aspx?cid=" + Request.QueryString["mid"] + "'</script>");
                return;
            }
            else
            {
                if (!IsPostBack)
                {
                    if (!string.IsNullOrEmpty(Request.QueryString["mid"]))
                    {
                        Show(Request.QueryString["mid"]);
                    }
                }
            }
        }

        private void Show(string id)
        {
            mid = id;

            MailsInfo mi = WC.BLL.Mails.Init().GetById(Convert.ToInt32(mid));

            if (mi.ReceiverID == Convert.ToInt32(Uid) || mi.SenderID == Convert.ToInt32(Uid))
            {
                Mails_DetailInfo md = Mails_Detail.Init().GetById(mi.did);
                Subject.InnerText ="标题："+ mi.Subject;
                Sender.InnerText = mi.SenderRealName + " (" + mi.SenderDepName + ")";
                bet = mi.ReceiverID + ";" + mi.SenderID;
                Sendtime.InnerText = WC.Tool.Utils.ConvertDate5(mi.SendTime);
                sjr.InnerText = WC.Tool.Utils.GetSubString2(md.SendRealNames, 300, "...");

                if (!string.IsNullOrEmpty(md.CcRealNames))
                {
                    csr = "<br><span style='font-weight:bold; color:#006600;'>抄送人</span>：" + WC.Tool.Utils.GetSubString2(md.CcRealNames, 250, "...");
                }

                if (!string.IsNullOrEmpty(md.Attachments))
                {
                    fjs = "";
                    string[] array = md.Attachments.Split('|');
                    for (int i = 0; i < array.Length; i++)
                    {
                        if (array[i].Trim() != "")
                        {
                            int t = array[i].LastIndexOf('/') + 1;
                            string filename = array[i].Substring(t, array[i].Length - t);
                            string fileurl = array[i].ToString();

                            fjs += string.Format(fj, Server.UrlEncode(fileurl), filename);

                        }
                    }
                }

                md.Bodys = md.Bodys + "";
                if (md.Bodys.ToLower().Contains("script"))
                {
                    bodys.InnerHtml = md.Bodys.ToLower().Replace("script", "scrript");
                }
                else
                {
                    bodys.InnerHtml = md.Bodys.ToLower().Replace("<p>", "").Replace("</p>", "<br>");
                }

                if (mi.IsRead == 0)
                {
                    mi.IsRead = 1;
                    WC.BLL.Mails.Init().Update(mi);

                    if (mi.SenderGUID == "1" && mi.ReceiverID == Convert.ToInt32(Uid) && mi.FolderType == 0)
                    {
                        string title = "[系统通知] : 收件人(" + RealName + ")已查看您发送的邮件!";
                        string content = "您好! 您撰写发送的的邮件<br>“<strong>" + mi.Subject + "</strong>” (发送于 " + WC.Tool.Utils.ConvertDate3(mi.SendTime) + ") <br><br>收件人<strong>(" + RealName + ")</strong>已于 " + WC.Tool.Utils.ConvertDate3(DateTime.Now) + " 拆启查阅。<br>";
                        int rid = mi.SenderID;
                        string ulist = mi.SenderRealName + "#" + mi.SenderID + "#" + mi.SenderDepName + ",";
                        string nlist = mi.SenderRealName + "(" + mi.SenderDepName + "),";
                        WC.WebUI.Dk.Help.AdminSendMail(title, content, rid, ulist, nlist);
                    }
                }
                ViewState["retitle"] = mi.Subject;
                ViewState["sid"] = mi.SenderID;
                ViewState["snames"] = mi.SenderRealName;
                ViewState["sdep"] = mi.SenderDepName;
            }

            else
            {
                WC.Tool.MessageBox.ShowAndRedirect(this, "您没有查看权限!", "MailList.aspx?fid=0");
            }

        }

        private bool IsOfficeFile(string filename)
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


        protected void Replay_Btn(object sender, EventArgs e)
        {
            string body = Request.Form["replay"];
            if (!string.IsNullOrEmpty(body.Trim()) && body.Trim() != "在这里输入快捷回复")
            {
                MailsInfo mi = new MailsInfo();
                Mails_DetailInfo md = new Mails_DetailInfo();
                mi.Subject = "快捷回复：" + ViewState["retitle"];
                mi.ReceiverID = Convert.ToInt32(ViewState["sid"]);
                md.Bodys = body;
                mi.SenderID = Convert.ToInt32(Uid);
                mi.SenderRealName = RealName;
                mi.SenderDepName = DepName;
                mi.SendType = 5; //回复
                mi.SendTime = DateTime.Now;

                md.SendIDs = mi.ReceiverID + "";
                md.SendRealNames = ViewState["snames"] + " (" + ViewState["sdep"] + ")";

                Mails_Detail.Init().Add(md);
                mi.did = md.id;
                WC.BLL.Mails.Init().Add(mi);

                WC.Tool.MessageBox.ShowAndRedirect(this, "已经成功回复!", "MailList.aspx?fid=0");
            }
            else
                WC.Tool.MessageBox.ShowAndRedirect(this, "快捷回复没有任何内容!", "MailList.aspx?fid=0");
        }
    }
}