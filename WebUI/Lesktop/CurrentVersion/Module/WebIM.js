Core.Link("StyleSheet", Core.GetUrl("Themes/Default/webim.css"), "text/css");

var Controls = null;
var Window = null, Control = null;

function init(completeCallback, errorCallback) {
    function LoadModulesComplete() {
        Controls = Core.GetModule("Controls.js");

        Control = Core.GetModule("Controls.js").Control;

        _init(completeCallback, errorCallback);
    }

    Core.LoadModules(
        LoadModulesComplete, errorCallback,
        ["Controls.js"]
    );
}

function _init(completeCallback, errorCallback) {
    try {
        //初始化代码，初始化完成后必须调用completeCallback;
        Core.LoadModules(function () {
            RichEditor = Core.GetModule("RichEditor.js").RichEditor;
            Management = Core.GetModule("Management.js");

            completeCallback();
        },
        errorCallback, ["RichEditor.js", "Management.js"]);
    }
    catch (ex) {
        errorCallback(new Core.Exception("客户端错误", String.format("{0}:{1}!", ex.mame, ex.message)));
    }
}



function dispose(completeCallback, errorCallback) {
    _dispose(completeCallback, errorCallback);
}

function _dispose(completeCallback, errorCallback) {
    try {
        //卸载代码，卸载完成后必须调用completeCallback;
        completeCallback();
    }
    catch (ex) {
        errorCallback(new Core.Exception("客户端错误", String.format("{0}:{1}!", ex.mame, ex.message)));
    }
}

//共享全局变量和函数，在此定义的变量和函数将由该应用程序的所有实例共享
var RichEditor = null;
var Management = null;

function EmptyCallback() {

}

var MessageFormat =

"<div class='messageTitle'>" +

"<span class='sender'>{0}</span>" +

"<span class='time'>{1}</span>" +

"<span class='operationContainer'></span>" +

"</div>" +

"<div class='messageContent'>{2}</div>";

var MessageFormatDom =

"<div class='messageTitle'>" +

"</div>" +

"<div class='messageContent'></div>" +

"<br/>";

var MSF_MessageFormat =

"<div class='messageTitle'>" +

"<span class='sender'>{0}</span>" +

"<span class='time'>{1}</span>" +

"</div>" +

"<div class='messageContent'>{2}</div>" +

"<br/>";

var MSF_MessageFormatDom =

"<div class='messageTitle'>" +

"</div>" +

"<div class='messageContent'></div>" +

"<br/>";

var FileHtmlFormat = "";

if (!ClientMode) {
    FileHtmlFormat = "<div class='div_filename'>文件名:{0}</div>" +

    "<div class='operationContainer'>" +

    "<div class='link_download'><a target='_blank' href='" + Core.GetPageUrl("download.aspx") + "?FileName={1}'>下载</a></div>" +

    //"<div class='link_saveas'><span onclick='javascript:window.SaveFile(unescape(\"{1}\"))'>另存为</span></div>" +
    "</div>";
}
else {
    FileHtmlFormat = "<div class='div_filename'>文件名:{0}</div>" +

    "<div class='operationContainer'>" +

    "<div class='link_saveas'><span onclick='javascript:window.OpenFile(unescape(\"{1}\"))'>打开</span></div>" +

    "<div class='link_saveas'><span onclick='javascript:window.SaveFile(unescape(\"{1}\"))'>另存为</span></div>" +

    "</div>";
}

//格式化数字
function FormatNumber(num, length) {
    var s = num.toString();
    var zero = "";
    for (var i = 0; i < length - s.length; i++) zero += "0";
    return zero + s;
}

//时间转字符串
function DateToString(date) {
    return String.format("{0}-{1}-{2} {3}:{4}:{5}", FormatNumber(date.getFullYear(), 4), FormatNumber(date.getMonth() + 1, 2), FormatNumber(date.getDate(), 2), FormatNumber(date.getHours(), 2), FormatNumber(date.getMinutes(), 2), FormatNumber(date.getSeconds(), 2));
}

//消息处理
function TranslateMessage(msg, data) {
    msg = msg.replace(/<img [^\t\n\r\f\v<>]+>/ig,
    function (img) {
        return img.replace(/src[^<>]*=[^<>]*(\x22|\x27)([^<>]+\/|)download.aspx\x3FFileName=([^\t\n\r\f\v\x22]+)(\x22|\x27)/ig,
        function (text, v1, v2, src) {
            url = String.format(Core.GetPageUrl("download.aspx") + "?FileName={{Accessory type=\"image\" src=\"{0}\"}", src);
            return String.format("src=\"{0}\"", url);
        });
    });

    msg = msg.replace(/<img [^\t\n\r\f\v<>]+>/ig,
    function (img) {
        return img.replace(/src[^<>]*=[^<>]*\x22([^<>]+\/|)file\x3A\/\/\/([^\t\n\r\f\v\x22]+)\x22/ig,
        function (text, v1, src) {

            var data_id = Core.GenerateUniqueId();
            var base64 = src; //window.external.ToBase64String(src);
            data[data_id] = base64;
            var index = src.lastIndexOf("\\");
            if (index < 0) index = -1;
            url = String.format(Core.GetPageUrl("download.aspx") + "?FileName={{Accessory type=\"image\" src=\"{0}\" data=\"{1}\"}", src.substr(index + 1, src.length - index - 1), data_id);
            return String.format("src=\"{0}\"", url);
        });
    });

    msg = msg.replace(/<a [^\t\n\r\f\v<>]+[^\x2F]>/ig,
    function (a) {
        var hrefReg = /href=\x22[^\t\n\r\f\v\x22]+\x22/ig
        hrefReg.lastIndex = 0;
        var href = hrefReg.exec(a);
        return String.format("[A:{0}]", href != null && href.length > 0 ? escape(href[0].substr(6, href[0].length - 7)) : "");
    });

    msg = msg.replace(/<\x2Fa>/ig,
    function (a) {
        return "[/A]";
    });

    msg = msg.replace(/\x5BFILE\x3A[^\n\f\r\t\v]+\x5D/g,
    function (file) {
        return String.format("[FILE:{{Accessory type=\"file\" src=\"{0}\"}]", escape(file.substr(6, file.length - 7)));
    });

    msg = msg.replace(/\x5BLOCAL\x3Afile\x3A\/\/\/([^\n\f\r\t\v]+)\x5D/g,
    function (file, path) {
        var data_id = Core.GenerateUniqueId();
        var base64 = path; //window.external.ToBase64String(path);
        data[data_id] = base64;
        var index = path.lastIndexOf("\\");
        if (index < 0) index = -1;
        return String.format("[FILE:{{Accessory type=\"file\" src=\"{0}\" data=\"{1}\"}]", path.substr(index + 1, path.length - (index + 1)), data_id);
    });

    msg = msg.replace(/<!--[^\n\f\r\t\v<>]*-->/g,
    function () {
        return "";
    });

    return msg;
}

function IsEmpty(str) {
    for (var i = 0; i < str.length; ) {
        var c = str.substr(i, 1);
        if (str.substr(i, 6).toLowerCase() == "&nbsp;") i += 6;
        else if (c == '\n' || c == '\r' || c == '\f' || c == '\t' || c == '\v' || c == ' ') i++;
        else return false;
    }
    return true;
}

//获得头像 by fj  2011-4-7  获得在线实时状态
function GetHeadIMG(info, size, gred) {
    if (info.HeadIMG == "") {
        var url = Core.Config.ServiceUrl + "/images/HeadIMG/user"
        if (size > 0) url += "." + size;
        if (gred) url += ".gred";
        url += ".png";
        return url;
    }
    else {
        return String.format("{0}?user={1}&size={2}&gred={3}&headimg={4}", Core.GetPageUrl("headimg.aspx"), info.Name, size, gred, info.HeadIMG);
    }
}

Module.ChatPanel = ChatPanel;

