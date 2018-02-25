namespace Core
{
    using Core.IO;
    using System;
    using System.Collections;
    using System.Collections.Generic;
    using System.Data;
    using System.Reflection;

    public class AccountImpl
    {
        private IAccountStorage m_IAccountStorage = null;
        private static AccountImpl m_Instance = new AccountImpl();
        private LinkedList<AccountInfo> m_List = new LinkedList<AccountInfo>();
        private object m_Lock = new object();
        private Hashtable m_UserInfoCache = new Hashtable();
        private Hashtable m_UserInfoCacheByID = new Hashtable();

        // 缓存中的用户信息的数量
#		if DEBUG
        const int MAX_CACHE_COUNT = 2;
#		else
		const int MAX_CACHE_COUNT = 2000;
#		endif

        private AccountImpl()
        {
            this.Init();
        }

        public void AddFriend(string user, string friend)
        {
            lock (this.m_Lock)
            {
                AccountInfo userInfo = Instance.GetUserInfo(user);
                AccountInfo friendInfo = Instance.GetUserInfo(friend);
                if (!((string.Compare(user, friend, true) == 0) || userInfo.ContainsFriend(friend)))
                {
                    this.m_IAccountStorage.AddFriend(user, friend);
                    this.RefreshUserInfo(user);
                    this.RefreshUserInfo(friend);
                }
            }
        }

        public void AddFriend(string user, string friend, int index)
        {
            lock (this.m_Lock)
            {
                if (this.m_IAccountStorage.GetRelationship(user, friend) == -1)
                {
                    this.AddFriend(user, friend);
                }
            }
        }

        public void AddUser(string name, string nickname, string password, string email, string phone, string telphone)
        {
            lock (this.m_Lock)
            {
                this.m_IAccountStorage.AddUser(name, nickname, password, email, phone, telphone);
                //this.RefreshUserInfo("public");
                this.RefreshUserInfo("manager");
            }
        }

        public void CreateGroup(string creator, string name, string nickname, long isExitGroup)
        {
            lock (this.m_Lock)
            {
                this.m_IAccountStorage.CreateGroup(creator, name, nickname, isExitGroup);
                this.RefreshUserInfo(creator);
            }
        }

        public void CreateTempGroup(string creator, string name, string nickname, string deptId, string userlist)
        {
            lock (this.m_Lock)
            {
                this.m_IAccountStorage.CreateTempGroup(creator, name, nickname, deptId, userlist);
                this.RefreshUserInfo(creator);
                if (userlist != "")
                {
                    foreach (string user in userlist.Split(new char[] { ',' }))
                    {
                        this.RefreshUserInfo(user);
                    }
                }
            }
        }

        public void CreateUser(string name, string nickname, string password, string email)
        {
            lock (this.m_Lock)
            {
                this.m_IAccountStorage.CreateUser(name, nickname, password, email);
                //this.RefreshUserInfo("public");
                this.RefreshUserInfo("manager");
            }
        }

        public void DeleteFriend(string user, string friend)
        {
            lock (this.m_Lock)
            {
                if (this.m_IAccountStorage.GetRelationship(user, friend) != -1)
                {
                    AccountInfo userInfo = this.GetUserInfo(user);
                    AccountInfo friendInfo = this.GetUserInfo(friend);
                    this.m_IAccountStorage.DeleteFriend(userInfo.ID, friendInfo.ID);
                    this.RefreshUserInfo(user);
                    this.RefreshUserInfo(friend);
                }
            }
        }

        public void DeleteGroup(string name, string creator)
        {
            AccountInfo info = this.GetUserInfo(name);
            List<string> members = new List<string>();
            foreach (string s in info.Friends)
            {
                members.Add(s);
            }
            lock (this.m_Lock)
            {
                this.m_IAccountStorage.DeleteGroup(info.ID);
                foreach (string member in members)
                {
                    this.RefreshUserInfo(member);
                }
            }
        }

        public void DeleteUser(string name)
        {
            AccountInfo info = this.GetUserInfo(name);
            long id = info.ID;
            List<string> friends = new List<string>();
            foreach (string s in info.Friends)
            {
                friends.Add(s);
            }
            this.m_IAccountStorage.DeleteUser(info.ID);
            try
            {
                Directory.Delete(string.Format("/{0}", name));
            }
            catch
            {
            }
            foreach (string friend in friends)
            {
                this.RefreshUserInfo(friend);
            }
        }

        public DataRowCollection GetAllGroups()
        {
            return this.m_IAccountStorage.GetAllGroups();
        }

        public DataRowCollection GetAllUsers()
        {
            return this.m_IAccountStorage.GetAllUsers();
        }

        public string GetAllUsersByName(string filter)
        {
            DataTable dt = this.m_IAccountStorage.GetAllUserByName(filter.Trim());
            if (dt.Rows.Count > 0)
            {
                return Utility.DataTableToJSON(dt, "Users");
            }
            return Utility.RenderHashJson(new object[] { "Users", "" });
        }

        private string[] GetGroupManagers(string name)
        {
            return this.m_IAccountStorage.GetGroupManagers(name);
        }

        public string GetGroupTempNameByDeptId(string deptId)
        {
            return this.m_IAccountStorage.GetGroupTempNameByDeptId(deptId);
        }

        public List<string> GetIMWindowRoles(string name)
        {
            return this.m_IAccountStorage.GetIMWindowRoles(name);
        }

        public AccountInfo GetUserInfo(long userId)
        {
            lock (this.m_Lock)
            {
                AccountInfo ai = null;
                try
                {
                    if (this.m_UserInfoCacheByID.ContainsKey(userId))
                    {
                        ai = this.m_UserInfoCacheByID[userId] as AccountInfo;
                        this.m_List.Remove(ai.ListNode);
                        this.m_List.AddLast(ai.ListNode);
                    }
                    else
                    {
                        ai = this.RefreshUserInfo(userId);
                    }
                }
                catch
                {
                }
                return ai;
            }
        }

        public AccountInfo GetUserInfo(string user)
        {
            if (string.IsNullOrEmpty(user))
            {
                return null;
            }
            lock (this.m_Lock)
            {
                string key = user.ToUpper();
                AccountInfo ai = null;
                try
                {
                    if (this.m_UserInfoCache.ContainsKey(key))
                    {
                        ai = this.m_UserInfoCache[key] as AccountInfo;
                        this.m_List.Remove(ai.ListNode);
                        this.m_List.AddLast(ai.ListNode);
                    }
                    else
                    {
                        ai = this.RefreshUserInfo(user);
                    }
                }
                catch
                {
                }
                return ai;
            }
        }

        public void Init()
        {
            string[] accStorageInfo = Utility.GetConfig().AppSettings.Settings["AccountStorageImpl"].Value.Split(new char[] { ' ' });
            ConstructorInfo ctor = Assembly.Load(accStorageInfo[0]).GetType(accStorageInfo[1]).GetConstructor(new Type[0]);
            this.m_IAccountStorage = ctor.Invoke(new object[0]) as IAccountStorage;
        }

        private AccountInfo RefreshUserInfo(long id)
        {
            DataRow userInfo = this.m_IAccountStorage.GetAccountInfo(id);
            if (userInfo != null)
            {
                AccountInfo info;
                string userName = userInfo["Name"] as string;
                List<FriendInfo> friends = new List<FriendInfo>();
                List<FriendInfo> managers = new List<FriendInfo>();
                FriendInfo creator = null;
                foreach (DataRow row in this.m_IAccountStorage.GetFriends(userName))
                {
                    string name = row["Name"] as string;
                    DateTime renewTime = (DateTime) row["RenewTime"];
                    FriendInfo fi = new FriendInfo(name, renewTime, Convert.ToInt64(row["Relationship"]), Convert.ToInt64(row["Type"]));
                    friends.Add(fi);
                    long CS_4_0003 = Convert.ToInt64(row["Relationship"]);
                    if ((CS_4_0003 <= 3) && (CS_4_0003 >= 2))
                    {
                        switch (((int) CS_4_0003))
                        {
                            case 2:
                                managers.Add(fi);
                                break;

                            case 3:
                                managers.Add(fi);
                                creator = fi;
                                break;
                        }
                    }
                }
                if (this.m_UserInfoCache.ContainsKey(userName.ToUpper()))
                {
                    info = this.m_UserInfoCache[userName.ToUpper()] as AccountInfo;
                    info.Reset(userInfo["Name"] as string, userInfo["NickName"] as string, Convert.ToInt64(userInfo["Key"]), Convert.ToInt64(userInfo["Type"]), this.m_IAccountStorage.GetUserRoles(userName), friends.ToArray(), (Convert.ToInt64(userInfo["Type"]) == 1) ? managers.ToArray() : null, creator, userInfo["EMail"] as string, userInfo["InviteCode"] as string, Convert.ToInt64(userInfo["AcceptStrangerIM"]) != 0, Convert.ToInt64(userInfo["MsgFileLimit"]), Convert.ToInt64(userInfo["MsgImageLimit"]), Convert.ToInt64(userInfo["DiskSize"]), Convert.ToInt64(userInfo["IsTemp"]), (DateTime) userInfo["RegisterTime"], userInfo["HomePage"] as string, userInfo["Password"] as string, userInfo);
                    return info;
                }
                info = new AccountInfo(userInfo["Name"] as string, userInfo["NickName"] as string, Convert.ToInt64(userInfo["Key"]), Convert.ToInt64(userInfo["Type"]), this.m_IAccountStorage.GetUserRoles(userName), friends.ToArray(), (Convert.ToInt64(userInfo["Type"]) == 1) ? managers.ToArray() : null, creator, userInfo["EMail"] as string, userInfo["InviteCode"] as string, Convert.ToInt64(userInfo["AcceptStrangerIM"]) != 0, Convert.ToInt64(userInfo["MsgFileLimit"]), Convert.ToInt64(userInfo["MsgImageLimit"]), Convert.ToInt64(userInfo["DiskSize"]), Convert.ToInt64(userInfo["IsTemp"]), (DateTime) userInfo["RegisterTime"], userInfo["HomePage"] as string, userInfo["Password"] as string, userInfo);
                if (this.m_List.Count >= 2)
                {
                    AccountInfo removeInfo = this.m_List.First.Value;
                    this.m_UserInfoCache.Remove(removeInfo.Name.ToUpper());
                    this.m_UserInfoCacheByID.Remove(removeInfo.ID);
                    this.m_List.RemoveFirst();
                }
                this.m_UserInfoCache[userName.ToUpper()] = info;
                this.m_UserInfoCacheByID[info.ID] = info;
                this.m_List.AddLast(info.ListNode);
                return info;
            }
            return null;
        }

        private AccountInfo RefreshUserInfo(string userName)
        {
            string key = userName.ToUpper();
            DataRow userInfo = this.m_IAccountStorage.GetAccountInfo(userName);
            if (userInfo != null)
            {
                AccountInfo info;
                List<FriendInfo> friends = new List<FriendInfo>();
                List<FriendInfo> managers = new List<FriendInfo>();
                FriendInfo creator = null;
                foreach (DataRow row in this.m_IAccountStorage.GetFriends(userName))
                {
                    string name = row["Name"] as string;
                    DateTime renewTime = (DateTime) row["RenewTime"];
                    FriendInfo fi = new FriendInfo(name, renewTime, Convert.ToInt64(row["Relationship"]), Convert.ToInt64(row["Type"]));
                    friends.Add(fi);
                    long CS_4_0003 = Convert.ToInt64(row["Relationship"]);
                    if ((CS_4_0003 <= 3) && (CS_4_0003 >= 2))
                    {
                        switch (((int) CS_4_0003))
                        {
                            case 2:
                                managers.Add(fi);
                                break;

                            case 3:
                                managers.Add(fi);
                                creator = fi;
                                break;
                        }
                    }
                }
                if (this.m_UserInfoCache.ContainsKey(key))
                {
                    info = this.m_UserInfoCache[key] as AccountInfo;
                    info.Reset(userInfo["Name"] as string, userInfo["NickName"] as string, Convert.ToInt64(userInfo["Key"]), Convert.ToInt64(userInfo["Type"]), this.m_IAccountStorage.GetUserRoles(userName), friends.ToArray(), (Convert.ToInt64(userInfo["Type"]) == 1) ? managers.ToArray() : null, creator, userInfo["EMail"] as string, userInfo["InviteCode"] as string, Convert.ToInt64(userInfo["AcceptStrangerIM"]) != 0, Convert.ToInt64(userInfo["MsgFileLimit"]), Convert.ToInt64(userInfo["MsgImageLimit"]), Convert.ToInt64(userInfo["DiskSize"]), Convert.ToInt64(userInfo["IsTemp"]), (DateTime) userInfo["RegisterTime"], userInfo["HomePage"] as string, userInfo["Password"] as string, userInfo);
                    return info;
                }
                info = new AccountInfo(userInfo["Name"] as string, userInfo["NickName"] as string, Convert.ToInt64(userInfo["Key"]), Convert.ToInt64(userInfo["Type"]), this.m_IAccountStorage.GetUserRoles(userName), friends.ToArray(), (Convert.ToInt64(userInfo["Type"]) == 1) ? managers.ToArray() : null, creator, userInfo["EMail"] as string, userInfo["InviteCode"] as string, Convert.ToInt64(userInfo["AcceptStrangerIM"]) != 0, Convert.ToInt64(userInfo["MsgFileLimit"]), Convert.ToInt64(userInfo["MsgImageLimit"]), Convert.ToInt64(userInfo["DiskSize"]), Convert.ToInt64(userInfo["IsTemp"]), (DateTime) userInfo["RegisterTime"], userInfo["HomePage"] as string, userInfo["Password"] as string, userInfo);
                if (this.m_List.Count >= 2)
                {
                    AccountInfo removeInfo = this.m_List.First.Value;
                    this.m_UserInfoCache.Remove(removeInfo.Name.ToUpper());
                    this.m_UserInfoCacheByID.Remove(removeInfo.ID);
                    this.m_List.RemoveFirst();
                }
                this.m_UserInfoCache[key] = info;
                this.m_UserInfoCacheByID[info.ID] = info;
                this.m_List.AddLast(info.ListNode);
                return info;
            }
            return null;
        }

        public void _RefreshUserInfo(long id)
        {
            lock (this.m_Lock)
            {
                this.RefreshUserInfo(id);
            }
        }

        public void UpdateUserInfo(string name, Hashtable values)
        {
            lock (this.m_Lock)
            {
                this.m_IAccountStorage.UpdateUserInfo(name, values);
                this.RefreshUserInfo(name);
            }
        }

        public bool Validate(string userId, string password)
        {
            lock (this.m_Lock)
            {
                return this.m_IAccountStorage.Validate(userId, password);
            }
        }

        public static AccountImpl Instance
        {
            get
            {
                return m_Instance;
            }
        }
    }
}

