using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

using WC.BLL;
using WC.Model;
using WC.DBUtility;

namespace WC.WebUI.Mobile.GovRec
{
    public partial class RecView : WC.BLL.MobilePage
    {
        protected string fjs = "", sm = "", gd = "";
        protected string fj = "<span style='font-weight:bold;'>{1}</span> &nbsp;&nbsp;&nbsp;&nbsp;<a href='/Manage/Utils/Download.aspx?destFileName={0}' ><img src='/img/mail_attachment.gif' />下载附件</a><br>";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && !string.IsNullOrEmpty(Request.QueryString["fl"]))
            {
                Show(Request.QueryString["fl"]);
            }
        }

        private void Show(string nid)
        {
            GovInfo gi = WC.BLL.Gov.Init().GetById(Convert.ToInt32(nid));
            DocBody.InnerHtml = gi.DocBody;
            IList list = WC.BLL.Gov_Recipient.Init().GetAll("UserID=" + Uid + " and Flow_ID=" + Request.QueryString["fl"], null);
            if (list.Count > 0)
            {
                Gov_RecipientInfo gii = list[0] as Gov_RecipientInfo;
                ViewState["gi"] = gii;
                if (gii.Sign == 0 && gi.Status == 1)
                {
                    pals.Visible = true;
                }
            }

            NewsTitle.InnerText = "标题：" + gi.Flow_Name;
            Creator.InnerText = gi.CreatorRealName + " (" + gi.CreatorDepName + ")";
            addtime.InnerText = WC.Tool.Utils.ConvertDate2(gi.AddTime);

            this.Page.Title = "公文签收：" + gi.Flow_Name;

            fjs = "<span style='color:#006600;'>相关文件</span>：<br>";

            if (!string.IsNullOrEmpty(gi.Flow_Files))
            {
                string[] array = gi.Flow_Files.Split('|');
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

            if (!string.IsNullOrEmpty(gi.Remark))
            {
                sm = "<span style='color:#006600;'>简要说明</span>：<br>" + gi.Remark + "<br><br>";
            }

            if (gi.IsValid == 0)
            {
                gd = "<br><span style='color:#006600;'>归档日期</span>：<br>所有人签收完 自动归档.<br><br>";
            }
            else
            {
                gd = "<br><span style='color:#006600;'>归档日期</span>：<br>" + WC.Tool.Utils.ConvertDate3(gi.ValidTime) + ".";
            }


            string tt = "";
            if (!string.IsNullOrEmpty(gi.DocNo))
                tt = "发文字号：" + gi.DocNo;
            else tt = "发文字号：无";

            top.InnerHtml = tt;

        }

        protected void Save_Btn(object sender, EventArgs e)
        {
            if (ViewState["gi"] != null)
            {
                Gov_RecipientInfo gi = ViewState["gi"] as Gov_RecipientInfo;
                if (gi.Sign == 0)
                {
                    gi.FeedBack = Request.Form["FeedBack"];
                    gi.Sign = 1;
                    gi.SignTime = DateTime.Now;
                    WC.BLL.Gov_Recipient.Init().Update(gi);

                    string guidang = "update gov set status=5 where id={0} and status=1 and IsValid=0 and (select count(*) from Gov_Recipient where flow_id={0} and sign=0)=0";
                    MsSqlOperate.ExecuteNonQuery(CommandType.Text, string.Format(guidang, gi.Flow_ID));

                    WC.Tool.MessageBox.ShowAndRedirect(this, "公文已成功签收!", "RecMenu.aspx");
                }
            }

        }

    }
}