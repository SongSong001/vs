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
    /// ������
    /// </summary>
    public class Utils
    {
        /// <summary>
        /// ת��ʱ���ʽ 09-1-07 / 09-1-07 16:53 / 200901071653 / 2009/01/07 16:53 / 2009��1��7�� 16:53 / 2009��1��7�� 16:53 ������
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
            return dt.ToString("yyyy") + "��" + dt.ToString("MM") + "��" + dt.ToString("dd") + "��" + " " + dt.ToString("HH:mm");
        }
        public static string ConvertDate3(object a)
        {
            DateTime dt = Convert.ToDateTime(a);
            return dt.ToString("yyyy") + "��" + dt.ToString("MM") + "��" + dt.ToString("dd") + "��" + " " + dt.ToString("HH:mm") + " " + GetDayOfWeek(dt);
        }
        public static string ConvertDate4(object a)
        {
            DateTime dt = Convert.ToDateTime(a);
            return dt.ToString("yyyy") + "��" + dt.ToString("MM") + "��" + dt.ToString("dd") + "��" + " " + GetDayOfWeek(dt);
        }
        public static string ConvertDate5(object a)
        {
            DateTime dt = Convert.ToDateTime(a);
            return dt.ToString("yyyy") + "-" + dt.ToString("MM") + "-" + dt.ToString("dd") + " " + " " + dt.ToString("HH:mm") + " " + GetDayOfWeek(dt);
        }
        /// <summary>
        /// �õ�2������֮�������  d2-d1
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
        /// ����һ�����������ڼ�(����)
        /// </summary>
        /// <param name="a"></param>
        /// <returns></returns>
        public static string GetDayOfWeek(object a)
        {
            DateTime d = Convert.ToDateTime(a);
            string en = d.DayOfWeek.ToString();
            string rt = "";
            if (en.ToLower() == "monday")
                rt = "��һ";
            if (en.ToLower() == "tuesday")
                rt = "�ܶ�";
            if (en.ToLower() == "wednesday")
                rt = "����";
            if (en.ToLower() == "thursday")
                rt = "����";
            if (en.ToLower() == "friday")
                rt = "����";
            if (en.ToLower() == "saturday")
                rt = "����";
            if (en.ToLower() == "sunday")
                rt = "����";
            return rt;
        }

        /// <summary>
        /// �������ڷ�������  31��,��5����,��12��
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
            int cc = aa - bb; //����
            int dd = (int)Math.Floor(Convert.ToDouble(cc / 365));
            int days = cc - dd * 365;
            int ee = days / 30;
            int day = days - ee * 30;
            return dd.ToString() + "��,��" + ee.ToString() + "����,��" + day + "��";
        }

        /// <summary>
        /// ��ȡ�ַ�����ʵ���ȣ�1�����ֳ���Ϊ2
        /// </summary>
        /// <param name="str">�������ַ���</param>
        /// <returns>�ַ�������</returns>
        public static int GetStringLength(string str)
        {
            return Encoding.Default.GetBytes(str).Length;
        }

        /// <summary>
        /// ��ȡ�����
        /// </summary>
        /// <returns></returns>
        public static int GetRandom(int send)
        {
            return new Random().Next(send);
        }

        /// <summary>
        /// �ж�ָ���ַ�����ָ���ַ��������е�λ��
        /// </summary>
        /// <param name="strSearch">�ַ���</param>
        /// <param name="stringArray">�ַ�������</param>
        /// <param name="caseInsensetive">�Ƿ����ִ�Сд, trueΪ������, falseΪ����</param>
        /// <returns>�ַ�����ָ���ַ��������е�λ��, �粻�����򷵻�-1</returns>
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
        /// �жϸ������ַ���(strNumber)�Ƿ�����ֵ��
        /// </summary>
        /// <param name="strNumber">Ҫȷ�ϵ��ַ���</param>
        /// <returns>���򷵼�true �����򷵻� false</returns>
        public static bool IsNumber(string strNumber)
        {
            return new Regex(@"^([0-9])[0-9]*(\.\w*)?$").IsMatch(strNumber);
        }

        /// <summary>
        /// �жϸ������ַ�������(strNumber)�е������ǲ��Ƕ�Ϊ��ֵ��
        /// </summary>
        /// <param name="strNumber">Ҫȷ�ϵ��ַ�������</param>
        /// <returns>���򷵼�true �����򷵻� false</returns>
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
        /// �Ƿ�Ϊʱ���ʽ
        /// </summary>
        /// <returns>���򷵼�true �����򷵻� false</returns>
        public static bool IsTime(string timeval)
        {
            return Regex.IsMatch(timeval, @"^((([0-1]?[0-9])|(2[0-3])):([0-5]?[0-9])(:[0-5]?[0-9])?)$");
        }

        /// <summary>
        /// �Ƿ���������
        /// ֧�ֵĸ�ʽ����("1980-06-06"��"1980/06/06")
        /// </summary>
        /// <param name="dateStr"></param>
        /// <returns></returns>
        public static bool IsDate(string dateStr)
        {

            string datePat = @"^(\d{4})(\/|-)(\d{1,2})(\/|-)(\d{1,2})$";
            bool IsMatch = Regex.IsMatch(dateStr, datePat);
            //���ڸ�ʽ����ȷ����ȷ��ʽ��1980-06-06
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
                //"�·ݱ�����1��-12��֮��";
                return false;
            }

            if (day < 1 || day > 31)
            {
                //"�ձ�����1-31��֮��";
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
                    // year + " �� 2 ��û�� " + day + " ��"
                    return false;
                }
            }
            return true; // date is valid
        }


        /// <summary>
        /// ��õ�ǰ����·��
        /// </summary>
        /// <param name="strPath">ָ����·��</param>
        /// <returns>����·��</returns>
        public static string GetMapPath(string strPath)
        {
            if (HttpContext.Current != null)
            {
                return HttpContext.Current.Server.MapPath(strPath);
            }
            else //��web��������
            {
                return System.IO.Path.Combine(AppDomain.CurrentDomain.BaseDirectory, strPath);
            }
        }

        /// <summary>
        /// �����ļ��Ƿ����
        /// </summary>
        /// <param name="filename">�ļ���</param>
        /// <returns>�Ƿ����</returns>
        public static bool FileExists(string filename)
        {
            return System.IO.File.Exists(filename);
        }

        /// <summary>
        /// дcookieֵ
        /// </summary>
        /// <param name="strName">����</param>
        /// <param name="strValue">ֵ</param>
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
        /// �ж��ļ����Ƿ�Ϊ���������ֱ����ʾ��ͼƬ�ļ���
        /// </summary>
        /// <param name="filename">�ļ���</param>
        /// <returns>�Ƿ����ֱ����ʾ</returns>
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
        /// �Ƿ�Ϊip
        /// </summary>
        /// <param name="ip"></param>
        /// <returns></returns>
        public static bool IsIP(string ip)
        {
            return Regex.IsMatch(ip, @"^((2[0-4]\d|25[0-5]|[01]?\d\d?)\.){3}(2[0-4]\d|25[0-5]|[01]?\d\d?)$");
        }

        /// <summary>
        /// ��ָ����ContentType���ָ���ļ��ļ�
        /// </summary>
        /// <param name="filepath">�ļ�·��</param>
        /// <param name="filename">������ļ���</param>
        /// <param name="filetype">���ļ����ʱ���õ�ContentType</param>
        public static void ResponseFile(string filepath, string filename, string filetype)
        {
            Stream iStream = null;
            // ������Ϊ10k
            byte[] buffer = new Byte[10000];
            // �ļ�����
            int length;
            // ��Ҫ�������ݳ���
            long dataToRead;
            try
            {
                // ���ļ�
                iStream = new FileStream(filepath, FileMode.Open, FileAccess.Read, FileShare.Read);
                // ��Ҫ�������ݳ���
                dataToRead = iStream.Length;

                HttpContext.Current.Response.ContentType = filetype;
                HttpContext.Current.Response.AddHeader("Content-Disposition", "attachment;filename=" + Utils.UrlEncode(filename.Trim()).Replace("+", " "));

                while (dataToRead > 0)
                {
                    // ���ͻ����Ƿ񻹴�������״̬
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
                        // �������������������ѭ��
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
                    // �ر��ļ�
                    iStream.Close();
                }
            }
            HttpContext.Current.Response.End();
        }

        /// <summary>
        /// ����XML�ڵ�
        /// </summary>
        /// <param name="xDocument">XmlDocument</param>
        /// <param name="elementName">Ԫ������</param>
        /// <param name="textName">�ı�ֵ</param>
        /// <returns>XmlElement</returns>
        public static XmlElement CreateXmlNode(XmlDocument xDocument, string elementName, string textName)
        {
            try
            {
                XmlElement xElement = xDocument.CreateElement(elementName);
                XmlText xText = xDocument.CreateTextNode(textName);
                xElement.AppendChild(xText);
                return xElement;//����
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// ���ɴ�CDATA�Ľڵ�
        /// </summary>
        /// <param name="xDocument">XmlDocument</param>
        /// <param name="elementName">Ԫ������</param>
        /// <param name="cdataValue">CDATAֵ</param>
        /// <returns>XmlElement</returns>
        public static XmlElement CreateXmlNodeCDATA(XmlDocument xDocument, string elementName, string cdataValue)
        {
            try
            {
                XmlElement xElement = xDocument.CreateElement(elementName);
                XmlCDataSection cdata = xDocument.CreateCDataSection(cdataValue);
                xElement.AppendChild(cdata);
                return xElement;//����
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
        /// �ַ�������ٹ�ָ�������򽫳����Ĳ�����ָ���ַ�������
        /// </summary>
        /// <param name="p_SrcString">Ҫ�����ַ���</param>
        /// <param name="p_Length">ָ������</param>
        /// <param name="p_TailString">�����滻���ַ���</param>
        /// <returns>��ȡ����ַ���</returns>
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
        /// ����Ƿ����email��ʽ
        /// </summary>
        /// <param name="strEmail">Ҫ�жϵ�email�ַ���</param>
        /// <returns>�жϽ��</returns>
        public static bool IsValidEmail(string strEmail)
        {
            return Regex.IsMatch(strEmail, @"^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$");
        }

        /// <summary>
        /// ����Ƿ���Sqlע��©��
        /// </summary>
        /// <param name="str">Ҫ�ж��ַ���</param>
        /// <returns>�жϽ��</returns>
        public static bool IsSafeSqlString(string str)
        {

            return !Regex.IsMatch(str, @"[-|;|,|\/|\(|\)|\[|\]|\}|\{|%|@|\*|!|\']");
        }

        /// <summary>
        /// �ָ��ַ���
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
        /// ���� HTML �ַ����ı�����
        /// </summary>
        /// <param name="str">�ַ���</param>
        /// <returns>������</returns>
        public static string HtmlEncode(string str)
        {
            return HttpUtility.HtmlEncode(str);
        }

        /// <summary>
        /// ���� HTML �ַ����Ľ�����
        /// </summary>
        /// <param name="str">�ַ���</param>
        /// <returns>������</returns>
        public static string HtmlDecode(string str)
        {
            return HttpUtility.HtmlDecode(str);
        }

        /// <summary>
        /// ���� URL �ַ����ı�����
        /// </summary>
        /// <param name="str">�ַ���</param>
        /// <returns>������</returns>
        public static string UrlEncode(string str)
        {
            return HttpUtility.UrlEncode(str);
        }

        /// <summary>
        /// ���� URL �ַ����ı�����
        /// </summary>
        /// <param name="str">�ַ���</param>
        /// <returns>������</returns>
        public static string UrlDecode(string str)
        {
            return HttpUtility.UrlDecode(str);
        }

        /// <summary>
        /// ��ʽ���ֽ����ַ���
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
        /// ��ȡ��̬ҳ���ַ
        /// </summary>
        /// <param name="oldPage">ԭҳ���ļ���</param>
        /// <param name="firstPram">��һ������</param>
        /// <param name="scendPram">�ڶ�������</param>
        /// <returns>��̬ҳ���ַ</returns>
        public static string GetStaticPageUrl(string oldPage, string firstPram, string scendPram)
        {
            if (oldPage.IndexOf('.') < 0)
                throw new Exception("�����ҳ���ļ����Ʋ����Ϲ淶");
            string[] oldPageInfo = oldPage.Split('.');
            StringBuilder temp = new StringBuilder();
            temp.Append(oldPageInfo[0]);
            temp.Append("_" + firstPram);
            temp.Append("_" + scendPram);
            temp.Append("." + oldPageInfo[1]);
            return temp.ToString();
        }

        /// <summary>
        /// ��ȡ��̬ҳ���ַ
        /// </summary>
        /// <param name="oldPage">ԭҳ���ļ���</param>
        /// <param name="firstPram">��һ������</param>
        /// <returns>��̬ҳ���ַ</returns>
        public static string GetStaticPageUrl(string oldPage, string firstPram)
        {
            if (oldPage.IndexOf('.') < 0)
                throw new Exception("�����ҳ���ļ����Ʋ����Ϲ淶");
            string[] oldPageInfo = @oldPage.Split('.');
            StringBuilder temp = new StringBuilder();
            temp.Append(oldPageInfo[0]);
            temp.Append("_" + @firstPram);
            temp.Append("." + oldPageInfo[1]);
            return temp.ToString();
        }

        /// <summary>
        /// ��ʽ����ַ
        /// </summary>
        /// <param name="oldPage">����ҳ��</param>
        /// <param name="firstPram">��һ������</param>
        /// <param name="scendPram">�ڶ�������</param>
        /// <returns>ת���õ���ַ</returns>
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
        /// ������֤��
        /// </summary>
        /// <returns>��֤��</returns>
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
        /// ��ʽ����ַ
        /// </summary>
        /// <param name="oldPage">����ҳ��</param>
        /// <param name="firstPram">��һ������</param>
        /// <returns>ת���õ���ַ</returns>
        public static string FormatUrl(string oldPage, string firstPram)
        {
            return FormatUrl(oldPage, firstPram, null);
        }

        /// <summary>
        /// ���ݿ�ʵ����,����һ��MODEL����
        /// ע��:MODEL����Ҫ�����ݿ��ֶ�һ��,˳������ν
        /// </summary>
        /// <param name="dr">SqlDataReader </param>
        /// <typeparam name="T">MODEL ����</typeparam>
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
        /// ��SqlDataReader����List
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
        /// ���ݿ�ʵ����,����һ��MODEL����
        /// ע��:MODEL����Ҫ�����ݿ��ֶ�һ��,˳������ν
        /// </summary>
        /// <param name="dr">DataRow </param>
        /// <typeparam name="T">MODEL ����</typeparam>
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
        /// ��DataSet��Tables[0]����List
        /// </summary>
        /// <typeparam name="T">MODEL ����</typeparam>
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
        /// ����Σ���ַ���(script/iframe/on��)
        /// </summary>
        /// <param name="str"></param>
        /// <returns>���˺�HtmlEncode</returns>
        public static string ClearHtml(string html)
        {
            System.Text.RegularExpressions.Regex regex1 = new System.Text.RegularExpressions.Regex(@"<script[\s\S]+</script *>", System.Text.RegularExpressions.RegexOptions.IgnoreCase);
            System.Text.RegularExpressions.Regex regex2 = new System.Text.RegularExpressions.Regex(@" href *= *[\s\S]*script *:", System.Text.RegularExpressions.RegexOptions.IgnoreCase);
            System.Text.RegularExpressions.Regex regex3 = new System.Text.RegularExpressions.Regex(@" on[\s\S]*=", System.Text.RegularExpressions.RegexOptions.IgnoreCase);
            System.Text.RegularExpressions.Regex regex4 = new System.Text.RegularExpressions.Regex(@"<iframe[\s\S]+</iframe *>", System.Text.RegularExpressions.RegexOptions.IgnoreCase);
            System.Text.RegularExpressions.Regex regex5 = new System.Text.RegularExpressions.Regex(@"<frameset[\s\S]+</frameset *>", System.Text.RegularExpressions.RegexOptions.IgnoreCase);
            System.Text.RegularExpressions.Regex regex6 = new System.Text.RegularExpressions.Regex(@" src *= *[\s\S]*script *:", System.Text.RegularExpressions.RegexOptions.IgnoreCase);

            html = regex1.Replace(html, ""); //����<script></script>��� 
            html = regex2.Replace(html, ""); //����href=script: (<A>) ���� 
            html = regex3.Replace(html, " _disibledevent="); //���������ؼ���on�¼� 
            html = regex4.Replace(html, ""); //����iframe 
            html = regex5.Replace(html, ""); //����frameset 
            html = regex6.Replace(html, ""); //����src=script;

            return html;
        }

        /// <summary>
        /// ���SQLע�����
        /// </summary>
        /// <param name="str">������ַ���</param>
        /// <returns>true-��ȫ/false-�Ƿ�</returns>
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

        //��ȡ2���֮������(���ֶ��)
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
            return b == 0 ? "��" : "��";
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
        /// ��һ������ ���л��� �����л�/ʵ�ֶ��� ����
        /// </summary>
        /// <param name="a"></param>
        /// <returns>����һ��������Ķ���</returns>
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
        /// �������HTML��ǩ
        /// </summary>
        /// <param name="html">html����</param>
        public static string RemoveHtml(string html)
        {
            if (string.IsNullOrEmpty(html))
                return string.Empty;

            return Regex.Replace(html, @"<.+?/?>", "", RegexOptions.IgnoreCase | RegexOptions.Singleline);
        }

        /// <summary>   
        /// �ж�һ���ַ����Ƿ�Ϊ��ĸ������   
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
        /// ����ҳ�治������
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
        /// ����Urlʾ�� http://localhost:85/manage/doc/
        /// </summary>
        /// <returns></returns>
        public static string GetRequestHostUrl()
        {
            //���URL��ֵ
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
            // �����ļ���С.
            FileInfo[] fis = d.GetFiles();
            foreach (FileInfo fi in fis)
            {
                Size += fi.Length;
            }
            // ��������ǰĿ¼�������ļ���.
            DirectoryInfo[] dis = d.GetDirectories();
            foreach (DirectoryInfo di in dis)
            {
                Size += DirSize(di);   //����õ��ݹ��ˣ����ø�����,ע�⣬���ﲢ����ֱ�ӷ���ֵ�����ǵ��ø���������
            }
            return (Size);
        }

        /// <summary>
        /// ��������Ƿ�����(ʹ�������ж� 100%s)
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
        /// Ilist<T> ת���� DataSet
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
