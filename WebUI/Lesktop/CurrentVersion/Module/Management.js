Core.Link("StyleSheet", Core.GetUrl("Themes/Default/Management.css"), "text/css");

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
            Common = Core.GetModule("Common.js");
            completeCallback();
        },
        errorCallback, ["Common.js"]);
    }
    catch (ex) {
        errorCallback(new Core.Exception(ex.mame, ex.message));
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
        errorCallback(new Core.Exception(ex.mame, ex.message));
    }
}

//共享全局变量和函数，在此定义的变量和函数将由该应用程序的所有实例共享
var Common = null;

function EmptyCallback() {

}

function Match(reg, str) {
    reg.lastIndex = 0;
    var ft = reg.exec(str);
    return (ft != null && ft.length == 1 && ft[0] == str)
}
//检查Email
function CheckEMail(email) {
    return Match(/[a-zA-Z0-9._\-]+@[a-zA-Z0-9._\-]+/ig, email);
}
//检查电话
function CheckTel(tel) {
    return Match(/[0-9\-]{6,30}/ig, tel);
}
//检查手机
function CheckMobile(mobile) {
    return Match(/[0-9]{11,11}/ig, mobile);
}
//检查名字
function CheckName(name) {
    return Match(/[a-zA-Z0-9_-]{2,256}/ig, name);
}
//检查密码
function CheckPassword(pwd) {
    return Match(/[0-9a-zA-Z]{4,10}/ig, pwd);
}

//获得头像
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

Module.FriendPanel = FriendPanel;
//好友数据源
function FriendPanelDS(config) {
    var obj = {};
    //by fj 2011-4-7  获得在线实时状态
    if (config == undefined) config = {};
    if (config.ShowState == undefined) config.ShowState = false;
    obj.GetSubNodes = function (callback, node) {
        if (node == null) {
            var nodes = [{
                Name: "Users",
                Text: "我的好友",
                Tag: null,
                ImageCss: "Image16_Folder"
            },
            {
                Name: "Groups",
                Text: "群组",
                Tag: null,
                ImageCss: "Image16_Folder"
            },
            {
                Name: "TempGroups",
                Text: "讨论组",
                Tag: null,
                ImageCss: "Image16_Folder"
            }];
            callback(nodes);
        }
        else {
            var name = node.GetName();
            if (name != "Users" && name != "Groups" && name != "TempGroups") return null;

            var type = (name == "Users" ? 0 : 1); //判断是用户还是组0:用户  1.群组 2.临时组
            if (name == "TempGroups")
                type = 2;
            Common.GetFriends(function (friends) {
                var nodes = [];
                for (var k in friends) {
                    var friend = friends[k];
                    if (friend.Type == type) {
                        if (type == 0) {
                            nodes.push({
                                Name: friend.Name.toUpperCase(),
                                Text: friend.Nickname,
                                Tag: friend,
                                HasChildren: false,
                                Tootip: {
                                    Content: friend.Phone
                                },
                                ImageSrc: GetHeadIMG(friend, 16, config.ShowState && friend.State == "Offline")
                            });
                        }
                        else if (type == 1) {
                            nodes.push({
                                Name: friend.Name.toUpperCase(),
                                Text: friend.Nickname,
                                Tag: friend,
                                HasChildren: false,
                                ImageCss: "Image16_Group"
                            });
                        }
                        else {
                            nodes.push({
                                Name: friend.Name.toUpperCase(),
                                Text: friend.Nickname,
                                Tag: friend,
                                HasChildren: false,
                                ImageCss: "Image16_Group"
                            });
                        }
                    }
                }
                callback(nodes);
            });
        }
    }

    return obj;
}
//好友面板
function FriendPanel(config) {
    var This = this;
    var OwnerForm = this;

    config.Css = "FriendPanel";
    //config.DataSource = FriendPanelDS;
    config.DataSource = new FriendPanelDS(config.DSConfig);
    var width = config.Width, height = config.Height;
    config.Width = 243;
    config.Height = 620;

    Controls.TreeView.call(This, config);

    var Base = {
        GetType: This.GetType,
        is: This.is
    };
    This.GetType = function () { return "FriendPanel"; }
    This.is = function (type) { return type == This.GetType() ? true : Base.is(type); }

    This.Resize(width, height);

    This.OnDblClick.Attach(
    function () {
        if (This.GetSelectedNode().GetTag() != null && Core.Session.GetUserName().toUpperCase() != This.GetSelectedNode().GetTag().Name.toUpperCase()) {
            var form = Core.Session.GetGlobal("ChatService").Open(This.GetSelectedNode().GetTag().Name, false);
        }
    });

    //增加个人信息显示 by fj 2011-5-3
    var tip = null;
    //鼠标点击
    This.OnClick.Attach(
		function () {
		    if (This.GetSelectedNode().GetTag() != null) {   //如果是用户才打开窗体
		        if (This.GetSelectedNode().GetTag().Type == 0) {
		            var user = This.GetSelectedNode().GetTag();
		            var nodename = "node" + user.Name.toUpperCase();
		            var parentnode = This.GetSelectedNode().GetParent(); //获得父节点
		            if (parentnode != null) {//如果父节点的Tag为空
		                nodename = "node" + parentnode.GetText().toUpperCase() + user.Name.toUpperCase();
		            }
		            if (parentnode != null && parentnode.GetTag() != null) {
		                nodename = "node" + parentnode.GetTag().Name.toUpperCase() + user.Name.toUpperCase();
		            }
		            var ret = GetAbsoluteLocation(document.getElementById(nodename)); //获得控件的绝对位置
		            var cwintop = CurrentWindow.GetTop();
		            var t = ret.absoluteTop + cwintop - 4; //获得Top
		            var l = CurrentWindow.GetLeft() - 250; //ret.absoluteLeft;
		            if (l < 250)
		                l = l + 500;
		            if (t > (313 + cwintop - 4))
		                t = 313 + cwintop - 4;
		            tip = Core.Session.GetGlobal("SingletonForm").ShowFriendInfoForm(user.Nickname, user.Phone, user.TelPhone, user.EMail, t, l);
		        }
		    }
		});
    //鼠标离开
    This.OnMouseout.Attach(
	    function () {
	        if (tip != null)
	            tip.Close();
	    });
    //end
}

