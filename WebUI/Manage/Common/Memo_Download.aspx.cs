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

namespace WC.WebUI.Manage.Common
{
    public partial class Memo_Download : WC.BLL.ViewPages
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["uid"]) && !string.IsNullOrEmpty(Request.QueryString["st"]))
            {
                DownLoad();
            }
            if (!string.IsNullOrEmpty(Request.QueryString["uid"]) && !string.IsNullOrEmpty(Request.QueryString["tt"]))
            {
                DownLoads();
            }
            if (!string.IsNullOrEmpty(Request.QueryString["uid"]) && !string.IsNullOrEmpty(Request.QueryString["s"]) && !string.IsNullOrEmpty(Request.QueryString["e"]))
            {
                if (Request.QueryString["uid"] == Uid)
                    MyDownLoad(Request.QueryString["s"], Request.QueryString["e"]);
            }
        }

        //单个导出
        private void DownLoad()
        {
            string ct = "", t = "", uname = "";

            int u = Convert.ToInt32(Request.QueryString["uid"]);
            int s = Convert.ToInt32(Request.QueryString["st"]);
            Sys_UserInfo su = Sys_User.Init().GetById(u);
            t = GetDate(s);
            uname = su.RealName + " (" + su.DepName + ")\r\n\r\n";
            ct += uname + " " + t + "\r\n\r\n";

            if (su.et6.Contains("#" + Uid + "#"))
            {
                string sql = "select * from Calendar where uid='" + u + "' and stime like '" + s + "%' order by stime asc";
                using (DataSet ds = MsSqlOperate.ExecuteDataset(CommandType.Text, sql))
                {
                    for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                    {
                        string stime = ds.Tables[0].Rows[i]["stime"] + "";
                        string etime = ds.Tables[0].Rows[i]["etime"] + "";
                        DateTime d1 = GetDatetime(stime);
                        DateTime d2 = GetDatetime(etime);
                        if (WC.Tool.Utils.GetDayOf2Date(d1, d2) == 1)
                        {
                            ct += "时间：" + GetTime(stime) + "\r\n";
                            ct += "标题：" + ds.Tables[0].Rows[i]["ename"] + "\r\n";
                            ct += "详情：" + ds.Tables[0].Rows[i]["memo"] + "\r\n\r\n";
                        }
                        else
                        {
                            ct += "时间：" + GetTime(stime) + " 至 " + GetTime(etime) + "\r\n";
                            ct += "标题：" + ds.Tables[0].Rows[i]["ename"] + "\r\n";
                            ct += "详情：" + ds.Tables[0].Rows[i]["memo"] + "\r\n\r\n";
                        }
                    }



                }
                Response.Clear();
                Response.ClearHeaders();
                Response.Buffer = false;

                Response.AppendHeader("Content-Disposition", "attachment;filename=" + s + ".txt");
                Response.ContentType = "application/vnd.txt";
                Response.Write(ct);
                Response.Flush();
                Response.End();
            }
            else
                Response.Write("<script>alert('您不是" + su.RealName + "(" + su.DepName + ")的直接上级,无权查看他的工作日程');window.location='/manage/common/MyMemo.aspx'</script>");
        }

        //我的日程导出
        private void MyDownLoad(string s, string e)
        {
            string ct = "", where = " ( ";
            int u = Convert.ToInt32(Request.QueryString["uid"]);
            Sys_UserInfo su = Sys_User.Init().GetById(u);
            ct += su.RealName + " (" + su.DepName + ")\r\n\r\n";
            where += " substring(STime,1,8) between '" + s + "' and '" + e + "' )";
            GetCT(u, ref ct, where);

            string filename = "";
            if (s != e)
                filename = UserName + "_" + s + "to" + e;
            else filename = UserName + "_" + s;

            Response.Clear();
            Response.ClearHeaders();
            Response.Buffer = false;

            Response.AppendHeader("Content-Disposition", "attachment;filename=" + filename + ".txt");
            Response.ContentType = "application/vnd.txt";
            Response.Write(ct);
            Response.Flush();
            Response.End();
        }

        //批量导出
        private void DownLoads()
        {

            string ct = "", where = " ( ";
            string tt = Request.QueryString["tt"];

            int u = Convert.ToInt32(Request.QueryString["uid"]);
            Sys_UserInfo su = Sys_User.Init().GetById(u);

            ct += su.RealName + " (" + su.DepName + ")\r\n\r\n";

            if (su.et6.Contains("#" + Uid + "#") && tt.Contains(";"))
            {
                string[] a = tt.Split(';'); 
                for (int i = 0; i < a.Length; i++)
                {
                    if (!string.IsNullOrEmpty(a[i]))
                    {
                        if (i != a.Length - 2)
                            where += " stime like '" + a[i] + "%' or ";
                        else
                            where += " stime like '" + a[i] + "%' ) ";
                    }
                }

                GetCT(u, ref ct, where);

                Response.Clear();
                Response.ClearHeaders();
                Response.Buffer = false;

                Response.AppendHeader("Content-Disposition", "attachment;filename=CalendarReports.txt");
                Response.ContentType = "application/vnd.txt";
                Response.Write(ct);
                Response.Flush();
                Response.End();
            }
            else
                Response.Write("<script>alert('您不是" + su.RealName + "(" + su.DepName + ")的直接上级,无权查看他的工作日程');window.location='/manage/common/MyMemo.aspx'</script>");
        }

        private void GetCT(int u, ref string ct, string where)
        {
            string sql = "select * from Calendar where uid='" + u + "' and " + where + " order by stime asc";
            using (DataSet ds = MsSqlOperate.ExecuteDataset(CommandType.Text, sql))
            {
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    string stime = ds.Tables[0].Rows[i]["stime"] + "";
                    string etime = ds.Tables[0].Rows[i]["etime"] + "";
                    DateTime d1 = GetDatetime(stime);
                    DateTime d2 = GetDatetime(etime);
                    if (WC.Tool.Utils.GetDayOf2Date(d1, d2) == 1)
                    {
                        ct += "时间：" + GetTime(stime) + "\r\n";
                        ct += "标题：" + ds.Tables[0].Rows[i]["ename"] + "\r\n";
                        ct += "详情：" + ds.Tables[0].Rows[i]["memo"] + "\r\n\r\n";
                    }
                    else
                    {
                        ct += "时间：" + GetTime(stime) + " 至 " + GetTime(etime) + "\r\n";
                        ct += "标题：" + ds.Tables[0].Rows[i]["ename"] + "\r\n";
                        ct += "详情：" + ds.Tables[0].Rows[i]["memo"] + "\r\n\r\n";
                    }
                }

            }

        }

        private string GetTime(string j)
        {
            string t = "";
            if (j.Contains("T"))
            {
                t = j.Split('T')[0].Substring(0, 4) + "-" + j.Split('T')[0].Substring(4, 2) + "-" + j.Split('T')[0].Substring(6, 2) + " "
                + j.Split('T')[1].Substring(0, 2) + ":" + j.Split('T')[1].Substring(2, 2);
            }
            else
            {
                t = j.Substring(0, 4) + "-" + j.Substring(4, 2) + "-" + j.Substring(6, 2);
            }
            return t;

        }

        private DateTime GetDatetime(string j)
        {
            if (j.Contains("T"))
                j = j.Split('T')[0].Substring(0, 4) + "-" + j.Split('T')[0].Substring(4, 2) + "-" + j.Split('T')[0].Substring(6, 2) + " "
                + j.Split('T')[1].Substring(0, 2) + ":" + j.Split('T')[1].Substring(2, 2);
            else
                j = j.Substring(0, 4) + "-" + j.Substring(4, 2) + "-" + j.Substring(6, 2);
            DateTime d = Convert.ToDateTime(j);
            return d;
        }

        protected string GetDate(object j)
        {
            string s = j + "";
            if (s.Length == 8 && WC.Tool.Utils.IsNumber(s))
            {
                string t = s.Substring(0, 4) + "-" + s.Substring(4, 2) + "-" + s.Substring(6, 2);
                s = WC.Tool.Utils.ConvertDate4(t);
            }
            return s;
        }

    }
}
