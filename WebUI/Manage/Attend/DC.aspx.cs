using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Text;
using System.IO;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

using WC.BLL;
using WC.Model;
using WC.DBUtility;
using WC.Tool;

namespace WC.WebUI.Manage.Attend
{
    public partial class DC : WC.BLL.ViewPages
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["type"]) && !string.IsNullOrEmpty(Request.QueryString["st"]))
            {
                string type = Request.QueryString["type"];
                string st = Request.QueryString["st"];
                string et = Request.QueryString["et"];
                if (WC.Tool.Utils.IsDate(st) && WC.Tool.Utils.IsDate(et))
                {
                    Todo(type);
                }
            }

        }

        private void Todo(string type)
        {
            switch (type)
            {
                case "1": td1(); break;
                case "2": td2(); break;
                case "3": td3(); break;
                case "4": td4(); break;
                default: break;
            }
        }

        private void td1()
        {
            string type = Request.QueryString["type"];
            string tmp = " AttendType=" + type;
            string keywords = Request.QueryString["keywords"];
            string st = Request.QueryString["st"];
            string et = Request.QueryString["et"];

            tmp += " and (addtime between '" + st + "' and '" + et + "') and (";
            tmp += " RealName like '%" + keywords + "%' or DepName like '%" + keywords + "%' ) ";

            //IList list = Work_Attend.Init().GetAll(tmp, "id asc");

            //DateTime t = DateTime.Now;
            //DateTime d1 = Convert.ToDateTime(st);
            //DateTime d2 = Convert.ToDateTime(et);
            //if (d1.CompareTo(d2) > 0)
            //{
            //    t = d1;
            //    d1 = d2;
            //    d2 = t;
            //}

            //List<Work_AttendInfo> li = new List<Work_AttendInfo>();
            //t = d1.AddDays(1);

            //while (t.CompareTo(d2) < 0)
            //{
            //    Work_AttendInfo w = new Work_AttendInfo();


            //    t = d1.AddDays(1);
            //}

            using (DataSet ds = MsSqlOperate.ExecuteDataset(CommandType.Text, "select * from Work_Attend where" + tmp))
            {
                DataTable dt = ds.Tables[0];
                if (dt.Rows.Count > 0)
                {
                    try
                    {
                        StringWriter swCSV = new StringWriter();
                        //列名
                        swCSV.WriteLine("人员姓名,考勤日期,考勤类别,考勤数据,备注 ");

                        //遍历datatable导出数据
                        foreach (DataRow drTemp in dt.Rows)
                        {
                            StringBuilder sbText = new StringBuilder();
                            sbText = AppendCSVFields(sbText, drTemp["RealName"] + "");
                            sbText = AppendCSVFields(sbText, Convert.ToDateTime(drTemp["AddTime"] + "").ToString("yyyy-MM-dd"));
                            sbText = AppendCSVFields(sbText, drTemp["StandardNames"] + "" + drTemp["StandardTimes"]);
                            sbText = AppendCSVFields(sbText, drTemp["SignTimes"] + " (" + drTemp["SignJudge"] + ")");
                            sbText = AppendCSVFields(sbText, drTemp["Notes"] + "");

                            sbText.Remove(sbText.Length - 1, 1);

                            //写datatable的一行
                            swCSV.WriteLine(sbText.ToString());
                        }
                        //下载文件
                        DownloadFile(Response, swCSV.GetStringBuilder(), "考勤" + st + ".csv");

                        swCSV.Close();
                        Response.End();

                    }
                    catch (Exception ex)
                    {
                        throw ex;
                    }
                }

                else
                {
                    Response.Write("<script>alert('没有任何数据');window.location='WorkList.aspx?type=1';</script>");
                }
            }

        }

        private void td2()
        {
            string type = Request.QueryString["type"];
            string tmp = " AttendType=" + type;
            string keywords = Request.QueryString["keywords"];
            string st = Request.QueryString["st"];
            string et = Request.QueryString["et"];

            tmp += " and (addtime between '" + st + "' and '" + et + "') and (";
            tmp += " RealName like '%" + keywords + "%' or DepName like '%" + keywords + "%' ) ";

            using (DataSet ds = MsSqlOperate.ExecuteDataset(CommandType.Text, "select * from Work_Attend where" + tmp))
            {
                DataTable dt = ds.Tables[0];
                if (dt.Rows.Count > 0)
                {
                    try
                    {
                        StringWriter swCSV = new StringWriter();
                        //列名
                        swCSV.WriteLine("外出人,登记日期,开始时间,结束时间,备注 ");

                        //遍历datatable导出数据
                        foreach (DataRow drTemp in dt.Rows)
                        {
                            StringBuilder sbText = new StringBuilder();
                            sbText = AppendCSVFields(sbText, drTemp["RealName"] + "");
                            sbText = AppendCSVFields(sbText, Convert.ToDateTime(drTemp["AddTime"] + "").ToString("yyyy-MM-dd"));
                            sbText = AppendCSVFields(sbText, drTemp["BeginTime"] + " " + drTemp["B1"] + ":" + drTemp["B2"]);
                            sbText = AppendCSVFields(sbText, drTemp["EndTime"] + " " + drTemp["E1"] + ":" + drTemp["E2"]);
                            sbText = AppendCSVFields(sbText, drTemp["Notes"] + "");

                            sbText.Remove(sbText.Length - 1, 1);

                            //写datatable的一行
                            swCSV.WriteLine(sbText.ToString());
                        }
                        //下载文件
                        DownloadFile(Response, swCSV.GetStringBuilder(), "外出" + st + ".csv");

                        swCSV.Close();
                        Response.End();

                    }
                    catch (Exception ex)
                    {
                        throw ex;
                    }
                }

                else
                {
                    Response.Write("<script>alert('没有任何数据');window.location='WorkList.aspx?type=1';</script>");
                }
            }

        }

        private void td3()
        {
            string type = Request.QueryString["type"];
            string tmp = " AttendType=" + type;
            string keywords = Request.QueryString["keywords"];
            string st = Request.QueryString["st"];
            string et = Request.QueryString["et"];

            tmp += " and (addtime between '" + st + "' and '" + et + "') and (";
            tmp += " RealName like '%" + keywords + "%' or DepName like '%" + keywords + "%' ) ";


            using (DataSet ds = MsSqlOperate.ExecuteDataset(CommandType.Text, "select * from Work_Attend where" + tmp))
            {
                DataTable dt = ds.Tables[0];
                if (dt.Rows.Count > 0)
                {
                    try
                    {
                        StringWriter swCSV = new StringWriter();
                        //列名
                        swCSV.WriteLine("请假人,登记日期,开始时间,结束时间,备注 ");

                        //遍历datatable导出数据
                        foreach (DataRow drTemp in dt.Rows)
                        {
                            StringBuilder sbText = new StringBuilder();
                            sbText = AppendCSVFields(sbText, drTemp["RealName"] + "");
                            sbText = AppendCSVFields(sbText, Convert.ToDateTime(drTemp["AddTime"] + "").ToString("yyyy-MM-dd"));
                            sbText = AppendCSVFields(sbText, drTemp["BeginTime"] + " " + drTemp["B1"] + ":" + drTemp["B2"]);
                            sbText = AppendCSVFields(sbText, drTemp["EndTime"] + " " + drTemp["E1"] + ":" + drTemp["E2"]);
                            sbText = AppendCSVFields(sbText, drTemp["Notes"] + "");

                            sbText.Remove(sbText.Length - 1, 1);

                            //写datatable的一行
                            swCSV.WriteLine(sbText.ToString());
                        }
                        //下载文件
                        DownloadFile(Response, swCSV.GetStringBuilder(), "请假" + st + ".csv");

                        swCSV.Close();
                        Response.End();

                    }
                    catch (Exception ex)
                    {
                        throw ex;
                    }
                }

                else
                {
                    Response.Write("<script>alert('没有任何数据');window.location='WorkList.aspx?type=1';</script>");
                }
            }

        }

        private void td4()
        {
            string type = Request.QueryString["type"];
            string tmp = " AttendType=" + type;
            string keywords = Request.QueryString["keywords"];
            string st = Request.QueryString["st"];
            string et = Request.QueryString["et"];

            tmp += " and (addtime between '" + st + "' and '" + et + "') and (";
            tmp += " RealName like '%" + keywords + "%' or DepName like '%" + keywords + "%' ) ";


            using (DataSet ds = MsSqlOperate.ExecuteDataset(CommandType.Text, "select * from Work_Attend where" + tmp))
            {
                DataTable dt = ds.Tables[0];
                if (dt.Rows.Count > 0)
                {
                    try
                    {
                        StringWriter swCSV = new StringWriter();
                        //列名
                        swCSV.WriteLine("出差人,登记日期,出差地点,开始时间,结束时间,备注 ");

                        //遍历datatable导出数据
                        foreach (DataRow drTemp in dt.Rows)
                        {
                            StringBuilder sbText = new StringBuilder();
                            sbText = AppendCSVFields(sbText, drTemp["RealName"] + "");
                            sbText = AppendCSVFields(sbText, Convert.ToDateTime(drTemp["AddTime"] + "").ToString("yyyy-MM-dd"));
                            sbText = AppendCSVFields(sbText, drTemp["TravelAddress"] + "");
                            sbText = AppendCSVFields(sbText, drTemp["BeginTime"] + " " + drTemp["B1"] + ":" + drTemp["B2"]);
                            sbText = AppendCSVFields(sbText, drTemp["EndTime"] + " " + drTemp["E1"] + ":" + drTemp["E2"]);
                            sbText = AppendCSVFields(sbText, drTemp["Notes"] + "");

                            sbText.Remove(sbText.Length - 1, 1);

                            //写datatable的一行
                            swCSV.WriteLine(sbText.ToString());
                        }
                        //下载文件
                        DownloadFile(Response, swCSV.GetStringBuilder(), "出差" + st + ".csv");

                        swCSV.Close();
                        Response.End();

                    }
                    catch (Exception ex)
                    {
                        throw ex;
                    }
                }

                else
                {
                    Response.Write("<script>alert('没有任何数据');window.location='WorkList.aspx?type=1';</script>");
                }
            }

        }

        /// <summary>
        /// csv添加逗号 用来区分列
        /// </summary>
        /// <param name="argFields">字段</param>
        /// <returns>添加后内容</returns>
        private StringBuilder AppendCSVFields(StringBuilder argSource, string argFields)
        {
            return argSource.Append(argFields.Replace(",", " ").Trim()).Append(",");
        }


        /// <summary>
        /// 弹出下载框
        /// </summary>
        /// <param name="argResp">弹出页面</param>
        /// <param name="argFileStream">文件流</param>
        /// <param name="strFileName">文件名</param>
        public static void DownloadFile(HttpResponse argResp, StringBuilder argFileStream, string strFileName)
        {
            try
            {
                string strResHeader = "attachment; filename=" + Guid.NewGuid().ToString() + ".csv";
                if (!string.IsNullOrEmpty(strFileName))
                {
                    strResHeader = "inline; filename=" + strFileName;
                }
                argResp.AppendHeader("Content-Disposition", strResHeader);//attachment说明以附件下载，inline说明在线打开
                argResp.ContentType = "application/ms-excel";
                argResp.ContentEncoding = Encoding.GetEncoding("GB2312"); // Encoding.UTF8;//
                argResp.Write(argFileStream);

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }
}