Module.FriendForm = FriendForm;
//好友窗体
function FriendForm(config) {
    var This = this;
    var OwnerForm = this;

    var width = config.Width, height = config.Height;
    config.Width = 233;
    config.Height = 707;

    Control.call(This, config);

    var Base = {
        GetType: This.GetType,
        is: This.is
    };

    This.GetType = function () { return "FriendForm"; }
    This.is = function (type) { return type == This.GetType() ? true : Base.is(type); }

    var m_Toolbar = new Controls.Toolbar({ "Left": 2, "Top": 2, "Width": 229, "Height": 24, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top, "Parent": This, "Text": "功能菜单", "Css": "toolbar", "Items": [{ "Text": "功能菜单", "Css": "Image22_Add", "Command": "Option"}] });

    m_Toolbar.OnCommand.Attach(
        function (command) {
            if (command == "Option") {
                var toolbar_btn_dom = m_Toolbar.GetControl(0);
                var coord = Core.Utility.GetClientCoord(toolbar_btn_dom);
                m_Menu.Popup(coord.X, coord.Y + toolbar_btn_dom.offsetHeight + 2);
            }
        }
    )
    //begin by fj 2011-3-15  增加组织架构
    var tab5 = new Controls.SimpleTabControl({ "Left": 1, "Top": 27, "Width": 236, "Height": 396, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Top, "Parent": This, "Text": "", "Css": "simple_tab", "Tabs": [{ "Text": "组织架构", "Width": 80, "ID": "ID100000007", "IsSelected": true }, { "Text": "我的好友", "Width": 80, "ID": "ID100000008", "IsSelected": false}], "BorderWidth": 1 });

    tab5.OnSelectedTab.Attach(
        function (index, preIndex) {

        }
    )

    var m_FriendPanel_Config = { "Left": 0, "Top": 0, "Width": 236, "Height": 368, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Top, "Parent": tab5.GetPanel(1), "Text": "", "Css": "control" };

    m_FriendPanel_Config.BorderWidth = 1;
    m_FriendPanel_Config.DSConfig = {
        ShowState: true
    };

    var m_FriendPanel = new FriendPanel(m_FriendPanel_Config);

    var m_DeptPanel_Config = { "Left": 0, "Top": 0, "Width": 236, "Height": 368, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Top | Controls.AnchorStyle.Right | Controls.AnchorStyle.Bottom, "Parent": tab5.GetPanel(0), "Text": "", "Css": "control" };

    m_DeptPanel_Config.BorderWidth = 1;
    m_DeptPanel_Config.DSConfig = {
        ShowState: true
    };

    var m_DeptPanel = new DeptPanel(m_DeptPanel_Config);

    This.Resize(width, height);
    //加载数据并根据路径展开节点
    m_FriendPanel.Refresh(function () {
        m_FriendPanel.Expand(EmptyCallback, "/Users");
        m_FriendPanel.Expand(EmptyCallback, "/Groups");
        m_FriendPanel.Expand(EmptyCallback, "/TempGroups");
    });
    //实现treeview刷新函数
    m_DeptPanel.Refresh(function () {
        m_DeptPanel.Expand(EmptyCallback, "/Depts"); //展开该路径下所有的节点
    });
    //end
    var menuConfig = {
        Items: [
        {
            Text: "好友/群管理",
            ID: "Management"
        },
        {
            Text: "消息管理",
            ID: "MsgHistory"
        }]
    };

    var m_Menu = new Controls.Menu(menuConfig);
    m_Menu.OnCommand.Attach(
    function (command) {
        if (command == "AddFriend") {
            Core.Session.GetGlobal("SingletonForm").ShowAddFriendForm();
        }
        else if (command == "Management") {
            Core.Session.GetGlobal("SingletonForm").ShowFriendManagementForm();
        }
        else if (command == "MsgHistory") {
            Core.Session.GetGlobal("SingletonForm").ShowMsgHistoryForm();
        }
        else if (command == "UpdateSelfInfo") {
            Core.Session.GetGlobal("SingletonForm").ShowUpdateSelfInfoForm();
        }
        else if (command == "Structure") {
            Core.Session.GetGlobal("SingletonForm").ShowStructureForm();
        }
    });

    CurrentWindow.OnNotify.Attach(
    function (command, data) {
        if (command == "FriendInfoChanged") {
            m_FriendPanel.Refresh(function () {
                m_FriendPanel.Expand(EmptyCallback, "/Users");
                m_FriendPanel.Expand(EmptyCallback, "/Groups");
                m_FriendPanel.Expand(EmptyCallback, "/TempGroups");
            });
            m_DeptPanel.Refresh(function () {
                m_DeptPanel.Expand(EmptyCallback, "/Depts");
            });
        }
        else if (command == "UserInfoChanged") {
            CurrentWindow.SetTitle(Core.Session.GetUserInfo().Nickname);
        }
        else if (command == "UserStateChanged") {
            m_FriendPanel.GetAllNodes(function (node) {
                if (node.GetTag() != null && node.GetTag().Name.toUpperCase() == data.User) {
                    node.SetImage(GetHeadIMG(node.GetTag(), 16, data.State == "Offline"));
                }
            });
            m_DeptPanel.GetAllNodes(function (node) {
                if (node.GetTag() != null && node.GetTag().Name.toUpperCase() == data.User) {
                    node.SetImage(GetHeadIMG(node.GetTag(), 16, data.State == "Offline"));
                }
            });
        }
    });

}

Module.AddFriendForm = AddFriendForm;
//添加好友窗体
function AddFriendForm(config) {
    var This = this;
    var OwnerForm = this;

    var width = config.Width, height = config.Height;
    config.Width = 528;
    config.Height = 448;

    Control.call(This, config);

    var Base = {
        GetType: This.GetType,
        is: This.is
    };

    This.GetType = function () { return "AddFriendForm"; }
    This.is = function (type) { return type == This.GetType() ? true : Base.is(type); }

    var m_Tab = new Controls.SimpleTabControl({ "Left": 1, "Top": 1, "Width": 526, "Height": 446, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top | Controls.AnchorStyle.Bottom, "Parent": This, "Text": "", "Css": "simple_tab_gred", "Tabs": [{ "Text": "添加好友/群", "Width": 120, "ID": "ID100000007", "IsSelected": true }, { "Text": "查找好友", "Width": 120, "ID": "ID100000022", "IsSelected": false }, { "Text": "查找群", "Width": 100, "ID": "ID100000023", "IsSelected": false}], "BorderWidth": 1 });

    m_Tab.OnSelectedTab.Attach(
        function (index, preIndex) {
            if (index == 1) {
                CurrentWindow.Waiting("正在载入好友列表...");
                m_FrameFirendList.Navigate(String.format("Management/FriendSearch.aspx?random={0}", (new Date()).getTime()));
            }
            else if (index == 2) {
                CurrentWindow.Waiting("正在载入群列表...");
                m_GroupList.Navigate(String.format("Management/GroupSearch.aspx?random={0}", (new Date()).getTime()));

            }
        }
    )

    var label2 = new Controls.Label({ "Left": 12, "Top": 20, "Width": 95, "Height": 14, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Top, "Parent": m_Tab.GetPanel(0), "Text": "群/用户账户名：", "Css": "label" });

    var m_EditNameF = new Controls.TextBox({ "Left": 112, "Top": 16, "Width": 402, "Height": 22, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top, "Parent": m_Tab.GetPanel(0), "Text": "", "Css": "textbox", "BorderWidth": 1 });

    if (Core.Params["Name"] != undefined) m_EditNameF.SetText(Core.Params["Name"]);

    var label4 = new Controls.Label({ "Left": 11, "Top": 54, "Width": 139, "Height": 14, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Top, "Parent": m_Tab.GetPanel(0), "Text": "验证信息：", "Css": "label" });

    var m_EditInfoF = new Controls.TextArea({ "Left": 11, "Top": 74, "Width": 502, "Height": 302, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top | Controls.AnchorStyle.Bottom, "Parent": m_Tab.GetPanel(0), "Text": "", "Css": "textarea", "BorderWidth": 1 });

    var m_BtnAddFriend = new Controls.Button({ "Left": 449, "Top": 384, "Width": 64, "Height": 26, "AnchorStyle": Controls.AnchorStyle.Right | Controls.AnchorStyle.Bottom, "Parent": m_Tab.GetPanel(0), "Text": "确定", "Css": "button_default" });

    m_BtnAddFriend.OnClick.Attach(
        function (btn) {
            Common.SendAddFriendRequest(
            function (result, ex) {
                if (!result) {
                    Core.Utility.ShowError(ex.toString());
                }
                else {
                    m_EditNameF.SetText("");
                    m_EditInfoF.SetText("")
                    Core.Utility.ShowFloatForm("添加好友/群的请求已发送，等待对方确认...", "text");
                }
            },
            m_EditNameF.GetText(), m_EditInfoF.GetText());
        }
    )

    var m_FrameFirendList_Config = { "Left": 6, "Top": 6, "Width": 512, "Height": 410, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top | Controls.AnchorStyle.Bottom, "Parent": m_Tab.GetPanel(1), "Text": "", "Css": "control" };

    var m_FrameFirendList = new Controls.Frame(m_FrameFirendList_Config);

    m_FrameFirendList.OnResized.Attach(
        function (btn) {

        }
    )

    var m_GroupList_Config = { "Left": 6, "Top": 6, "Width": 512, "Height": 410, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top | Controls.AnchorStyle.Bottom, "Parent": m_Tab.GetPanel(2), "Text": "", "Css": "control" };

    var m_GroupList = new Controls.Frame(m_GroupList_Config);

    m_GroupList.OnResized.Attach(
        function (btn) {

        }
    )

    This.Resize(width, height);
}

