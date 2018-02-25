namespace Core
{
    using System;
    using System.Collections;
    using System.Collections.Generic;

    public class MessageCacheManagement
    {
        private Hashtable m_Cache = new Hashtable();
        private int m_Count = 0;
        private static MessageCacheManagement m_Instance = new MessageCacheManagement();

        private MessageCacheManagement()
        {
        }

        public void Clear()
        {
            lock (this.m_Cache)
            {
                List<Message> msgs = new List<Message>();
                foreach (DictionaryEntry ent in this.m_Cache)
                {
                    (ent.Value as List<Message>).Clear();
                }
                this.m_Count = 0;
            }
        }

        public List<Message> Find(string user, string sender, DateTime from)
        {
            int i;
            Hashtable CS_2_0001;
            List<Message> CS_2_0002;
            List<Message> msgs = new List<Message>();
            List<Message> userMsgs = null;
            lock ((CS_2_0001 = this.m_Cache))
            {
                userMsgs = this.GetUserMessageCache(user);
            }
            lock ((CS_2_0002 = userMsgs))
            {
                i = 0;
                while ((i < userMsgs.Count) && (userMsgs[i].CreatedTime <= from))
                {
                    i++;
                }
                while (i < userMsgs.Count)
                {
                    if (((sender == null) || (sender == "*")) || (sender == userMsgs[i].Sender.Name))
                    {
                        msgs.Add(userMsgs[i]);
                    }
                    i++;
                }
            }
            if ((sender == null) || (sender == "*"))
            {
                AccountInfo userInfo = AccountImpl.Instance.GetUserInfo(user);
                foreach (string groupName in userInfo.Groups)
                {
                    AccountInfo groupInfo = AccountImpl.Instance.GetUserInfo(groupName);
                    List<Message> groupMsgs = null;
                    lock ((CS_2_0001 = this.m_Cache))
                    {
                        groupMsgs = this.GetUserMessageCache(groupName);
                    }
                    lock ((CS_2_0002 = groupMsgs))
                    {
                        if (from < groupInfo.GetGroupMemberRenewTime(user))
                        {
                            from = groupInfo.GetGroupMemberRenewTime(user);
                        }
                        i = 0;
                        while ((i < groupMsgs.Count) && (groupMsgs[i].CreatedTime <= from))
                        {
                            i++;
                        }
                        while (i < groupMsgs.Count)
                        {
                            msgs.Add(groupMsgs[i]);
                            i++;
                        }
                    }
                }
            }
            return msgs;
        }

        public List<Message> GetAll()
        {
            lock (this.m_Cache)
            {
                List<Message> msgs = new List<Message>();
                foreach (DictionaryEntry ent in this.m_Cache)
                {
                    foreach (Message msg in ent.Value as List<Message>)
                    {
                        msgs.Add(msg);
                    }
                }
                return msgs;
            }
        }

        public DateTime? GetMinCreatedTime(string user)
        {
            lock (this.m_Cache)
            {
                List<Message> userMsgs = this.GetUserMessageCache(user);
                return ((userMsgs.Count == 0) ? null : new DateTime?(userMsgs[0].CreatedTime));
            }
        }

        private List<Message> GetUserMessageCache(string user)
        {
            if (!this.m_Cache.ContainsKey(user))
            {
                this.m_Cache.Add(user, new List<Message>());
            }
            return (this.m_Cache[user] as List<Message>);
        }

        public void Insert(string user, Message msg)
        {
            List<Message> userMsgs = null;
            lock (this.m_Cache)
            {
                userMsgs = this.GetUserMessageCache(user);
            }
            lock (userMsgs)
            {
                userMsgs.Add(msg);
                this.m_Count++;
            }
        }

        public int Count
        {
            get
            {
                return this.m_Count;
            }
        }

        public static MessageCacheManagement Instance
        {
            get
            {
                return m_Instance;
            }
        }
    }
}

