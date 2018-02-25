
//if (window.external.Version != undefined && window.external.Version != "1.0.1.7") {
//    window.external.ShowError("客户端版本不兼容，请升级至1.0.1.7！");
//    window.external.ExitApplication();
//}

Core.main = window;

function InitGlobal() {
    var FriendsInfoCache = (function () {

        var obj = {};
        var _friends = null;
        var _friendsIndexName = {};
        var _friendsIndexID = {};

        obj.GetFriendInfo = function (name) {
            return _friendsIndexName[name.toUpperCase()];
        }

        obj.GetFriends = function (callback, useCache) {
            try {
                if (useCache == undefined) useCache = true;

                if (_friends == null || !useCache) {
                    var data = {
                        Action: "GetFriends"
                    };
                    Core.SendCommand(
						function (ret) {
						    if (_friends != null) {
						        Core.Session.GetGlobal("WindowManagement").Notify("FriendInfoChanged", _friends);
						    }
						    _friends = ret.Friends;
						    _friendsIndexName = {};
						    _friendsIndexID = {};
						    for (var i in _friends) {
						        _friendsIndexName[_friends[i].Name.toUpperCase()] = _friends[i];
						        _friendsIndexID[_friends[i].ID] = _friends[i];
						    }
						    callback(ret.Friends);
						},
						function (ex) {
						    callback(null, ex);
						},
						Core.Utility.RenderJson(data), "Core.Web Common_CH", false
					);
                }
                else {
                    callback(_friends);
                }
            }
            catch (ex) {
                callback(null, new Core.Exception(ex));
            }
        }

        obj.Refresh = function () {
            try {
                var data = {
                    Action: "GetFriends"
                };
                Core.SendCommand(
					function (ret) {
					    _friends = ret.Friends;
					    _friendsIndexName = {};
					    _friendsIndexID = {};
					    for (var i in _friends) {
					        _friendsIndexName[_friends[i].Name.toUpperCase()] = _friends[i];
					        _friendsIndexID[_friends[i].ID] = _friends[i];
					    }
					    Core.Session.GetGlobal("WindowManagement").Notify("FriendInfoChanged", _friends);
					},
					function (ex) {
					},
					Core.Utility.RenderJson(data), "Core.Web Common_CH", false
				);
            }
            catch (ex) {
            }
        }
        //by fj 2011-4-7  增加在线实时状态显示
        obj.ResetState = function (user, state) {
            //            var id = 0
            //            if (typeof user == "number") id = user;
            //            else id = user.ID
            //            if (_friendsIndexID[id] != undefined) _friendsIndexID[id].State = state;
            if (_friendsIndexName[user] != undefined) _friendsIndexName[user].State = state;
        }
        return obj;
    })();

    Core.Session.RegisterGlobal("FriendsInfoCache", FriendsInfoCache);
    //-------------------------------------------------------------加载组织架构----------------------------------------------
    //by fj 2011-3-23  加载组织架构
    var DeptsFriendsInfoCache = (function () {

        var obj = {};
        var _deptsFriends = null;
        var _deptsFriendsIndexName = {};
        var _deptsFriendsIndexID = {};

        obj.GetDeptsFriendInfo = function (name) {
            return _deptsFriendsIndexName[name.toUpperCase()];
        }

        obj.GetDeptsFriends = function (callback, useCache) {
            try {
                if (useCache == undefined) useCache = true;

                if (_deptsFriends == null || !useCache) {
                    var data = {
                        Action: "GetDeptsFriends"
                    };
                    Core.SendCommand(
						function (ret) {
						    if (_deptsFriends != null) {
						        Core.Session.GetGlobal("WindowManagement").Notify("FriendInfoChanged", _deptsFriends);
						    }
						    _deptsFriends = ret.DeptsFriends;
						    _deptsFriendsIndexName = {};
						    _deptsFriendsIndexID = {};
						    for (var i in _deptsFriends) {
						        _deptsFriendsIndexName[_deptsFriends[i].Name.toUpperCase()] = _deptsFriends[i];
						        _deptsFriendsIndexID[_deptsFriends[i].ID] = _deptsFriends[i];
						    }
						    callback(ret.DeptsFriends);
						},
						function (ex) {
						    callback(null, ex);
						},
						Core.Utility.RenderJson(data), "Core.Web Common_CH", false
					);
                }
                else {
                    callback(_deptsFriends);
                }
            }
            catch (ex) {
                callback(null, new Core.Exception(ex));
            }
        }

        obj.Refresh = function () {
            try {
                var data = {
                    Action: "GetDeptsFriends"
                };
                Core.SendCommand(
					function (ret) {
					    _deptsFriends = ret.DeptsFriends;
					    _deptsFriendsIndexName = {};
					    _deptsFriendsIndexID = {};
					    for (var i in _deptsFriends) {
					        _deptsFriendsIndexName[_deptsFriends[i].Name.toUpperCase()] = _deptsFriends[i];
					        _deptsFriendsIndexID[_deptsFriends[i].ID] = _deptsFriends[i];
					    }
					    Core.Session.GetGlobal("WindowManagement").Notify("FriendInfoChanged", _deptsFriends);
					},
					function (ex) {
					},
					Core.Utility.RenderJson(data), "Core.Web Common_CH", false
				);
            }
            catch (ex) {
            }
        }
        //by fj 2011-4-7  增加在线实时状态显示
        obj.ResetState = function (user, state) {
            //            var id = 0
            //            if (typeof user == "number") id = user;
            //            else id = user.ID
            //            if (_deptsFriendsIndexID[id] != undefined) _deptsFriendsIndexID[id].State = state;
            if (_deptsFriendsIndexName[user] != undefined) _deptsFriendsIndexName[user].State = state;
        }
        return obj;
    })();

    Core.Session.RegisterGlobal("DeptsFriendsInfoCache", DeptsFriendsInfoCache);

    //---------------------------------------------------------------------------------------------------------------------------------
    //-------------------------------------------------------------加载部门----------------------------------------------
    var DeptsCache = (function () {

        var obj = {};
        var _deptsFriends = null;
        var _deptsFriendsIndexName = {};
        var _deptsFriendsIndexID = {};

        obj.GetDeptsFriendInfo = function (name) {
            return _deptsFriendsIndexName[name.toUpperCase()];
        }

        obj.GetDepts = function (callback, useCache) {
            try {
                if (useCache == undefined) useCache = true;

                if (_deptsFriends == null || !useCache) {
                    var data = {
                        Action: "GetDeptsFriends"
                    };
                    Core.SendCommand(
						function (ret) {
						    if (_deptsFriends != null) {
						        Core.Session.GetGlobal("WindowManagement").Notify("DeptsInfoChanged", _deptsFriends);
						    }
						    _deptsFriends = ret.DeptsFriends;
						    _deptsFriendsIndexName = {};
						    _deptsFriendsIndexID = {};
						    for (var i in _deptsFriends) {
						        _deptsFriendsIndexName[_deptsFriends[i].Name.toUpperCase()] = _deptsFriends[i];
						        _deptsFriendsIndexID[_deptsFriends[i].ID] = _deptsFriends[i];
						    }
						    callback(ret.DeptsFriends);
						},
						function (ex) {
						    callback(null, ex);
						},
						Core.Utility.RenderJson(data), "Core.Web Common_CH", false
					);
                }
                else {
                    callback(_deptsFriends);
                }
            }
            catch (ex) {
                callback(null, new Core.Exception(ex));
            }
        }

        obj.Refresh = function () {
            try {
                var data = {
                    Action: "GetDeptsFriends"
                };
                Core.SendCommand(
					function (ret) {
					    _deptsFriends = ret.DeptsFriends;
					    _deptsFriendsIndexName = {};
					    _deptsFriendsIndexID = {};
					    for (var i in _deptsFriends) {
					        _deptsFriendsIndexName[_deptsFriends[i].Name.toUpperCase()] = _deptsFriends[i];
					        _deptsFriendsIndexID[_deptsFriends[i].ID] = _deptsFriends[i];
					    }
					    Core.Session.GetGlobal("WindowManagement").Notify("DeptsInfoChanged", _deptsFriends);
					},
					function (ex) {
					},
					Core.Utility.RenderJson(data), "Core.Web Common_CH", false
				);
            }
            catch (ex) {
            }
        }
        return obj;
    })();

    Core.Session.RegisterGlobal("DeptsCache", DeptsCache);
    //---------------------------------------------------------------------------------------------------------------------------------


    var SingletonForm = (function () {

        var obj = {};

        var m_FriendForm = null;

        obj.ShowFriendForm = function () {
            if (m_FriendForm == null) {
                var config = {
                    Left: 0,
                    Top: 0,
                    Width: 250,
                    Height: 450,
                    Title: {
                        InnerHTML: String.format("欢迎你-{0}", Core.Session.GetUserInfo().Nickname)
                    },
                    MinWidth: 250,
                    HasMaxButton: false,
                    HasMinButton: false,
                    Resizable: false,
                    OnClose: function (form) {
                        form.Hide();
                    },
                    AnchorStyle: Core.WindowAnchorStyle.Right | Core.WindowAnchorStyle.Bottom
                };
                m_FriendForm = Core.CreateWindow(config);
                m_FriendForm.MoveEx("RIGHT|TOP", -16, 2, true);
                m_FriendForm.Show();
                m_FriendForm.Load(Core.GetPageUrl("FriendForm.aspx"), null);
            }
            else {
                m_FriendForm.Show();
            }

            return m_FriendForm;
        }

        var m_AddFriendForm = null;

        obj.ShowAddFriendForm = function (friendName) {
            if (m_AddFriendForm == null) {
                var config = {
                    Left: 0,
                    Top: 0,
                    Width: 600,
                    Height: 450,
                    Title: {
                        InnerHTML: "查找"
                    },
                    Resizable: false,
                    HasMaxButton: false,
                    HasMinButton: false,
                    OnClose: function (form) {
                        form.Close();
                        m_AddFriendForm = null;
                    }
                }
                m_AddFriendForm = Core.CreateWindow(config);
                m_AddFriendForm.MoveEx('center', 0, -20, true);
                setTimeout(function () { m_AddFriendForm.Show(); }, 10);
                var url = Core.GetPageUrl("AddFriendForm.aspx?random=" + (new Date()).getTime());
                if (friendName != undefined) url += "&Name=" + friendName;
                m_AddFriendForm.Load(url, null);
            }
            else {
                setTimeout(function () { m_AddFriendForm.Show(); }, 10);
            }

            return m_AddFriendForm;
        }

        var m_FriendManagementForm = null;

        obj.ShowFriendManagementForm = function () {
            if (m_FriendManagementForm == null) {
                var config = {
                    Left: 0,
                    Top: 0,
                    Width: 750,
                    Height: 450,
                    MinWidth: 750,
                    MinHeight: 450,
                    Title: {
                        InnerHTML: "好友/群组管理"
                    },
                    Resizable: true,
                    HasMaxButton: false,
                    HasMinButton: true,
                    AnchorStyle: Core.WindowAnchorStyle.Left | Core.WindowAnchorStyle.Bottom
                }
                m_FriendManagementForm = Core.CreateWindow(config);
                m_FriendManagementForm.OnClosed.Attach(function () { m_FriendManagementForm = null; });
                m_FriendManagementForm.MoveEx('center', 0, -20, true);
                setTimeout(function () { m_FriendManagementForm.Show(); }, 10);
                m_FriendManagementForm.Load(Core.GetPageUrl("Management/Form.aspx"), null);
            }
            else {
                setTimeout(function () { m_FriendManagementForm.Show(); }, 10);
            }

            return m_FriendManagementForm;
        }

        var m_MsgHistoryForm = null;

        obj.ShowMsgHistoryForm = function (peer) {
            if (m_MsgHistoryForm == null) {
                var config = {
                    Left: 0,
                    Top: 0,
                    Width: 700,
                    Height: 450,
                    MinWidth: 700,
                    MinHeight: 450,
                    Title: {
                        InnerHTML: "消息管理"
                    },
                    Resizable: true,
                    HasMaxButton: ClientMode,
                    HasMinButton: true,
                    AnchorStyle: Core.WindowAnchorStyle.Left | Core.WindowAnchorStyle.Bottom
                }
                m_MsgHistoryForm = Core.CreateWindow(config);
                m_MsgHistoryForm.OnClosed.Attach(function () { m_MsgHistoryForm = null; });
                m_MsgHistoryForm.MoveEx('center', 0, -20, true);
                setTimeout(function () { m_MsgHistoryForm.Show(); }, 10);
                var url = Core.GetPageUrl("MsgHistory/Form.aspx");
                url += "?random=" + (new Date()).getTime();
                if (peer != undefined) url += String.format("&Peer={0}&Type={1}", peer.Name, peer.Type);
                m_MsgHistoryForm.Load(url, null);
            }
            else {
                setTimeout(function () { m_MsgHistoryForm.Show(); }, 10);
            }

            return m_MsgHistoryForm;
        }

        var m_UpdateSelfInfoForm = null;

        obj.ShowUpdateSelfInfoForm = function () {
            if (m_UpdateSelfInfoForm == null) {
                var config = {
                    Left: 0,
                    Top: 0,
                    Width: 370,
                    Height: 420,
                    MinWidth: 370,
                    MinHeight: 420,
                    Title: {
                        InnerHTML: "修改个人资料"
                    },
                    Resizable: false,
                    HasMaxButton: false,
                    HasMinButton: true,
                    AnchorStyle: Core.WindowAnchorStyle.Left | Core.WindowAnchorStyle.Top
                }
                m_UpdateSelfInfoForm = Core.CreateWindow(config);
                m_UpdateSelfInfoForm.OnClosed.Attach(function () { m_UpdateSelfInfoForm = null; });
                m_UpdateSelfInfoForm.MoveEx('CENTER', 0, 0, true);
                setTimeout(function () { m_UpdateSelfInfoForm.Show(); }, 10);
                var url = Core.GetPageUrl("Management/UpdateSelfInfo.aspx");
                url += "?random=" + (new Date()).getTime();
                m_UpdateSelfInfoForm.Load(url, null);
            }
            else {
                setTimeout(function () { m_UpdateSelfInfoForm.Show(); }, 10);
            }

            return m_UpdateSelfInfoForm;
        }

        //by fj 2011-5-3  增加个人信息显示窗口
        var m_FriendInfoForm = null;

        obj.ShowFriendInfoForm = function (nickname, phone, telphone, email, top, left) {
            var config = {
                Left: 0,
                Top: 0,
                Width: 250,
                Height: 140,
                Title: {
                    InnerHTML: "好友信息"
                },
                Resizable: false,
                HasMaxButton: false,
                HasMinButton: false,
                OnClose: function (form) {
                    form.Close();
                    m_FriendInfoForm = null;
                }
            }
            m_FriendInfoForm = Core.CreateWindow(config);
            m_FriendInfoForm.MoveEx('LEFT|TOP', left, top, true);
            setTimeout(function () { m_FriendInfoForm.Show(); }, 10);
            var url = Core.GetPageUrl("FloatFriendInfo.aspx?random=" + (new Date()).getTime());
            url += "&NickName=" + escape(nickname) + "&Phone=" + escape(phone) + "&TelPhone=" + escape(telphone) + "&EMail=" + escape(email);
            m_FriendInfoForm.Load(url, null);
            return m_FriendInfoForm;
        }
        //end

        //by fj 2011-6-21  增加组织架构
        var m_StructureForm = null;

        obj.ShowStructureForm = function () {
            if (m_StructureForm == null) {
                var config = {
                    Left: 0,
                    Top: 0,
                    Width: 750,
                    Height: 450,
                    MinWidth: 750,
                    MinHeight: 450,
                    Title: {
                        InnerHTML: "组织架构"
                    },
                    Resizable: true,
                    HasMaxButton: false,
                    HasMinButton: true,
                    AnchorStyle: Core.WindowAnchorStyle.Left | Core.WindowAnchorStyle.Bottom
                }
                m_StructureForm = Core.CreateWindow(config);
                m_StructureForm.OnClosed.Attach(function () { m_StructureForm = null; });
                m_StructureForm.MoveEx('center', 0, -20, true);
                setTimeout(function () { m_StructureForm.Show(); }, 10);
                m_StructureForm.Load(Core.GetPageUrl("Management/Structure.aspx"), null);
            }
            else {
                setTimeout(function () { m_StructureForm.Show(); }, 10);
            }

            return m_StructureForm;
        }
        //end

        return obj;
    })();

    Core.Session.RegisterGlobal("SingletonForm", SingletonForm);

    function ChatFormTag(cf) {
        var This = this;

        var m_Msgs = [];

        var m_IsCreated = false;

        This.OnFormCreated = new Core.Delegate();

        This.OnFormCreated.Attach(
			function () {
			    m_IsCreated = true;
			    for (var i in m_Msgs) {
			        cf.GetHtmlWindow().AddMessage(m_Msgs[i]);
			    }
			}
		);

        This.AddMessage = function (msg) {
            if (m_IsCreated) cf.GetHtmlWindow().AddMessage(msg);
            else m_Msgs.push(msg);
        }
    }

    var ChatService = (function () {

        var obj = {};

        var m_ChatForms = {};

        obj.Open = function (peer, slient) {
            if (slient == undefined) slient = false;
            var key = peer.toUpperCase();

            if (m_ChatForms[key] == undefined) {
                var form = Core.CreateWindow(
					{
					    Left: 0, Top: 0, Width: 670, Height: 480, MinWidth: 670, MinHeight: 480,
					    Title: { InnerHTML: "对话窗口" },
					    AnchorStyle: Core.WindowAnchorStyle.Left | Core.WindowAnchorStyle.Bottom
					}
				);
                form.SetTag(new ChatFormTag(form));
                form.OnClosed.Attach(function () { delete m_ChatForms[key]; });
                if (slient) {
                    form.MoveEx("", 10000, 10000, true);
                    form.Show();
                }
                else {
                    if (!ClientMode) {
                        var r = Math.round(Math.random() * 40);
                        form.MoveEx("LEFT|BOTTOM", 16 + r, -32 - r, true);
                    }
                    else {
                        form.MoveEx("CENTER|BOTTOM", 0, -30, true);
                    }
                    form.Show();
                }
                m_ChatForms[key] = form;
                form.Load(
					Core.GetPageUrl(String.format("ChatForm.aspx?peer={0}&random={1}", peer, (new Date()).getTime())),
					function () {
					    if (slient) {
					        //form.Minimum();  //by fj 2011-4-14  如果隐藏计算高度会错误.
					        if (!ClientMode) {
					            var r = Math.round(Math.random() * 40);
					            form.MoveEx("LEFT|BOTTOM", 16 + r, -32 - r, true);
					        }
					        else {
					            form.MoveEx("CENTER|BOTTOM", 0, -30, true);
					        }
					    }
					}
				);
            }
            else {
                if (!slient) m_ChatForms[key].Show();
            }
            return m_ChatForms[key];
        }

        return obj;

    })();

    Core.Session.RegisterGlobal("ChatService", ChatService);

    var WindowManagement = (function () {
        var m_All = [];

        var obj = {};

        obj.Add = function (win) {
            m_All.push(win);
        }

        obj.Remove = function (win) {
            var i = 0;
            for (; i < m_All.length && m_All[i] != win; i++);
            if (i < m_All.length) m_All.splice(i, 1);
        }

        obj.Notify = function (cmd, data) {
            for (var i in m_All) {
                try {
                    m_All[i].OnNotify.Call(cmd, data);
                }
                catch (ex) {
                }
            }
        }

        return obj;
    })();

    Core.Session.RegisterGlobal("WindowManagement", WindowManagement);
    //接收服务端推送的消息,并进行处理
    var ReponsesProcess = (function () {

        var obj = {};

        function Msg_Cort(m1, m2) {
            if (m1.CreatedTime > m2.CreatedTime) return 1;
            if (m1.CreatedTime < m2.CreatedTime) return -1;
            return 0;
        }

        var m_GlobalHandler = {
            "GLOBAL:IM_MESSAGE_NOTIFY": function (data) {
                if (data.Peer == "*") {  //离线消息处理
                    data.Messages.sort(Msg_Cort);

                    for (var i in data.Messages) {
                        var msg = data.Messages[i];
                        if (msg.Sender.Name.toLowerCase() == "administrator") {
                            Core.Utility.ShowFloatForm(msg.Content, "json");
                        }
                        else {
                            if (msg.Receiver.Type == 0) {  //0:代表用户  1:代表群
                                (function (msg) {
                                    //by fj 2011-3-25  增加消息闪烁
                                    Core.Utility.ScrollTitle("【" + msg.Sender.Nickname + "】来消息了");
                                    var form = Core.Session.GetGlobal("ChatService").Open(msg.Sender.Name, true);
                                    form.GetTag().AddMessage(msg);
                                    document.all.music.src = "/Lesktop/m.wav";
                                })(msg);
                            }
                            else {
                                (function (msg) {
                                    //by fj 2011-3-25  增加消息闪烁
                                    Core.Utility.ScrollTitle("【" + msg.Receiver.Nickname + "】来消息了");
                                    var form = Core.Session.GetGlobal("ChatService").Open(msg.Receiver.Name, true);
                                    form.GetTag().AddMessage(msg);
                                    document.all.music.src = "/Lesktop/m.wav";
                                })(msg);
                            }
                        }
                    }
                }
                else {
                    if (data.Message.Sender.Name.toLowerCase() == "administrator") {
                        Core.Utility.ShowFloatForm(data.Message.Content, "json");
                    }
                    else {
                        if (data.Message.Receiver.Type == 0) {
                            (function (msg) {
                                //by fj 2011-3-25  增加消息闪烁
                                Core.Utility.ScrollTitle("【" + msg.Sender.Nickname + "】来消息了");
                                var form = Core.Session.GetGlobal("ChatService").Open(msg.Sender.Name, true);
                                form.GetTag().AddMessage(msg);
                                document.all.music.src = "/Lesktop/m.wav";
                            })(data.Message);
                        }
                        else {
                            (function (msg) {
                                //by fj 2011-3-25  增加消息闪烁
                                var form = Core.Session.GetGlobal("ChatService").Open(msg.Receiver.Name, true);
                                Core.Utility.ScrollTitle("【" + msg.Receiver.Nickname + "】来消息了");
                                form.GetTag().AddMessage(msg);
                                document.all.music.src = "/Lesktop/m.wav";
                            })(data.Message);
                        }
                    }
                }
            },
            "UserStateChanged": function (data) {   //by fj 2011-4-7  增加在线实时状态显示
                Core.Session.GetGlobal("FriendsInfoCache").ResetState(data.User, data.State);
                Core.Session.GetGlobal("DeptsFriendsInfoCache").ResetState(data.User, data.State);
                Core.Session.GetGlobal("WindowManagement").Notify("UserStateChanged", data);
            },
            "GroupMemberChanged": function (data) {   //by fj 2011-4-11  刷新群成员
                Core.Session.GetGlobal("WindowManagement").Notify("GroupMemberChanged", data);
            },
            "GLOBAL:REFRESH_FIRENDS": function (data) {
                Core.Session.GetGlobal("FriendsInfoCache").Refresh();
                Core.Session.GetGlobal("DeptsFriendsInfoCache").Refresh();
            }
        }
        //处理服务器向客户端推送的数据
        obj.Process = function (responseText) {
            var ret = Core.Utility.ParseJson(responseText);
            Core.Session.WriteLog(responseText);
            if (ret.IsSucceed) {
                var responses = ret.Responses;

                for (var i in responses) {
                    var cr = responses[i];

                    if (cr.CommandID == "GLOBAL:SessionReset") {
                        Core.Session.ResponsesCache.InvokeErrorCallback("all", new Core.Exception("服务器错误", "会话重启失败!"));
                        break;
                    }
                    if (m_GlobalHandler[cr.CommandID] != undefined) {
                        m_GlobalHandler[cr.CommandID](cr.Data);
                    }
                    else {
                        Core.Session.ResponsesCache.InvokeCallback(cr.CommandID, cr.Data);
                    }
                }
            }
            else {
                if (ret.Exception.Name == "UnauthorizedException") {   //未授权异常
                    if (Core.Session.ResponsesCache.IsRunning()) {
                        Core.Session.ResponsesCache.Stop();
                        Core.Utility.ShowFloatForm("{\"Type\":\"UnauthorizedException\"}", "json");
                    }
                }
                else if (ret.Exception.Name == "IncompatibleException") { //程序版本不一样异常
                    if (Core.Session.ResponsesCache.IsRunning()) {
                        Core.Session.ResponsesCache.Stop();
                        Core.Utility.ShowFloatForm("{\"Type\":\"IncompatibleException\"}", "json");
                    }
                }
            }
        }

        return obj;
    })();

    Core.Session.RegisterGlobal("ReponsesProcess", ReponsesProcess);
}

