
var ClientMode = false;
var CurrentWindow = null;

Core.WindowAnchorStyle = {};
Core.WindowAnchorStyle.Left = 1;
Core.WindowAnchorStyle.Right = 1 << 1;
Core.WindowAnchorStyle.Top = 1 << 2;
Core.WindowAnchorStyle.Bottom = 1 << 3;
Core.WindowAnchorStyle.All = 15;

Core.IWindow = function () {

    this.ShowDialog = function (parent) { }

    this.Show = function () { }

    this.Hide = function () { }

    this.Minimum = function () { }

    this.Close = function () { }

    this.Move = function () { }

    this.MoveEx = function () { }

    this.Resize = function () { }

    this.GetTag = function () { }

    this.SetTag = function () { }

    this.GetTitle = function () { }

    this.SetTitle = function () { }

    this.IsTop = function () { }

    this.IsVisible = function () { }

    this.BringToTop = function () { }

    this.Load = function (url, callback) { }

    this.GetHtmlWindow = function () { }

    this.OnLoad = new Core.Delegate();

    this.OnClosed = new Core.Delegate();

    this.OnHidden = new Core.Delegate();

    this.OnNotify = new Core.Delegate();

    this.GetClientWidth = function () { };

    this.GetClientHeight = function () { };

    this.Notify = function () { }
}

Core.GetPageUrl = function (url) {
    if (ClientMode || Core.Config.ServiceUrl == "") return url;
    if (Core.Config.ServiceUrl == "/") return "/" + url;
    return Core.Config.ServiceUrl + "/" + url;
}

Core.Utility.ShowWarning = function (text) {
    //    if (ClientMode) window.external.ShowWarning(text);
    //    else 
    alert(text);
}

Core.Utility.ShowError = function (text) {
    text = text.toString().replace("Exception", "错误");
    //    if (ClientMode) window.external.ShowError(text);
    //    else 
    alert(text);
}

Core.Utility.ShowFloatForm = function (text, type) {
    var floatForm = Core.CreateWindow(
		{
		    Left: 0, Top: 0, Width: 262, Height: 230,
		    Title: { InnerHTML: "消息" },
		    HasMinButton: false, HasMaxButton: false,
		    Resizable: false,
		    MinHeight: 80,
		    ShowInTaskbar: false
		}
	);

    floatForm.MoveEx("RIGHT|BOTTOM", 10000, 10000, true);
    floatForm.Show();

    floatForm.Load(
		Core.GetPageUrl("FloatForm.aspx"),
		function () {
		    floatForm.GetHtmlWindow().ShowMessage(text, type);
		    floatForm.MoveEx("RIGHT|BOTTOM", 0, 0, true);
		}
	);
}

Core.SendCommand = function (callback, errorCallback, data, handler, isAysn) {
    /// <summary>
    ///  发送请求到服务端  客户端向服务端发请求的
    /// </summary>
    /// <param name="callback">回调方法</param>
    /// <param name="errorCallback">错误回调方法</param>
    /// <param name="data">发送的数据或者命令</param>
    /// <param name="handler">ajax请求处理钩子</param>
    /// <param name="isAysn">是否异步</param>
    if (isAysn == undefined) isAysn = false;

    if (isAysn) {
        Core.Session.ResponsesCache.Start();
    }

    var postData = '<?xml version="1.0" encoding="utf-8" ?>\r\n';
    var id = Core.GenerateUniqueId() + "-" + Math.round(1000000000 + Math.random() * 100000000);
    postData += String.format(
		'<Command ID="{0}" SessionID=\"{1}" Handler=\"{3}\" IsAsyn=\"{4}\">{2}</Command>\r\n',
		id, Core.Session.GetSessionID(), Core.Utility.TransferCharForXML(data), handler, isAysn
	);

    if (isAysn) {
        if (ClientMode) Core.Session.ResponsesCache.NewCommandHandler(id, new CommandHandler(id, callback, errorCallback));
        else Core.Session.ResponsesCache.NewCommandHandler(id, callback, errorCallback);
    }
    //ajax接收处理事件,定义了对怎么处理,错误怎么处理
    var post_handler = {
        onsuccess: function (status, responseText) {
            try {
                var ret = Core.Utility.ParseJson(responseText);

                if (ret.IsSucceed) {
                    if (!isAysn) callback(ret.Data);
                }
                else {
                    if (isAysn) Core.Session.ResponsesCache.InvokeErrorCallback(id);
                    else errorCallback(ret.Exception);
                }
            }
            finally {
            }
        },
        onerror: function (status, msg) {
//            if (isAysn) Core.Session.ResponsesCache.InvokeErrorCallback(id, new Core.Exception("服务器错误", msg == "" ? "请求服务器失败!" : msg));
//            else errorCallback(new Core.Exception("服务器错误", msg == "" ? "请求服务器失败!" : msg));
        },
        onabort: function () {
        }
    }
    //发送请求
    Core.Post(Core.GetPageUrl("command.aspx"), postData, 'text/xml', -1, post_handler);
}

function CommandHandler(id, callback, errorCallback) {
    this.Callback = function (data, type) {
        if (type == "json") data = Core.Utility.ParseJson(data);
        callback(data);
    }

    this.ErrorCallback = function (data, type) {
        if (type == "json") data = Core.Utility.ParseJson(data);
        errorCallback(data);
    }
}