Module.FriendManagementForm = FriendManagementForm;
//好友管理窗体
function FriendManagementForm(config) {
    var This = this;
    var OwnerForm = this;

    var width = config.Width, height = config.Height;
    config.Width = 596;
    config.Height = 502;

    Control.call(This, config);

    var Base = {
        GetType: This.GetType,
        is: This.is
    };

    This.GetType = function () { return "FriendManagementForm"; }
    This.is = function (type) { return type == This.GetType() ? true : Base.is(type); }

    var tab2 = new Controls.SimpleTabControl({ "Left": 1, "Top": 1, "Width": 594, "Height": 500, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top | Controls.AnchorStyle.Bottom, "Parent": This, "Text": "", "Css": "simple_tab_gred", "Tabs": [{ "Text": "好友管理", "Width": 80, "ID": "ID100000014", "IsSelected": true }, { "Text": "群管理", "Width": 80, "ID": "ID100000015", "IsSelected": false }, { "Text": "所有用户", "Width": 80, "ID": "ID100000016", "IsSelected": false }, { "Text": "所有群组", "Width": 80, "ID": "ID100000017", "IsSelected": false}], "BorderWidth": 1 });

    tab2.OnSelectedTab.Attach(
        function (index, preIndex) {
            if (index == 0) {
                CurrentWindow.Waiting("正在载入好友列表...");
                m_FrameFriend.Navigate(String.format("FriendList.aspx?random={0}", (new Date()).getTime()));
            }
            else if (index == 1) {
                CurrentWindow.Waiting("正在载入群列表...");
                m_FrameGroup.Navigate(String.format("GroupList.aspx?random={0}", (new Date()).getTime()));

            }
            else if (index == 2) {
                CurrentWindow.Waiting("正在载入用户列表...");
                m_FrameAllUsers.Navigate(String.format("AllUSers.aspx?random={0}", (new Date()).getTime()));

            }
            else if (index == 3) {
                CurrentWindow.Waiting("正在载入群列表...");
                m_FrameAllGroups.Navigate(String.format("AllGroups.aspx?random={0}", (new Date()).getTime()));

            }
        }
    )

    var m_FrameFriend_Config = { "Left": 6, "Top": 6, "Width": 580, "Height": 462, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top | Controls.AnchorStyle.Bottom, "Parent": tab2.GetPanel(0), "Text": "", "Css": "frame" };

    m_FrameFriend_Config.BorderWidth = 1;

    var m_FrameFriend = new Controls.Frame(m_FrameFriend_Config);



    m_FrameFriend.OnResized.Attach(
        function (btn) {

        }
    )

    var m_FrameGroup_Config = { "Left": 6, "Top": 6, "Width": 580, "Height": 462, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top | Controls.AnchorStyle.Bottom, "Parent": tab2.GetPanel(1), "Text": "", "Css": "frame" };

    m_FrameGroup_Config.BorderWidth = 1;

    var m_FrameGroup = new Controls.Frame(m_FrameGroup_Config);



    m_FrameGroup.OnResized.Attach(
        function (btn) {

        }
    )

    var m_FrameAllUsers_Config = { "Left": 6, "Top": 6, "Width": 580, "Height": 462, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top | Controls.AnchorStyle.Bottom, "Parent": tab2.GetPanel(2), "Text": "", "Css": "frame" };

    m_FrameAllUsers_Config.BorderWidth = 1;

    var m_FrameAllUsers = new Controls.Frame(m_FrameAllUsers_Config);



    m_FrameAllUsers.OnResized.Attach(
        function (btn) {

        }
    )

    var m_FrameAllGroups_Config = { "Left": 6, "Top": 6, "Width": 580, "Height": 462, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top | Controls.AnchorStyle.Bottom, "Parent": tab2.GetPanel(3), "Text": "", "Css": "frame" };

    m_FrameAllGroups_Config.BorderWidth = 1;

    var m_FrameAllGroups = new Controls.Frame(m_FrameAllGroups_Config);

    m_FrameAllGroups.OnResized.Attach(
        function (btn) {

        }
    )

    This.Resize(width, height);

    tab2.Select(0);

    tab2.SetTabVisible(2, Core.Session.GetUserName().toLowerCase() == "sa");
    tab2.SetTabVisible(3, Core.Session.GetUserName().toLowerCase() == "sa");
    tab2.SetTabVisible(3, Core.Session.GetUserName().toLowerCase() == "manager");
    CurrentWindow.OnNotify.Attach(
    function (command, data) {
        if (command == "FriendInfoChanged") {
            if (tab2.GetSelectedIndex() == 0) {
                //CurrentWindow.Waiting("正在载入好友列表...");
                m_FrameFriend.Navigate(String.format("FriendList.aspx?random={0}", (new Date()).getTime()));
            }
            else if (tab2.GetSelectedIndex() == 1) {
                //CurrentWindow.Waiting("正在载入群列表...");
                m_FrameGroup.Navigate(String.format("GroupList.aspx?Type=1&random={0}", (new Date()).getTime()));
            }
        }
    });

}

