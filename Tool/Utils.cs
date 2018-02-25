using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using System.Reflection;
using System.Web;
using System.Web.UI;
using System.Configuration;
using System.Xml;
using System.Net.Mail;
using System.Text.RegularExpressions;
using System.IO;
using System.Security.Cryptography;
using Microsoft.VisualBasic;
using System.Data;
using System.Data.SqlClient;
using System.Management;
using System.Runtime;
using System.Runtime.Serialization.Formatters.Binary;

namespace WC.Tool
{
    /// <summary>
    /// 工具类
    /// </summary>
    public class Utils
    {
        /// <summary>
        /// 转换时间格式 09-1-07 / 09-1-07 16:53 / 200901071653 / 2009/01/07 16:53 / 2009年1月7日 16:53 / 2009年1月7日 16:53 星期五
        /// </summary>
        /// <param name="a"></param>
        /// <returns></returns>
        public static string ConvertDate(object a)
        {
            return Convert.ToDateTime(a).ToString("yy-M-dd");
        }
        public static string ConvertDate_(object a)
        {
            return Convert.ToDateTime(a).ToString("yy-M-dd HH:mm");
        }
        public static string ConvertDate__(object a)
        {
            return Convert.ToDateTime(a).ToString("yyyyMMddHHmm");
        }
        public static string ConvertDate0(object a)
        {
            return Convert.ToDateTime(a).ToString("yyyy-MM-dd");
        }
        public static string ConvertDate1(object a)
        {
            return Convert.ToDateTime(a).ToString("yyyy-MM-dd HH:mm");
        }
        public static string ConvertDate2(object a)
        {
            DateTime dt = Convert.ToDateTime(a);
            return dt.ToString("yyyy") + "年" + dt.ToString("MM") + "月" + dt.ToString("dd") + "日" + " " + dt.ToString("HH:mm");
        }
        public static string ConvertDate3(object a)
        {
            DateTime dt = Convert.ToDateTime(a);
            return dt.ToString("yyyy") + "年" + dt.ToString("MM") + "月" + dt.ToString("dd") + "日" + " " + dt.ToString("HH:mm") + " " + GetDayOfWeek(dt);
        }
        public static string ConvertDate4(object a)
        {
            DateTime dt = Convert.ToDateTime(a);
            return dt.ToString("yyyy") + "年" + dt.ToString("MM") + "月" + dt.ToString("dd") + "日" + " " + GetDayOfWeek(dt);
        }
        public static string ConvertDate5(object a)
        {
            DateTime dt = Convert.ToDateTime(a);
            return dt.ToString("yyyy") + "-" + dt.ToString("MM") + "-" + dt.ToString("dd") + " " + " " + dt.ToString("HH:mm") + " " + GetDayOfWeek(dt);
        }
        /// <summary>
        /// 得到2个日期之间的天数  d2-d1
        /// </summary>
        /// <param name="d1"></param>
        /// <param name="d2"></param>
        /// <returns></returns>
        public static int GetDayOf2Date(DateTime d1, DateTime d2)
        {
            TimeSpan s = new TimeSpan(d2.Ticks - d1.Ticks);
            return s.Days;
        }
        /// <summary>
        /// 返回一个日期是星期几(中文)
        /// </summary>
        /// <param name="a"></param>
        /// <returns></returns>
        public static string GetDayOfWeek(object a)
        {
            DateTime d = Convert.ToDateTime(a);
            string en = d.DayOfWeek.ToString();
            string rt = "";
            if (en.ToLower() == "monday")
                rt = "周一";
            if (en.ToLower() == "tuesday")
                rt = "周二";
            if (en.ToLower() == "wednesday")
                rt = "周三";
            if (en.ToLower() == "thursday")
                rt = "周四";
            if (en.ToLower() == "friday")
                rt = "周五";
            if (en.ToLower() == "saturday")
                rt = "周六";
            if (en.ToLower() == "sunday")
                rt = "周日";
            return rt;
        }