function ChatPanel(config) {
    var This = this;
    var OwnerForm = this;

    config.Css = "MainWnd";

    var width = config.Width, height = config.Height;
    config.Width = 490;
    config.Height = 493;

    Control.call(This, config);

    var Base = {
        GetType: This.GetType,
        is: This.is
    };

    This.GetType = function () { return "ChatPanel"; }
    This.is = function (type) { return type == This.GetType() ? true : Base.is(type); }

    var m_MsgPanel_Config = { "Left": 0, "Top": 25, "Width": 490, "Height": 334, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top | Controls.AnchorStyle.Bottom, "Parent": This, "Text": "", "Css": "control" };

    m_MsgPanel_Config.User = config.User
    m_MsgPanel_Config.Peer = config.Peer;

    if (config.Peer.Type == 0) {
        m_MsgPanel_Config.Operations = [{
            Text: "引用",
            Command: "Quote"
        }];
    }
    else {
        m_MsgPanel_Config.Operations = [{
            Text: "加为好友",
            Command: "AddFriend"
        },
                {
                    Text: "私聊",
                    Command: "Chat"
                },
                {
                    Text: "引用",
                    Command: "Quote"
                }];
    }

    var m_MsgPanel = new MsgPanel(m_MsgPanel_Config);

    var m_MsgEditor_Config = { "Left": 0, "Top": 364, "Width": 490, "Height": 97, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Bottom, "Parent": This, "Text": "", "Css": "control" };

    m_MsgEditor_Config.BorderWidth = 1;
    m_MsgEditor_Config.Css = "richEditor";

    var m_MsgEditor = new MsgEditor(m_MsgEditor_Config);


    var m_BtnSend = new Controls.Button({ "Left": 368, "Top": 466, "Width": 121, "Height": 26, "AnchorStyle": Controls.AnchorStyle.Right | Controls.AnchorStyle.Bottom, "Parent": This, "Text": "发送(Enter)", "Css": "button_default" });

    m_BtnSend.OnClick.Attach(
        function (btn) {
            //            if (m_MsgEditor.GetValue().length > 4096) {
            //                alert("消息不能超过4000个字符！");
            //                return;
            //            }
            if (IsEmpty(m_MsgEditor.GetValue())) {
                alert("消息不能为空！");
                return;
            }

            var data = {
                Action: "NewMessage",
                Sender: m_User.Name,
                Receiver: m_Peer.Name
            };

            data.Content = TranslateMessage(m_MsgEditor.GetValue(), data);

            var temp = m_MsgPanel.CreateMessage(data.Content, data);
            m_MsgEditor.SetValue(" ");

            function Send_Error(ex) {
                alert(ex);
            }

            function Send_Callback(data) {
                var message = data;
                m_MsgPanel.AddMessage(message, temp);
            }

            Core.SendCommand(Send_Callback, Send_Error, Core.Utility.RenderJson(data), "Core.Web WebIM", false);
        }
    )

    //按钮生成
    var m_Toolbar = new Controls.Toolbar({ "Left": 0, "Top": 0, "Width": 490, "Height": 24, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top, "Parent": This, "Text": "", "Css": "toolbar", "Items": [{ "Text": "发送文件", "Css": "Image22_MoveTo", "Command": "SendFile" }, { "Text": "发送图片", "Css": "Image22_Picture", "Command": "SendImage" }, { "Text": "截图", "Css": "Image22_Picture", "Command": "GradScreen" }, { "Text": "消息历史", "Css": "Image22_MessageRecord", "Command": "MsgRecord" }, { "Text": "加为好友", "Css": "Image22_Add", "Command": "AddFriend" }, { "Text": "成员管理", "Css": "Image22_Add", "Command": "GroupMemberManage" }, { "Text": "讨论组", "Css": "Image22_TempGroup", "Command": "CreateTempGroup" }, { "Text": "退出群组", "Css": "Image22_Delete", "Command": "ExitGroup"}] });

    m_Toolbar.SetButtonVisible(4, false);
    //by fj 2011-3-29   增加权限控制
    //    m_Toolbar.SetButtonVisible(0, false);
    //    m_Toolbar.SetButtonVisible(1, false);
    //by fj 2011-6-15  隐藏消息历史按钮
    m_Toolbar.SetButtonVisible(3, false);
    //    Core.GetModule("Common.js").GetWindowRoles(
    //					function (result, ex) {
    //					    if (result) {
    //					        var commands = ex.split(",");
    //					        for (var i = 0; i < commands.length; i++) {
    //					            if (commands[i] == "SendImg") {
    //					                m_Toolbar.SetButtonVisible(1, true);
    //					            }
    //					            if (commands[i] == "SendFile") {
    //					                m_Toolbar.SetButtonVisible(0, true);
    //					            }
    //					        }
    //					    }
    //					}
    //				);
    //如果不是好友则显示加为好友按钮
    Core.Session.GetGlobal("FriendsInfoCache").GetFriends(
            function () {
                var fi = Core.Session.GetGlobal("FriendsInfoCache").GetFriendInfo(config.Peer.Name);
                m_Toolbar.SetButtonVisible(4, config.Peer.Type == 0 && fi == null);
            });
    //by  2011-4-12  增加成员管理功能
    m_Toolbar.SetButtonVisible(5, false);
    if (config.Peer.Type == 1 && config.Peer.GroupCreator == config.User.Name) {
        m_Toolbar.SetButtonVisible(5, true);
    }
    //by fj 2011-4-29 增加成员管理功能
    if (config.Peer.Type == 2 && config.Peer.GroupCreator == config.User.Name) {
        m_Toolbar.SetButtonVisible(5, true);
    }
    //by 2011-4-12 增加聊天窗口退出群功能
    m_Toolbar.SetButtonVisible(7, false);
    //修改为根据群组设置,如果可以退出才显示该按钮
    if ((config.Peer.Type == 1 || config.Peer.Type == 2) && config.Peer.GroupCreator != config.User.Name && config.Peer.IsExitGroup == true) {
        m_Toolbar.SetButtonVisible(7, true);
    }
    m_Toolbar.OnCommand.Attach(
        function (command) {
            if (command == "AddFriend") {
                Core.Session.GetGlobal("SingletonForm").ShowAddFriendForm(m_Peer.Name);
            } //管理群成员
            else if (command == "GroupMemberManage") {
                var config = {
                    Left: 0, Top: 0,
                    Width: 500, Height: 440,
                    MinWidth: 500, MinHeight: 440,
                    Title: {
                        InnerHTML: "管理群/讨论组成员"
                    },
                    Resizable: false,
                    HasMaxButton: false,
                    HasMinButton: true,
                    AnchorStyle: Core.WindowAnchorStyle.Left | Core.WindowAnchorStyle.Top
                }

                var form = Core.CreateWindow(config);
                //form.MoveEx('CENTER', 0, 0, true);
                //form.Show();
                form.ShowDialog(CurrentWindow, 'CENTER', 0, 0, true, null);
                var url = Core.GetPageUrl(String.format("Management/AddMemberToGroup.aspx?random={0}&Name={1}", (new Date()).getTime(), m_Peer.Name));
                form.Load(url, null);
            } //退出群组 by fj 2011-4-18
            else if (command == "ExitGroup") {
                var data = {
                    Action: "ExitGroup",
                    GroupName: m_Peer.Name
                };

                function Send_Error(ex) {
                    alert(ex);
                }

                function Send_Callback(data) {
                    alert("退出成功!");
                    Core.Session.GetGlobal("FriendsInfoCache").Refresh();
                    CurrentWindow.Close();
                }

                Core.SendCommand(Send_Callback, Send_Error, Core.Utility.RenderJson(data), "Core.Web Common_CH", false);
            }
            else if (command == "CreateTempGroup") { //创建临时组by fj 2011-5-5  
                var config = {
                    Left: 0, Top: 0,
                    Width: 500, Height: 440,
                    MinWidth: 500, MinHeight: 440,
                    Title: {
                        InnerHTML: "创建讨论组"
                    },
                    Resizable: false,
                    HasMaxButton: false,
                    HasMinButton: true,
                    AnchorStyle: Core.WindowAnchorStyle.Left | Core.WindowAnchorStyle.Top
                }

                var form = Core.CreateWindow(config);
                form.MoveEx('CENTER', 0, 0, true);
                //form.Show();
                form.ShowDialog(CurrentWindow, 'CENTER', 0, 0, true, null);
                var currentFriend = m_Peer.Type == 0 ? m_Peer.Name : "";
                var url = Core.GetPageUrl(String.format("Management/AddMemberToGroup.aspx?random={0}&Name={1}&&CurrentFriend={2}", (new Date()).getTime(), "", currentFriend));
                form.Load(url, null);
            }
            else if (command == "SendFile") {
                if (ClientMode) {
                    //                    var file = window.external.OpenFile("");
                    //                    if (file != "") {
                    //                        m_MsgPanel.UploadFile(file,
                    //                        function (path) {
                    //                            if (path == "") return;
                    //                            var html = m_MsgEditor.CreateFileHtml([path]);
                    //                            Send(html);
                    //                        });
                    //                    }
                }
                else {
                    var tag = {};
                    tag.AfterUpload = function (path) {
                        form.Close();
                        var html = m_MsgEditor.CreateFileHtml([path]);
                        Send(html);
                    }

                    var form = Core.CreateWindow({
                        Left: 0,
                        Top: 0,
                        Width: 250,
                        Height: 120,
                        Title: {
                            InnerHTML: "请选择要添加的文件..."
                        },
                        Resizable: false,
                        HasMinButton: false,
                        HasMaxButton: false
                    });

                    form.SetTag(tag);
                    form.ShowDialog(CurrentWindow, "center", 0, -10, true, null);
                    form.Load(Core.GetPageUrl("Upload.aspx"), null);
                }
            }
            else if (command == "SendImage") {
                if (ClientMode) {
                    //                    var file = window.external.OpenFile("图片文件|*.png;*.gif;*.jpg;*.jpeg;*.bmp;*.jpe");
                    //                    if (file != "") {
                    //                        var html = String.format("<img src=\"file:///{0}\"/>", file);
                    //                        m_MsgEditor.Append(html);
                    //                    }
                }
                else {
                    var tag = {};
                    tag.AfterUpload = function (path) {
                        form.Close();
                        var imgHTML = String.format("<img src=\"{1}?FileName={0}\"/>", escape(path), Core.GetPageUrl("download.aspx"));
                        m_MsgEditor.Append(imgHTML);
                    }

                    var form = Core.CreateWindow({
                        Left: 0,
                        Top: 0,
                        Width: 300,
                        Height: 130,
                        Title: {
                            InnerHTML: "请选择你要添加的图片..."
                        },
                        Resizable: false,
                        HasMinButton: false,
                        HasMaxButton: false
                    });

                    form.SetTag(tag);
                    form.ShowDialog(CurrentWindow, "center", 0, -10, true, null);
                    form.Load(Core.GetPageUrl("Upload.aspx?Type=Img"), null); //增加数据类型判断
                }
            }
            else if (command == "GradScreen") {
                if (ClientMode) {
                    //                    var file = window.external.GradScreen();
                    //                    if (file != "") {
                    //                        var html = String.format("<img src=\"file:///{0}\"/>", file);
                    //                        m_MsgEditor.Append(html);
                    //                    }
                }
            }
            else if (command == "MsgRecord") {
                Core.Session.GetGlobal("SingletonForm").ShowMsgHistoryForm(m_Peer);
            }
        }
    )

    This.Resize(width, height);

    var split = Controls.CreateHorizSplit(m_MsgPanel, m_MsgEditor, false);

    var m_User = config.User;
    var m_Peer = config.Peer;

    var m_From = new Date(0);
    var m_ErrorCount = 0;
    var m_RecordMaxTime = null;

    m_MsgPanel.OnCommand.Attach(
    function (cmd, msg) {
        if (cmd == "AddFriend") {
            if (msg.Sender.ID != Core.Session.GetUserInfo().ID) {
                Core.Session.GetGlobal("SingletonForm").ShowAddFriendForm(msg.Sender.Name);
            }
        }
        else if (cmd == "Chat") {
            if (msg.Sender.ID != Core.Session.GetUserInfo().ID) {
                Core.Session.GetGlobal("ChatService").Open(msg.Sender.Name);
            }
        }
        else if (cmd == "Quote") {
            msg.Content = msg.Content.replace(/\x5BFILE\x3A[^\t\n\r\f\v\x5B\x5D]+\x5D/ig,
            function (val) {
                var file = val.substr(6, val.length - 7);
                return String.format(
                FileHtmlFormat, Core.Path.GetFileName(unescape(file)), file);
            });

            msg.Content = msg.Content.replace(/\x5BA\x3A[^\t\n\r\f\v\x5B\x5D]+\x5D/ig,
            function (val) {
                var file = val.substr(3, val.length - 4);
                return String.format("<a target='_blank' href='{0}' onclick='return window.OpenLink(this.href);'>", unescape(file));
            });

            msg.Content = msg.Content.replace(/\x5B\x2FA\x5D/ig,
            function (val) {
                return "</a>";
            });

            var html = String.format(MessageFormat, Core.Utility.IsNull(msg.Sender.Nickname, msg.Sender.Name), DateToString(msg.CreatedTime == undefined ? new Date() : msg.CreatedTime), msg.Content);
            html = String.format("<div class='message_quote'><div class='message'>{0}</div></div>", html);
            m_MsgEditor.Append(html);
        }
    });
    //回车提交
    m_MsgEditor.OnKeyDown.Attach(function (evt) {
        if (evt.keyCode == 13 && !evt.ctrlKey && !evt.altKey && !evt.shiftKey) {
            Core.Utility.PreventDefault(evt);
            setTimeout(m_BtnSend.Click, 1);
        }
    });

    function MsgSort(msg1, msg2) {
        if (msg1.CreatedTime > msg2.CreatedTime) return 1;
        if (msg1.CreatedTime < msg2.CreatedTime) return -1;
        return 0;
    }

    function Send(content) {
        var data = {
            Action: "NewMessage",
            Sender: m_User.Name,
            Receiver: m_Peer.Name
        };

        data.Content = TranslateMessage(content, data);

        var temp = m_MsgPanel.CreateMessage(data.Content);
        m_MsgEditor.SetValue(" ");

        function Send_Error(ex) {
            alert(ex);
        }

        function Send_Callback(data) {
            var message = data;
            m_MsgPanel.AddMessage(message, temp);
        }

        Core.SendCommand(Send_Callback, Send_Error, Core.Utility.RenderJson(data), "Core.Web WebIM", false);
    }

    This.AddMessage = function (msg) {
        m_MsgPanel.AddMessage(msg);
        CurrentWindow.Notify();
    }
    //如果是客户端模式,则显示截图按钮
    m_Toolbar.SetButtonVisible(2, ClientMode);

}

