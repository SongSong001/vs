using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.IO;
using System.Xml;

namespace WC.Tool
{
    public class Config
    {

        private static string[] GetForbidden()
        {
            List<string> array = new List<string>();
            Hashtable stand_config = (Hashtable)HttpContext.Current.Application["stand_config"];
            Hashtable ForbiddenUploadType = (Hashtable)stand_config["forbiddenuploadtype"];
            foreach (System.Collections.DictionaryEntry d in ForbiddenUploadType)
            {
                array.Add(d.Value + "");
            }
            return array.ToArray();
        }

        private static string[] ForbiddenUploadType = { ".asp", ".aspx", ".php", ".cgi", ".asa", ".exe", ".dll", ".bat", ".com", ".xhtml", ".shtml", ".htx", ".ashx", ".cmd", ".cer", ".cdx", ".ad", ".adprototype", ".asax", ".ascx", ".ashx", ".asmx", ".axd", ".browser", ".cd", ".compiled", ".config", ".csproj", ".dd", ".exclude", ".idc", ".java", ".jsl", ".ldb", ".ldd", ".lddprototype", ".ldf", ".licx", ".master", ".mdb", ".mdf", ".msgx", ".refresh", ".rem", ".resources", ".resx", ".rules", ".sd", ".sdm", ".sdmdocument", ".shtm", ".sitemap", ".skin", ".soap", ".stm", ".svc", ".vb", ".vbproj", ".vjsproj", ".vsdisco", ".webinfo", ".xoml" };

        public static bool IsValidFile(HttpPostedFile f)
        {
            string ext = WC.Tool.Utils.GetFileExtension(f.FileName).ToLower();

            if (ForbiddenUploadType.Length == 7)
                ForbiddenUploadType = GetForbidden();

            bool b = true;
            for (int i = 0; i < ForbiddenUploadType.Length; i++)
            {
                string t = ForbiddenUploadType[i].ToLower();
                if (!string.IsNullOrEmpty(ext))
                {
                    string fn = Path.GetFileName(ext).ToLower();
                    if (fn.Contains(t))
                        b = false;
                }
                else b = false;
            }
            return b;
        }

        public static Hashtable GetConfigByFileName(string filename)
        {
            string file = HttpContext.Current.Server.MapPath(filename);
            Hashtable ht = new Hashtable();
            using (StreamReader sr = new StreamReader(file, System.Text.Encoding.UTF8))
            {
                string content = sr.ReadToEnd().Trim();
                string[] tmpstr = content.Split(new string[1] { "@end" }, StringSplitOptions.None);
                foreach (string ss in tmpstr)
                {
                    if (!string.IsNullOrEmpty(ss.Trim()))
                    {
                        if (ss.Contains("?"))
                        {
                            string tmp = WC.Tool.Utils.GetMulti(ss, "{", "}")[0];
                            ht.Add(tmp.Split('?')[0], tmp.Split('?')[1]);
                        }
                        if (ss.Contains("!"))
                        {
                            string tmp = WC.Tool.Utils.GetMulti(ss, "{", "}")[0];
                            string key = tmp.Split('!')[0];
                            string values = tmp.Split('!')[1];
                            Hashtable hh = new Hashtable();
                            foreach (string s in values.Split(','))
                            {
                                hh.Add(s.Split(':')[0], s.Split(':')[1]);
                            }
                            ht.Add(key, hh);
                        }
                    }
                }
                sr.Close();
            }
            return ht;
        }

        public static bool CheckInstall()
        {
            XmlDocument xd = new XmlDocument();
            xd.Load(HttpContext.Current.Server.MapPath(GetTap()));
            string t = xd.SelectSingleNode("ins/install").Attributes["Value"].Value;
            if (t != "9C+EB60=")
            {
                HttpContext.Current.Application["isinstall"] = "0";
                return false;
            }
            else
            {
                HttpContext.Current.Application["isinstall"] = "1";
                return true;
            }
        }

        public static void IsInstall()
        {
            if ((HttpContext.Current.Application["isinstall"] + "") == "0")
                HttpContext.Current.Response.Redirect("~/Install/Default.aspx");
        }

        //"~/img/snap/ins.gif"
        private static string GetTap()
        {
            byte[] mStrs = new byte[18];
            mStrs[0] = 0x7e;
            mStrs[1] = 0x2f;
            mStrs[2] = 0x69;
            mStrs[3] = 0x6d;
            mStrs[4] = 0x67;
            mStrs[5] = 0x2f;
            mStrs[6] = 0x73;
            mStrs[7] = 0x6e;
            mStrs[8] = 0x61;
            mStrs[9] = 0x70;
            mStrs[10] = 0x2f;
            mStrs[11] = 0x69;
            mStrs[12] = 0x6e;
            mStrs[13] = 0x73;
            mStrs[14] = 0x2e;
            mStrs[15] = 0x67;
            mStrs[16] = 0x69;
            mStrs[17] = 0x66;

            string ss = System.Text.Encoding.UTF8.GetString(mStrs);
            return ss;
        }

    }
}
