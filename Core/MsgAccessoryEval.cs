namespace Core
{
    using Core.IO;
    using Microsoft.JScript;
    using System;
    using System.Collections;
    using System.IO;
    using System.Text.RegularExpressions;
    using System.Web;
    using System.Xml;

    internal class MsgAccessoryEval
    {
        private Hashtable m_Data;
        private string m_MsgDir;
        private string m_Receiver;
        private string m_ReceiverMsgDir;
        private string m_Sender;
        private string m_SenderMsgDir;

        public MsgAccessoryEval(long key, string receiver, string sender, Hashtable data)
        {
            this.m_Receiver = receiver;
            this.m_Sender = sender;
            this.m_Data = data;
            this.m_ReceiverMsgDir = string.Format("/{0}/Message/MSG{1:00000000}", receiver, key);
            this.m_SenderMsgDir = string.Format("/{0}/Message/MSG{1:00000000}", sender, key);
            this.m_MsgDir = (AccountImpl.Instance.GetUserInfo(receiver).Type > 0) ? string.Format("/{1}/Message/MSG{0:00000000}", key, receiver) : string.Format("Message/MSG{0:00000000}", key);
        }

        public string Replace(Match match)
        {
            string fileName;
            XmlDocument xml = new XmlDocument();
            string value = match.Value;
            xml.LoadXml(string.Format("<{0} />", value.Substring(1, value.Length - 2)));
            string src = GlobalObject.unescape(xml.DocumentElement.GetAttribute("src"));
            string type = xml.DocumentElement.GetAttribute("type").ToLower();
            string data = xml.DocumentElement.GetAttribute("data");
            if (ServerImpl.Instance.IsPublic(src))
            {
                return string.Format("{0}", Core.IO.Path.GetRelativePath(src));
            }
            if (!Core.IO.Directory.Exists(this.m_ReceiverMsgDir))
            {
                Core.IO.Directory.CreateDirectory(this.m_ReceiverMsgDir);
            }
            if ((AccountImpl.Instance.GetUserInfo(this.m_Receiver).Type == 0) && !Core.IO.Directory.Exists(this.m_SenderMsgDir))
            {
                Core.IO.Directory.CreateDirectory(this.m_SenderMsgDir);
            }
            if (string.IsNullOrEmpty(Core.IO.Path.GetUser(src)))
            {
                string fileOwnerName = this.m_Sender;
                src = string.Format("/{0}/{1}", fileOwnerName, src);
            }
            bool allowRead = true;
            try
            {
                ServerImpl.Instance.CheckPermission(HttpContext.Current, src, 4);
            }
            catch
            {
                allowRead = false;
            }
            if ((data == "") && !allowRead)
            {
                return src;
            }
            Hashtable _files = new Hashtable();
            if (!_files.ContainsKey(src))
            {
                fileName = Core.IO.Path.GetFileName(src);
                for (int i = 1; _files.ContainsValue(fileName); i++)
                {
                    fileName = string.Format("{0}({1}){2}", System.IO.Path.GetFileNameWithoutExtension(fileName), i.ToString(), System.IO.Path.GetExtension(fileName));
                }
                _files.Add(src, fileName);
                try
                {
                    string dataBase64;
                    byte[] buffer;
                    Stream stream;
                    if (AccountImpl.Instance.GetUserInfo(this.m_Receiver).Type == 0)
                    {
                        if (data == "")
                        {
                            Core.IO.File.Copy(src, this.m_SenderMsgDir + "/" + fileName);
                        }
                        else
                        {
                            dataBase64 = this.m_Data[data] as string;
                            buffer = System.Convert.FromBase64String(dataBase64);
                            using (stream = Core.IO.File.Open(this.m_SenderMsgDir + "/" + fileName, FileMode.Create, FileAccess.Write, FileShare.None))
                            {
                                try
                                {
                                    stream.Write(buffer, 0, buffer.Length);
                                }
                                finally
                                {
                                    stream.Close();
                                }
                            }
                        }
                    }
                    if (data == "")
                    {
                        Core.IO.File.Copy(src, this.m_ReceiverMsgDir + "/" + fileName);
                    }
                    else
                    {
                        dataBase64 = this.m_Data[data] as string;
                        buffer = System.Convert.FromBase64String(dataBase64);
                        using (stream = Core.IO.File.Open(this.m_ReceiverMsgDir + "/" + fileName, FileMode.Create, FileAccess.Write, FileShare.None))
                        {
                            try
                            {
                                stream.Write(buffer, 0, buffer.Length);
                            }
                            finally
                            {
                                stream.Close();
                            }
                        }
                    }
                }
                catch
                {
                }
            }
            else
            {
                fileName = _files[src] as string;
            }
            return GlobalObject.escape(string.Format("{0}/{1}", this.m_MsgDir, fileName));
        }
    }
}