        /// <summary>
        /// 根据日期返回年龄  31岁,零5个月,零12天
        /// </summary>
        /// <param name="a"></param>
        /// <returns></returns>
        public static string GetAgeByDatetime(object a)
        {
            DateTime b = Convert.ToDateTime(a);
            int a2 = DateTime.Now.Year;
            int b2 = b.Year;
            int a3 = DateTime.Now.Month;
            int b3 = b.Month;
            int a4 = DateTime.Now.Day;
            int b4 = b.Day;
            int aa = (a2 - 1900) * 365 + a3 * 30 + a4;
            int bb = (b2 - 1900) * 365 + b3 * 30 + b4;
            int cc = aa - bb; //天数
            int dd = (int)Math.Floor(Convert.ToDouble(cc / 365));
            int days = cc - dd * 365;
            int ee = days / 30;
            int day = days - ee * 30;
            return dd.ToString() + "岁,零" + ee.ToString() + "个月,零" + day + "天";
        }

        /// <summary>
        /// 获取字符串真实长度，1个汉字长度为2
        /// </summary>
        /// <param name="str">待检查的字符串</param>
        /// <returns>字符串长度</returns>
        public static int GetStringLength(string str)
        {
            return Encoding.Default.GetBytes(str).Length;
        }

        /// <summary>
        /// 获取随机数
        /// </summary>
        /// <returns></returns>
        public static int GetRandom(int send)
        {
            return new Random().Next(send);
        }

        /// <summary>
        /// 判断指定字符串在指定字符串数组中的位置
        /// </summary>
        /// <param name="strSearch">字符串</param>
        /// <param name="stringArray">字符串数组</param>
        /// <param name="caseInsensetive">是否不区分大小写, true为不区分, false为区分</param>
        /// <returns>字符串在指定字符串数组中的位置, 如不存在则返回-1</returns>
        public static int GetInArrayID(string strSearch, string[] stringArray, bool caseInsensetive)
        {
            for (int i = 0; i < stringArray.Length; i++)
            {
                if (caseInsensetive)
                {
                    if (strSearch.ToLower() == stringArray[i].ToLower())
                    {
                        return i;
                    }
                }
                else
                {
                    if (strSearch == stringArray[i])
                    {
                        return i;
                    }
                }
            }
            return -1;
        }

        /// <summary>
        /// 判断给定的字符串(strNumber)是否是数值型
        /// </summary>
        /// <param name="strNumber">要确认的字符串</param>
        /// <returns>是则返加true 不是则返回 false</returns>
        public static bool IsNumber(string strNumber)
        {
            return new Regex(@"^([0-9])[0-9]*(\.\w*)?$").IsMatch(strNumber);
        }

        /// <summary>
        /// 判断给定的字符串数组(strNumber)中的数据是不是都为数值型
        /// </summary>
        /// <param name="strNumber">要确认的字符串数组</param>
        /// <returns>是则返加true 不是则返回 false</returns>
        public static bool IsNumberArray(string[] strNumber)
        {
            if (strNumber == null)
            {
                return false;
            }
            if (strNumber.Length < 1)
            {
                return false;
            }
            foreach (string id in strNumber)
            {
                if (!IsNumber(id))
                {
                    return false;
                }
            }
            return true;
        }

        /// <summary>
        /// 是否为时间格式
        /// </summary>
        /// <returns>是则返加true 不是则返回 false</returns>
        public static bool IsTime(string timeval)
        {
            return Regex.IsMatch(timeval, @"^((([0-1]?[0-9])|(2[0-3])):([0-5]?[0-9])(:[0-5]?[0-9])?)$");
        }

        /// <summary>
        /// 是否是日期型
        /// 支持的格式包括("1980-06-06"和"1980/06/06")
        /// </summary>
        /// <param name="dateStr"></param>
        /// <returns></returns>
        public static bool IsDate(string dateStr)
        {

            string datePat = @"^(\d{4})(\/|-)(\d{1,2})(\/|-)(\d{1,2})$";
            bool IsMatch = Regex.IsMatch(dateStr, datePat);
            //日期格式不正确，正确格式：1980-06-06
            if (!IsMatch)
                return false;
            string[] dates = dateStr.Split('/', '-');
            if (dates == null || dates.Length < 3)
                return false;

            int year = int.Parse(dates[0]);
            int month = int.Parse(dates[1]);
            int day = int.Parse(dates[2]);

            if (month < 1 || month > 12)
            {
                //"月份必须是1月-12月之间";
                return false;
            }

            if (day < 1 || day > 31)
            {
                //"日必须是1-31日之间";
                return false;
            }

            if ((month == 4 || month == 6 || month == 9 || month == 11) && day == 31)
            {
                //month doesn't have 31 days!"
                return false;
            }

            if (month == 2)
            { // check for february 29th
                bool isleap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
                if (day > 29 || (day == 29 && !isleap))
                {
                    // year + " 年 2 月没有 " + day + " 日"
                    return false;
                }
            }
            return true; // date is valid
        }


