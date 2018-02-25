using System;
using System.Collections;
using System.Collections.Generic;
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

namespace WC.WebUI.Manage.Attend
{
    public partial class WorkAttendAdd : WC.BLL.ViewPages
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!string.IsNullOrEmpty(Request.QueryString["type"]))
                {
                    Show(Request.QueryString["type"]);
                }
            }
        }

        private void Show(string t)
        {
            switch (t)
            {
                case "1": Show1(); break;
                case "2": type2.Visible = true; break;
                case "3": type3.Visible = true; break;
                case "4": type4.Visible = true; break;
                default: break;
            }
        }

        private void Show1()
        {
            type1.Visible = true;
            if (!string.IsNullOrEmpty(Request.QueryString["tid"]))
            {
                Attend1.Visible = true;
            }
            //string sql = "select a.id,a.AttendNames,a.AttendTimes,b.SignTimes,b.SignJudge,b.Notes,b.id as wid from Work_AttendSet as a left join Work_Attend as b on a.id=b.AttendTimeID where AttendType=1 and UID=" + Uid + " and datediff(d,addtime,getdate())=0";
            string sql = "select a.id,a.AttendNames,a.AttendTimes,b.SignTimes,b.SignJudge,b.Notes,b.id as wid from Work_AttendSet as a left join (select * from Work_Attend where AttendType=1 and UID=" + Uid + " and datediff(d,addtime,getdate())=0) as b on a.id=b.AttendTimeID";
            using (DataSet ds = MsSqlOperate.ExecuteDataset(CommandType.Text, sql))
            {
                rpt1.DataSource = ds.Tables[0].DefaultView;
                rpt1.DataBind();
            }
        }

        protected void Sign_Btn1(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["tid"]) && (Request.QueryString["type"] == "1"))
            {
                string tid = Request.QueryString["tid"];
                IList list = Work_Attend.Init().GetAll(" AttendType=1 and UID=" + Uid + " and AttendTimeID=" + tid + " and datediff(d,addtime,getdate())=0 ", null);
                if (list.Count == 0)
                {
                    Work_AttendSetInfo si = Work_AttendSet.Init().GetById(Convert.ToInt32(tid));

                    Work_AttendInfo wi = new Work_AttendInfo();
                    wi.AddTime = DateTime.Now;
                    wi.UID = Convert.ToInt32(Uid);
                    wi.DepID = Convert.ToInt32(DepID);
                    wi.RealName = RealName;
                    wi.DepName = DepName;

                    wi.AttendTimeID = Convert.ToInt32(tid);

                    wi.StandardTimes = si.AttendTimes;
                    wi.StandardNames = si.AttendNames;
                    wi.SignTimes = DateTime.Now.TimeOfDay.ToString().Substring(0, 5);
                    wi.SignDates = DateTime.Now.ToString("yyyy-MM-dd");

                    DateTime dt = Convert.ToDateTime(si.AttendTimes);
                    DateTime jt = Convert.ToDateTime(DateTime.Now.Hour + ":" + DateTime.Now.Minute);
                    if (si.AttendNames.Contains("上班"))
                    {
                        if (DateTime.Compare(dt, jt) >= 0)
                        {
                            wi.SignJudge = "正常";
                        }
                        else
                        {
                            wi.SignJudge = "迟到";
                        }

                    }
                    if (si.AttendNames.Contains("下班"))
                    {
                        if (DateTime.Compare(dt, jt) <= 0)
                        {
                            wi.SignJudge = "正常";
                        }
                        else
                        {
                            wi.SignJudge = "早退";
                        }

                    }

                    wi.AttendType = 1;
                    wi.Notes = "(" + WC.Tool.RequestUtils.GetIP() + ") " + Notes1.Value;

                    wi.BeginTime = DateTime.Now;
                    wi.EndTime = DateTime.Now;

                    Work_Attend.Init().Add(wi);

                    Response.Write("<script>alert('上下班登记已添加！');window.location='WorkAttendAdd.aspx?type=1'</script>");
                }
            }
        }

        protected void Sign_Btn2(object sender, EventArgs e)
        {
            Work_AttendInfo wi = new Work_AttendInfo();
            wi.AddTime = DateTime.Now;
            wi.UID = Convert.ToInt32(Uid);
            wi.DepID = Convert.ToInt32(DepID);
            wi.RealName = RealName;
            wi.DepName = DepName;

            wi.AttendTimeID = 0;
            wi.StandardTimes = "";
            wi.StandardNames = "";
            wi.SignTimes = "";
            wi.SignDates = "";
            wi.SignJudge = "";

            wi.AttendType = 2;

            wi.TravelAddress = "";
            wi.Notes = "(" + WC.Tool.RequestUtils.GetIP() + ") " + Notes2.Value;
            wi.BeginTime = Convert.ToDateTime(Request.Form["BeginTime2"]);
            wi.EndTime = Convert.ToDateTime(Request.Form["EndTime2"]);
            wi.B1 = Request.Form["B1_2"];
            wi.B2 = Request.Form["B2_2"];
            wi.E1 = Request.Form["E1_2"];
            wi.E2 = Request.Form["E2_2"];

            Work_Attend.Init().Add(wi);

            Response.Write("<script>alert('外出登记已添加！');window.location='WorkAttendAdd.aspx?type=2'</script>");
        }

        protected void Sign_Btn3(object sender, EventArgs e)
        {
            Work_AttendInfo wi = new Work_AttendInfo();
            wi.AddTime = DateTime.Now;
            wi.UID = Convert.ToInt32(Uid);
            wi.DepID = Convert.ToInt32(DepID);
            wi.RealName = RealName;
            wi.DepName = DepName;

            wi.AttendTimeID = 0;
            wi.StandardTimes = "";
            wi.StandardNames = "";
            wi.SignTimes = "";
            wi.SignDates = "";
            wi.SignJudge = "";

            wi.AttendType = 3;

            wi.TravelAddress = "";
            wi.Notes = "(" + WC.Tool.RequestUtils.GetIP() + ") " + Notes3.Value;
            wi.BeginTime = Convert.ToDateTime(Request.Form["BeginTime3"]);
            wi.EndTime = Convert.ToDateTime(Request.Form["EndTime3"]);
            wi.B1 = Request.Form["B1_3"];
            wi.B2 = Request.Form["B2_3"];
            wi.E1 = Request.Form["E1_3"];
            wi.E2 = Request.Form["E2_3"];

            Work_Attend.Init().Add(wi);

            Response.Write("<script>alert('请假登记已添加！');window.location='WorkAttendAdd.aspx?type=3'</script>");
        }

        protected void Sign_Btn4(object sender, EventArgs e)
        {
            Work_AttendInfo wi = new Work_AttendInfo();
            wi.AddTime = DateTime.Now;
            wi.UID = Convert.ToInt32(Uid);
            wi.DepID = Convert.ToInt32(DepID);
            wi.RealName = RealName;
            wi.DepName = DepName;

            wi.AttendTimeID = 0;
            wi.StandardTimes = "";
            wi.StandardNames = "";
            wi.SignTimes = "";
            wi.SignDates = "";
            wi.SignJudge = "";

            wi.AttendType = 4;

            wi.TravelAddress = TravelAddress4.Value;
            wi.Notes = "(" + WC.Tool.RequestUtils.GetIP() + ") " + Notes4.Value;
            wi.BeginTime = Convert.ToDateTime(Request.Form["BeginTime4"]);
            wi.EndTime = Convert.ToDateTime(Request.Form["EndTime4"]);
            wi.B1 = Request.Form["B1_4"];
            wi.B2 = Request.Form["B2_4"];
            wi.E1 = Request.Form["E1_4"];
            wi.E2 = Request.Form["E2_4"];

            Work_Attend.Init().Add(wi);

            Response.Write("<script>alert('出差登记已添加！');window.location='WorkAttendAdd.aspx?type=4'</script>");
        }

        protected string SignClick(object d, object j)
        {
            string r = "<a href='WorkAttendAdd.aspx?type=1&tid={0}'>登记</a>", t = "<span style='color:#666666'>已登记</span>";
            if (!WC.Tool.Utils.IsNumber(j + ""))
            {
                t = string.Format(r, d + "");
            }
            return t;
        }

        protected string SignJudge(object b)
        {
            string r = "";
            if (b.ToString().Contains("正常"))
                r = "<span style='color:#006600'>" + b + "</span>";
            else r = "<span style='color:#ff0000'>" + b + "</span>";
            return r;
        }

        protected string TypeStr()
        {
            string b = "", a = Request.QueryString["type"];
            switch (a)
            {
                case "1": b = " >> 上下班"; break;
                case "2": b = " >> 外出"; break;
                case "3": b = " >> 请假"; break;
                case "4": b = " >> 出差"; break;
                default: break;
            }
            return b;
        }

    }
}