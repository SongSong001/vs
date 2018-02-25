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
using System.Text;
using WC.BLL;
using WC.Model;
using WC.DBUtility;

namespace WC.WebUI.Manage
{
    public partial class DeskTop : WC.BLL.ViewPages
    {
        private string tmp = "<tr><td height=24><img src='/img/news.gif' style='border:0px;height:12px;' /><a href=#@ onclick=window.parent.runWin('{4}','{0}','icon8a1{5}')  title='{1}'> {2} &nbsp;({3})</a></td></tr>";
        private string tmp_noread = "<tr><td height=24><span><img src='/img/mail_noread.gif' style='border:0px;height:12px;width:12px;' /><a href=#@ onclick=window.parent.runWin('{4}','{0}','icon9c3{5}')  title='{1}'> {2} &nbsp;({3})</a></span></td></tr>";
        private string tmp_hasread = "<tr><td height=24><span><img src='/img/mail_isread.gif' style='border:0px;height:12px;width:12px;' /><a href=#@ onclick=window.parent.runWin('{4}','{0}','icon1d2{5}')  title='{1}'> {2} &nbsp;({3})</a></span></td></tr>";
        private string tmp_flow = "<tr><td height=24><span><img src='/img/flow.gif' style='border:0px;height:12px;' /><a href=#@ onclick=window.parent.runWin('{4}','{0}','icon3e5{5}') title='{1}'> {2} &nbsp;({3})</a></span></td></tr>";

        private string block_line = "<tr><td height=24>&nbsp;</td></tr>";
        protected string script = "";
        
        protected string news_num = "0";
        protected string mails_num1 = "0";
        protected string mails_num2 = "0";
        protected string flows_num1 = "0";
        protected string flows_num2 = "0";
        protected string calendar_num = "0";
        protected string note_num = "0";
        protected string mydoc_num = "0";
        protected string shared_num = "0";
        protected string shared_num2 = "0";

        protected string exe_num = "0";
        protected string man_num = "0";

        protected string forum_num = "0";

