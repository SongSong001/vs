namespace Core
{
    using Core.IO;
    using System;
    using System.Collections;
    using System.Collections.Generic;
    using System.IO;
    using System.Text;

    public class AccountState
    {
        private static string DefaultMsgConfig = Utility.RenderHashJson(new object[] { "LastReceivedTime", new DateTime(0x7d0, 1, 1) });
        private Hashtable m_Config = new Hashtable();
        private DateTime m_LastAccessTime = DateTime.Now;
        private Hashtable m_Sessions = new Hashtable();
        private string m_User;

        public AccountState(string user)
        {
            this.m_User = user;
            this.LoadConfig();
        }

        public Hashtable GetConfig(string type)
        {
            return (this.m_Config[type.ToUpper()] as Hashtable);
        }

        private void LoadConfig()
        {
            this.LoadConfig("message.conf", DefaultMsgConfig);
        }

        private void LoadConfig(string type, string def)
        {
            Hashtable config;
            try
            {
                using (Stream stream = Core.IO.File.Open(string.Format("/{0}/Config/{1}", this.m_User, type), FileMode.OpenOrCreate, FileAccess.Read, FileShare.Read))
                {
                    byte[] buffer = new byte[stream.Length];
                    stream.Read(buffer, 0, buffer.Length);
                    string content = Encoding.UTF8.GetString(buffer);
                    if (string.IsNullOrEmpty(content))
                    {
                        content = def;
                    }
                    config = Utility.ParseJson(content) as Hashtable;
                    this.m_Config[type.ToUpper()] = config;
                }
            }
            catch
            {
                config = Utility.ParseJson(def) as Hashtable;
                this.m_Config[type.ToUpper()] = config;
            }
        }

        public void NewSession(string sessionId)
        {
            AccountSession session = null;
            lock (this)
            {
                if (!this.m_Sessions.ContainsKey(sessionId))
                {
                    this.m_Sessions[sessionId] = session = new AccountSession(this.m_User, sessionId);
                }
                session = this.m_Sessions[sessionId] as AccountSession;
                ServerImpl.Instance.WriteLog(string.Format("New Session:SessionID = \"{0}\", UserName='{1}'", sessionId, this.m_User));
            }
            if (session != null)
            {
                this.SendUnreadMessage(session);
                SessionManagement.Instance.Insert(session);
            }
            AccountInfo info = AccountImpl.Instance.GetUserInfo(this.UserName);
            SessionManagement.Instance.Send("UserStateChanged", Utility.RenderHashJson(new object[] { "User", info.Name.ToUpper(), "State", "Online", "Details", info.DetailsJson }));
        }

        public bool Receive(string sessionId, ResponsesListener listener)
        {
            AccountSession session = null;
            bool reset = false;
            lock (this)
            {
                if (!this.m_Sessions.ContainsKey(sessionId))
                {
                    this.m_Sessions[sessionId] = new AccountSession(this.m_User, sessionId);
                    reset = true;
                }
                this.m_LastAccessTime = DateTime.Now;
                session = this.m_Sessions[sessionId] as AccountSession;
            }
            if (reset)
            {
                ServerImpl.Instance.WriteLog(string.Format("Reset Session:SessionID = \"{0}\", UserName='{1}'", sessionId, this.m_User));
                session.Send("GLOBAL:SessionReset", "null");
            }
            if (session != null)
            {
                SessionManagement.Instance.Insert(session);
            }
            return session.Receive(listener);
        }

        public void Remove(string sessionId)
        {
            lock (this)
            {
                (this.m_Sessions[sessionId] as AccountSession).SendCache();
                this.m_Sessions.Remove(sessionId);
                if (this.m_Sessions.Count == 0)
                {
                    this.SaveConfig();
                }
            }
        }

        private void SaveConfig()
        {
            Hashtable config = this.GetConfig("message.conf");
            lock (config)
            {
                DateTime lrt = (DateTime) config["LastReceivedTime"];
                if (lrt > this.m_LastAccessTime)
                {
                    config["LastReceivedTime"] = this.m_LastAccessTime;
                }
            }
            this.SaveConfig("message.conf");
        }

        private void SaveConfig(string type)
        {
            try
            {
                using (Stream stream = Core.IO.File.Open(string.Format("/{0}/Config/{1}", this.m_User, type), FileMode.Create, FileAccess.Write, FileShare.None))
                {
                    Hashtable config = this.m_Config[type.ToUpper()] as Hashtable;
                    byte[] buffer = Encoding.UTF8.GetBytes(Utility.RenderJson(config));
                    stream.Write(buffer, 0, buffer.Length);
                }
            }
            catch
            {
            }
        }

        public void Send(string commandId, string data)
        {
            List<string> ol = new List<string>();
            lock (this)
            {
                foreach (DictionaryEntry ent in this.m_Sessions)
                {
                    (ent.Value as AccountSession).Send(commandId, data);
                }
            }
        }

        private void SendUnreadMessage(AccountSession session)
        {
            DateTime from;
            AccountState CS_2_0000;
            lock ((CS_2_0000 = this))
            {
                from = (DateTime) this.GetConfig("MESSAGE.CONF")["LastReceivedTime"];
                if (from > this.m_LastAccessTime)
                {
                    from = this.m_LastAccessTime;
                }
            }
            List<Message> msgs = MessageImpl.Instance.Find(this.m_User, "*", new DateTime?(from));
            string data = string.Empty;
            if (msgs.Count > 0)
            {
                data = Utility.RenderHashJson(new object[] { "Peer", "*", "Messages", msgs });
                Hashtable config = this.GetConfig("MESSAGE.CONF");
                lock (config)
                {
                    foreach (Message message in msgs)
                    {
                        DateTime lrt = (DateTime) config["LastReceivedTime"];
                        if (lrt < message.CreatedTime)
                        {
                            config["LastReceivedTime"] = message.CreatedTime;
                        }
                    }
                }
                lock ((CS_2_0000 = this))
                {
                    this.SaveConfig();
                }
            }
            else
            {
                data = Utility.RenderHashJson(new object[] { "Peer", "*", "Messages", JsonText.EmptyArray });
            }
            session.Send("GLOBAL:IM_MESSAGE_NOTIFY", data);
        }

        public void Timeout(string sessionId)
        {
            lock (this)
            {
                (this.m_Sessions[sessionId] as AccountSession).SendCache();
            }
        }

        public bool IsOnline
        {
            get
            {
                return (this.m_Sessions.Count > 0);
            }
        }

        public DateTime LastAccessTime
        {
            get
            {
                return this.m_LastAccessTime;
            }
        }

        public DateTime LastReceivedTime
        {
            get
            {
                DateTime from = (DateTime) (this.m_Config["MESSAGE.CONF"] as Hashtable)["LastReceivedTime"];
                if (from > this.m_LastAccessTime)
                {
                    from = this.m_LastAccessTime;
                }
                return from;
            }
        }

        public string UserName
        {
            get
            {
                return this.m_User;
            }
        }
    }
}