function SetClientMode(cm, win) {
    ClientMode = cm;

    var enableSelTag = {
        "TEXTAREA": "",
        "INPUT": ""
    };

    if (ClientMode) {
        Core.CreateWindow = function (config) {
            var _config = {};
            _config.Left = Core.Utility.IsNull(config.Left, 100);
            _config.Top = Core.Utility.IsNull(config.Top, 100);
            _config.Width = Core.Utility.IsNull(config.Width, 400);
            _config.Height = Core.Utility.IsNull(config.Height, 300);
            _config.MinWidth = Core.Utility.IsNull(config.MinWidth, Math.min(_config.Width, 400));
            _config.MinHeight = Core.Utility.IsNull(config.MinHeight, Math.min(_config.Height, 300));
            _config.HasMinButton = Core.Utility.IsNull(config.HasMinButton, true);
            _config.HasMaxButton = Core.Utility.IsNull(config.HasMaxButton, true);
            _config.Resizable = Core.Utility.IsNull(config.Resizable, true);
            _config.Css = Core.Utility.IsNull(config.Css, "window");
            _config.BorderWidth = Core.Utility.IsNull(config.BorderWidth, 6);
            _config.ShowInTaskbar = Core.Utility.IsNull(config.ShowInTaskbar, _config.HasMinButton);
            _config.Tag = Core.Utility.IsNull(config.Tag, null);

            if (config.Title == undefined) {
                _config.Title = {
                    Height: 18,
                    InnerHTML: ""
                };
            }
            else {
                _config.Title = {};
                _config.Title.Height = Core.Utility.IsNull(config.Title.Height, 18);
                _config.Title.InnerHTML = Core.Utility.IsNull(config.Title.InnerHTML, "");
            }

            _config.OnClose = Core.Utility.IsNull(config.OnClose, null);

            var win = null; // window.external.CreateWindow(_config);
            Core.Session.GetGlobal("WindowManagement").Add(win);
            win.OnClosed.Attach(function (w) { Core.Session.GetGlobal("WindowManagement").Remove(w); });
            return win;
        }

        //Core.Session = window.external.Session;
    }
    else {
        Core.CreateWindow = function (config) {
            var win = new Window(config);
            Core.Session.GetGlobal("WindowManagement").Add(win);
            win.OnClosed.Attach(function (w) { Core.Session.GetGlobal("WindowManagement").Remove(w); });
            return win;
        }

        Core.Session = new SessionConstructor();
    }

    InitGlobal();

    Desktop.Create();

    Core.Taskbar = Taskbar;
    Core.Desktop = Desktop;

    Core.OutputPanel = Core.CreateWindow(
		{
		    Left: 200, Top: 150, Width: 600, Height: 450,
		    Title: { InnerHTML: "输 出" },
		    HasMinButton: false,
		    OnClose: function (form) {
		        form.Hide();
		    }
		}
	);

    if (window.init != undefined) window.init();

    return true;
}