        /// <summary>
        /// 获得当前绝对路径
        /// </summary>
        /// <param name="strPath">指定的路径</param>
        /// <returns>绝对路径</returns>
        public static string GetMapPath(string strPath)
        {
            if (HttpContext.Current != null)
            {
                return HttpContext.Current.Server.MapPath(strPath);
            }
            else //非web程序引用
            {
                return System.IO.Path.Combine(AppDomain.CurrentDomain.BaseDirectory, strPath);
            }
        }

        /// <summary>
        /// 返回文件是否存在
        /// </summary>
        /// <param name="filename">文件名</param>
        /// <returns>是否存在</returns>
        public static bool FileExists(string filename)
        {
            return System.IO.File.Exists(filename);
        }

        /// <summary>
        /// 写cookie值
        /// </summary>
        /// <param name="strName">名称</param>
        /// <param name="strValue">值</param>
        public static void WriteCookie(string strName, string strValue, int expires)
        {
            HttpCookie cookie = HttpContext.Current.Request.Cookies[strName];
            if (cookie == null)
            {
                cookie = new HttpCookie(strName);
            }
            cookie.Value = strValue;
            cookie.Expires = DateTime.Now.AddMinutes(expires);
            HttpContext.Current.Response.AppendCookie(cookie);

        }

        /// <summary>
        /// 判断文件名是否为浏览器可以直接显示的图片文件名
        /// </summary>
        /// <param name="filename">文件名</param>
        /// <returns>是否可以直接显示</returns>
        public static bool IsImgFilename(string filename)
        {
            filename = filename.Trim();
            if (filename.EndsWith(".") || filename.IndexOf(".") == -1)
            {
                return false;
            }
            string extname = filename.Substring(filename.LastIndexOf(".") + 1).ToLower();
            return (extname == "jpg" || extname == "jpeg" || extname == "png" || extname == "bmp" || extname == "gif");
        }

        /// <summary>
        /// 是否为ip
        /// </summary>
        /// <param name="ip"></param>
        /// <returns></returns>
        public static bool IsIP(string ip)
        {
            return Regex.IsMatch(ip, @"^((2[0-4]\d|25[0-5]|[01]?\d\d?)\.){3}(2[0-4]\d|25[0-5]|[01]?\d\d?)$");
        }

        /// <summary>
        /// 以指定的ContentType输出指定文件文件
        /// </summary>
        /// <param name="filepath">文件路径</param>
        /// <param name="filename">输出的文件名</param>
        /// <param name="filetype">将文件输出时设置的ContentType</param>
        public static void ResponseFile(string filepath, string filename, string filetype)
        {
            Stream iStream = null;
            // 缓冲区为10k
            byte[] buffer = new Byte[10000];
            // 文件长度
            int length;
            // 需要读的数据长度
            long dataToRead;
            try
            {
                // 打开文件
                iStream = new FileStream(filepath, FileMode.Open, FileAccess.Read, FileShare.Read);
                // 需要读的数据长度
                dataToRead = iStream.Length;

                HttpContext.Current.Response.ContentType = filetype;
                HttpContext.Current.Response.AddHeader("Content-Disposition", "attachment;filename=" + Utils.UrlEncode(filename.Trim()).Replace("+", " "));

                while (dataToRead > 0)
                {
                    // 检查客户端是否还处于连接状态
                    if (HttpContext.Current.Response.IsClientConnected)
                    {
                        length = iStream.Read(buffer, 0, 10000);
                        HttpContext.Current.Response.OutputStream.Write(buffer, 0, length);
                        HttpContext.Current.Response.Flush();
                        buffer = new Byte[10000];
                        dataToRead = dataToRead - length;
                    }
                    else
                    {
                        // 如果不再连接则跳出死循环
                        dataToRead = -1;
                    }
                }
            }
            catch (Exception ex)
            {
                HttpContext.Current.Response.Write("Error : " + ex.Message);
            }
            finally
            {
                if (iStream != null)
                {
                    // 关闭文件
                    iStream.Close();
                }
            }
            HttpContext.Current.Response.End();
        }

