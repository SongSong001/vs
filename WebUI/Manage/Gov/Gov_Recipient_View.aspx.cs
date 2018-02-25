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

namespace WC.WebUI.Manage.Gov
{
    public partial class Gov_Recipient_View : WC.BLL.ViewPages
    {
        protected string fjs = "", sm = "", gd = "";
        protected string fj = "<span style='font-weight:bold;'>{1}</span> &nbsp;&nbsp;&nbsp;&nbsp;<a href='/Manage/Utils/Download.aspx?destFileName={0}' ><img src='/img/mail_attachment.gif' />下载附件</a><br>";
 
        protected string LoadOriginalFile = "";
        protected string doctype = "doc";

        protected string advice_count = "0";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && !string.IsNullOrEmpty(Request.QueryString["fl"]))
            {
                Show(Request.QueryString["fl"]);
            }
        }

        private void Show(string nid)
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

            SqlParameter[] sqls = { sqlpt1, sqlpt2, sqlpt3, rid };
            MsSqlOperate.ExecuteNonQuery(CommandType.StoredProcedure, "Gov_GetRecipientCount", sqls);
            wdpy.InnerText = sqlpt1.Value + "";
            yjpy.InnerText = sqlpt2.Value + "";
            wdsq.InnerText = sqlpt3.Value + "";


            GovInfo gi = WC.BLL.Gov.Init().GetById(Convert.ToInt32(nid));
            DocBody.Value = gi.DocBody;
            IList list = WC.BLL.Gov_Recipient.Init().GetAll("UserID=" + Uid + " and Flow_ID=" + Request.QueryString["fl"], null);
            if (list.Count > 0)
            {
                Gov_RecipientInfo gii = list[0] as Gov_RecipientInfo;
                ViewState["gi"] = gii;
                if (gii.Sign == 0 && gi.Status==1)
                {
                    jss.Visible = true;
                    pal.Visible = true;
                    back.Visible = false;
                }
            }

            string url = "http://" + Request.ServerVariables["HTTP_HOST"].ToString()
            + Request.ServerVariables["PATH_INFO"].ToString();
            int c = url.LastIndexOf("/");
            url = url.Substring(0, c) + "/";
            url = url.ToLower().Replace("/manage/gov", "");
            LoadOriginalFile = url + gi.CurrentDocPath.ToString();

            NewsTitle.InnerText = gi.Flow_Name;
            Creator.InnerText = gi.CreatorRealName + " (" + gi.CreatorDepName + ")";
            addtime.InnerText = WC.Tool.Utils.ConvertDate2(gi.AddTime);

            this.Page.Title = "公文签收：" + gi.Flow_Name;

            fjs = "<span style='font-weight:bold; color:#006600;'>相关文件</span>：<br>";
            //int k = gi.CurrentDocPath.LastIndexOf('/') + 1;
            //string fname = gi.CurrentDocPath.Substring(k, gi.CurrentDocPath.Length - k);
            //string furl = gi.CurrentDocPath.ToString();

            //fjs += string.Format(fj, Server.UrlEncode(furl), fname);


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
                sm = "<span style='font-weight:bold; color:#006600;'>简要说明</span>：<br>" + gi.Remark + "<br><br>";
            }

            if (gi.IsValid == 0)
            {
                gd = "<br><span style='font-weight:bold; color:#006600;'>归档日期</span>：<br>所有人员签收完毕 自动归档.<br><br>";
            }
            else
            {
                gd = "<br><span style='font-weight:bold; color:#006600;'>归档日期</span>：<br>"+WC.Tool.Utils.ConvertDate3(gi.ValidTime)+".";
            }


            string tt = "";
            if (!string.IsNullOrEmpty(gi.DocNo))
                tt = "发文字号：" + gi.DocNo + " &nbsp;&nbsp; 密级： " + gi.Secret;
            else tt = "发文字号：无 &nbsp;&nbsp; 密级： " + gi.Secret;

            top.InnerHtml = tt;

            string sql = "select count(*) from Gov_Recipient where Flow_ID=" + nid;
            advice_count = MsSqlOperate.ExecuteScalar(CommandType.Text, sql) + "";

        }

        protected void Save_Btn(object sender, EventArgs e)
        {
            if (ViewState["gi"] !=null)
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

                    string words = HttpContext.Current.Server.HtmlEncode("您好!公文已成功签收!");
                    Response.Redirect("/InfoTip/Operate_Success.aspx?returnpage="
                    + Request.Url.AbsoluteUri + "&tip=" + words);
                }
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
    }
}