function SessionConstructor() {
    /// <summary>
    ///  全局会话状态
    /// </summary>
    var obj = this;

    var m_UserName = null;
    var m_UserInfo = null;
    var m_SessionID = null;
    var m_Cookie = null;
    var GlobalHandler = {};

    obj.InitService = function (username, userinfo, cookie, sessionId) {
        /// <summary>
        ///  全局会话状态
        /// </summary>
        /// <param name="username">用户名</param>
        /// <param name="userinfo">用户信息集合</param>
        /// <param name="cookie">cookie</param>
        /// <param name="sessionId">用户会话Id</param>
        m_UserName = username;
        m_UserInfo = userinfo;
        m_SessionID = sessionId;
        m_Cookie = cookie;

        Core.Session.ResponsesCache.Start();
    }
    //获得用户Json对象
    obj.GetUserInfo = function () {
        return m_UserInfo;
    }
    //获得用户名称
    obj.GetUserName = function () {
        return m_UserName;
    }
    //获得会话ID
    obj.GetSessionID = function () {
        return m_SessionID;
    }
    //获得用户Cookie信息
    obj.GetCookie = function () {
        return m_Cookie;
    }
    //重置用户信息
    obj.ResetUserInfo = function (info) {
        m_UserInfo = info;
        Core.Session.GetGlobal("WindowManagement").Notify("UserInfoChanged", info);
    }
    //会话状态重置
    obj.Reset = function () {
        m_UserName = null;
        m_UserInfo = null;
        m_SessionID = null;
        m_Cookie = null;
    }

    obj.WriteLog = function (log) {
        try {
            Core.OutputPanel.GetHtmlWindow().Write(log);
        }
        catch (ex) {
        }
    }

    var m_GlobalObject = {};

    obj.RegisterGlobal = function (key, value) {
        m_GlobalObject[key.toUpperCase()] = value;
    }

    obj.RemoveGlobal = function (key) {
        delete m_GlobalObject[key.toUpperCase()];
    }

    obj.GetGlobal = function (key) {
        return m_GlobalObject[key.toUpperCase()] == undefined ? null : m_GlobalObject[key.toUpperCase()];
    }

    obj.ResponsesCache = (function () {
        var CommandCallbackCache = {};

        var obj = {};

        var baseTime = new Date(2000, 0, 1);

        var m_Controler = null;
        var m_Stop = false;
        var m_IsRunning = false;

        obj.NewCommandHandler = function (id, callback, errorCallback) {
            var handler = new CommandHandler(id, callback, errorCallback)
            CommandCallbackCache[id] = handler;
        }

        obj.InvokeCallback = function (cmdid, data) {
            if (CommandCallbackCache[cmdid] != undefined) {
                CommandCallbackCache[cmdid].Callback(data);
                delete CommandCallbackCache[cmdid];
            }
        }

        obj.InvokeErrorCallback = function (cmdid, data) {
            if (cmdid == "all") {
                var callbacks = CommandCallbackCache;

                CommandCallbackCache = {};

                for (var key in callbacks) {
                    try {
                        callbacks[key].ErrorCallback(data);
                    }
                    catch (ex) {
                    }
                }
            }
            else {
                if (CommandCallbackCache[cmdid] != undefined) {
                    CommandCallbackCache[cmdid].ErrorCallback(data);
                    delete CommandCallbackCache[cmdid];
                }
            }
        }

        obj.IsRunning = function () {
            return m_IsRunning;
        }

        obj.Start = function () {
            if (!m_IsRunning) {
                m_IsRunning = true;
                m_Stop = false;
                Send();
            }
        }

        obj.Stop = function () {
            m_Stop = true;
            if (m_Controler != null) m_Controler.Abort();
        }
        //接收服务端向客户端推送的数据
        function Send() {
            if (m_Stop) {
                m_IsRunning = false;
                return;
            }

            var RequestID = Core.GenerateUniqueId();

            var data = String.format('RequestID={0}&SessionID={1}&ClientMode=false&ServerVersion={2}', RequestID, Core.Session.GetSessionID(), Core.Config.Version);

            var post_handler = {
                onsuccess: function (status, responseText) {
                    try {
                        Core.Session.GetGlobal("ReponsesProcess").Process(responseText);
                    }
                    catch (ex) {
                    }
                    setTimeout(Send, 10);
                },
                onerror: function (status, msg) {
                    try {
                        var ex = new Core.Exception("服务器错误", msg == "" ? "请求服务器失败!" : msg);
                        Core.Session.ResponsesCache.InvokeErrorCallback("all", ex);
                        //Core.Utility.ShowFloatForm(ex.toString(), "text");
                    }
                    catch (ex) {
                    }
                    setTimeout(Send, 5000);
                },
                onabort: function () {
                    Core.Session.WriteLog("Abort");
                    setTimeout(Send, 10);
                }
            };
            //Post消息到后台进行处理
            m_Controler = Core.Post(
				Core.GetPageUrl("response.aspx") + "?ID=" + RequestID,
				data, 'application/x-www-form-urlencoded', 2 * 60 * 1000,
				post_handler
			);
        }

        return obj;

    })();

    return obj;
}