Module.ImageControl = ImageControl;
//图片控件
function ImageControl(config) {
    var This = this;
    var OwnerForm = this;

    config.Css = "ImageControl";

    var width = config.Width, height = config.Height;
    config.Width = 200;
    config.Height = 200;

    Control.call(This, config);

    var Base = {
        GetType: This.GetType,
        is: This.is
    };

    This.GetType = function () { return "ImageControl"; }
    This.is = function (type) { return type == This.GetType() ? true : Base.is(type); }

    This.Resize(width, height);

    var img = null;

    function centerImage() {
        //alert("配置宽度:" + parseFloat(config.ImageWidth) + "配置高度:" + parseFloat(config.ImageHeight) + "图片宽度:" + img.width + "图片高度:" + img.height);
        if (img.width > config.ImageWidth || img.height > config.ImageHeight) {
            if (img.width * config.ImageHeight > img.height * config.ImageWidth) {
                img.height = config.ImageWidth * img.height / img.width;
                img.width = config.ImageWidth;
            }
            else {
                img.width = config.ImageHeight * img.width / img.height;
                img.height = config.ImageHeight;
            }
        }
        //alert("宽度:" + This.GetClientWidth() + "高度:" + This.GetClientHeight() + "左边:" + (This.GetClientWidth() - img.width) / 2 + "上边:" + (This.GetClientHeight() - img.height) / 2)
        img.style.marginLeft = (This.GetClientWidth() - img.width) / 2 + 'px';
        img.style.marginTop = (This.GetClientHeight() - img.height) / 2 + 'px';
    }

    This.OnResized.Attach(
    function () {
        if (img != null) {
            img.style.marginLeft = (This.GetClientWidth() - img.width) / 2 + 'px';
            img.style.marginTop = (This.GetClientHeight() - img.height) / 2 + 'px';
        }
    });

    This.LoadImage = function (src) {
        This.GetDom().innerHTML = "<img/>";
        img = This.GetDom().firstChild;
        img.onload = centerImage;
        img.src = src;
    }

    This.GetImageSrc = function () {
        return img == null ? "" : img.src;
    }

}
//用户信息
function UserInfoPanel(config) {
    var This = this;
    var OwnerForm = this;

    config.Css = "UpdateSelfInfo";

    var width = config.Width, height = config.Height;
    config.Width = 380;
    config.Height = 337;

    Control.call(This, config);

    var Base = {
        GetType: This.GetType,
        is: This.is
    };

    This.GetType = function () { return "UserInfoPanel"; }
    This.is = function (type) { return type == This.GetType() ? true : Base.is(type); }

    var label2 = new Controls.Label({ "Left": 11, "Top": 2, "Width": 51, "Height": 14, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Top, "Parent": This, "Text": "登录名：", "Css": "label" });

    var m_EditName = new Controls.TextBox({ "Left": 64, "Top": 0, "Width": 316, "Height": 22, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top, "Parent": This, "Text": "", "Css": "textbox", "BorderWidth": 1 });

    m_EditName.GetTextBoxDom().readOnly = true;

    var m_EditNickname = new Controls.TextBox({ "Left": 64, "Top": 28, "Width": 316, "Height": 22, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top, "Parent": This, "Text": "", "Css": "textbox", "BorderWidth": 1 });

    var label5 = new Controls.Label({ "Left": 23, "Top": 32, "Width": 42, "Height": 14, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Top, "Parent": This, "Text": "昵称：", "Css": "label" });

    var m_EditEMail = new Controls.TextBox({ "Left": 64, "Top": 58, "Width": 316, "Height": 22, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top, "Parent": This, "Text": "", "Css": "textbox", "BorderWidth": 1 });

    var label7 = new Controls.Label({ "Left": 24, "Top": 62, "Width": 40, "Height": 14, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Top, "Parent": This, "Text": "邮箱：", "Css": "label" });

    //var label8 = new Controls.Label({ "Left": 24, "Top": 94, "Width": 39, "Height": 14, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Top, "Parent": This, "Text": "主页：", "Css": "label" });

    //var m_EditHomePage = new Controls.TextBox({ "Left": 64, "Top": 90, "Width": 316, "Height": 22, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top, "Parent": This, "Text": "", "Css": "textbox", "BorderWidth": 1 });

    var m_HeadIMG_Config = { "Left": 64, "Top": 88, "Width": 316, "Height": 150, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top, "Parent": This, "Text": "", "Css": "control" };

    m_HeadIMG_Config.BorderWidth = 1;
    m_HeadIMG_Config.ImageWidth = 150;
    m_HeadIMG_Config.ImageHeight = 150;

    var m_HeadIMG = new ImageControl(m_HeadIMG_Config);

    var label11 = new Controls.Label({ "Left": 20, "Top": 90, "Width": 42, "Height": 14, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Top, "Parent": This, "Text": "头像：", "Css": "label" });

    // var m_EditRemark = new Controls.TextArea({ "Left": 64, "Top": 120, "Width": 316, "Height": 58, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top, "Parent": This, "Text": "", "Css": "textarea", "BorderWidth": 1 });

    // var label14 = new Controls.Label({ "Left": 0, "Top": 124, "Width": 64, "Height": 14, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Top, "Parent": This, "Text": "个性签名：", "Css": "label" });

    var label15 = new Controls.Label({ "Left": 64, "Top": 300, "Width": 117, "Height": 14, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Top, "Parent": This, "Text": "", "Css": "label" });

    label15.GetDom().innerHTML = "<a class=''>修改头像...</a><input type='file' name='file_headimg' id='file_headimg'/>"
    label15.GetDom().childNodes[1].onchange = function () {
        //限制头像上传图片的格式 by fj 2011-4-11
        var fileName = new String(label15.GetDom().childNodes[1].value); //文件名
        if (fileName != "") {
            var extension = new String(fileName.substring(fileName.lastIndexOf(".") + 1, fileName.length)); //文件扩展名
            if (extension.toUpperCase() == "JPG" || extension.toUpperCase() == "GIF"
                || extension.toUpperCase() == "JPEG" || extension.toUpperCase() == "PMG"
                || extension.toUpperCase() == "PNG" || extension.toUpperCase() == "JPE" || extension.toUpperCase() == "BMP")//你可以添加扩展名 
            {
            }
            else {
                Core.Utility.ShowWarning("请选择正确的图片格式!正确格式包含(.JPG|.GIF|.JPEG|.PMG|.PNG|.JPE|.BMP)");
                var who = label15.GetDom().childNodes[1];
                var who2 = who.cloneNode(false);
                who2.onchange = who.onchange;
                who.parentNode.replaceChild(who2, who);
                return;
            }
            //end
            if (ClientMode) {
                var file = label15.GetDom().childNodes[1];
                if (file.value.indexOf("fakepath") >= 0) {
                    file.select();
                    m_HeadIMG.LoadImage(document.selection.createRange().text);
                }
                else {
                    m_HeadIMG.LoadImage(file.value);
                }
            }
            else {
                m_HeadIMG.LoadImage(String.format("{0}?FileName=/{1}/Public/Images/HeadImg/head_changed_warning.png", Core.GetPageUrl("download.aspx"), Core.Session.GetUserName()));
            }
        }
    }
    //begin by fj 2011-4-18  增加电话
    var label16 = new Controls.Label({ "Left": 0, "Top": 246, "Width": 64, "Height": 16, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Top, "Parent": This, "Text": "联系电话：", "Css": "label" });

    var m_Phone = new Controls.TextBox({ "Left": 64, "Top": 244, "Width": 316, "Height": 22, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top, "Parent": This, "Text": "", "Css": "textbox", "BorderWidth": 1 });

    var label18 = new Controls.Label({ "Left": 0, "Top": 270, "Width": 64, "Height": 14, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Top, "Parent": This, "Text": "联系手机：", "Css": "label" });

    // var label19 = new Controls.Label({ "Left": 20, "Top": 290, "Width": 42, "Height": 14, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Top, "Parent": This, "Text": "手机：", "Css": "label" });

    var m_TelPhone = new Controls.TextBox({ "Left": 64, "Top": 272, "Width": 316, "Height": 22, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top, "Parent": This, "Text": "", "Css": "textbox", "BorderWidth": 1 });

    // var m_MobilePhone = new Controls.TextBox({ "Left": 64, "Top": 292, "Width": 316, "Height": 22, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top, "Parent": This, "Text": "", "Css": "textbox", "BorderWidth": 1 });

    //end
    This.Resize(width, height);

    This.SetInfo = function (info) {
        m_EditName.SetText(info.Name);
        m_EditNickname.SetText(info.Nickname);
        m_EditEMail.SetText(info.EMail);
        //m_EditHomePage.SetText(info.HomePage);
        //m_EditRemark.SetText(info.Remark);
        //by fj 2011-4-18  增加电话
        m_Phone.SetText(info.Phone);
        //m_MobilePhone.SetText(info.MobilePhone);
        m_TelPhone.SetText(info.TelPhone);
        m_HeadIMG.LoadImage(String.format("{0}?user={1}&gred=false&headimg={2}", Core.GetPageUrl("headimg.aspx"), info.Name, info.HeadIMG));
    }

    This.GetInfo = function () {
        if (m_EditName.GetText() == "") {
            Core.Utility.ShowWarning("登录名不能为空！");
            m_EditName.GetTextBoxDom().focus();
            return null;
        }

        if (m_EditName.GetText().length > 10 || m_EditName.GetText().length < 2) {
            Core.Utility.ShowWarning("登录名格式错误，登录名只能包含数字，英文字母，长度为2-10个字符！");
            m_EditName.GetTextBoxDom().focus();
            return null;
        }

        if (!CheckName(m_EditName.GetText())) {
            Core.Utility.ShowWarning("登录名格式错误，登录名只能包含数字，英文字母，长度为2-10个字符！");
            m_EditName.GetTextBoxDom().focus();
            return null;
        }

        if (m_EditNickname.GetText() == "") {
            Core.Utility.ShowWarning("昵称不能为空！");
            m_EditNickname.GetTextBoxDom().focus();
            return null;
        }

        if (m_EditNickname.GetText().length > 16 || m_EditNickname.GetText().length < 2) {
            Core.Utility.ShowWarning("姓名格式错误，长度为2-16个字符");
            m_EditNickname.GetTextBoxDom().focus();
            return;
        }

        //        if (m_EditEMail.GetText() == "") {
        //            Core.Utility.ShowWarning("邮箱不能为空！");
        //            m_EditEMail.GetTextBoxDom().focus();
        //            return null;
        //        }

        if (m_EditEMail.GetText().length > 80) {
            Core.Utility.ShowWarning("邮箱不能超过80字符！");
            m_EditEMail.GetTextBoxDom().focus();
            return null;
        }
        if (m_EditEMail.GetText() != "") {
            if (!CheckEMail(m_EditEMail.GetText())) {
                Core.Utility.ShowWarning("邮箱格式错误！");
                m_EditEMail.GetTextBoxDom().focus();
                return null;
            }
        }
        //by fj 2011-4-18  增加电话
        //        if (m_MobilePhone.GetText() != "" && !CheckMobile(m_MobilePhone.GetText())) {
        //            Core.Utility.ShowWarning("手机格式错误！");
        //            m_MobilePhone.GetTextBoxDom().focus();
        //            return null;
        //        }
        if (m_TelPhone.GetText() != "" && !CheckTel(m_TelPhone.GetText())) {
            Core.Utility.ShowWarning("固定电话格式错误！");
            m_TelPhone.GetTextBoxDom().focus();
            return null;
        }
        var info = {
            Name: m_EditName.GetText(),
            Nickname: m_EditNickname.GetText(),
            EMail: m_EditEMail.GetText(),
            //HomePage: m_EditHomePage.GetText(),
            //Remark: m_EditRemark.GetText(),
            Phone: m_Phone.GetText(),
            TelPhone: m_TelPhone.GetText()
            // MobilePhone: m_MobilePhone.GetText()
        };
        //end

        return info;
    }

}
//组信息
function GroupInfoPanel(config) {
    var This = this;
    var OwnerForm = this;

    config.Css = "UpdateSelfInfo";

    var width = config.Width, height = config.Height;
    config.Width = 324;
    config.Height = 388;

    Control.call(This, config);

    var Base = {
        GetType: This.GetType,
        is: This.is
    };

    This.GetType = function () { return "GroupInfoPanel"; }
    This.is = function (type) { return type == This.GetType() ? true : Base.is(type); }

    var label2 = new Controls.Label({ "Left": 11, "Top": 4, "Width": 52, "Height": 14, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Top, "Parent": This, "Text": "群名称：", "Css": "label" });

    var m_EditName = new Controls.TextBox({ "Left": 64, "Top": 0, "Width": 260, "Height": 22, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top, "Parent": This, "Text": "", "Css": "textbox", "BorderWidth": 1 });

    m_EditName.GetTextBoxDom().readOnly = true;

    var m_EditNickname = new Controls.TextBox({ "Left": 64, "Top": 30, "Width": 260, "Height": 22, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top, "Parent": This, "Text": "", "Css": "textbox", "BorderWidth": 1 });

    var label5 = new Controls.Label({ "Left": 11, "Top": 34, "Width": 55, "Height": 14, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Top, "Parent": This, "Text": "群简称：", "Css": "label" });

    //var label8 = new Controls.Label({ "Left": 10, "Top": 64, "Width": 53, "Height": 14, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Top, "Parent": This, "Text": "群主页：", "Css": "label" });

    //var m_EditHomePage = new Controls.TextBox({ "Left": 64, "Top": 60, "Width": 260, "Height": 22, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top, "Parent": This, "Text": "", "Css": "textbox", "BorderWidth": 1 });

    var m_HeadIMG_Config = { "Left": 64, "Top": 80, "Width": 260, "Height": 180, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top, "Parent": This, "Text": "", "Css": "control" };

    m_HeadIMG_Config.BorderWidth = 1;
    m_HeadIMG_Config.ImageWidth = 150;
    m_HeadIMG_Config.ImageHeight = 150;

    var m_HeadIMG = new ImageControl(m_HeadIMG_Config);
    var label16 = new Controls.Label({ "Left": 0, "Top": 62, "Width": 60, "Height": 14, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Top, "Parent": This, "Text": "允许退群：", "Css": "label" });

    var m_IsExitGroup = new Controls.CheckBox({ "Left": 64, "Top": 58, "Width": 60, "Height": 20, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top, "Parent": This, "Text": "", "Css": "checkbox", "BorderWidth": 1 });

    var label11 = new Controls.Label({ "Left": 11, "Top": 84, "Width": 53, "Height": 14, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Top, "Parent": This, "Text": "群LOGO：", "Css": "label" });

    //var m_EditRemark = new Controls.TextArea({ "Left": 64, "Top": 92, "Width": 260, "Height": 86, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top, "Parent": This, "Text": "", "Css": "textarea", "BorderWidth": 1 });

    //var label14 = new Controls.Label({ "Left": 9, "Top": 94, "Width": 55, "Height": 14, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Top, "Parent": This, "Text": "群介绍：", "Css": "label" });

    var label15 = new Controls.Label({ "Left": 64, "Top": 270, "Width": 117, "Height": 14, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Top, "Parent": This, "Text": "", "Css": "label" });

    label15.GetDom().innerHTML = "<a class=''>修改Logo...</a><input type='file' name='file_headimg' id='file_headimg'/>"
    label15.GetDom().childNodes[1].onchange = function () {
        //限制头像上传图片的格式 by fj 2011-4-11
        var fileName = new String(label15.GetDom().childNodes[1].value); //文件名
        if (fileName != "") {
            var extension = new String(fileName.substring(fileName.lastIndexOf(".") + 1, fileName.length)); //文件扩展名
            if (extension.toUpperCase() == "JPG" || extension.toUpperCase() == "GIF"
                || extension.toUpperCase() == "JPEG" || extension.toUpperCase() == "PMG"
                || extension.toUpperCase() == "PNG" || extension.toUpperCase() == "JPE" || extension.toUpperCase() == "BMP")//你可以添加扩展名 
            {
            }
            else {
                Core.Utility.ShowWarning("请选择正确的图片格式!正确格式包含(.JPG|.GIF|.JPEG|.PMG|.PNG|.JPE|.BMP)");
                var who = label15.GetDom().childNodes[1];
                var who2 = who.cloneNode(false);
                who2.onchange = who.onchange;
                who.parentNode.replaceChild(who2, who);
                return;
            }

            if (ClientMode) {
                var file = label15.GetDom().childNodes[1];
                if (file.value.indexOf("fakepath") >= 0) {
                    file.select();
                    m_HeadIMG.LoadImage(document.selection.createRange().text);
                }
                else {
                    m_HeadIMG.LoadImage(file.value);
                }
            }
            else {
                m_HeadIMG.LoadImage(String.format("{0}?FileName=/{1}/Public/Images/HeadImg/head_changed_warning.png", Core.GetPageUrl("download.aspx"), Core.Session.GetUserName()));
            }
        }
        //end
    }

    This.Resize(width, height);

    This.SetInfo = function (info) {
        m_EditName.SetText(info.Name);
        m_EditNickname.SetText(info.Nickname);
        // m_EditHomePage.SetText(info.HomePage);
        //m_EditRemark.SetText(info.Remark);
        m_IsExitGroup.SetCheckValue(info.IsExitGroup);
        m_HeadIMG.LoadImage(String.format("{0}?user={1}&gred=false&headimg={2}", Core.GetPageUrl("headimg.aspx"), info.Name, info.HeadIMG));
    }

    This.GetInfo = function () {
        if (m_EditName.GetText() == "") {
            Core.Utility.ShowWarning("群组名不能为空！");
            m_EditName.GetTextBoxDom().focus();
            return null;
        }

        if (m_EditName.GetText().length > 256 || m_EditName.GetText().length < 2) {
            Core.Utility.ShowWarning("群组名格式错误，长度为2-256个字符！");
            m_EditName.GetTextBoxDom().focus();
            return null;
        }

        if (!CheckName(m_EditName.GetText())) {
            Core.Utility.ShowWarning("群组名格式错误，登录名只能包含数字，英文字母，长度为2-256个字符！");
            m_EditName.GetTextBoxDom().focus();
            return null;
        }

        if (m_EditNickname.GetText() == "") {
            Core.Utility.ShowWarning("群简称不能为空！");
            m_EditNickname.GetTextBoxDom().focus();
            return null;
        }

        if (m_EditNickname.GetText().length > 16 || m_EditNickname.GetText().length < 2) {
            Core.Utility.ShowWarning("群简称格式错误，长度为2-16个字符");
            m_EditNickname.GetTextBoxDom().focus();
            return;
        }

        var info = {
            Name: m_EditName.GetText(),
            Nickname: m_EditNickname.GetText(),
            IsExitGroup: m_IsExitGroup.GetCheckValue()
            //HomePage: m_EditHomePage.GetText(),
            //Remark: m_EditRemark.GetText()
        };

        return info;
    }

}

