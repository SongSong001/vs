using Core;
using Iesi.Collections.Generic;
using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

public class Management_AddMemberToGroup : Page
{
    private CommandCtrl cmdCtrl;
    private string filter = "";
    private string GroupName = "";

    private void BindListLeft()
    {
        ListBox lbLeft = this.FindControl("lbLeft") as ListBox;
        lbLeft.Items.Clear();
        foreach (DataRow row in AccountImpl.Instance.GetAllUsers())
        {
            if (this.IsExists(row["name"].ToString()))
            {
                lbLeft.Items.Add(new ListItem(row["nickname"].ToString() + "(" + row["name"].ToString() + ")", row["name"].ToString()));
            }
        }
    }

    private void BindListRight(AccountInfo ac)
    {
        ListBox lbRight = this.FindControl("lbRight") as ListBox;
        lbRight.Items.Clear();
        foreach (string name in AccountImpl.Instance.GetUserInfo(this.GroupName).Friends)
        {
            AccountInfo fi = AccountImpl.Instance.GetUserInfo(name);
            if ((fi.Type == 0) && (fi.Name != ac.Creator))
            {
                lbRight.Items.Add(new ListItem(fi.Nickname + "(" + fi.Name + ")", fi.Name));
            }
        }
    }

    private void cmdCtrl_OnCommand(string command, object data)
    {
        try
        {
            this.GroupName = base.Request.QueryString["Name"];
            if (command == "AddMemberToGroup")
            {
                Hashtable haperr;
                object[] firends;
                Hashtable peer;
                if (this.GroupName != "")
                {
                    haperr = (Hashtable) Utility.ParseJson(data.ToString());
                    if (haperr != null)
                    {
                        int i;
                        AccountInfo peerInfo;
                        string content;
                        AccountInfo Group = AccountImpl.Instance.GetUserInfo(this.GroupName);
                        string[] oldFirends = Group.Friends;
                        firends = (object[]) haperr["Peers"];
                        ISet<string> iSetOldFirends = new HashedSet<string>();
                        ISet<string> iSetFirends = new HashedSet<string>();
                        for (i = 0; i < oldFirends.Length; i++)
                        {
                            if (oldFirends[i] != ServerImpl.Instance.GetCurrentUser(this.Context).Name)
                            {
                                iSetOldFirends.Add(oldFirends[i]);
                            }
                        }
                        for (i = 0; i < firends.Length; i++)
                        {
                            peer = (Hashtable) firends[i];
                            iSetFirends.Add(peer["Name"].ToString());
                        }
                        ISet<string> friendsIsNewAndOld = iSetOldFirends.Intersect(iSetFirends);
                        ISet<string> friendsDelete = iSetOldFirends.Minus(friendsIsNewAndOld);
                        ISet<string> friendsAdd = iSetFirends.Minus(friendsIsNewAndOld);
                        foreach (string peer1 in friendsAdd)
                        {
                            AccountImpl.Instance.AddFriend(peer1, this.GroupName);
                            peerInfo = AccountImpl.Instance.GetUserInfo(peer1);
                            content = Utility.RenderHashJson(new object[] { "Type", "AddToGroupNotify", "User", AccountImpl.Instance.GetUserInfo(peer1), "Group", Group });
                            if (ConfigurationManager.AppSettings["GroupMembersAddDeleteIsReminded"].ToString() == "1")
                            {
                                MessageImpl.Instance.NewMessage(this.GroupName, this.GroupName, string.Format("{0}({1})已加入群！", peerInfo.Nickname, peerInfo.Name), null);
                            }
                            SessionManagement.Instance.Send(peer1, "GLOBAL:REFRESH_FIRENDS", null);
                            SessionManagement.Instance.Send("GroupMemberChanged", Utility.RenderHashJson(new object[] { "User", this.GroupName }));
                        }
                        foreach (string peer2 in friendsDelete)
                        {
                            AccountImpl.Instance.DeleteFriend(peer2, this.GroupName);
                            peerInfo = AccountImpl.Instance.GetUserInfo(peer2);
                            content = Utility.RenderHashJson(new object[] { "Type", "AddToGroupNotify", "User", AccountImpl.Instance.GetUserInfo(peer2), "Group", Group });
                            if (ConfigurationManager.AppSettings["GroupMembersAddDeleteIsReminded"].ToString() == "1")
                            {
                                MessageImpl.Instance.NewMessage(this.GroupName, this.GroupName, string.Format("{0}({1})已退出群！", peerInfo.Nickname, peerInfo.Name), null);
                            }
                            SessionManagement.Instance.Send(peer2, "GLOBAL:REFRESH_FIRENDS", null);
                            SessionManagement.Instance.Send("GroupMemberChanged", Utility.RenderHashJson(new object[] { "User", this.GroupName }));
                        }
                        this.BindListRight(Group);
                        this.BindListLeft();
                    }
                }
                else if (this.GroupName == "")
                {
                    string CurrentFriend = base.Request.QueryString["CurrentFriend"];
                    haperr = (Hashtable) Utility.ParseJson(data.ToString());
                    if (haperr != null)
                    {
                        string UserName = ServerImpl.Instance.GetCurrentUser(this.Context).Name;
                        string userlist = "";
                        firends = (object[]) haperr["Peers"];
                        long Count = 0;
                        if (ConfigurationManager.AppSettings["TempGroupAutoGreateUserCount"].Length > 0)
                        {
                            Count = Convert.ToInt64(ConfigurationManager.AppSettings["TempGroupAutoGreateUserCount"]);
                        }
                        if (firends.Length <= Count)
                        {
                            if (firends.Length > 0)
                            {
                                foreach (object firend in firends)
                                {
                                    peer = (Hashtable) firend;
                                    if ((peer["Name"].ToString().ToUpper() != UserName.ToUpper()) && (peer["Name"].ToString() != CurrentFriend))
                                    {
                                        userlist = userlist + ((userlist == "") ? "" : ",") + peer["Name"].ToString();
                                    }
                                }
                                this.GroupName = "M" + DateTime.Now.ToString("yyyyMMddHHmmssfff") + new Random(((DateTime.Now.Minute * 0xea60) + (DateTime.Now.Second * 0x3e8)) + DateTime.Now.Millisecond).Next();
                                AccountImpl.Instance.CreateTempGroup(UserName, this.GroupName, "M" + DateTime.Now.ToString("yyyyMMddHHmmssfff") + "讨论组", "", userlist);
                                SessionManagement.Instance.Send(UserName, "GLOBAL:REFRESH_FIRENDS", null);
                                AccountInfo cu = AccountImpl.Instance.GetUserInfo(UserName);
                                if (ConfigurationManager.AppSettings["GroupMembersAddDeleteIsReminded"].ToString() == "1")
                                {
                                    MessageImpl.Instance.NewMessage(this.GroupName, this.GroupName, string.Format("{0}({1})已加入讨论组！", cu.Nickname, UserName), null);
                                }
                                if (CurrentFriend != "")
                                {
                                    AccountInfo CurrentFriendInfo = AccountImpl.Instance.GetUserInfo(CurrentFriend);
                                    AccountImpl.Instance.AddFriend(CurrentFriend, this.GroupName);
                                    SessionManagement.Instance.Send(CurrentFriend, "GLOBAL:REFRESH_FIRENDS", null);
                                    if (ConfigurationManager.AppSettings["GroupMembersAddDeleteIsReminded"].ToString() == "1")
                                    {
                                        MessageImpl.Instance.NewMessage(this.GroupName, this.GroupName, string.Format("{0}({1})已加入讨论组！", CurrentFriendInfo.Nickname, CurrentFriendInfo.Name), null);
                                    }
                                }
                                foreach (object firend in firends)
                                {
                                    peer = (Hashtable) firend;
                                    if ((peer["Name"].ToString().ToUpper() != UserName.ToUpper()) && (peer["Name"].ToString() != CurrentFriend))
                                    {
                                        AccountInfo userInfo = AccountImpl.Instance.GetUserInfo(peer["Name"].ToString());
                                        SessionManagement.Instance.Send(peer["Name"].ToString(), "GLOBAL:REFRESH_FIRENDS", null);
                                        if (ConfigurationManager.AppSettings["GroupMembersAddDeleteIsReminded"].ToString() == "1")
                                        {
                                            MessageImpl.Instance.NewMessage(this.GroupName, this.GroupName, string.Format("{0}({1})已加入讨论组！", userInfo.Nickname, userInfo.Name), null);
                                        }
                                    }
                                }
                                this.cmdCtrl.State["Action"] = "Close";
                            }
                        }
                        else
                        {
                            this.cmdCtrl.State["Action"] = "Error";
                            this.cmdCtrl.State["Exception"] = string.Format("自动创建讨论组人数超过最大限制,最大限制人数:{0}!", Count);
                        }
                    }
                }
            }
            if (command == "RefreshMember")
            {
                this.cmdCtrl.State["Action"] = "RefreshFriendsList";
            }
            if (command == "Search")
            {
                this.filter = data.ToString();
            }
        }
        catch (Exception ex)
        {
            this.cmdCtrl.State["Action"] = "Error";
            this.cmdCtrl.State["Exception"] = ex;
        }
    }

    private bool IsExists(string name)
    {
        if (this.GroupName != "")
        {
            AccountInfo ac = AccountImpl.Instance.GetUserInfo(this.GroupName);
            foreach (string firend in ac.Friends)
            {
                if (firend == name)
                {
                    return false;
                }
            }
        }
        return true;
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        this.cmdCtrl = this.FindControl("CommandCtrl") as CommandCtrl;
        this.cmdCtrl.OnCommand += new CommandCtrl.OnCommandDelegate(this.cmdCtrl_OnCommand);
        this.GroupName = base.Request.QueryString["Name"];
        this.cmdCtrl.State["Action"] = null;
        ListBox lbLeft = this.FindControl("lbLeft") as ListBox;
        ListBox lbRight = this.FindControl("lbRight") as ListBox;
        lbLeft.Attributes.Add("ondblclick", "AddItem()");
        lbRight.Attributes.Add("ondblclick", "DelItem()");
        lbLeft.Items.Clear();
        lbRight.Items.Clear();
        this.BindListLeft();
        if (this.GroupName != "")
        {
            AccountInfo ac = AccountImpl.Instance.GetUserInfo(this.GroupName);
            this.BindListRight(ac);
        }
    }
}

