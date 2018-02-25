namespace Core.Web
{
    using Core;
    using Core.IO;
    using Core.Text;
    using Microsoft.JScript;
    using System;
    using System.Collections;
    using System.Collections.Generic;
    using System.IO;
    using System.Text;
    using System.Text.RegularExpressions;
    using System.Web;

    public class DownloadMsg : IHttpHandler, IComparer<Message>
    {
        private HttpContext _context;
        private string _path;
        private static string FileHtmlFormat = "<div class='div_filename'>文件名:{0}</div><div class='operationContainer'><div class='link_download'><a target='_blank' href='{2}?FileName={1}'>下载</a></div></div>";
        private static DateTime m_TempFileLWT;
        private static TextTemplate m_Template = null;
        private static object m_TempLock = new object();
        private static string MessageHtmlFormat = "<div class='message' style='background-color:{3}'><div class='messageTitle'><span class='sender'>{0}</span><span class='time'>{1:yyyy-MM-dd HH:mm:ss}</span></div><div class='messageContent'>{2}</div></div><br/>";
        private static Regex Regex_A = new Regex(@"(\x5B\/A\x5D|\x5BA\x3A([^\f\n\r\t\v\x5B\x5D]+)\x5D)", RegexOptions.IgnoreCase);
        private static Regex Regex_Download = new Regex(@"(<[^<>]+)src=(\x22|\x27)([^\f\n\r\t\v<>\x22\x27]+/|)download.aspx\x3FFileName=([^\f\n\r\t\v<>\x22\x27]+)(\x22|\x27)([^<>]*>)", RegexOptions.IgnoreCase);
        private static Regex Regex_File = new Regex(@"\x5BFILE\x3A([^\f\n\r\t\v\x5B\x5D]+)\x5D", RegexOptions.IgnoreCase);

        private string ReplaceA(Match m)
        {
            if (m.Value == "[/A]")
            {
                return "</a>";
            }
            return string.Format("<a target='_black' href='{0}'>", GlobalObject.unescape(m.Groups[2].Value));
        }

        private string ReplaceDownload(Match m)
        {
            return string.Format("{2}src=\"{0}?FileName={1}\"{3}", new object[] { this._path, m.Groups[4].Value.StartsWith("/") ? m.Groups[4].Value : string.Format("/{0}/{1}", ServerImpl.Instance.GetUserName(this._context), m.Groups[4].Value), m.Groups[1].Value, m.Groups[6].Value });
        }

        private string ReplaceFile(Match m)
        {
            return string.Format(FileHtmlFormat, GlobalObject.unescape(Core.IO.Path.GetFileName(m.Groups[1].Value)), m.Groups[1].Value.StartsWith("/") ? m.Groups[1].Value : string.Format("/{0}/{1}", ServerImpl.Instance.GetUserName(this._context), m.Groups[1].Value), this._path);
        }

        int IComparer<Message>.Compare(Message m1, Message m2)
        {
            if (m1.CreatedTime > m2.CreatedTime)
            {
                return 1;
            }
            if (m1.CreatedTime < m2.CreatedTime)
            {
                return -1;
            }
            return 0;
        }

        void IHttpHandler.ProcessRequest(HttpContext context)
        {
            lock (m_TempLock)
            {
                Core.IO.FileInfo fi = new Core.IO.FileInfo("/administrator/Public/Data/history.htm");
                if ((m_Template == null) || (m_TempFileLWT < fi.LastWriteTime))
                {
                    using (Stream stream = Core.IO.File.Open("/administrator/Public/Data/history.htm", FileMode.OpenOrCreate, FileAccess.Read, FileShare.None))
                    {
                        byte[] buffer = new byte[stream.Length];
                        stream.Read(buffer, 0, buffer.Length);
                        m_Template = new TextTemplate(Encoding.UTF8.GetString(buffer));
                    }
                    m_TempFileLWT = fi.LastWriteTime;
                }
            }
            this._context = context;
            this._path = string.Format("http://{0}{1}{2}/download.aspx", this._context.Request.Url.Host, (this._context.Request.Url.Port == 80) ? "" : (":" + this._context.Request.Url.Port.ToString()), ServerImpl.Instance.ServiceUrl);
            AccountInfo cu = AccountImpl.Instance.GetUserInfo(ServerImpl.Instance.GetUserName(context));
            AccountInfo peer = AccountImpl.Instance.GetUserInfo((long) System.Convert.ToInt32(context.Request.QueryString["Peer"]));
            context.Response.ContentType = "application/octet-stream";
            context.Response.AppendHeader("Content-Disposition", "attachment;filename=history.htm");
            List<Message> messages = MessageImpl.Instance.FindHistory(cu.Name, peer.Name, new DateTime(0x7d0, 1, 1), new DateTime(0x834, 1, 1));
            messages.Sort(this);
            StringBuilder msg_content = new StringBuilder();
            int count = 0;
            foreach (Message msg in messages)
            {
                string content = Regex_Download.Replace(msg.Content, new MatchEvaluator(this.ReplaceDownload));
                content = Regex_File.Replace(content, new MatchEvaluator(this.ReplaceFile));
                content = Regex_A.Replace(content, new MatchEvaluator(this.ReplaceA));
                msg_content.AppendFormat(MessageHtmlFormat, new object[] { msg.Sender.Nickname, msg.CreatedTime, content, ((count % 2) != 0) ? "#FFFFFF" : "#F8FCFF" });
                count++;
            }
            Hashtable values = new Hashtable();
            values["SENDER"] = cu.Nickname;
            values["RECEIVER"] = peer.Nickname;
            values["MESSAGES"] = msg_content.ToString();
            context.Response.Write(m_Template.Render(values));
        }

        bool IHttpHandler.IsReusable
        {
            get
            {
                return true;
            }
        }
    }
}