function MsgPanel(config) {
    var This = this;
    var OwnerForm = this;

    if (config.BorderWidth == undefined) config.BorderWidth = 1;
    config.Css = "MsgPanel";

    var m_User = config.User;
    var m_Peer = config.Peer;

    var width = config.Width, height = config.Height;
    config.Width = 200;
    config.Height = 200;

    Controls.Frame.call(This, config);

    var Base = {
        GetType: This.GetType,
        is: This.is
    };

    This.GetType = function () { return "MsgPanel"; }
    This.is = function (type) { return type == This.GetType() ? true : Base.is(type); }

    This.Resize(width, height);

    var msg_css = Core.Utility.IsNull(config.MessageCss, "message");

    This.OnCommand = new Core.Delegate();

    This.Clear = function () {
        This.GetDocument().body.innerHTML = "";
    }

    This.CreateMessage = function (content) {
        content = content.replace(/<img\s[^<>]*>/ig,
        function (val) {
            return String.format("<img src='{0}'/>", Core.GetUrl("Themes/Default/WebIM/loading_img.gif"));
        });

        content = content.replace(/\x5BFILE\x3A\s*\{Accessory\s+type=\"file\"\s+src=\"([^\t\n\r\f\v\x5B\x5D]+)\"\}\x5D/ig,
        function (val, file) {
            return String.format("<div class='div_filename'><img src='{0}'/></div>", Core.GetUrl("Themes/Default/WebIM/loading_file.gif"), file);
        });

        var msgDiv = This.GetDocument().createElement("DIV");
        msgDiv.className = msg_css;
        msgDiv.innerHTML = String.format("<div class='messageTitle'>" + "<span class='sender'>{0}</span>" + "<span class='time'>{1}</span>" + "<div class='operationContainer' style='display:none;'>" + "</div>" + "</div>" + "<div class='messageContent'>{2}" + "</div>", m_User.Nickname, DateToString(new Date()), content);
        This.GetDocument().body.appendChild(msgDiv);
        This.GetDocument().body.scrollTop = This.GetDocument().body.scrollHeight;
        return msgDiv;
    }

    This.AddMessage = function (msg, temp, custom) {
        msg.Content = msg.Content.replace(/\x5BFILE\x3A[^\t\n\r\f\v\x5B\x5D]+\x5D/ig,
        function (val) {
            //替换+号转换 by fj 2011-4-19  解决文件乱码
            val = val.replace("+", "%2B");
            var file = val.substr(6, val.length - 7);
            return String.format(
            FileHtmlFormat, Core.Path.GetFileName(unescape(file)), file);
        });

        msg.Content = msg.Content.replace(/\x5BA\x3A[^\t\n\r\f\v\x5B\x5D]+\x5D/ig,
        function (val) {
            var file = val.substr(3, val.length - 4);
            return String.format("<a target='_blank' href='{0}' onclick='return window.OpenLink(this.href);'>", unescape(file));
        });

        msg.Content = msg.Content.replace(/\x5B\x2FA\x5D/ig,
        function (val) {
            return "</a>";
        });

        var msgDiv = This.GetDocument().createElement("DIV");
        msgDiv.className = msg_css;
        msgDiv.innerHTML = String.format(MessageFormat, Core.Utility.IsNull(msg.Sender.Nickname, msg.Sender.Name), DateToString(msg.CreatedTime == undefined ? new Date() : msg.CreatedTime), msg.Content, Module.GetResourceUrl("WebIM/user.png"));

        if (config.Operations != undefined) {
            var opeContainer = msgDiv.firstChild.childNodes[2];
            opeContainer.style.display = "none";

            msgDiv.onmousemove = function () {
                opeContainer.style.display = "inline";
            }

            msgDiv.onmouseout = function () {
                opeContainer.style.display = "none";
            }

            var opeHtml = "";
            for (var i in config.Operations) {
                var opeA = This.GetDocument().createElement("A");
                opeA.innerHTML = config.Operations[i].Text;
                opeContainer.appendChild(opeA);

                (function (command, msg, opeA) {
                    opeA.onclick = function () {
                        This.OnCommand.Call(command, msg);
                    }
                })(config.Operations[i].Command, msg, opeA);
            }

            if (custom != undefined) {
                msgDiv.appendChild(custom);
            }
        }

        if (temp == undefined) This.GetDocument().body.appendChild(msgDiv);
        else This.GetDocument().body.replaceChild(msgDiv, temp);

        //msgDiv.scrollIntoView();
        This.GetDocument().body.scrollTop = This.GetDocument().body.scrollHeight;
        msgDiv = null;
    }

    This.AddDom = function (dom) {
        This.GetDocument().body.appendChild(dom);

        This.GetDocument().body.scrollTop = This.GetDocument().body.scrollHeight;

        msgDiv = null;
    }

    This.Link("StyleSheet", Core.GetUrl("Themes/Default/EditorCss.css"), "text/css");

    This.GetDocument().onkeydown = function (e) {
        var evt = new Core.Event(e, This.GetWindow());
        if (evt.GetEvent().keyCode == 116 || (evt.GetEvent().ctrlKey && evt.GetEvent().keyCode == 82)) {
            evt.GetEvent().keyCode = 0;
            evt.GetEvent().returnValue = false;
            return false;
        }
        if (evt.GetEvent().keyCode == 70 && evt.GetEvent().ctrlKey && !evt.GetEvent().altKey && !evt.GetEvent().shiftKey) {
            evt.GetEvent().keyCode = 0;
            evt.GetEvent().returnValue = false;
            return false;
        }
    }

    function UploadHandler(file, afterUpload) {
        var html = String.format("<div class='dl_image_dl'></div><div class='dl_text'><span class='span_normal'>正在上传 \"{0}\"...</span><span class='processing'></span><a>取消</a></div>", file, Module.GetResourceUrl("WebIM/dl_file.gif"));
        var dom = This.GetDocument().createElement("DIV");
        dom.className = 'message_file_dl';
        dom.innerHTML = html;

        var info_dom = dom.childNodes[1].childNodes[0];
        var pdom = dom.childNodes[1].childNodes[1];
        var a_dom = dom.childNodes[1].childNodes[2];
        var img_dom = dom.childNodes[0];

        var _isCanceled = false;
        a_dom.onclick = function () {
            _isCanceled = true;
        }

        var _recv = 0,
        _total = 0;

        this.BeforeUpload = function () {
            This.AddDom(dom);
        }

        this.Processing = function (length, size, speed) {
            _recv = length;
            _total = size;
            var temp;
            if (size > 1024 * 1024 * 1024) temp = Math.round(size / (1024 * 1024 * 1024) * 100) / 100 + "GB";
            else if (size > 1024 * 1024) temp = Math.round(size / (1024 * 1024) * 100) / 100 + "MB";
            else if (size > 1024) temp = Math.round(size / 1024 * 100) / 100 + "KB";
            else temp = size + "B";
            pdom.innerHTML = String.format("上传速度:{2}KB/s 已完成:{0}%, 共 {1}", (Math.round(length / size * 1000) / 10), temp, Math.round(speed / 10) / 100);
            return _isCanceled ? 0 : 1;
        }

        this.AfterUpload = function (path) {
            info_dom.innerHTML = String.format(_recv == _total ? "\"{0}\" 上传完毕" : "\"{0}\" 上传已取消！", file);
            info_dom.className = (_recv == _total ? "span_normal" : "span_red");
            pdom.innerHTML = "";
            a_dom.style.display = 'none';
            img_dom.className = (_recv == _total ? "dl_image_file" : "dl_image_cancel");
            if (afterUpload != undefined) afterUpload(path);
        }

        this.HandleError = function (msg) {
            info_dom.className = "span_red";
            info_dom.innerHTML = String.format("上传 \"{0}\" 时发生错误: {1}", file, msg);
            pdom.innerHTML = "";
            a_dom.style.display = 'none';
            img_dom.className = "dl_image_error";
        }
    }

    This.UploadFile = function (file, afterUpload) {
        //        if (ClientMode) {
        //            var handler = new UploadHandler(Core.Path.GetFileName(file), afterUpload);
        //            window.external.Upload(document.cookie, file, handler);
        //        }
    }

    function DownloadHandler(file) {
        var html = String.format("<div class='dl_image_dl'></div><div class='dl_text'><span class='span_normal'>正在下载 \"{0}\"...</span><span class='processing'></span><a>取消</a></div>", file, Module.GetResourceUrl("WebIM/dl_file.gif"));
        var dom = This.GetDocument().createElement("DIV");
        dom.className = 'message_file_dl';
        dom.innerHTML = html;

        var info_dom = dom.childNodes[1].childNodes[0];
        var pdom = dom.childNodes[1].childNodes[1];
        var a_dom = dom.childNodes[1].childNodes[2];
        var img_dom = dom.childNodes[0];

        var _isCanceled = false;
        a_dom.onclick = function () {
            _isCanceled = true;
        }

        var _recv = 0,
        _total = 0;

        this.BeforeDownload = function () {
            This.AddDom(dom);
        }

        this.Processing = function (length, size, speed) {
            _recv = length;
            _total = size;
            var temp;
            if (size > 1024 * 1024 * 1024) temp = Math.round(size / (1024 * 1024 * 1024) * 100) / 100 + "GB";
            else if (size > 1024 * 1024) temp = Math.round(size / (1024 * 1024) * 100) / 100 + "MB";
            else if (size > 1024) temp = Math.round(size / 1024 * 100) / 100 + "KB";
            else temp = size + "B";
            pdom.innerHTML = String.format("下载速度:{2}KB/s 已完成:{0}%, 共 {1}", (Math.round(length / size * 1000) / 10), temp, Math.round(speed / 10) / 100);
            return _isCanceled ? 0 : 1;
        }

        this.AfterDownload = function () {
            info_dom.innerHTML = String.format(_recv == _total ? "\"{0}\" 下载完毕" : "\"{0}\" 下载已取消！", file);
            info_dom.className = (_recv == _total ? "span_normal" : "span_red");
            pdom.innerHTML = "";
            a_dom.style.display = 'none';
            img_dom.className = (_recv == _total ? "dl_image_file" : "dl_image_cancel");
        }

        this.HandleError = function (msg) {
            info_dom.className = "span_red";
            info_dom.innerHTML = String.format("下载 \"{0}\" 时发生错误: {1}", file, msg);
            pdom.innerHTML = "";
            a_dom.style.display = 'none';
            img_dom.className = "dl_image_error";
        }
    }

    This.GetWindow().OpenLink = function (filePath) {
        return confirm(String.format("您确定要打开\"{0}\"？", filePath));
    }

    This.GetWindow().SaveFile = function (filePath) {
        //        if (ClientMode) {
        //            window.external.Save(document.cookie, Core.GetPageUrl("download.aspx") + "?FileName=" + filePath, Core.Path.GetFileName(filePath), new DownloadHandler(Core.Path.GetFileName(filePath)));
        //        }
    }
    This.GetWindow().OpenFile = function (filePath) {
        //        if (ClientMode) {
        //            window.external.Open(document.cookie, Core.GetPageUrl("download.aspx") + "?FileName=" + filePath, Core.Path.GetFileName(filePath), new DownloadHandler(Core.Path.GetFileName(filePath)));
        //        }
    }

}

function MsgEditor(config) {
    var This = this;
    var OwnerForm = this;

    config.StyleSheet = Core.GetUrl("Themes/Default/EditorCss.css");

    var width = config.Width, height = config.Height;
    config.Width = 200;
    config.Height = 200;

    RichEditor.call(This, config);

    var Base = {
        GetType: This.GetType,
        is: This.is
    };

    This.GetType = function () { return "MsgEditor"; }
    This.is = function (type) { return type == This.GetType() ? true : Base.is(type); }

    This.Resize(width, height);

    This.CreateFileHtml = function (paths) {
        var fs = [];
        for (var i in paths) {
            var html = "<div contenteditable='false' class='message_file'>" + String.format("[FILE:{0}]", paths[i]) + "</div>";
            fs.push(html);
        }
        return "<br/>" + fs.join("<br/>") + "<br/>";
    }

}

Module.MsgHistroyPanel = MsgHistroyPanel;

function MsgHistroyPanel(config) {
    var This = this;
    var OwnerForm = this;

    var width = config.Width, height = config.Height;
    config.Width = 615;
    config.Height = 449;

    Control.call(This, config);

    var Base = {
        GetType: This.GetType,
        is: This.is
    };

    This.GetType = function () { return "MsgHistroyPanel"; }
    This.is = function (type) { return type == This.GetType() ? true : Base.is(type); }

    var m_MsgPanel_Config = { "Left": 211, "Top": 26, "Width": 398, "Height": 418, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top | Controls.AnchorStyle.Bottom, "Parent": This, "Text": "", "Css": "control" };
    //增加回复按钮 by fj 2011-6-16
    m_MsgPanel_Config.Operations = [{
        Text: "回复",
        Command: "Chat"
    }];

    var m_MsgPanel = new MsgPanel(m_MsgPanel_Config);
    //增加事件处理 by fj 2011-6-16
    m_MsgPanel.OnCommand.Attach(function (command, user) {
        if (command == "Chat") {
            if (user.Sender.ID != Core.Session.GetUserInfo().ID) {
                Core.Session.GetGlobal("ChatService").Open(user.Sender.Name)
            }
        }
    });

    var toolbar3 = new Controls.Toolbar({ "Left": 6, "Top": 1, "Width": 603, "Height": 24, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top, "Parent": This, "Text": "", "Css": "toolbar", "Items": [{ "Text": "上一页", "Css": "Image22_UpButton", "Command": "Previous" }, { "Text": "下一页", "Css": "Image22_DownButton", "Command": "Next" }] });

    toolbar3.OnCommand.Attach(
        function (command) {
            if (command == "Previous") {
                if (m_Messages.length > 0) {
                    m_From = new Date(2000, 0, 1);
                    m_To = m_Messages[m_Messages.length - 1].CreatedTime;
                }
                RefreshMessages();
            }
            else if (command == "Next") {
                if (m_Messages.length > 0) {
                    m_To = new Date(2100, 0, 1);
                    m_From = m_Messages[0].CreatedTime;
                }
                RefreshMessages();
            }
            else if (command == "Search") {
                m_MsgSearchPanel.SetVisible(true);
                m_MsgPanel.SetVisible(false);
                toolbar3.SetVisible(false);
                tab4.SetVisible(false);
            }
        }
    )

    var tab4 = new Controls.SimpleTabControl({ "Left": 6, "Top": 26, "Width": 200, "Height": 418, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Top | Controls.AnchorStyle.Bottom, "Parent": This, "Text": "", "Css": "simple_tab", "Tabs": [{ "Text": "我的好友", "Width": 80, "ID": "ID100000018", "IsSelected": true }, { "Text": "组织机构", "Width": 80, "ID": "ID100000019", "IsSelected": false}], "BorderWidth": 1 });

    tab4.OnSelectedTab.Attach(
        function (index, preIndex) {

        }
    )
    var m_FriendPanel_Config = { "Left": 1, "Top": 1, "Width": 200, "Height": 391, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top | Controls.AnchorStyle.Bottom, "Parent": tab4.GetPanel(0), "Text": "", "Css": "control" };

    m_FriendPanel_Config.DSConfig = {
        ShowState: true
    };

    var m_FriendPanel = new FriendPanel(m_FriendPanel_Config);


    var m_DeptPanel_Config = { "Left": 1, "Top": 1, "Width": 200, "Height": 392, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top | Controls.AnchorStyle.Bottom, "Parent": tab4.GetPanel(1), "Text": "", "Css": "control" };

    m_DeptPanel_Config.DSConfig = {
        ShowState: true
    };

    var m_DeptPanel = new DeptPanel(m_DeptPanel_Config);
    //增加搜索面板 by fj 2011-6-16
    var m_MsgSearchPanel_config = {
        Left: 0,
        Top: 0,
        Width: 615,
        Height: 449,
        AnchorStyle: Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top | Controls.AnchorStyle.Bottom,
        Parent: This,
        Text: "",
        Css: "control"
    };
    m_MsgSearchPanel_config.HistoryPanel = This;
    var m_MsgSearchPanel = new MsgSearchPanel(m_MsgSearchPanel_config);
    m_MsgSearchPanel.GetDom().style.zIndex = "100";
    m_MsgSearchPanel.SetVisible(false);

    This.View = function (peer) {
        if (peer.Receiver.Type == 1) {
            m_Peer = peer.Receiver.Name
        }
        else {
            m_Peer = peer.Receiver.ID == Core.Session.GetUserInfo().ID ? peer.Sender.Name : peer.Receiver.Name
        }
        m_To = new Date(2900, 0, 1);
        m_From = peer.CreatedTime;
        RefreshMessages();
    };

    This.PanelIsDisplay = function (display) {
        m_MsgPanel.SetVisible(display);
        toolbar3.SetVisible(display);
        tab4.SetVisible(display);
    };

    //end
    This.Resize(width, height);

    m_FriendPanel.Refresh(function () {
        m_FriendPanel.Expand(EmptyCallback, "/Users");
        m_FriendPanel.Expand(EmptyCallback, "/Groups");
        m_FriendPanel.Expand(EmptyCallback, "/TempGroups");
    });

    //实现treeview刷新函数
    m_DeptPanel.Refresh(function () {
        m_DeptPanel.Expand(EmptyCallback, "/Depts"); //展开该路径下所有的节点
        //            m_DeptPanel.Expand(EmptyCallback, "/Groups");
    });

    var m_Peer = Core.Utility.IsNull(Core.Params["Peer"], "");

    var m_To = new Date(2900, 0, 1);
    var m_From = new Date(2000, 0, 1);

    var m_Messages = [];

    function RefreshMessages() {
        if (m_Peer == "") return;
        var data = {
            Action: "FindHistory",
            User: Core.Session.GetUserName(),
            Peer: m_Peer,
            From: m_From,
            To: m_To
        };
        Core.SendCommand(
        function (ret) {
            m_FriendPanel.Select(EmptyCallback, (Core.Params["Type"] == "0" ? "/Users/" : "/Groups/") + m_Peer.toUpperCase());
            m_MsgPanel.Clear();
            for (var i = ret.Messages.length - 1; i >= 0; i--) {
                m_MsgPanel.AddMessage(ret.Messages[i]);
            }
            m_Messages = ret.Messages;
        },
        function (ex) {
            Core.Utility.ShowError(ex.toString());
        },
        Core.Utility.RenderJson(data), "Core.Web Common_CH", false);
    }

    m_FriendPanel.OnClick.Attach(
    function () {
        m_To = new Date(2100, 0, 1);
        m_From = new Date(2000, 0, 1);
        var node = m_FriendPanel.GetSelectedNode();
        if (node != null && node.GetTag() != null) {
            m_Peer = node.GetTag().Name;
            RefreshMessages();
        }
    });
    //by fj 2011-3-29  添加组织架构的人员点击获取聊天记录
    m_DeptPanel.OnClick.Attach(
    function () {
        m_To = new Date(2100, 0, 1);
        m_From = new Date(2000, 0, 1);
        var node = m_DeptPanel.GetSelectedNode();
        if (node != null && node.GetTag() != null) {
            if (node.GetTag().Name != "Depts" && node.GetTag().DType == 1) {
                m_Peer = node.GetTag().Name;
                RefreshMessages();
            }
        }
    });
    //Controls.CreateVerticalSplit(m_FriendPanel, m_MsgPanel);

    RefreshMessages();

}
function FriendPanel(config) {
    var This = this;
    var OwnerForm = this;

    var width = config.Width, height = config.Height;
    config.Width = 200;
    config.Height = 200;

    Management.FriendPanel.call(This, config);

    var Base = {
        GetType: This.GetType,
        is: This.is
    };

    This.GetType = function () { return "FriendPanel"; }
    This.is = function (type) { return type == This.GetType() ? true : Base.is(type); }

    This.Resize(width, height);
}

Module.GroupChatForm = GroupChatForm;

function GroupChatForm(config) {
    var This = this;
    var OwnerForm = this;

    var width = config.Width, height = config.Height;
    config.Width = 650;
    config.Height = 500;

    Control.call(This, config);

    var Base = {
        GetType: This.GetType,
        is: This.is
    };

    This.GetType = function () { return "GroupChatForm"; }
    This.is = function (type) { return type == This.GetType() ? true : Base.is(type); }

    // var tab1 = new Controls.SimpleTabControl({ "Left": 1, "Top": 1, "Width": 463, "Height": 498, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top | Controls.AnchorStyle.Bottom, "Parent": This, "Text": "", "Css": "simple_tab_gred", "Tabs": [{ "Text": "对话窗口", "Width": 80, "ID": "ID100000007", "IsSelected": true}], "BorderWidth": 1 });
    //by fj 2011-6-15增加聊天记录窗口
    var tab1 = new Controls.SimpleTabControl({ "Left": 1, "Top": 1, "Width": 463, "Height": 498, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top | Controls.AnchorStyle.Bottom, "Parent": This, "Text": "", "Css": "simple_tab_gred", "Tabs": [{ "Text": "会话窗口", "Width": 80, "ID": "ID100000010", "IsSelected": true }, { "Text": "会话记录", "Width": 80, "ID": "ID100000012", "IsSelected": false }, { "Text": "群共享", "Width": 80, "ID": "ID100000113", "IsSelected": false}], "BorderWidth": 1 });

    tab1.OnSelectedTab.Attach(
        function (index, preIndex) {
            //by fj 2011-6-15增加聊天记录窗口
            if (index == 1) {
                var data = {
                    Action: "FindHistory",
                    User: Core.Session.GetUserInfo().Name,
                    Peer: config.Peer.Name,
                    From: new Date(2000, 0, 1),
                    To: new Date(2100, 0, 1),
                    All: true
                };

                CurrentWindow.Waiting("正在载入消息记录...");
                Core.SendCommand(
                function (ret) {
                    CurrentWindow.Completed();

                    m_MsgPanel.Clear();
                    for (var i = ret.Messages.length - 1; i >= 0; i--) {
                        m_MsgPanel.AddMessage(ret.Messages[i]);
                    }
                },
                function (ex) {
                    CurrentWindow.Completed();
                    Core.Utility.ShowError(ex.toString());
                },
                Core.Utility.RenderJson(data), "Core.Web Common_CH", false);
            } else if (index == 2) {
                CurrentWindow.Waiting("正在载入文件列表...");
                var url = String.format("Management/GroupShare.aspx?GroupId={1}&random={0}", (new Date()).getTime(), config.Peer.ID);
                frameShare.Navigate(Core.GetPageUrl(url));
            }
            //end
        }
    )

    var m_ChatPanel_Config = { "Left": 8, "Top": 5, "Width": 444, "Height": 459, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top | Controls.AnchorStyle.Bottom, "Parent": tab1.GetPanel(0), "Text": "", "Css": "control" };

    m_ChatPanel_Config.User = config.User
    m_ChatPanel_Config.Peer = config.Peer;

    var m_ChatPanel = new ChatPanel(m_ChatPanel_Config);

    //by fj 2011-6-15增加聊天记录窗口
    var m_MsgPanel_Config = { "Left": 8, "Top": 30, "Width": 444, "Height": 434, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top | Controls.AnchorStyle.Bottom, "Parent": tab1.GetPanel(1), "Text": "", "Css": "control" };
    var m_MsgPanel = new MsgPanel(m_MsgPanel_Config);

    //by fj 2011-7-31 增加共享窗口
    var frameShare_Config = { "Left": 1, "Top": 1, "Width": 458, "Height": 470, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top | Controls.AnchorStyle.Bottom, "Parent": tab1.GetPanel(2), "Text": "", "Css": "control" };
    var frameShare = new Controls.Frame(frameShare_Config);
    frameShare.OnResized.Attach(
        function (btn) {

        }
    )
    tab1.Select(0);
    tab1.SetTabVisible(2, config.Peer.Type == 1);
    //end

    var toolbar7 = new Controls.Toolbar({ "Left": 8, "Top": 5, "Width": 443, "Height": 24, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top, "Parent": tab1.GetPanel(1), "Text": "", "Css": "toolbar", "Items": [{ "Text": "保存聊天记录", "Css": "Image22_SaveAs", "Command": "SaveAs" }, { "Text": "上一页", "Css": "Image22_UpButton", "Command": "Previous" }, { "Text": "下一页", "Css": "Image22_DownButton", "Command": "Next"}] });
    toolbar7.OnCommand.Attach(
        function (command) {
            if (command == "SaveAs") {
                var url = String.format("DownloadMsg.ashx?Peer={0}&random={1}", config.Peer.ID, (new Date()).getTime());
                m_MsgPanel.Navigate(Core.GetPageUrl(url));
            }
            else if (command == "Previous") {
                if (m_Messages.length > 0) {
                    m_From = new Date(2000, 0, 1);
                    m_To = m_Messages[m_Messages.length - 1].CreatedTime;
                }
                RefreshMessages();
            }
            else if (command == "Next") {
                if (m_Messages.length > 0) {
                    m_To = new Date(2100, 0, 1);
                    m_From = m_Messages[0].CreatedTime;
                }
                RefreshMessages();
            }
        }
    )
    var m_Peer = config.Peer.Name;
    var m_To = new Date(2100, 0, 1);
    var m_From = new Date(2000, 0, 1);

    var m_Messages = [];

    function RefreshMessages() {
        if (m_Peer == "") return;
        var data = {
            Action: "FindHistory",
            User: Core.Session.GetUserName(),
            Peer: m_Peer,
            From: m_From,
            To: m_To
        };
        Core.SendCommand(
        function (ret) {
            m_MsgPanel.Clear();
            for (var i = ret.Messages.length - 1; i >= 0; i--) {
                m_MsgPanel.AddMessage(ret.Messages[i]);
            }
            m_Messages = ret.Messages;
        },
        function (ex) {
            Core.Utility.ShowError(ex.toString());
        },
        Core.Utility.RenderJson(data), "Core.Web Common_CH", false);
    }

    //end
    var m_GroupMemberList_Config = { "Left": 469, "Top": 1, "Width": 180, "Height": 498, "AnchorStyle": Controls.AnchorStyle.Right | Controls.AnchorStyle.Top | Controls.AnchorStyle.Bottom, "Parent": This, "Text": "", "Css": "control" };

    m_GroupMemberList_Config.BorderWidth = 1;
    m_GroupMemberList_Config.Group = config.Peer;

    var m_GroupMemberList = new GroupMemberList(m_GroupMemberList_Config);

    This.Resize(width, height);

    This.AddMessage = m_ChatPanel.AddMessage;
    //by fj 2011-4-7 增加在线实时状态显示
    CurrentWindow.OnNotify.Attach(
            function (command, data) {
                if (command == "UserStateChanged") {
                    m_GroupMemberList.RefreshMemberState(data.User, data.State);
                }
                //增加群成员刷新 by fj 2011-4-13
                if (command == "GroupMemberChanged") {
                    m_GroupMemberList.RefreshMemberTreeView();
                }
            });

}

function GroupMemberList(config) {
    var This = this;
    var OwnerForm = this;

    config.Css = "GroupMemberList";

    var width = config.Width, height = config.Height;
    config.Width = 222;
    config.Height = 556;

    Control.call(This, config);

    var Base = {
        GetType: This.GetType,
        is: This.is
    };

    This.GetType = function () { return "GroupMemberList"; }
    This.is = function (type) { return type == This.GetType() ? true : Base.is(type); }

    var m_GroupMemberTreeView_DS = function () {
        var _members = null;
        var _groupInfo = null;
        var _groupCreator = null;
        //清除缓存
        this.Clear = function () {
            _members = null;
        }
        function _GetSubNodes(callback, item) {
            var nodes = [];
            if (item.GetFullPath() == "/Managers") {
                for (var i in _members) {
                    var member = _members[i];
                    if (member.ID == _groupCreator.ID) {
                        var node = {
                            Name: member.Name.toUpperCase(),
                            Text: member.Nickname,
                            Tag: member,
                            HasChildren: false,
                            Tootip: {
                                Content: member.Phone
                            },
                            ImageSrc: GetHeadIMG(member, 16, member.State == "Offline")
                        };
                        //ImageSrc: String.format("{0}?user={1}&gred=false&size=16&headimg={2}", Core.GetPageUrl("headimg.aspx"), member.Name, member.HeadIMG)
                        nodes.push(node);
                    }
                }
            }
            else if (item.GetFullPath() == "/Members") {
                for (var i in _members) {
                    var member = _members[i];
                    if (member.ID != _groupCreator.ID) {
                        var node = {
                            Name: member.Name.toUpperCase(),
                            Text: member.Nickname,
                            Tag: member,
                            HasChildren: false,
                            Tootip: {
                                Content: member.Phone
                            },
                            ImageSrc: GetHeadIMG(member, 16, member.State == "Offline")
                        };
                        //ImageSrc: String.format("{0}?user={1}&gred=false&size=16&headimg={2}", Core.GetPageUrl("headimg.aspx"), member.Name, member.HeadIMG)
                        nodes.push(node);
                    }
                }
            }
            callback(nodes);
        }

        this.GetSubNodes = function (callback, item) {
            if (item == null) {
                var nodes = [{
                    Name: "Managers",
                    Text: "群管理员",
                    Tag: null,
                    ImageCss: "Image16_Group"
                },
                {
                    Name: "Members",
                    Text: "群组成员",
                    Tag: null,
                    ImageCss: "Image16_Group"
                }];
                callback(nodes);
            }
            else {
                if (_members == null) {
                    var data = {
                        Action: "GetGroupMembers",
                        Name: config.Group.Name
                    };
                    Core.SendCommand(
                            function (ret) {
                                _members = ret.Members;
                                _gourpInfo = ret.GroupInfo;
                                _groupCreator = ret.GroupCreator;
                                _GetSubNodes(callback, item);
                            },
                            function (ex) {
                                callback(null, ex);
                            },
                             Core.Utility.RenderJson(data), "Core.Web Common_CH", false);
                }
                else {
                    _GetSubNodes(callback, item);
                }
            }
        }
    }
    var dataSource = new m_GroupMemberTreeView_DS();
    var m_GroupMemberTreeView = new Controls.TreeView({ "Left": 1, "Top": 22, "Width": 220, "Height": 533, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top | Controls.AnchorStyle.Bottom, "Parent": This, "Text": "", "Css": "treeview", "BorderWidth": 0, "DataSource": dataSource });

    //增加个人信息显示 by fj 2011-5-3
    var tip = null;
    m_GroupMemberTreeView.OnClick.Attach(
      	function () {
      	    if (m_GroupMemberTreeView.GetSelectedNode().GetTag() != null) {   //如果是用户才打开窗体
      	        if (m_GroupMemberTreeView.GetSelectedNode().GetTag().Type == 0) {
      	            var user = m_GroupMemberTreeView.GetSelectedNode().GetTag();
      	            var nodename = "node" + user.Name.toUpperCase();
      	            var parentnode = m_GroupMemberTreeView.GetSelectedNode().GetParent(); //获得父节点
      	            if (parentnode != null) {//如果父节点的Tag为空
      	                nodename = "node" + parentnode.GetText().toUpperCase() + user.Name.toUpperCase();
      	            }
      	            if (parentnode != null && parentnode.GetTag() != null) {
      	                nodename = "node" + parentnode.GetTag().Name.toUpperCase() + user.Name.toUpperCase();
      	            }
      	            var ret = GetAbsoluteLocation(document.getElementById(nodename)); //获得控件的绝对位置
      	            var cwintop = CurrentWindow.GetTop();
      	            var cwinwidth = CurrentWindow.GetWidth();
      	            var t = ret.absoluteTop + cwintop - 4; //获得Top
      	            var l = CurrentWindow.GetLeft() + cwinwidth; //ret.absoluteLeft;
      	            if (t > (353 + cwintop - 4))
      	                t = 353 + cwintop - 4;
      	            tip = Core.Session.GetGlobal("SingletonForm").ShowFriendInfoForm(user.Nickname, user.Phone, user.TelPhone, user.EMail, t, l);
      	        }
      	    }
      	}
    )
    //鼠标离开
    m_GroupMemberTreeView.OnMouseout.Attach(
	    function () {
	        if (tip != null)
	            tip.Close();
	    });
    //end
    var m_Header_Config = { "Left": 0, "Top": 0, "Width": 222, "Height": 21, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top, "Parent": This, "Text": "", "Css": "control" };

    m_Header_Config.Text = "群成员列表";

    var m_Header = new HeaderCtrl(m_Header_Config);

    This.Resize(width, height);

    m_GroupMemberTreeView.Refresh(function () {
        m_GroupMemberTreeView.Expand(EmptyCallback, "/Managers");
        m_GroupMemberTreeView.Expand(EmptyCallback, "/Members");
    });

    m_GroupMemberTreeView.OnDblClick.Attach(
        function () {
            if (m_GroupMemberTreeView.GetSelectedNode().GetTag() != null && m_GroupMemberTreeView.GetSelectedNode().GetTag().ID != Core.Session.GetUserInfo().ID) {
                var form = Core.Session.GetGlobal("ChatService").Open(m_GroupMemberTreeView.GetSelectedNode().GetTag().Name, false);
            }
        });



    //by fj 2011-4-7 增加在线实时状态显示
    This.RefreshMemberState = function (memberId, state) {
        m_GroupMemberTreeView.GetAllNodes(function (node) {
            if (node.GetTag() != null && node.GetTag().Name.toUpperCase() == memberId) {
                node.SetImage(GetHeadIMG(node.GetTag(), 16, state == "Offline"))
            }
        });
    }
    //by fj 2011-4-13  增加群成员刷新
    This.RefreshMemberTreeView = function () {
        //清除缓存
        dataSource.Clear();
        m_GroupMemberTreeView.Refresh(function () {
            m_GroupMemberTreeView.Expand(EmptyCallback, "/Managers");
            m_GroupMemberTreeView.Expand(EmptyCallback, "/Members");
        });
    }
}

Module.UserChatForm = UserChatForm;

function UserChatForm(config) {
    var This = this;
    var OwnerForm = this;

    var width = config.Width, height = config.Height;
    config.Width = 650;
    config.Height = 500;

    Control.call(This, config);

    var Base = {
        GetType: This.GetType,
        is: This.is
    };

    This.GetType = function () { return "UserChatForm"; }
    This.is = function (type) { return type == This.GetType() ? true : Base.is(type); }

    // var tab1 = new Controls.SimpleTabControl({ "Left": 1, "Top": 1, "Width": 463, "Height": 498, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top | Controls.AnchorStyle.Bottom, "Parent": This, "Text": "", "Css": "simple_tab_gred", "Tabs": [{ "Text": "对话窗口", "Width": 80, "ID": "ID100000010", "IsSelected": true}], "BorderWidth": 1 });
    //by fj 2011-6-15增加聊天记录窗口
    var tab1 = new Controls.SimpleTabControl({ "Left": 1, "Top": 1, "Width": 463, "Height": 498, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top | Controls.AnchorStyle.Bottom, "Parent": This, "Text": "", "Css": "simple_tab_gred", "Tabs": [{ "Text": "会话窗口", "Width": 80, "ID": "ID100000010", "IsSelected": true }, { "Text": "聊天记录", "Width": 80, "ID": "ID100000012", "IsSelected": false}], "BorderWidth": 1 });

    tab1.OnSelectedTab.Attach(
        function (index, preIndex) {
            //by fj 2011-6-15增加聊天记录窗口
            if (index == 1) {
                var data = {
                    Action: "FindHistory",
                    User: Core.Session.GetUserInfo().Name,
                    Peer: config.Peer.Name,
                    From: new Date(2000, 0, 1),
                    To: new Date(2100, 0, 1),
                    All: true
                };

                CurrentWindow.Waiting("正在载入消息记录...");
                Core.SendCommand(
                function (ret) {
                    CurrentWindow.Completed();

                    m_MsgPanel.Clear();
                    for (var i = ret.Messages.length - 1; i >= 0; i--) {
                        m_MsgPanel.AddMessage(ret.Messages[i]);
                    }
                },
                function (ex) {
                    CurrentWindow.Completed();
                    Core.Utility.ShowError(ex.toString());
                },
                Core.Utility.RenderJson(data), "Core.Web Common_CH", false);
            }
            //end
        }
    )

    var m_ChatPanel_Config = { "Left": 8, "Top": 5, "Width": 444, "Height": 459, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top | Controls.AnchorStyle.Bottom, "Parent": tab1.GetPanel(0), "Text": "", "Css": "control" };

    m_ChatPanel_Config.User = config.User
    m_ChatPanel_Config.Peer = config.Peer;

    var m_ChatPanel = new ChatPanel(m_ChatPanel_Config);

    //by fj 2011-6-15增加聊天记录窗口
    var m_MsgPanel_Config = { "Left": 8, "Top": 30, "Width": 444, "Height": 434, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top | Controls.AnchorStyle.Bottom, "Parent": tab1.GetPanel(1), "Text": "", "Css": "control" };
    var m_MsgPanel = new MsgPanel(m_MsgPanel_Config);

    var toolbar7 = new Controls.Toolbar({ "Left": 8, "Top": 5, "Width": 443, "Height": 24, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top, "Parent": tab1.GetPanel(1), "Text": "", "Css": "toolbar", "Items": [{ "Text": "保存聊天记录", "Css": "Image22_SaveAs", "Command": "SaveAs" }, { "Text": "上一页", "Css": "Image22_UpButton", "Command": "Previous" }, { "Text": "下一页", "Css": "Image22_DownButton", "Command": "Next"}] });
    toolbar7.OnCommand.Attach(
        function (command) {
            if (command == "SaveAs") {
                var url = String.format("DownloadMsg.ashx?Peer={0}&random={1}", config.Peer.ID, (new Date()).getTime());
                m_MsgPanel.Navigate(Core.GetPageUrl(url));
            }
            else if (command == "Previous") {
                if (m_Messages.length > 0) {
                    m_From = new Date(2000, 0, 1);
                    m_To = m_Messages[m_Messages.length - 1].CreatedTime;
                }
                RefreshMessages();
            }
            else if (command == "Next") {
                if (m_Messages.length > 0) {
                    m_To = new Date(2100, 0, 1);
                    m_From = m_Messages[0].CreatedTime;
                }
                RefreshMessages();
            }
        }
    )
    var m_Peer = config.Peer.Name;
    var m_To = new Date(2100, 0, 1);
    var m_From = new Date(2000, 0, 1);

    var m_Messages = [];

    function RefreshMessages() {
        if (m_Peer == "") return;
        var data = {
            Action: "FindHistory",
            User: Core.Session.GetUserName(),
            Peer: m_Peer,
            From: m_From,
            To: m_To
        };
        Core.SendCommand(
        function (ret) {
            m_MsgPanel.Clear();
            for (var i = ret.Messages.length - 1; i >= 0; i--) {
                m_MsgPanel.AddMessage(ret.Messages[i]);
            }
            m_Messages = ret.Messages;
        },
        function (ex) {
            Core.Utility.ShowError(ex.toString());
        },
        Core.Utility.RenderJson(data), "Core.Web Common_CH", false);
    }

    //end

    var m_UserImageCtrl_Config = { "Left": 469, "Top": 319, "Width": 180, "Height": 180, "AnchorStyle": Controls.AnchorStyle.Right | Controls.AnchorStyle.Bottom, "Parent": This, "Text": "", "Css": "control" };

    m_UserImageCtrl_Config.BorderWidth = 1;

    var m_UserImageCtrl = new UserImageCtrl(m_UserImageCtrl_Config);
    m_UserImageCtrl.LoadImage(GetHeadIMG(config.User, 150, config.User.State == "Offline"));
    //m_UserImageCtrl.LoadImage(String.format("{0}?user={1}&gred=false&size=150&headimg={2}", Core.GetPageUrl("headimg.aspx"), config.User.Name, config.User.HeadIMG))


    var m_UserInfoCtrl_Config = { "Left": 469, "Top": 1, "Width": 180, "Height": 314, "AnchorStyle": Controls.AnchorStyle.Right | Controls.AnchorStyle.Top | Controls.AnchorStyle.Bottom, "Parent": This, "Text": "", "Css": "control" };

    m_UserInfoCtrl_Config.BorderWidth = 1;
    m_UserInfoCtrl_Config.User = config.Peer;

    var m_UserInfoCtrl = new UserInfoCtrl(m_UserInfoCtrl_Config);

    This.Resize(width, height);

    This.AddMessage = m_ChatPanel.AddMessage;

    CurrentWindow.OnNotify.Attach(
    function (command, data) {
        if (command == "FriendInfoChanged") {
            /*m_FriendPanel.Refresh(function()
            {
            m_FriendPanel.Expand(EmptyCallback, "/Users");
            m_FriendPanel.Expand(EmptyCallback, "/Groups");
            });*/
        }
        else if (command == "UserInfoChanged") {
            var userInfo = Core.Session.GetUserInfo();
            m_UserImageCtrl.LoadImage(GetHeadIMG(userInfo, 150, data.State == "Offline"));
        } //by fj 2011-4-7 增加在线实时状态显示
        else if (command == "UserStateChanged") {
            if (config.Peer.Name.toUpperCase() == data.User) {
                m_UserInfoCtrl.ResetUserInfo(data.Details);
            }
        }
    });

}

function UserImageCtrl(config) {
    var This = this;
    var OwnerForm = this;

    config.Css = 'UserImageCtrl';

    var width = config.Width, height = config.Height;
    config.Width = 165;
    config.Height = 181;

    Management.ImageControl.call(This, config);

    var Base = {
        GetType: This.GetType,
        is: This.is
    };

    This.GetType = function () { return "UserImageCtrl"; }
    This.is = function (type) { return type == This.GetType() ? true : Base.is(type); }

    This.Resize(width, height);

}

function UserInfoCtrl(config) {
    var This = this;
    var OwnerForm = this;

    config.Css = 'UserInfoCtrl';

    var width = config.Width, height = config.Height;
    config.Width = 200;
    config.Height = 486;

    Control.call(This, config);

    var Base = {
        GetType: This.GetType,
        is: This.is
    };

    This.GetType = function () { return "UserInfoCtrl"; }
    This.is = function (type) { return type == This.GetType() ? true : Base.is(type); }

    var m_ImageCtrl_Config = { "Left": 0, "Top": 0, "Width": 200, "Height": 180, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top, "Parent": This, "Text": "", "Css": "control" };

    m_ImageCtrl_Config.BorderWidth = 0;

    var m_ImageCtrl = new UserImageCtrl(m_ImageCtrl_Config);

    //m_ImageCtrl.LoadImage(String.format("{0}?user={1}&gred=false&size=150&headimg={2}", Core.GetPageUrl("headimg.aspx"), config.User.Name, config.User.HeadIMG));
    m_ImageCtrl.LoadImage(GetHeadIMG(config.User, 150, config.User.State == "Offline"));

    //by fj 2011-4-22  增加显示电话号码
    var m_phone = new Controls.Label({ "Left": 14, "Top": 186, "Width": 188, "Height": 18, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top, "Parent": This, "Text": "", "Css": "label" });

    var m_telphone = new Controls.Label({ "Left": 14, "Top": 206, "Width": 188, "Height": 18, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top, "Parent": This, "Text": "", "Css": "label" });

    // var m_mobilephone = new Controls.Label({ "Left": 14, "Top": 226, "Width": 188, "Height": 18, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Top, "Parent": This, "Text": "", "Css": "label" });

    // var m_email = new Controls.Label({ "Left": 14, "Top": 246, "Width": 188, "Height": 18, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Top, "Parent": This, "Text": "", "Css": "label" });
    var m_email = new Controls.Label({ "Left": 14, "Top": 226, "Width": 188, "Height": 18, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top, "Parent": This, "Text": "", "Css": "label" });

    m_phone.SetText("联系电话:" + config.User.Phone);
    m_telphone.SetText("联系手机:" + config.User.TelPhone);
    // m_mobilephone.SetText("手机:" + config.User.MobilePhone);
    m_email.SetText("EMail:" + config.User.EMail);

    This.Resize(width, height);
    //by fj 2011-4-7 增加在线实时状态显示
    This.ResetUserInfo = function (info) {
        config.User = info;
        m_phone.SetText("联系电话:" + config.User.Phone);
        m_telphone.SetText("联系手机:" + config.User.TelPhone);
        //m_mobilephone.SetText("手机:" + config.User.MobilePhone);
        m_email.SetText("EMail:" + config.User.EMail);
        m_ImageCtrl.LoadImage(GetHeadIMG(config.User, 150, config.User.State == "Offline"));
    }
    //end
    //by fj 2011-7-21  增加点击复制功能
    m_telphone.SetTitle("点击复制");
    m_phone.SetTitle("点击复制");
    m_email.SetTitle("点击复制");
    m_telphone.OnClick.Attach(
        function () {
            var clipBoardContent = "";
            clipBoardContent += m_telphone.GetText().replace("联系手机:", "");
            if (clipBoardContent != "") {
                window.clipboardData.setData("Text", clipBoardContent);
                alert("复制成功!");
            }
        }
    )
    m_phone.OnClick.Attach(
        function () {
            var clipBoardContent = "";
            clipBoardContent += m_phone.GetText().replace("联系电话:", "");
            if (clipBoardContent != "") {
                window.clipboardData.setData("Text", clipBoardContent);
                alert("复制成功!");
            }
        }
    )
    m_email.OnClick.Attach(
        function () {
            var clipBoardContent = "";
            clipBoardContent += m_email.GetText().replace("EMail:", "");
            if (clipBoardContent != "") {
                window.clipboardData.setData("Text", clipBoardContent);
                alert("复制成功!");
            }
        }
    )
    //end
}

function HeaderCtrl(config) {
    var This = this;
    var OwnerForm = this;

    var width = config.Width, height = config.Height;
    config.Width = 146;
    config.Height = 21;

    Control.call(This, config);

    var Base = {
        GetType: This.GetType,
        is: This.is
    };

    This.GetType = function () { return "HeaderCtrl"; }
    This.is = function (type) { return type == This.GetType() ? true : Base.is(type); }

    This.Resize(width, height);

    This.GetDom().innerHTML = String.format("<div class='HeaderCtrl'><div class='HeaderCtrlText'>{0}</div></div>", config.Text);

}

//by fj 2011-3-29  增加消息框里的组织架构
function DeptPanel(config) {
    var This = this;
    var OwnerForm = this;

    var width = config.Width, height = config.Height;
    config.Width = 200;
    config.Height = 200;

    Management.DeptPanel.call(This, config);

    var Base = {
        GetType: This.GetType,
        is: This.is
    };

    This.GetType = function () { return "DeptPanel"; }
    This.is = function (type) { return type == This.GetType() ? true : Base.is(type); }

    This.Resize(width, height);
}

//消息查询面板
function MsgSearchPanel(config) {
    var This = this;
    config.Css = "MsgSearchPanel";
    var width = config.Width, height = config.Height;
    config.Width = 520;
    config.Height = 461;
    Control.call(This, config);
    var Base = {
        GetType: This.GetType,
        is: This.is
    };
    This.GetType = function () {
        return "MsgSearchPanel"
    };
    This.is = function (type) {
        return type == This.GetType() ? true : Base.is(type)
    };
    var label1 = new Controls.Label({
        Left: 9,
        Top: 14,
        Width: 62,
        Height: 14,
        AnchorStyle: Controls.AnchorStyle.Left | Controls.AnchorStyle.Top,
        Parent: This,
        Text: "查找范围：",
        Css: "label"
    });
    var label2 = new Controls.Label({
        Left: 9,
        Top: 44,
        Width: 62,
        Height: 14,
        AnchorStyle: Controls.AnchorStyle.Left | Controls.AnchorStyle.Top,
        Parent: This,
        Text: "查找内容：",
        Css: "label"
    });
    var textbox1 = new Controls.TextBox({
        Left: 72,
        Top: 40,
        Width: 440,
        Height: 22,
        AnchorStyle: Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top,
        Parent: This,
        Text: "",
        Css: "textbox",
        BorderWidth: 1
    });
    var m_MsgPanel_config = {
        Left: 8,
        Top: 102,
        Width: 505,
        Height: 352,
        AnchorStyle: Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top | Controls.AnchorStyle.Bottom,
        Parent: This,
        Text: "",
        Css: "control"
    };
    m_MsgPanel_config.BorderWidth = 1;
    m_MsgPanel_config.Operations = [{
        Text: "查看前后消息",
        Command: "View"
    },
    { Text: "回复",
        Command: "Chat"
    }];
    var m_MsgPanel = new MsgPanel(m_MsgPanel_config);
    m_MsgPanel.OnCommand.Attach(function (command, user) {
        //查看前后消息
        if (command == "View") {
            config.HistoryPanel.PanelIsDisplay(true);
            config.HistoryPanel.View(user);
            This.SetVisible(false);
        } else if (command == "Chat") {//回复
            if (user.Sender.ID != Core.Session.GetUserInfo().ID) {
                Core.Session.GetGlobal("ChatService").Open(user.Sender.Name)
            }
        }
    });
    var btnSearch = new Controls.Button({
        Left: 448,
        Top: 68,
        Width: 64,
        Height: 26,
        AnchorStyle: Controls.AnchorStyle.Right | Controls.AnchorStyle.Top,
        Parent: This,
        Text: "搜 索",
        Css: "button_default"
    });
    btnSearch.OnClick.Attach(function (command) {
        var reg = /([0-9]{1,4})\-([0-9]{1,2})\-([0-9]{1,2})/ig;
        reg.lastIndex = 0;
        if (enddate.GetText() != "" && reg.exec(enddate.GetText()) == null) {
            Core.Utility.ShowWarning("起始日期格式错误！");
            enddate.GetTextBoxDom().focus();
            return
        }
        reg.lastIndex = 0;
        if (startdate.GetText() != "" && reg.exec(startdate.GetText()) == null) {
            Core.Utility.ShowWarning("结束日期格式错误！");
            startdate.GetTextBoxDom().focus();
            return
        }
        if (textbox1.GetText() == "") {
            Core.Utility.ShowWarning("请输入查找内容！");
            return
        }
        var m_Form = new Date(2000, 0, 1);
        if (enddate.GetText() != "") {
            reg.lastIndex = 0;
            var value = reg.exec(enddate.GetText());
            m_Form = new Date(parseInt(value[1]), parseInt(value[2]) - 1, parseInt(value[3]))
        }
        var m_To = new Date(2100, 0, 1, 23, 59, 59);
        if (startdate.GetText() != "") {
            reg.lastIndex = 0;
            var value = reg.exec(startdate.GetText());
            m_To = new Date(parseInt(value[1]), parseInt(value[2]) - 1, parseInt(value[3]), 23, 59, 59)
        }
        var m_Type = "";
        m_Type = drpType.GetValue();
        CurrentWindow.Waiting("正在搜索消息...");
        var s_config = {
            Action: "SearchMessage",
            Content: textbox1.GetText(),
            Type: m_Type.toString(),
            From: m_Form,
            To: m_To
        };
        Core.SendCommand(function (data) {
            m_MsgPanel.Clear();
            if (data.Messages.length != 0) {
                for (var index in data.Messages) {
                    m_MsgPanel.AddMessage(data.Messages[index])
                }
            }
            else {
                var div = m_MsgPanel.GetDocument().createElement("DIV");
                div.innerHTML = String.format("<div class='message'><div class='error'>未搜索到相关的消息！</div></div>");
                m_MsgPanel.AddDom(div)
            }
            CurrentWindow.Completed()
        }, function (data) {
            CurrentWindow.Completed();
            Core.Utility.ShowError(data)
        }, Core.Utility.RenderJson(s_config), "Core.Web Common_CH", false)
    });
    var btnReturn = new Controls.Button({
        Left: 374,
        Top: 68,
        Width: 64,
        Height: 26,
        AnchorStyle: Controls.AnchorStyle.Right | Controls.AnchorStyle.Top,
        Parent: This,
        Text: "返 回",
        Css: "button_default"
    });
    btnReturn.OnClick.Attach(function (command) {
        This.SetVisible(false);
        config.HistoryPanel.PanelIsDisplay(true);
    });

    var drpType = new Controls.DropDownList({ "Left": 72, "Top": 10, "Width": 210, "Height": 22, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Top, "Parent": This, "Text": "", "Css": "dropdownlist" });
    drpType.AddItem("全部", "0"); //0
    drpType.AddItem("组织机构", "1"); //1
    drpType.AddItem("我的好友", "2"); //2
    drpType.AddItem("群", "3"); //3
    drpType.AddItem("临时组", "4"); //4
    drpType.SetValue("0"); //设置默认值
    var startdate = new Controls.TextBox({
        Left: 426,
        Top: 10,
        Width: 85,
        Height: 22,
        AnchorStyle: Controls.AnchorStyle.Right | Controls.AnchorStyle.Top,
        Parent: This,
        Text: "",
        Css: "textbox",
        BorderWidth: 1
    });
    startdate.GetDom().style.overflow = "visible";
    startdate.GetDom().title = "日期格式：年-月-日，如：2010-1-1";
    startdate.GetTextBoxDom().onfocus = function () {
        HS_setDate(startdate.GetTextBoxDom(), startdate.GetDom())
    };
    var label5 = new Controls.Label({
        Left: 409,
        Top: 14,
        Width: 14,
        Height: 14,
        AnchorStyle: Controls.AnchorStyle.Right | Controls.AnchorStyle.Top,
        Parent: This,
        Text: "到",
        Css: "label"
    });
    var enddate = new Controls.TextBox({
        Left: 321,
        Top: 10,
        Width: 85,
        Height: 22,
        AnchorStyle: Controls.AnchorStyle.Right | Controls.AnchorStyle.Top,
        Parent: This,
        Text: "",
        Css: "textbox",
        BorderWidth: 1
    });
    enddate.GetDom().style.overflow = "visible";
    enddate.GetDom().title = "日期格式：年-月-日，如：2010-1-1";
    enddate.GetTextBoxDom().onfocus = function () {
        HS_setDate(enddate.GetTextBoxDom(), enddate.GetDom())
    };
    var label6 = new Controls.Label({
        Left: 301,
        Top: 14,
        Width: 16,
        Height: 14,
        AnchorStyle: Controls.AnchorStyle.Right | Controls.AnchorStyle.Top,
        Parent: This,
        Text: "从",
        Css: "label"
    });
    This.Resize(width, height);
    var defautltdate = new Date();
    defautltdate = new Date(defautltdate.getFullYear(), defautltdate.getMonth(), defautltdate.getDate());
    startdate.SetText(String.format("{0}-{1}-{2}", defautltdate.getFullYear(), defautltdate.getMonth() + 1, defautltdate.getDate()));
    var defautltenddate = new Date();
    defautltenddate.setTime(defautltdate.getTime() - 7 * 24 * 60 * 60 * 1000);
    enddate.SetText(String.format("{0}-{1}-{2}", defautltenddate.getFullYear(), defautltenddate.getMonth() + 1, defautltenddate.getDate()));
    This.GetDom().onkeydown = function (v) {
        if (v == undefined) {
            v = window.event
        }
        if (v.keyCode == 13 && !v.shiftKey && !v.ctrlKey && !v.altKey) {
            btnSearch.Click()
        }
    }
}