        protected string qyzx = "";
        protected string wdyj = "";
        protected string wdsp = "";
        protected string wdgw = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && !string.IsNullOrEmpty(Uid))
            {
                Bas_ComInfo bi = HttpContext.Current.Application["cominfo"] as Bas_ComInfo;
                if (bi.TipsState == 1)
                    TipsState.Visible = true;
                else TipsState.Visible = false;
                Show();
            }
        }

        private void Show()
        {
            SqlParameter rid = new SqlParameter();
            rid.ParameterName = "@uid";
            rid.Size = 50;
            rid.Value = Uid;

            SqlParameter rid2 = new SqlParameter();
            rid2.ParameterName = "@depid";
            rid2.Size = 50;
            rid2.Value = DepID;

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

            SqlParameter sqlpt5 = new SqlParameter();
            sqlpt5.Direction = ParameterDirection.Output;
            sqlpt5.ParameterName = "@pt5";
            sqlpt5.Size = 7;

            SqlParameter sqlpt6 = new SqlParameter();
            sqlpt6.Direction = ParameterDirection.Output;
            sqlpt6.ParameterName = "@pt6";
            sqlpt6.Size = 7;

            SqlParameter sqlpt7 = new SqlParameter();
            sqlpt7.Direction = ParameterDirection.Output;
            sqlpt7.ParameterName = "@pt7";
            sqlpt7.Size = 7;

            SqlParameter sqlpt8 = new SqlParameter();
            sqlpt8.Direction = ParameterDirection.Output;
            sqlpt8.ParameterName = "@pt8";
            sqlpt8.Size = 7;

            SqlParameter sqlpt10 = new SqlParameter();
            sqlpt10.Direction = ParameterDirection.Output;
            sqlpt10.ParameterName = "@pt10";
            sqlpt10.Size = 7;

            SqlParameter sqlpt11 = new SqlParameter();
            sqlpt11.Direction = ParameterDirection.Output;
            sqlpt11.ParameterName = "@pt11";
            sqlpt11.Size = 7;

            SqlParameter sqlpt12 = new SqlParameter();
            sqlpt12.Direction = ParameterDirection.Output;
            sqlpt12.ParameterName = "@pt12";
            sqlpt12.Size = 7;

            SqlParameter sqlpt13 = new SqlParameter();
            sqlpt13.Direction = ParameterDirection.Output;
            sqlpt13.ParameterName = "@pt13";
            sqlpt13.Size = 7;

            SqlParameter[] sqls = { sqlpt1, sqlpt2, sqlpt3, sqlpt4, sqlpt5, sqlpt6, sqlpt7, sqlpt8, sqlpt10, sqlpt11, sqlpt12, sqlpt13, rid, rid2 };
            using (DataSet ds = MsSqlOperate.ExecuteDataset(CommandType.StoredProcedure, "Global_GetDesktopData", sqls))
            {
                news_num = sqlpt1.Value + "";
                mails_num1 = sqlpt2.Value + "";
                mails_num2 = sqlpt3.Value + "";
                flows_num1 = sqlpt4.Value + "";
                flows_num2 = sqlpt5.Value + "";
                calendar_num = sqlpt6.Value + "";
                note_num = sqlpt7.Value + "";
                mydoc_num = sqlpt8.Value + "";
                shared_num = sqlpt10.Value + "";
                shared_num2 = sqlpt11.Value + "";
                exe_num = sqlpt12.Value + "";
                man_num = sqlpt13.Value + "";

                forum_num = MsSqlOperate.ExecuteScalar(CommandType.Text, "select count(id) from wc_forum_reply1 where DateDiff(d,addtime,getdate())=0") + "";

                int offset = 22;
                if (!string.IsNullOrEmpty(px))
                {
                    int x = Convert.ToInt32(px.Split('?')[0]);
                    if (x < 1030 && x > 1000)
                        offset = 22;
                    if (x < 1000)
                        offset = 18;
                    if (x > 1100 && x < 1300)
                        offset = 31;
                    if (x >= 1300)
                        offset = 36;

                }

                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    string t = string.Format(tmp, "/manage/News/News_View.aspx?nid=" + ds.Tables[0].Rows[i]["id"],
                        ds.Tables[0].Rows[i]["NewsTitle"], WC.Tool.Utils.GetSubString2("" + ds.Tables[0].Rows[i]["NewsTitle"], offset, ".."),
                        WC.Tool.Utils.ConvertDate(ds.Tables[0].Rows[i]["addtime"]), "资讯" + (i + 1),i);
                    qyzx += t;
                }
                int j = 7 - ds.Tables[0].Rows.Count;
                for (int i = 0; i < j; i++)
                {
                    qyzx += block_line;
                }

                for (int i = 0; i < ds.Tables[1].Rows.Count; i++)
                {
                    string t = "";
                    if (ds.Tables[1].Rows[i]["isread"] + "" == "0")
                    {
                        t = string.Format(tmp_noread, "/manage/Common/Mail_View.aspx?fid=0&mid=" + ds.Tables[1].Rows[i]["id"],
                            ds.Tables[1].Rows[i]["Subject"] + " - " + WC.Tool.Utils.ConvertDate3(ds.Tables[1].Rows[i]["SendTime"]), WC.Tool.Utils.GetSubString2("" + ds.Tables[1].Rows[i]["Subject"], offset + 1, ".."),
                            ds.Tables[1].Rows[i]["SenderRealName"], "未读邮件" + (i + 1),i);
                    }
                    else
                    {
                        t = string.Format(tmp_hasread, "/manage/Common/Mail_View.aspx?fid=0&mid=" + ds.Tables[1].Rows[i]["id"],
                            ds.Tables[1].Rows[i]["Subject"] + " - " + WC.Tool.Utils.ConvertDate3(ds.Tables[1].Rows[i]["SendTime"]), WC.Tool.Utils.GetSubString2("" + ds.Tables[1].Rows[i]["Subject"], offset + 1, ".."),
                            ds.Tables[1].Rows[i]["SenderRealName"], "已读邮件" + (i + 1),i);
                    }
                    wdyj += t;
                }
                int p = 7 - ds.Tables[1].Rows.Count;
                for (int i = 0; i < p; i++)
                {
                    wdyj += block_line;
                }

                int bm = 0;
                for (int i = 0; i < ds.Tables[2].Rows.Count; i++)
                {
                    if (i < 7)
                    {
                        string w = "", s = ds.Tables[2].Rows[i]["CreatorRealName"] + "";
                        if (s.Trim() == RealName)
                            w = "[我的申请] ";
                        else
                            w = "[审批/查阅] ";

                        string t = string.Format(tmp_flow, "/manage/Flow/Flow_View.aspx?fl=" + ds.Tables[2].Rows[i]["id"],
                            ds.Tables[2].Rows[i]["Flow_Name"], WC.Tool.Utils.GetSubString2("" + w + ds.Tables[2].Rows[i]["Flow_Name"], offset + 1, ".."),
                            ds.Tables[2].Rows[i]["CreatorRealName"], "流程" + (i + 1),i);

                        if (!wdsp.Contains(t))
                            wdsp += t;
                        else bm++;
                    }
                }
                int k = 7 - WC.Tool.Utils.GetSplitNum("<tr><td height=24>", wdsp);
                for (int i = 0; i < k; i++)
                {
                    wdsp += block_line;
                }

                Hashtable page_ht = (Hashtable)HttpContext.Current.Application["stand_config"];
                script = page_ht["index_tips"] + "";

                if (ds.Tables[3].Rows.Count > 0)
                {
                    string temp = " marqueecontent[{0}] = '{1}';  ", ct = "";
                    for (int i = 0; i < ds.Tables[3].Rows.Count; i++)
                    {
                        ct += string.Format(temp, i, ds.Tables[3].Rows[i]["tips"] + "");
                    }
                    script = ct;
                }

            }

        }

    }
}