Module.UpdateSelfInfo = UpdateSelfInfo;
//用户信息修改
function UpdateSelfInfo(config) {
    var This = this;
    var OwnerForm = this;

    var width = config.Width, height = config.Height;
    config.Width = 360;
    config.Height = 455;

    Control.call(This, config);

    var Base = {
        GetType: This.GetType,
        is: This.is
    };

    This.GetType = function () { return "UpdateSelfInfo"; }
    This.is = function (type) { return type == This.GetType() ? true : Base.is(type); }
    //by fj 2011-3-28 关闭修改密码功能
    var tab1 = new Controls.SimpleTabControl({ "Left": 1, "Top": 1, "Width": 358, "Height": 550, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top | Controls.AnchorStyle.Bottom, "Parent": This, "Text": "", "Css": "simple_tab_gred", "Tabs": [{ "Text": "个人资料", "Width": 80, "ID": "ID100000020", "IsSelected": true }, { "Text": "修改密码", "Width": 80, "ID": "ID100000021", "IsSelected": false}], "BorderWidth": 1 });
    //var tab1 = new Controls.SimpleTabControl({ "Left": 1, "Top": 1, "Width": 358, "Height": 473, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top | Controls.AnchorStyle.Bottom, "Parent": This, "Text": "", "Css": "simple_tab_gred", "Tabs": [{ "Text": "个人资料", "Width": 80, "ID": "ID100000020", "IsSelected": true}], "BorderWidth": 1 });
    tab1.Select(GetState().Tab);

    tab1.OnSelectedTab.Attach(
        function (index, preIndex) {
            var state = GetState();
            state.Tab = index;
            ResetState(state);
        }
    )

    //tab1.SetTabVisible(1, false);
    var m_Info_Config = { "Left": 10, "Top": 8, "Width": 337, "Height": 380, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top | Controls.AnchorStyle.Bottom, "Parent": tab1.GetPanel(0), "Text": "", "Css": "control" };

    var m_Info = new UserInfoPanel(m_Info_Config);

    var m_BtnOK = new Controls.Button({ "Left": 276, "Top": 390, "Width": 70, "Height": 26, "AnchorStyle": Controls.AnchorStyle.Right | Controls.AnchorStyle.Bottom, "Parent": tab1.GetPanel(0), "Text": "更 新", "Css": "button_default" });

    m_BtnOK.OnClick.Attach(
        function (btn) {
            var info = m_Info.GetInfo();
            if (info != null) {
                CurrentWindow.Waiting("正在更新个人资料...");
                DoCommand("Update", info);
            }
        }
    )

    var label4 = new Controls.Label({ "Left": 22, "Top": 27, "Width": 52, "Height": 14, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Top, "Parent": tab1.GetPanel(1), "Text": "原密码：", "Css": "label" });

    var label8 = new Controls.Label({ "Left": 22, "Top": 65, "Width": 52, "Height": 14, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Top, "Parent": tab1.GetPanel(1), "Text": "新密码：", "Css": "label" });

    var m_EditPrePassword = new Controls.PasswordBox({ "Left": 77, "Top": 23, "Width": 265, "Height": 22, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top, "Parent": tab1.GetPanel(1), "Text": "", "Css": "textbox", "BorderWidth": 1 });

    var m_EditPassword = new Controls.PasswordBox({ "Left": 77, "Top": 61, "Width": 265, "Height": 22, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top, "Parent": tab1.GetPanel(1), "Text": "", "Css": "textbox", "BorderWidth": 1 });

    var m_EditPasswordConfirm = new Controls.PasswordBox({ "Left": 77, "Top": 98, "Width": 265, "Height": 22, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top, "Parent": tab1.GetPanel(1), "Text": "", "Css": "textbox", "BorderWidth": 1 });

    var label12 = new Controls.Label({ "Left": 10, "Top": 102, "Width": 64, "Height": 14, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top, "Parent": tab1.GetPanel(1), "Text": "密码确认：", "Css": "label" });

    var BtnAlterPassword = new Controls.Button({ "Left": 251, "Top": 142, "Width": 90, "Height": 26, "AnchorStyle": Controls.AnchorStyle.Right | Controls.AnchorStyle.Top, "Parent": tab1.GetPanel(1), "Text": "修改密码", "Css": "button_default" });

    BtnAlterPassword.OnClick.Attach(
              function (btn) {
                  /*if (m_EditPrePassword.GetText() == "")
                  {
                  Core.Utility.ShowWarning("请输入原密码！");
                  m_EditPrePassword.GetPasswordDom().focus();
                  return;
                  }
               
                  if (!CheckPassword(m_EditPrePassword.GetText()))
                  {
                  Core.Utility.ShowWarning("密码必须由4-10位字母或数字组成！");
                  m_EditPrePassword.GetPasswordDom().focus();
                  return;
                  }
                  */
                  if (m_EditPassword.GetText() == "") {
                      Core.Utility.ShowWarning("请输入新密码！");
                      m_EditPassword.GetPasswordDom().focus();
                      return;
                  }

                  if (!CheckPassword(m_EditPassword.GetText())) {
                      Core.Utility.ShowWarning("密码必须由4-10位字母或数字组成！");
                      m_EditPassword.GetPasswordDom().focus();
                      return;
                  }

                  if (m_EditPasswordConfirm.GetText() != m_EditPassword.GetText()) {
                      Core.Utility.ShowWarning("两次输入密码不一致！");
                      m_EditPasswordConfirm.GetPasswordDom().focus();
                      return;
                  }

                  var data = {
                      PreviousPassword: m_EditPrePassword.GetText(),
                      Password: m_EditPassword.GetText()
                  };

                  CurrentWindow.Waiting("正在修改密码...");
                  DoCommand("ChangePassword", data);
              }
         )

    This.Resize(width, height);

    m_Info.SetInfo(GetState().SelfInfo);

}

