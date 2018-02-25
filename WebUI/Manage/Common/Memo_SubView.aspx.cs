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
using System.IO;
using System.Text;
using WC.BLL;
using WC.Model;
using WC.DBUtility;

namespace WC.WebUI.Manage.Common
{
    public partial class Memo_SubView : WC.BLL.ViewPages
    {
        protected string ct = "";
        protected string t = "";
        protected string uname = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["uid"]) && !string.IsNullOrEmpty(Request.QueryString["st"]))
            {
                Show(Request.QueryString["uid"], Request.QueryString["st"]);
            }
        }

        private void Show(string uid, string st)
        {
            Sys_UserInfo su = Sys_User.Init().GetById(Convert.ToInt32(uid));
            t = GetDate(st);
            uname = su.RealName + " (" + su.DepName + ")";
            ct += uname + " " + t + "\r\n\r\n";
            if (su.et6.Contains("#" + Uid + "#"))
            {
                int u = Convert.ToInt32(uid);
                int s = Convert.ToInt32(st);
                string sql = "select * from Calendar where uid='"+u+"' and stime like '"+st+"%' order by stime asc";
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
                    Bodys.Value = ct;
                }

            }
            else
                Response.Write("<script>alert('您不是" + su.RealName + "(" + su.DepName + ")的直接上级,无权查看他的工作日程');window.location='/manage/common/MyMemo.aspx'</script>");

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
                j = j.Split('T')[0].Substring(0, 4) + "-" + j.Split('T')[0].Substring(4, 2) + "-" + j.Split('T')[0].Substring(6, 2) +" "
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

        protected void Totxt_Btn(object sender, EventArgs e)
        {
            Response.Redirect("Memo_Download.aspx?uid=" + Request.QueryString["uid"] + "&st=" + Request.QueryString["st"]);
        }

    }
}