String.format = function (fmt) {
    var params = arguments;
    var pattern = /{{|{[1-9][0-9]*}|\x7B0\x7D/g;
    return fmt.replace(
		pattern,
		function (p) {
		    if (p == "{{") return "{";
		    return params[parseInt(p.substr(1, p.length - 2), 10) + 1]
		}
	);
}

var __LoginForm = null;
var __StartServiceCallback = null;

function StartService(callback) {
    __StartServiceCallback = callback;
    if (__LoginForm == null && (Core.Session == undefined || Core.Session.GetUserName() == null)) {
        SetClientMode(false, null);
    }
    else {
        if (__StartServiceCallback != undefined && __StartServiceCallback != null) {
            __StartServiceCallback();
            __StartServiceCallback = null;
        }
    }
}

Core.Login = function (auto) {
    if (__LoginForm != null) return;

    __LoginForm = Core.CreateWindow(
		{
		    Left: 0, Top: 0, Width: 612, Height: 430,
		    HasMinButton: false, HasMaxButton: false,
		    Resizable: false,
		    Title: { InnerHTML: "用户登录" }
		}
	);

    __LoginForm.OnClosed.Attach(
		function (f) {
		    __LoginForm = null;
		    if (Core.Session.GetUserName() != null && Core.Session.GetUserName() != "") {
		        if (__StartServiceCallback != undefined && __StartServiceCallback != null) {
		            __StartServiceCallback();
		            __StartServiceCallback = null;
		        }
		    }
		    if ((Core.Session.GetUserName() == null || Core.Session.GetUserName() == "") && ClientMode) {
		        //window.external.ExitApplication();
		    }
		}
	);

    __LoginForm.MoveEx('center', 0, -20, true);
    __LoginForm.Show();

    //    var url = String.format("login.aspx?auto={0}", auto ? "true" : "false");

    //    if (Core.Session.GetUserName() != null && Core.Session.GetUserName() != "") {
    //        url += "&name=" + Core.Session.GetUserName();
    //    }
    //wenjl 2011-3-15   修正为自动登录
    var url = String.format("login.aspx?auto={0}", auto ? "true" : "false");
    //    url += "&name=" + escape(GetCookie("IMUSER"));
    //    url += "&pwd=" + escape(GetCookie("IMPWD"));
    Core.Session.Reset();

    __LoginForm.Load(
		Core.GetPageUrl(url),
		function () {
		}
	);
}

function init() {
    Core.Login(!ClientMode);
}