Module.UpdateGroupInfo = UpdateGroupInfo;
//更新组信息
function UpdateGroupInfo(config) {
    var This = this;
    var OwnerForm = this;

    var width = config.Width, height = config.Height;
    config.Width = 360;
    config.Height = 375;

    Control.call(This, config);

    var Base = {
        GetType: This.GetType,
        is: This.is
    };

    This.GetType = function () { return "UpdateGroupInfo"; }
    This.is = function (type) { return type == This.GetType() ? true : Base.is(type); }

    var tab1 = new Controls.SimpleTabControl({ "Left": 1, "Top": 1, "Width": 358, "Height": 473, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top | Controls.AnchorStyle.Bottom, "Parent": This, "Text": "", "Css": "simple_tab_gred", "Tabs": [{ "Text": "群资料", "Width": 80, "ID": "ID100000024", "IsSelected": true}], "BorderWidth": 1 });

    tab1.OnSelectedTab.Attach(
        function (index, preIndex) {

        }
    )

    var m_Info_Config = { "Left": 10, "Top": 10, "Width": 337, "Height": 310, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Top, "Parent": tab1.GetPanel(0), "Text": "", "Css": "control" };

    var m_Info = new GroupInfoPanel(m_Info_Config);

    var BtnOK = new Controls.Button({ "Left": 265, "Top": 320, "Width": 81, "Height": 26, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Bottom, "Parent": tab1.GetPanel(0), "Text": "更 新", "Css": "button_default" });

    BtnOK.OnClick.Attach(
        function (btn) {
            var info = m_Info.GetInfo();
            if (info != null) {
                CurrentWindow.Waiting("正在更新群资料...");
                DoCommand("Update", info);
            }
        }
    )

    This.Resize(width, height);

    m_Info.SetInfo(GetState().AccountInfo);

}

