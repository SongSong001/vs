namespace Core
{
    using System;
    using System.Collections;
    using System.Collections.Generic;
    using System.Reflection;
    using System.Text.RegularExpressions;
    using System.Threading;
    using System.Web;

    public class MessageImpl
    {
        private IMessageStorage m_IMessageStorage = null;
        private static MessageImpl m_Instance = new MessageImpl();
        private object m_Lock = new object();
        private DateTime m_MaxCreatedTime = DateTime.Now;
        private long m_MaxKey = 1;
        private Timer m_Timer = null;

        //缓存数
#		if DEBUG
        const Int32 MAX_CACHE_COUNT = 4;
#		else
		const Int32 MAX_CACHE_COUNT = 1024;
#		endif

        static MessageImpl()
        {
            Instance.Initialize(HttpContext.Current);
        }

        private MessageImpl()
        {
            this.m_Timer = new Timer(new TimerCallback(this.TimerProc));
            this.m_Timer.Change(0, 0x1d4c0);
        }

        public void Dispose()
        {
        }

        public List<Message> Find(string receiver, string sender, DateTime? from)
        {
            lock (this.m_Lock)
            {
                DateTime? min = MessageCacheManagement.Instance.GetMinCreatedTime(receiver);
                List<Message> messages = new List<Message>();
                if ((!min.HasValue || !from.HasValue) || (from.Value < min.Value))
                {
                    messages.AddRange(this.FindInDatabase(receiver, sender, from));
                    if (AccountImpl.Instance.GetUserInfo(receiver).Type == 0)
                    {
                        messages.AddRange(this.FindInDatabase(sender, receiver, from));
                    }
                }
                messages.AddRange(MessageCacheManagement.Instance.Find(receiver, sender, from.Value));
                if (AccountImpl.Instance.GetUserInfo(receiver).Type == 0)
                {
                    messages.AddRange(MessageCacheManagement.Instance.Find(sender, receiver, from.Value));
                }
                return messages;
            }
        }

        public List<Message> FindHistory(string receiver, string sender, DateTime from, DateTime to)
        {
            return this.m_IMessageStorage.FindHistory(AccountImpl.Instance.GetUserInfo(receiver).ID, AccountImpl.Instance.GetUserInfo(sender).ID, from, to);
        }

        public List<Message> FindHistory(string peerType, string content, DateTime from, DateTime to, string user)
        {
            return this.m_IMessageStorage.FindHistory(peerType, content, from, to, user);
        }

        public List<Message> FindInDatabase(string receiver, string sender, DateTime? from)
        {
            lock (this.m_Lock)
            {
                return this.m_IMessageStorage.Find((receiver == "*") ? 0 : AccountImpl.Instance.GetUserInfo(receiver).ID, (sender == "*") ? 0 : AccountImpl.Instance.GetUserInfo(sender).ID, from);
            }
        }

        public void Initialize(HttpContext context)
        {
            lock (this.m_Lock)
            {
                string[] accStorageInfo = Utility.GetConfig().AppSettings.Settings["MessageStorageImpl"].Value.Split(new char[] { ' ' });
                ConstructorInfo ctor = Assembly.Load(accStorageInfo[0]).GetType(accStorageInfo[1]).GetConstructor(new Type[0]);
                this.m_IMessageStorage = ctor.Invoke(new object[0]) as IMessageStorage;
                this.m_MaxKey = this.m_IMessageStorage.GetMaxKey();
                this.m_MaxCreatedTime = this.m_IMessageStorage.GetCreatedTime();
            }
        }

        public Message NewMessage(string receiver, string sender, string content, Hashtable data)
        {
            lock (this.m_Lock)
            {
                Hashtable config;
                DateTime lrt;
                string cmdData;
                Hashtable CS_2_0005;
                long key = ++this.m_MaxKey;
                content = HtmlUtil.ReplaceHtml(content);
                MsgAccessoryEval eval = new MsgAccessoryEval(key, receiver, sender, data);
                content = new Regex("{Accessory [^\f\n\r\t\v<>]+}").Replace(content, new MatchEvaluator(eval.Replace));
                Message message = new Message(AccountImpl.Instance.GetUserInfo(sender), AccountImpl.Instance.GetUserInfo(receiver), content, new DateTime((DateTime.Now.Ticks / 0x2710) * 0x2710), key);
                new List<Message>().Add(message);
                if (AccountImpl.Instance.GetUserInfo(receiver).Type == 0)
                {
                    if (SessionManagement.Instance.IsOnline(receiver))
                    {
                        try
                        {
                            config = SessionManagement.Instance.GetAccountState(receiver).GetConfig("message.conf");
                            lock ((CS_2_0005 = config))
                            {
                                lrt = (DateTime) config["LastReceivedTime"];
                                config["LastReceivedTime"] = message.CreatedTime;
                            }
                            cmdData = Utility.RenderHashJson(new object[] { "Peer", sender, "Message", message });
                            SessionManagement.Instance.Send(receiver, "GLOBAL:IM_MESSAGE_NOTIFY", cmdData);
                        }
                        catch
                        {
                        }
                    }
                }
                else
                {
                    AccountInfo groupInfo = AccountImpl.Instance.GetUserInfo(receiver);
                    AccountInfo senderInfo = AccountImpl.Instance.GetUserInfo(sender);
                    foreach (string member in groupInfo.Friends)
                    {
                        try
                        {
                            AccountInfo memberInfo = AccountImpl.Instance.GetUserInfo(member);
                            if (((senderInfo.Name.ToLower() == "administrator") || (memberInfo.ID != senderInfo.ID)) && SessionManagement.Instance.IsOnline(member))
                            {
                                config = SessionManagement.Instance.GetAccountState(memberInfo.Name).GetConfig("message.conf");
                                lock ((CS_2_0005 = config))
                                {
                                    lrt = (DateTime) config["LastReceivedTime"];
                                    config["LastReceivedTime"] = message.CreatedTime;
                                }
                                cmdData = Utility.RenderHashJson(new object[] { "Peer", groupInfo.Name, "Message", message });
                                SessionManagement.Instance.Send(member, "GLOBAL:IM_MESSAGE_NOTIFY", cmdData);
                            }
                        }
                        catch
                        {
                        }
                    }
                }
                MessageCacheManagement.Instance.Insert(receiver, message);
                if (MessageCacheManagement.Instance.Count >= 4)
                {
                    this.WriteCache();
                }
                return message;
            }
        }

        private void TimerProc(object state)
        {
            this.WriteCache();
        }

        public void WriteCache()
        {
            if (MessageCacheManagement.Instance.Count > 0)
            {
                List<Message> cacheMsgs = MessageCacheManagement.Instance.GetAll();
                this.m_IMessageStorage.Write(cacheMsgs);
                MessageCacheManagement.Instance.Clear();
            }
        }

        public static MessageImpl Instance
        {
            get
            {
                return m_Instance;
            }
        }
    }
}

