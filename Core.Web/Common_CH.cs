using Core;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Web;

internal class Common_CH : CommandHandler
{
    public Common_CH(HttpContext context, string sessionId, string id, string data) : base(context, sessionId, id, data)
    {
    }

    public override string Process()
    {
        List<AccountInfo.Details> fis;
        string peer;
        string content;
        string name;
        List<Message> msgs;
        AccountInfo groupInfo;
        AccountInfo userInfo;
        Hashtable ps = Utility.ParseJson(base.Data) as Hashtable;
        switch ((ps["Action"] as string))
        {
            case "GetFriends":
                fis = new List<AccountInfo.Details>();
                foreach (string f in AccountImpl.Instance.GetUserInfo(base.UserName).Friends)
                {
                    fis.Add(AccountImpl.Instance.GetUserInfo(f).DetailsJson);
                }
                return Utility.RenderHashJson(new object[] { "Friends", fis });

            case "GetDeptsFriends":
                fis = OrganizationImpl.Instance.GetDeptsFirends();
                return Utility.RenderHashJson(new object[] { "DeptsFriends", fis });

            case "GetWindowRoles":
            {
                List<string> fis1 = AccountImpl.Instance.GetIMWindowRoles(base.UserName);
                string result = "";
                foreach (string i in fis1)
                {
                    result = result + ((result == "") ? "" : ",") + i;
                }
                return Utility.RenderHashJson(new object[] { "WindowRoles", result });
            }
            case "SendAddFriendRequest":
            {
                peer = ps["Peer"] as string;
                if (string.Compare(peer, base.UserName, true) == 0)
                {
                    throw new Exception("不能添加自己为好友！");
                }
                if (AccountImpl.Instance.GetUserInfo(peer) == null)
                {
                    throw new Exception(string.Format("用户(或群组) \"{0}\" 不存在！", peer));
                }
                AccountInfo peerInfo = AccountImpl.Instance.GetUserInfo(peer);
                if (peerInfo.Type == 0)
                {
                    if (AccountImpl.Instance.GetUserInfo(base.UserName).ContainsFriend(peer))
                    {
                        throw new Exception(string.Format("用户 \"{0}({1})\" 已经是您的好友！", peerInfo.Nickname, peer));
                    }
                    MessageImpl.Instance.NewMessage(peer, "administrator", Utility.RenderHashJson(new object[] { "Type", "AddFriendRequest", "Peer", AccountImpl.Instance.GetUserInfo(base.UserName), "Info", ps["Info"] as string }), null);
                }
                else
                {
                    if (AccountImpl.Instance.GetUserInfo(base.UserName).ContainsFriend(peer))
                    {
                        throw new Exception(string.Format("您已加入群 \"{0}({1})\"！", peerInfo.Nickname, peer));
                    }
                    MessageImpl.Instance.NewMessage(peerInfo.Creator, "administrator", Utility.RenderHashJson(new object[] { "Type", "AddGroupRequest", "User", AccountImpl.Instance.GetUserInfo(base.UserName), "Group", peerInfo, "Info", ps["Info"] as string }), null);
                }
                return Utility.RenderHashJson(new object[] { "Result", true });
            }
            case "DeleteFriend":
                peer = ps["Peer"] as string;
                AccountImpl.Instance.DeleteFriend(base.UserName, peer);
                content = Utility.RenderHashJson(new object[] { "Type", "DeleteFriendNotify", "User", AccountImpl.Instance.GetUserInfo(base.UserName), "Peer", AccountImpl.Instance.GetUserInfo(peer), "Info", ps["Info"] as string });
                MessageImpl.Instance.NewMessage(peer, "administrator", content, null);
                MessageImpl.Instance.NewMessage(base.UserName, "administrator", content, null);
                return Utility.RenderHashJson(new object[] { "Result", true });

            case "AddFriend":
                peer = ps["Peer"] as string;
                if (!AccountImpl.Instance.GetUserInfo(base.UserName).ContainsFriend(peer))
                {
                    AccountImpl.Instance.AddFriend(base.UserName, peer);
                    content = Utility.RenderHashJson(new object[] { "Type", "AddFriendNotify", "User", AccountImpl.Instance.GetUserInfo(base.UserName), "Peer", AccountImpl.Instance.GetUserInfo(peer), "Info", ps["Info"] as string });
                    MessageImpl.Instance.NewMessage(peer, "administrator", content, null);
                    MessageImpl.Instance.NewMessage(base.UserName, "administrator", content, null);
                }
                return Utility.RenderHashJson(new object[] { "Result", true });

            case "AddToGroup":
            {
                string user = ps["User"] as string;
                string group = ps["Group"] as string;
                AccountImpl.Instance.AddFriend(user, group);
                content = Utility.RenderHashJson(new object[] { "Type", "AddToGroupNotify", "User", AccountImpl.Instance.GetUserInfo(user), "Group", AccountImpl.Instance.GetUserInfo(group) });
                MessageImpl.Instance.NewMessage(group, "administrator", content, null);
                SessionManagement.Instance.Send("GroupMemberChanged", Utility.RenderHashJson(new object[] { "User", group }));
                return Utility.RenderHashJson(new object[] { "Result", true });
            }
            case "GetAccountInfo":
                name = ps["Name"] as string;
                return Utility.RenderHashJson(new object[] { "Info", AccountImpl.Instance.GetUserInfo(name) });

            case "FindHistory":
                MessageImpl.Instance.WriteCache();
                msgs = MessageImpl.Instance.FindHistory(ps["User"].ToString(), ps["Peer"].ToString(), Convert.ToDateTime(ps["From"]), Convert.ToDateTime(ps["To"]));
                return Utility.RenderHashJson(new object[] { "Result", true, "User", ps["User"], "Peer", ps["Peer"], "Messages", msgs });

            case "GetGroupMembers":
            {
                name = ps["Name"].ToString();
                groupInfo = AccountImpl.Instance.GetUserInfo(name);
                List<AccountInfo.Details> members = new List<AccountInfo.Details>();
                foreach (string memberName in groupInfo.Friends)
                {
                    members.Add(AccountImpl.Instance.GetUserInfo(memberName).DetailsJson);
                }
                return Utility.RenderHashJson(new object[] { "Result", true, "Members", members, "GroupInfo", groupInfo, "GroupCreator", AccountImpl.Instance.GetUserInfo(groupInfo.Creator).DetailsJson });
            }
            case "ExitGroup":
            {
                string groupName = ps["GroupName"].ToString();
                userInfo = AccountImpl.Instance.GetUserInfo(base.UserName);
                groupInfo = AccountImpl.Instance.GetUserInfo(groupName);
                AccountImpl.Instance.DeleteFriend(base.UserName, groupName);
                SessionManagement.Instance.Send("GroupMemberChanged", Utility.RenderHashJson(new object[] { "User", groupName }));
                SessionManagement.Instance.Send(base.UserName, "GLOBAL:REFRESH_FIRENDS", null);
                if (ConfigurationManager.AppSettings["GroupMembersAddDeleteIsReminded"].ToString() == "1")
                {
                    MessageImpl.Instance.NewMessage(groupName, groupName, string.Format("{0}({1})已退出群！", userInfo.Nickname, userInfo.Name), null);
                }
                return Utility.RenderHashJson(new object[] { "Result", true });
            }
            case "CreateTempGroups":
            {
                string deptId = ps["DeptId"].ToString();
                string deptName = ps["DeptName"].ToString();
                string tempGroupName = AccountImpl.Instance.GetGroupTempNameByDeptId(deptId);
                if (tempGroupName == "")
                {
                    string userlist = "";
                    DataRowCollection users = OrganizationImpl.Instance.GetDeptAllUser(deptId);
                    long Count = 0;
                    if (ConfigurationManager.AppSettings["TempGroupAutoGreateUserCount"].Length > 0)
                    {
                        Count = Convert.ToInt64(ConfigurationManager.AppSettings["TempGroupAutoGreateUserCount"]);
                    }
                    if (users.Count > Count)
                    {
                        return Utility.RenderHashJson(new object[] { "ErrorInfo", string.Format("自动创建讨论组人数超过最大限制,最大限制人数:{0}!", Count) });
                    }
                    if (users.Count > 0)
                    {
                        foreach (DataRow row in users)
                        {
                            if (row["name"].ToString().ToUpper() != base.UserName.ToUpper())
                            {
                                userlist = userlist + ((userlist == "") ? "" : ",") + row["name"].ToString();
                            }
                        }
                    }
                    tempGroupName = "M" + DateTime.Now.ToString("yyyyMMddHHmmssfff") + new Random(((DateTime.Now.Minute * 0xea60) + (DateTime.Now.Second * 0x3e8)) + DateTime.Now.Millisecond).Next();
                    AccountImpl.Instance.CreateTempGroup(base.UserName, tempGroupName, deptName + "讨论组", deptId, userlist);
                    SessionManagement.Instance.Send(base.UserName, "GLOBAL:REFRESH_FIRENDS", null);
                    AccountInfo cu = AccountImpl.Instance.GetUserInfo(base.UserName);
                    MessageImpl.Instance.NewMessage(tempGroupName, tempGroupName, string.Format("{0}({1})已加入讨论组！", cu.Nickname, base.UserName), null);
                    if (users.Count > 0)
                    {
                        foreach (DataRow row in users)
                        {
                            if (row["name"].ToString().ToUpper() != base.UserName.ToUpper())
                            {
                                userInfo = AccountImpl.Instance.GetUserInfo(row["name"].ToString());
                                SessionManagement.Instance.Send(row["name"].ToString(), "GLOBAL:REFRESH_FIRENDS", null);
                                if (ConfigurationManager.AppSettings["GroupMembersAddDeleteIsReminded"].ToString() == "1")
                                {
                                    MessageImpl.Instance.NewMessage(tempGroupName, tempGroupName, string.Format("{0}({1})已加入讨论组！", userInfo.Nickname, userInfo.Name), null);
                                }
                            }
                        }
                    }
                }
                return Utility.RenderHashJson(new object[] { "DeptInfo", tempGroupName });
            }
            case "UsersSerach":
                name = ps["Name"] as string;
                return AccountImpl.Instance.GetAllUsersByName(name.Trim());

            case "ReLogin":
                SessionManagement.Instance.GetAccountState(base.UserName).NewSession(ps["SessionID"].ToString());
                return Utility.RenderHashJson(new object[] { "Result", true });

            case "SearchMessage":
                content = ps["Content"] as string;
                MessageImpl.Instance.WriteCache();
                msgs = MessageImpl.Instance.FindHistory(ps["Type"].ToString(), content, Convert.ToDateTime(ps["From"]), Convert.ToDateTime(ps["To"]), base.UserName);
                return Utility.RenderHashJson(new object[] { "Result", true, "Messages", msgs });

            case "GetAllDepts":
                return OrganizationImpl.Instance.GetAllDepts();
        }
        throw new NotImplementedException();
    }

    public override void Process(object data)
    {
        throw new NotImplementedException();
    }
}