//by  wenjl  2011-3-22   增加组织架构
Module.DeptPanel = DeptPanel;
//组织架构面板
function DeptPanel(config) {
    var This = this;
    var OwnerForm = this;

    config.Css = "DeptPanel";
    //config.DataSource = DeptPanelDS;
    config.DataSource = new DeptPanelDS(config.DSConfig);
    var width = config.Width, height = config.Height;
    config.Width = 243;
    config.Height = 620;

    Controls.TreeView.call(This, config);

    var Base = {
        GetType: This.GetType,
        is: This.is
    };

    This.GetType = function () { return "DeptPanel"; }
    This.is = function (type) { return type == This.GetType() ? true : Base.is(type); }

    This.Resize(width, height);
    //定义双击事件
    This.OnDblClick.Attach(
        function () {
            if (This.GetSelectedNode().GetTag() != null) {
                if (This.GetSelectedNode().GetTag().Name != "Depts" && Core.Session.GetUserName().toUpperCase() != This.GetSelectedNode().GetTag().Name.toUpperCase()) {
                    //增加临时组功能 by  wenjl 2011-4-28  
                    if (This.GetSelectedNode().GetTag().DType == 1) {//用户
                        var form = Core.Session.GetGlobal("ChatService").Open(This.GetSelectedNode().GetTag().Name, false);
                    } else if (This.GetSelectedNode().GetTag().DType == 0) {//部门
                        var data = {
                            Action: "CreateTempGroups",
                            DeptId: This.GetSelectedNode().GetTag().ID,
                            DeptName: This.GetSelectedNode().GetTag().Name
                        };
                        Core.SendCommand(
		                    function (ret) {
		                        if (ret != null && ret.DeptInfo != undefined) {
		                            var form = Core.Session.GetGlobal("ChatService").Open(ret.DeptInfo.toString(), false);
		                            return;
		                        }
		                        if (ret != null && ret.ErrorInfo != undefined)
		                            alert(ret.ErrorInfo);
		                    },
		                    function (ex) {
		                        alert("创建讨论组失败!");
		                    },
		                Core.Utility.RenderJson(data), "Core.Web Common_CH", false
	                   );
                    }
                }
            }
        });
    //增加个人信息显示 by fj 2011-5-3
    var tip = null;
    //鼠标点击
    This.OnClick.Attach(
		function () {
		    if (This.GetSelectedNode().GetTag() != null) {   //如果是用户才打开窗体
		        if (This.GetSelectedNode().GetTag().Name != "Depts" && This.GetSelectedNode().GetTag().DType == 1) {
		            var user = This.GetSelectedNode().GetTag();
		            var nodename = "node" + user.Name.toUpperCase();
		            var parentnode = This.GetSelectedNode().GetParent(); //获得父节点
		            if (parentnode != null) {//如果父节点的Tag为空
		                nodename = "node" + parentnode.GetText().toUpperCase() + user.Name.toUpperCase();
		            }
		            if (parentnode != null && parentnode.GetTag() != null) {
		                nodename = "node" + parentnode.GetTag().Name.toUpperCase() + user.Name.toUpperCase();
		            }
		            var ret = GetAbsoluteLocation(document.getElementById(nodename)); //获得控件的绝对位置
		            var cwintop = CurrentWindow.GetTop();
		            var t = ret.absoluteTop + cwintop - 4;
		            var l = CurrentWindow.GetLeft() - 250; //ret.absoluteLeft;
		            if (l < 250)
		                l = l + 500;
		            if (t > (313 + cwintop - 4))
		                t = 313 + cwintop - 4;
		            tip = Core.Session.GetGlobal("SingletonForm").ShowFriendInfoForm(user.Nickname, user.Phone, user.TelPhone, user.EMail, t, l);
		        }
		    }
		});
    //鼠标离开
    This.OnMouseout.Attach(
	    function () {
	        if (tip != null)
	            tip.Close();
	    });
    //end
}

//by  wenjl  2011-3-22   增加组织架构
/*组件架构数据源
*/
function DeptPanelDS(config) {
    var obj = {};
    //by fj 2011-4-7  获得在线实时状态
    if (config == undefined) config = {};
    if (config.ShowState == undefined) config.ShowState = false;
    obj.GetSubNodes = function (callback, node) {
        if (node == null) {
            var nodes = [{
                Name: "Depts",
                Text: "组织架构",
                Tag: null,
                ImageCss: "Image16_Folder"
            }];
            callback(nodes);
        }
        else {
            var nodes = [];
            var tag = node.GetTag();
            if (tag != null)
                tag = tag.ID;
            Common.GetDeptsFriends(function (deptsFriends) {
                if (tag == null) {
                    for (var k in deptsFriends) {
                        var friend = deptsFriends[k];
                        if (friend.ParentId == 0) {
                            if (friend.DType == "0") {//部门
                                nodes.push({
                                    Name: friend.Name.toUpperCase(),
                                    Text: friend.Nickname,
                                    Tag: friend,
                                    Parent: node,
                                    HasChildren: true,
                                    ImageCss: "Image16_Folder"
                                });
                            }
                            else if (friend.DType == "1") {
                                nodes.push({
                                    Name: friend.Name.toUpperCase(),
                                    Text: friend.Nickname,
                                    Tag: friend,
                                    Parent: node,
                                    HasChildren: false,
                                    Tootip: {
                                        Content: friend.Phone
                                    },
                                    HasCheckBox: config.ShowCheckBox,
                                    ImageSrc: GetHeadIMG(friend, 16, config.ShowState && friend.State == "Offline")
                                });
                            }
                        }
                    }
                }
                else {
                    for (var k in deptsFriends) {
                        var friend = deptsFriends[k];
                        if (friend.ParentId == tag) {
                            if (friend.DType == "0") {//部门
                                nodes.push({
                                    Name: friend.Name.toUpperCase(),
                                    Text: friend.Nickname,
                                    Tag: friend,
                                    Parent: node,
                                    HasChildren: true,
                                    ImageCss: "Image16_Folder"
                                });
                            }
                            else if (friend.DType == "1") {
                                nodes.push({
                                    Name: friend.Name.toUpperCase(),
                                    Text: friend.Nickname,
                                    Tag: friend,
                                    Parent: node,
                                    HasChildren: false,
                                    Tootip: {
                                        Content: friend.Phone
                                    },
                                    HasCheckBox: config.ShowCheckBox,
                                    ImageSrc: GetHeadIMG(friend, 16, config.ShowState && friend.State == "Offline")
                                });
                            }
                        }
                    }
                }

            });
            callback(nodes);
        }
    }

    return obj;
}