        /// <summary>
        /// 生成XML节点
        /// </summary>
        /// <param name="xDocument">XmlDocument</param>
        /// <param name="elementName">元素名称</param>
        /// <param name="textName">文本值</param>
        /// <returns>XmlElement</returns>
        public static XmlElement CreateXmlNode(XmlDocument xDocument, string elementName, string textName)
        {
            try
            {
                XmlElement xElement = xDocument.CreateElement(elementName);
                XmlText xText = xDocument.CreateTextNode(textName);
                xElement.AppendChild(xText);
                return xElement;//返回
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// 生成带CDATA的节点
        /// </summary>
        /// <param name="xDocument">XmlDocument</param>
        /// <param name="elementName">元素名称</param>
        /// <param name="cdataValue">CDATA值</param>
        /// <returns>XmlElement</returns>
        public static XmlElement CreateXmlNodeCDATA(XmlDocument xDocument, string elementName, string cdataValue)
        {
            try
            {
                XmlElement xElement = xDocument.CreateElement(elementName);
                XmlCDataSection cdata = xDocument.CreateCDataSection(cdataValue);
                xElement.AppendChild(cdata);
                return xElement;//返回
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static string HtmlEnCoding(string input)
        {
            return input;
        }

        public void MD5Conputer()
        {
            throw new System.NotImplementedException();
        }

        /// <summary>
        /// 字符串如果操过指定长度则将超出的部分用指定字符串代替
        /// </summary>
        /// <param name="p_SrcString">要检查的字符串</param>
        /// <param name="p_Length">指定长度</param>
        /// <param name="p_TailString">用于替换的字符串</param>
        /// <returns>截取后的字符串</returns>
        public static string GetSubString(string p_SrcString, int p_Length, string p_TailString)
        {
            string myResult = p_SrcString;
            if (p_Length >= 0)
            {
                byte[] bsSrcString = Encoding.Default.GetBytes(p_SrcString);
                if (bsSrcString.Length > p_Length)
                {
                    int nRealLength = p_Length;
                    int[] anResultFlag = new int[p_Length];
                    byte[] bsResult = null;

                    int nFlag = 0;
                    for (int i = 0; i < p_Length; i++)
                    {
                        if (bsSrcString[i] > 127)
                        {
                            nFlag++;
                            if (nFlag == 3)
                            {
                                nFlag = 1;
                            }
                        }
                        else
                        {
                            nFlag = 0;
                        }
                        anResultFlag[i] = nFlag;
                    }
                    if ((bsSrcString[p_Length - 1] > 127) && (anResultFlag[p_Length - 1] == 1))
                    {
                        nRealLength = p_Length + 1;
                    }
                    bsResult = new byte[nRealLength];
                    Array.Copy(bsSrcString, bsResult, nRealLength);
                    myResult = Encoding.Default.GetString(bsResult);
                    myResult = myResult + p_TailString;
                }
            }
            return myResult;
        }

        /// <summary>
        /// 检测是否符合email格式
        /// </summary>
        /// <param name="strEmail">要判断的email字符串</param>
        /// <returns>判断结果</returns>
        public static bool IsValidEmail(string strEmail)
        {
            return Regex.IsMatch(strEmail, @"^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$");
        }

        /// <summary>
        /// 检测是否有Sql注入漏洞
        /// </summary>
        /// <param name="str">要判断字符串</param>
        /// <returns>判断结果</returns>
        public static bool IsSafeSqlString(string str)
        {

            return !Regex.IsMatch(str, @"[-|;|,|\/|\(|\)|\[|\]|\}|\{|%|@|\*|!|\']");
        }

        /// <summary>
        /// 分割字符串
        /// </summary>
        public static string[] SplitString(string strContent, string strSplit)
        {
            if (strContent.IndexOf(strSplit) < 0)
            {
                string[] tmp = { strContent };
                return tmp;
            }
            return Regex.Split(strContent, @strSplit.Replace(".", @"\."), RegexOptions.IgnoreCase);
        }

        /// <summary>
        /// 返回 HTML 字符串的编码结果
        /// </summary>
        /// <param name="str">字符串</param>
        /// <returns>编码结果</returns>
        public static string HtmlEncode(string str)
        {
            return HttpUtility.HtmlEncode(str);
        }

        /// <summary>
        /// 返回 HTML 字符串的解码结果
        /// </summary>
        /// <param name="str">字符串</param>
        /// <returns>解码结果</returns>
        public static string HtmlDecode(string str)
        {
            return HttpUtility.HtmlDecode(str);
        }

        /// <summary>
        /// 返回 URL 字符串的编码结果
        /// </summary>
        /// <param name="str">字符串</param>
        /// <returns>编码结果</returns>
        public static string UrlEncode(string str)
        {
            return HttpUtility.UrlEncode(str);
        }

        /// <summary>
        /// 返回 URL 字符串的编码结果
        /// </summary>
        /// <param name="str">字符串</param>
        /// <returns>解码结果</returns>
        public static string UrlDecode(string str)
        {
            return HttpUtility.UrlDecode(str);
        }

        /// <summary>
        /// 格式化字节数字符串
        /// </summary>
        /// <param name="bytes"></param>
        /// <returns></returns>
        public static string FormatBytesStr(int bytes)
        {
            if (bytes > 1073741824)
            {
                return ((double)(bytes / 1073741824)).ToString("0") + "G";
            }
            if (bytes > 1048576)
            {
                return ((double)(bytes / 1048576)).ToString("0") + "M";
            }
            if (bytes > 1024)
            {
                return ((double)(bytes / 1024)).ToString("0") + "K";
            }
            return bytes.ToString() + "Bytes";
        }

        /// <summary>
        /// 获取静态页面地址
        /// </summary>
        /// <param name="oldPage">原页面文件名</param>
        /// <param name="firstPram">第一个参数</param>
        /// <param name="scendPram">第二个参数</param>
        /// <returns>静态页面地址</returns>
        public static string GetStaticPageUrl(string oldPage, string firstPram, string scendPram)
        {
            if (oldPage.IndexOf('.') < 0)
                throw new Exception("输入的页面文件名称不符合规范");
            string[] oldPageInfo = oldPage.Split('.');
            StringBuilder temp = new StringBuilder();
            temp.Append(oldPageInfo[0]);
            temp.Append("_" + firstPram);
            temp.Append("_" + scendPram);
            temp.Append("." + oldPageInfo[1]);
            return temp.ToString();
        }

        /// <summary>
        /// 获取静态页面地址
        /// </summary>
        /// <param name="oldPage">原页面文件名</param>
        /// <param name="firstPram">第一个参数</param>
        /// <returns>静态页面地址</returns>
        public static string GetStaticPageUrl(string oldPage, string firstPram)
        {
            if (oldPage.IndexOf('.') < 0)
                throw new Exception("输入的页面文件名称不符合规范");
            string[] oldPageInfo = @oldPage.Split('.');
            StringBuilder temp = new StringBuilder();
            temp.Append(oldPageInfo[0]);
            temp.Append("_" + @firstPram);
            temp.Append("." + oldPageInfo[1]);
            return temp.ToString();
        }

        /// <summary>
        /// 格式化网址
        /// </summary>
        /// <param name="oldPage">请求页面</param>
        /// <param name="firstPram">第一个参数</param>
        /// <param name="scendPram">第二个参数</param>
        /// <returns>转换好的网址</returns>
        public static string FormatUrl(string oldPage, string firstPram, string scendPram)
        {
            StringBuilder temp = new StringBuilder();
            if (!string.IsNullOrEmpty(oldPage))
                temp.Append(oldPage);
            if (!string.IsNullOrEmpty(firstPram))
                temp.Append("?" + firstPram);
            if (!string.IsNullOrEmpty(scendPram))
                temp.Append("&" + scendPram);
            return temp.ToString();
        }

        /// <summary>
        /// 产生验证码
        /// </summary>
        /// <returns>验证码</returns>
        public static string CreateRandomStr(int len)
        {
            int number;
            StringBuilder checkCode = new StringBuilder();
            Random random = new Random();
            for (int i = 0; i < len; i++)
            {
                number = random.Next();
                if (number % 2 == 0)
                {
                    checkCode.Append((char)('0' + (char)(number % 10)));
                }
                else
                {
                    checkCode.Append((char)('A' + (char)(number % 26)));
                }
            }
            return checkCode.ToString();
        }

        /// <summary>
        /// 格式化网址
        /// </summary>
        /// <param name="oldPage">请求页面</param>
        /// <param name="firstPram">第一个参数</param>
        /// <returns>转换好的网址</returns>
        public static string FormatUrl(string oldPage, string firstPram)
        {
            return FormatUrl(oldPage, firstPram, null);
        }

        /// <summary>
        /// 数据库实例化,生成一个MODEL对象
        /// 注意:MODEL属性要与数据库字段一致,顺序无所谓
        /// </summary>
        /// <param name="dr">SqlDataReader </param>
        /// <typeparam name="T">MODEL 类型</typeparam>
        /// <returns></returns>
        public static T SetParm<T>(SqlDataReader dr)
        {
            T instance = (T)typeof(T).Assembly.CreateInstance(typeof(T).FullName);
            foreach (PropertyInfo p in typeof(T).GetProperties())
            {
                if (dr[p.Name] is DBNull)
                    p.SetValue(instance, null, null);
                else
                    p.SetValue(instance, dr[p.Name], null);
            }
            return instance;
        }

        /// <summary>
        /// 从SqlDataReader返回List
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="dr"></param>
        /// <returns></returns>
        public static IList<T> GetList<T>(SqlDataReader dr)
        {
            IList<T> list = new List<T>();
            while (dr.Read())
            {
                list.Add(SetParm<T>(dr));
            }
            return list;
        }

        /// <summary>
        /// 数据库实例化,生成一个MODEL对象
        /// 注意:MODEL属性要与数据库字段一致,顺序无所谓
        /// </summary>
        /// <param name="dr">DataRow </param>
        /// <typeparam name="T">MODEL 类型</typeparam>
        /// <returns></returns>
        public static T SetParm<T>(DataRow dr)
        {
            T instance = (T)typeof(T).Assembly.CreateInstance(typeof(T).FullName);
            List<string> list = GetDataRowColumnName(dr);
            foreach (PropertyInfo p in typeof(T).GetProperties())
            {
                if (list.Contains(p.Name.ToLower()))
                {
                    if (dr[p.Name] is DBNull)
                        p.SetValue(instance, null, null);
                    else
                        p.SetValue(instance, dr[p.Name], null);
                }
            }
            return instance;
        }

        private static List<string> GetDataRowColumnName(DataRow dr)
        {
            List<string> list = new List<string>();
            for (int i = 0; i < dr.Table.Columns.Count; i++)
            {
                list.Add(dr.Table.Columns[i].ColumnName.ToLower());
            }
            return list;
        }

        /// <summary>
        /// 从DataSet的Tables[0]返回List
        /// </summary>
        /// <typeparam name="T">MODEL 类型</typeparam>
        /// <param name="ds">DataSet </param>
        /// <returns></returns>
        public static IList<T> GetList<T>(DataSet ds)
        {
            IList<T> list = new List<T>();
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                list.Add(SetParm<T>(dr));
            }
            return list;
        }

        /// <summary>
        /// 过滤危险字符串(script/iframe/on等)
        /// </summary>
        /// <param name="str"></param>
        /// <returns>过滤后并HtmlEncode</returns>
        public static string ClearHtml(string html)
        {
            System.Text.RegularExpressions.Regex regex1 = new System.Text.RegularExpressions.Regex(@"<script[\s\S]+</script *>", System.Text.RegularExpressions.RegexOptions.IgnoreCase);
            System.Text.RegularExpressions.Regex regex2 = new System.Text.RegularExpressions.Regex(@" href *= *[\s\S]*script *:", System.Text.RegularExpressions.RegexOptions.IgnoreCase);
            System.Text.RegularExpressions.Regex regex3 = new System.Text.RegularExpressions.Regex(@" on[\s\S]*=", System.Text.RegularExpressions.RegexOptions.IgnoreCase);
            System.Text.RegularExpressions.Regex regex4 = new System.Text.RegularExpressions.Regex(@"<iframe[\s\S]+</iframe *>", System.Text.RegularExpressions.RegexOptions.IgnoreCase);
            System.Text.RegularExpressions.Regex regex5 = new System.Text.RegularExpressions.Regex(@"<frameset[\s\S]+</frameset *>", System.Text.RegularExpressions.RegexOptions.IgnoreCase);
            System.Text.RegularExpressions.Regex regex6 = new System.Text.RegularExpressions.Regex(@" src *= *[\s\S]*script *:", System.Text.RegularExpressions.RegexOptions.IgnoreCase);

            html = regex1.Replace(html, ""); //过滤<script></script>标记 
            html = regex2.Replace(html, ""); //过滤href=script: (<A>) 属性 
            html = regex3.Replace(html, " _disibledevent="); //过滤其它控件的on事件 
            html = regex4.Replace(html, ""); //过滤iframe 
            html = regex5.Replace(html, ""); //过滤frameset 
            html = regex6.Replace(html, ""); //过滤src=script;

            return html;
        }

        /// <summary>
        /// 检测SQL注入代码
        /// </summary>
        /// <param name="str">待检测字符串</param>
        /// <returns>true-安全/false-非法</returns>
        public static bool CheckSql(string Str)
        {
            if (Str != null)
            {
                string SqlStr = "dbcc |alter |drop |exec |insert |select |delete |update |master |truncate |declare |char |where |--|cmdshell|sysobjects|db_|backup| from";
                bool ReturnValue = true;
                try
                {
                    if (Str.Trim() != "")
                    {
                        Str = Str.Trim().ToLower();
                        string[] anySqlStr = SqlStr.Split('|');
                        foreach (string ss in anySqlStr)
                        {
                            if (Str.IndexOf(ss) >= 0)
                            {
                                ReturnValue = false;
                            }
                        }
                    }
                }
                catch
                {
                    ReturnValue = false;
                }
                return ReturnValue;
            }
            else return true;
        }

        //获取2标记之间内容(出现多次)
        public static string[] GetMulti(string str, string head, string tail)
        {
            List<string> list = new List<string>();
            if (str.Contains(head) && str.Contains(tail))
            {
                string[] array = str.Split(new string[1] { head }, StringSplitOptions.None);
                for (int i = 1; i < array.Length; i++)
                {
                    if (array[i].Contains(tail))
                    {
                        int m = array[i].IndexOf(tail);
                        list.Add(array[i].Substring(0, m).ToLower());
                    }
                }
            }
            return list.ToArray();
        }

        public static string GetSubString2(string obj, int length, string token)
        {
            return obj.Length > length ? obj.Substring(0, length) + token : obj;
        }

        public static string GetStringByInt(int b)
        {
            return b == 0 ? "否" : "是";
        }

        public static string Win32_GetMainBoardBiosSerialNumber()
        {
            ManagementClass mc = new ManagementClass("Win32_NetworkAdapterConfiguration");
            ManagementObjectCollection moc = mc.GetInstances();
            string str = "";
            foreach (ManagementObject mo in moc)
            {
                if ((bool)mo["IPEnabled"] == true)
                    str = mo["MacAddress"].ToString();
            }
            return str;
        }

        public static string Win32_GetMainBoardBiosSerialNumber1()
        {
            ManagementObject disk = new ManagementObject("win32_logicaldisk.deviceid=\"d:\"");
            disk.Get();
            return disk.GetPropertyValue("VolumeSerialNumber").ToString();
        }

        public static string Win32_GetCpuSerialNumber()
        {
            string cpuInfo = "";
            ManagementClass cimobject = new ManagementClass("Win32_Processor");
            ManagementObjectCollection moc = cimobject.GetInstances();
            foreach (ManagementObject mo in moc)
            {
                cpuInfo = mo.Properties["ProcessorId"].Value.ToString();
            }
            return cpuInfo;
        }

        /// <summary>
        /// 将一个对象 序列化后 反序列化/实现对象 拷贝
        /// </summary>
        /// <param name="a"></param>
        /// <returns>返回一个拷贝后的对象</returns>
        public static object Serialize(object a)
        {
            MemoryStream ms = new MemoryStream();
            BinaryFormatter f = new BinaryFormatter();
            f.Serialize(ms, a);
            ms.Close();
            byte[] b = ms.ToArray();
            ms.Dispose();

            MemoryStream m = new MemoryStream(b);
            return f.Deserialize(m);
        }

        /// <summary>
        /// 清除所有HTML标签
        /// </summary>
        /// <param name="html">html代码</param>
        public static string RemoveHtml(string html)
        {
            if (string.IsNullOrEmpty(html))
                return string.Empty;

            return Regex.Replace(html, @"<.+?/?>", "", RegexOptions.IgnoreCase | RegexOptions.Singleline);
        }

        /// <summary>   
        /// 判断一个字符串是否为字母加数字   
        /// Regex("[a-zA-Z0-9]?"   
        /// </summary>   
        /// <param name="source"></param>   
        /// <returns></returns>   
        public static bool IsWordAndNum(string _value)
        {
            Regex regex = new Regex("[a-zA-Z0-9]?");
            return regex.Match(_value).Success;
        }

        /// <summary>
        /// 设置页面不被缓存
        /// </summary>
        public static void SetPageNoCache()
        {

            HttpContext.Current.Response.Buffer = true;
            HttpContext.Current.Response.ExpiresAbsolute = System.DateTime.Now.AddSeconds(-1);
            HttpContext.Current.Response.Expires = 0;
            HttpContext.Current.Response.CacheControl = "no-cache";
            HttpContext.Current.Response.AddHeader("Pragma", "No-Cache");
        }

        public static bool IsOfficeFile(string filename)
        {
            bool b = false;
            if (filename.Contains("."))
            {
                string[] arr = filename.Split('.');
                string t = arr[arr.Length - 1].ToLower();
                if (t.Contains("doc") || t.Contains("xls") || t.Contains("wps"))
                {
                    b = true;
                }
            }
            return b;
        }

        /// <summary>
        /// 返回Url示例 http://localhost:85/manage/doc/
        /// </summary>
        /// <returns></returns>
        public static string GetRequestHostUrl()
        {
            //获得URL的值
            string url = "http://" + HttpContext.Current.Request.ServerVariables["HTTP_HOST"].ToString()
                  + HttpContext.Current.Request.ServerVariables["PATH_INFO"].ToString();
            int i = url.LastIndexOf("/");
            url = url.Substring(0, i) + "/";
            return url;
        }

        public static long DirSize(DirectoryInfo d)
        {
            //string path = "~/files";
            //DirectoryInfo di = new DirectoryInfo(Server.MapPath(path));
            //Response.Write(WC.Tool.Utils.DirSize(di)/(1048576.0F));

            long Size = 0;
            // 所有文件大小.
            FileInfo[] fis = d.GetFiles();
            foreach (FileInfo fi in fis)
            {
                Size += fi.Length;
            }
            // 遍历出当前目录的所有文件夹.
            DirectoryInfo[] dis = d.GetDirectories();
            foreach (DirectoryInfo di in dis)
            {
                Size += DirSize(di);   //这就用到递归了，调用父方法,注意，这里并不是直接返回值，而是调用父返回来的
            }
            return (Size);
        }

        /// <summary>
        /// 随机数是是否命中(使用余数判断 100%s)
        /// </summary>
        /// <param name="s"></param>
        /// <returns></returns>
        public static bool IsRandomHit(int s)
        {
            int t = new Random().Next(1, 101);
            return (t % s == 0) ? true : false;
        }

        public static int GetSplitNum(string s, string r)
        {
            int a = 0;
            if (r.Contains(s))
            {
                a = r.Split(new string[1] { s }, StringSplitOptions.None).Length - 1;
            }
            return a;
        }

        public static string GetFileExtension(string filename)
        {
            string r = "";
            if (filename.Contains("."))
            {
                string[] arr = filename.Split('.');
                r = "." + arr[arr.Length - 1].ToLower();
            }
            return r;
        }

        /// <summary>
        /// Ilist<T> 转换成 DataSet
        /// </summary>
        /// <param name="list"></param>
        /// <returns></returns>
        public static DataSet ConvertListToDataSet<T>(IList<T> list)
        {
            if (list == null || list.Count <= 0)
                return null;
            DataSet ds = new DataSet();
            DataTable dt = new DataTable(typeof(T).Name);
            DataColumn column;
            DataRow row;
            System.Reflection.PropertyInfo[] myPropertyInfo = typeof(T).GetProperties(System.Reflection.BindingFlags.Public | System.Reflection.BindingFlags.Instance);
            foreach (T t in list)
            {
                if (t == null)
                    continue;
                row = dt.NewRow();
                for (int i = 0, j = myPropertyInfo.Length; i < j; i++)
                {
                    System.Reflection.PropertyInfo pi = myPropertyInfo[i];
                    string name = pi.Name;
                    if (dt.Columns[name] == null)
                    {
                        column = new DataColumn(name, pi.PropertyType);
                        dt.Columns.Add(column);
                    }
                    row[name] = pi.GetValue(t, null);
                }
                dt.Rows.Add(row);
            }
            ds.Tables.Add(dt);
            return ds;
        }


    }
}
