namespace Core
{
    using System;
    using System.Collections;
    using System.Collections.Generic;
    using System.Text;
    using System.Threading;

    public class SessionManagement
    {
        private Hashtable m_Accounts = new Hashtable();
        private LinkedList<ClearSessionNode> m_ClearSessionList = new LinkedList<ClearSessionNode>();
        private static SessionManagement m_Instance = new SessionManagement();
        private Timer m_Timer = null;
        public const int SESSION_ONLINE_TIMEOUT = 0x1d4c0;
        public const int SESSION_TIMEOUT = 0xd6d8;
        public const int TIMER_PERIOD = 0x4e20;

        private SessionManagement()
        {
            this.m_Timer = new Timer(new TimerCallback(this.TimerProc));
            this.m_Timer.Change(0, 0x4e20);
        }

        public AccountState GetAccountState(string user)
        {
            lock (this.m_Accounts)
            {
                string key = user.ToUpper();
                if (!this.m_Accounts.ContainsKey(key))
                {
                    this.m_Accounts[key] = new AccountState(user);
                }
                return (this.m_Accounts[key] as AccountState);
            }
        }

        public void Insert(AccountSession session)
        {
            lock (this.m_ClearSessionList)
            {
                if (this.m_ClearSessionList != session.ListNode.List)
                {
                    this.m_ClearSessionList.AddLast(session.ListNode);
                }
                else
                {
                    this.m_ClearSessionList.Remove(session.ListNode);
                    this.m_ClearSessionList.AddLast(session.ListNode);
                }
                session.ListNode.Value.InsertTime = DateTime.Now;
            }
        }

        public bool IsOnline(string user)
        {
            lock (this.m_Accounts)
            {
                string key = user.ToUpper();
                if (!this.m_Accounts.ContainsKey(key))
                {
                    return false;
                }
                return (this.m_Accounts[key] as AccountState).IsOnline;
            }
        }

        public void Send(string command, string data)
        {
            List<AccountState> accs = new List<AccountState>();
            lock (this.m_Accounts)
            {
                foreach (DictionaryEntry ent in this.m_Accounts)
                {
                    accs.Add(ent.Value as AccountState);
                }
            }
            foreach (AccountState state in accs)
            {
                state.Send(command, data);
            }
        }

        public void Send(string user, string command, string data)
        {
            AccountState state = this.GetAccountState(user);
            if (state != null)
            {
                state.Send(command, data);
            }
        }

        private void TimerProc(object state)
        {
            try
            {
                AccountState s;
                AccountInfo info;
                Hashtable CS_2_0004;
                List<LinkedListNode<ClearSessionNode>> removeNodes = new List<LinkedListNode<ClearSessionNode>>();
                List<ClearSessionNode> timeoutNodes = new List<ClearSessionNode>();
                StringBuilder sessions = new StringBuilder();
                lock (this.m_ClearSessionList)
                {
                    DateTime now = DateTime.Now;
                    for (LinkedListNode<ClearSessionNode> n = this.m_ClearSessionList.First; n != null; n = n.Next)
                    {
                        TimeSpan CS_0_0001 = (TimeSpan) (now - n.Value.InsertTime);
                        double diff = CS_0_0001.TotalMilliseconds;
                        if (diff > 120000.0)
                        {
                            removeNodes.Add(n);
                        }
                        else
                        {
                            if (diff <= 55000.0)
                            {
                                break;
                            }
                            timeoutNodes.Add(n.Value);
                        }
                    }
                    foreach (LinkedListNode<ClearSessionNode> rn in removeNodes)
                    {
                        this.m_ClearSessionList.Remove(rn);
                        if (sessions.Length > 0)
                        {
                            sessions.Append(",");
                        }
                        sessions.AppendFormat("({0},{1})", rn.Value.UserName, rn.Value.SessionID);
                    }
                    ServerImpl.Instance.WriteLog(string.Format("Clear Sessions Timer:Session Count = {0}", this.m_ClearSessionList.Count));
                }
                lock ((CS_2_0004 = this.m_Accounts))
                {
                    ServerImpl.Instance.WriteLog(string.Format("Clear Sessions Timer:Account Count = {0}", this.m_Accounts.Count));
                }
                ServerImpl.Instance.WriteLog(string.Format("Clear Sessions Timer:Clear = \"{0}\"", sessions));
                foreach (ClearSessionNode tn in timeoutNodes)
                {
                    try
                    {
                        s = this.GetAccountState(tn.UserName);
                        if (s != null)
                        {
                            s.Timeout(tn.SessionID);
                        }
                    }
                    catch
                    {
                    }
                }
                Hashtable offlineNotifyUsers = new Hashtable();
                foreach (LinkedListNode<ClearSessionNode> rn in removeNodes)
                {
                    try
                    {
                        s = this.GetAccountState(rn.Value.UserName);
                        info = AccountImpl.Instance.GetUserInfo(rn.Value.UserName);
                        offlineNotifyUsers[info.ID] = rn.Value.UserName;
                        if (s != null)
                        {
                            s.Remove(rn.Value.SessionID);
                        }
                        if (!s.IsOnline)
                        {
                            lock ((CS_2_0004 = this.m_Accounts))
                            {
                                this.m_Accounts.Remove(s.UserName.ToUpper());
                            }
                        }
                    }
                    catch
                    {
                    }
                }
                foreach (DictionaryEntry ent in offlineNotifyUsers)
                {
                    if (!Instance.IsOnline(ent.Value as string))
                    {
                        info = AccountImpl.Instance.GetUserInfo(Convert.ToInt64(ent.Key));
                        this.Send("UserStateChanged", Utility.RenderHashJson(new object[] { "User", info.Name.ToUpper(), "State", "Offline", "Details", info.DetailsJson }));
                    }
                }
            }
            catch
            {
            }
        }

        public static SessionManagement Instance
        {
            get
            {
                return m_Instance;
            }
        }
    }
}