//by fj 2011-6-21  组织架构
Module.StructurePanel = StructurePanel;

function StructurePanel(config) {
    var This = this;
    var OwnerForm = this;
    config.DataSource = new StructurePanelDS(config.DSConfig);
    var width = config.Width, height = config.Height;
    config.Width = 220;
    config.Height = 500;
    Controls.TreeView.call(This, config);

    var Base = {
        GetType: This.GetType,
        is: This.is
    };

    This.GetType = function () { return "StructurePanel"; }
    This.is = function (type) { return type == This.GetType() ? true : Base.is(type); }

    This.Resize(width, height);
}

//组织架构数据源
function StructurePanelDS(config) {
    var obj = {};
    if (config.ShowCheckBox == undefined) config.ShowCheckBox = false;
    obj.GetSubNodes = function (callback, node) {
        if (node == null) {
            var nodes = [{
                Name: "Structure",
                Text: "组织架构",
                Tag: null,
                ImageCss: "Image16_Folder"
            }];
            callback(nodes);
        }
        else {
            var nodes = [];
            var tag = node.GetTag();
            if (tag != null)
                tag = tag.ID;
            Common.GetDeptsFriends(function (deptsFriends) {
                if (tag == null) {
                    for (var k in deptsFriends) {
                        var friend = deptsFriends[k];
                        if (friend.ParentId == 0) {
                            if (friend.DType == "0") {//部门
                                nodes.push({
                                    Name: friend.Name.toUpperCase(),
                                    Text: friend.Nickname,
                                    Tag: friend,
                                    Parent: node,
                                    HasChildren: true,
                                    HasCheckBox: config.ShowCheckBox,
                                    ImageCss: "Image16_Folder"
                                });
                            }

                        }
                    }
                }
                else {
                    for (var k in deptsFriends) {
                        var friend = deptsFriends[k];
                        if (friend.ParentId == tag) {
                            if (friend.DType == "0") {//部门
                                nodes.push({
                                    Name: friend.Name.toUpperCase(),
                                    Text: friend.Nickname,
                                    Tag: friend,
                                    Parent: node,
                                    HasChildren: true,
                                    HasCheckBox: config.ShowCheckBox,
                                    ImageCss: "Image16_Folder"
                                });
                            }

                        }
                    }
                }

            });
            callback(nodes);
        }
    }

    return obj;
}


//人力资源信息
Module.HRForm = HRForm;
function HRForm(config) {
    var This = this;
    var OwnerForm = this;

    var width = config.Width, height = config.Height;
    config.Width = 754;
    config.Height = 458;

    Control.call(This, config);

    var Base = {
        GetType: This.GetType,
        is: This.is
    };

    This.GetType = function () { return "HRForm"; }
    This.is = function (type) { return type == This.GetType() ? true : Base.is(type); }

    var tab1 = new Controls.SimpleTabControl({ "Left": 0, "Top": 1, "Width": 754, "Height": 455, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top | Controls.AnchorStyle.Bottom, "Parent": This, "Text": "", "Css": "simple_tab", "Tabs": [{ "Text": "公司名称", "Width": 80, "ID": "ID100000023", "IsSelected": true }, { "Text": "部门管理", "Width": 80, "ID": "ID100000024", "IsSelected": false }, { "Text": "员工管理", "Width": 80, "ID": "ID100000025", "IsSelected": false}], "BorderWidth": 1 });

    tab1.OnSelectedTab.Attach(
        function (index, preIndex) {
            if (index == 0) {
                CurrentWindow.Waiting("正在载入公司资料...");
                frmCompany.Navigate(String.format("Company.aspx?random={0}", (new Date()).getTime()));
            }
            else if (index == 1) {
                CurrentWindow.Waiting("正在载入部门资料...");
                frmDept.Navigate(String.format("DeptManage.aspx?random={0}", (new Date()).getTime()));

            }
            else if (index == 2) {
                CurrentWindow.Waiting("正在载入用户列表...");
                frmEmp.Navigate(String.format("AllUSers.aspx?random={0}", (new Date()).getTime()));

            }
        }
    )

    var frmCompany_Config = { "Left": 0, "Top": 0, "Width": 734, "Height": 426, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top | Controls.AnchorStyle.Bottom, "Parent": tab1.GetPanel(0), "Text": "", "Css": "control" };

    var frmCompany = new Controls.Frame(frmCompany_Config);

    frmCompany.OnResized.Attach(
        function (btn) {

        }
    )

    var frmDept_Config = { "Left": 0, "Top": 0, "Width": 734, "Height": 426, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top | Controls.AnchorStyle.Bottom, "Parent": tab1.GetPanel(1), "Text": "", "Css": "control" };

    var frmDept = new Controls.Frame(frmDept_Config);

    frmDept.OnResized.Attach(
        function (btn) {

        }
    )

    var frmEmp_Config = { "Left": 0, "Top": 0, "Width": 734, "Height": 426, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Right | Controls.AnchorStyle.Top | Controls.AnchorStyle.Bottom, "Parent": tab1.GetPanel(2), "Text": "", "Css": "control" };

    var frmEmp = new Controls.Frame(frmEmp_Config);

    frmEmp.OnResized.Attach(
        function (btn) {

        }
    )
    tab1.Select(0);
    //    var m_StructurePanel_Config = { "Left": 1, "Top": 1, "Width": 200, "Height": 455, "AnchorStyle": Controls.AnchorStyle.Left | Controls.AnchorStyle.Top | Controls.AnchorStyle.Bottom, "Parent": This, "Text": "", "Css": "control" };

    //    m_StructurePanel_Config.DSConfig = {
    //        ShowCheckBox: false
    //    };
    //    var m_StructurePanel = new StructurePanel(m_StructurePanel_Config);

    //    m_StructurePanel.Refresh(function () {
    //        m_StructurePanel.Expand(EmptyCallback, "/Structure"); //展开该路径下所有的节点
    //    });
    //    This.Resize(width, height);
    //    CurrentWindow.OnNotify.Attach(
    //    function (command, data) {
    //        if (command == "DeptsInfoChanged") {
    //            m_StructurePanel.Refresh(function () {
    //                m_StructurePanel.Expand(EmptyCallback, "/Structure"); //展开该路径下所有的节点
    //            });
    //        }
    //    });
}

//end
