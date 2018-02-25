using System;
using System.Collections;
using System.Data;
using System.Data.SqlClient;

using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;

using WC.DBUtility;

namespace WC.WebUI.Manage.Utils
{
    /// <summary>
    /// $codebehindclassname$ 的摘要说明
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class message : IHttpHandler
    {
        private string mail = "<span style=font-weight:bold><a href=# onclick=addTab('收件箱','/manage/Common/Mail_List.aspx?fid=0','icon-data3') >您有 ({0}) 封新邮件请查收</a></span><br>";
        private string gov = "<span style=font-weight:bold><a href=# onclick=addTab('我的审核','/Manage/gov/Gov_List.aspx?action=verify','icon-password') >您有 ({0}) 件新公文需审批</a></span><br>";
        private string gov_r = "<span style=font-weight:bold><a href=# onclick=addTab('公文签收','/Manage/gov/Gov_Recipient.aspx?action=verify','icon-et') >您有 ({0}) 件新公文需签收</a></span><br>";
        private string flow = "<span style=font-weight:bold><a href=# onclick=addTab('我的批阅','/Manage/flow/Flow_List.aspx?action=verify','icon-html') >您有 ({0}) 个新流程需审批</a></span><br>";
        private string cal = "<span style=font-weight:bold><a href=# onclick=addTab('我的日程','/manage/CalendarMemo/CalendarMemo.aspx','icon-calendar') >您有 ({0}) 个今天日程安排</a></span><br>";

        public void ProcessRequest(HttpContext context)
        {
            context.Response.Charset = "UTF-8";
            context.Response.Cache.SetNoStore();
            string uid = context.Request.Params["uid"];
            string result = "";

            SqlParameter rid = new SqlParameter();
            rid.ParameterName = "@uid";
            rid.Size = 50;
            rid.Value = Convert.ToInt32(uid);

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


            SqlParameter[] sqls = { sqlpt1, sqlpt2, sqlpt3, sqlpt4, sqlpt5, rid };
            int[] nums = { 0, 0, 0, 0, 0 };
            using (DataSet ds = MsSqlOperate.ExecuteDataset(CommandType.StoredProcedure, "Global_Message", sqls))
            {
                nums[0] = Convert.ToInt32(sqlpt1.Value);
                nums[1] = Convert.ToInt32(sqlpt2.Value);
                nums[2] = Convert.ToInt32(sqlpt3.Value);
                nums[3] = Convert.ToInt32(sqlpt4.Value);
                nums[4] = Convert.ToInt32(sqlpt5.Value);

                if (nums[0] > 0)
                {
                    result += string.Format(mail, nums[0]);
                }
                if (nums[1] > 0)
                {
                    result += string.Format(gov, nums[1]);
                }
                if (nums[2] > 0)
                {
                    result += string.Format(gov_r, nums[2]);
                }
                if (nums[3] > 0)
                {
                    result += string.Format(flow, nums[3]);
                }
                if (nums[4] > 0)
                {
                    result += string.Format(cal, nums[4]);
                }

            }


            if (result == "")
                result = "1";

            context.Response.Write(result);
            context.Response.End();
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}
