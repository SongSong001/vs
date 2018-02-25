
function init(completeCallback) {
    completeCallback();
}

var FriendsInfoCache = Core.Session.GetGlobal("FriendsInfoCache");

Module.GetFriends = function(callback, userCache) {
    FriendsInfoCache.GetFriends(callback, userCache);
}

//------------------------------------加载组织架构---------------------------------------------
var DeptsFriendsInfoCache = Core.Session.GetGlobal("DeptsFriendsInfoCache");
/*
callback:回调函数
userCache:部门和部门人员缓存
*/
Module.GetDeptsFriends = function(callback, userCache) {
    DeptsFriendsInfoCache.GetDeptsFriends(callback, userCache);
}

//------------------------------------加载部门2011-6-22---------------------------------------------
var DeptsCache = Core.Session.GetGlobal("DeptsCache");
/*
callback:回调函数
userCache:用户或者部门名称
*/
Module.GetDeptList = function (callback, userCache) {
    DeptsCache.GetDepts(callback, userCache);
}
//-------------------------------------------------------------------------------------------------

Module.SendAddFriendRequest = function(callback, peer, info) {
    var data = {
        Action: "SendAddFriendRequest",
        Peer: peer,
        Info: info
    };
    Core.SendCommand(
		function(ret) {
		    callback(true);
		},
		function(ex) {
		    callback(false, ex);
		},
		Core.Utility.RenderJson(data), "Core.Web Common_CH", false
	);
}

Module.AddFriend = function(callback, peer) {
    var data = {
        Action: "AddFriend",
        Peer: peer
    };
    Core.SendCommand(
		function(ret) {
		    callback(true);
		},
		function(ex) {
		    callback(false, ex);
		},
		Core.Utility.RenderJson(data), "Core.Web Common_CH", false
	);
}

Module.AddToGroup = function(callback, user, group) {
    var data = {
        Action: "AddToGroup",
        User: user,
        Group: group
    };

    Core.SendCommand(
		function(ret) {
		    callback(true);
		},
		function(ex) {
		    callback(false, ex);
		},
		Core.Utility.RenderJson(data), "Core.Web Common_CH", false
	);
}

//by  wenjl  2010-3-29  获取权限
Module.GetWindowRoles = function(callback) {
    var data = {
        Action: "GetWindowRoles"
    };

    Core.SendCommand(
		function(ret) {
		    callback(true, ret.WindowRoles);
		},
		function(ex) {
		    callback(false, ex);
		},
		Core.Utility.RenderJson(data), "Core.Web Common_CH", false
	);
}

Module.DeleteFriend = function(callback, peer) {
    var data = {
        Action: "DeleteFriend",
        Peer: peer
    };
    Core.SendCommand(
		function(ret) {
		    callback(true);
		},
		function(ex) {
		    callback(false, ex);
		},
		Core.Utility.RenderJson(data), "Core.Web Common_CH", false
	);
}

Module.CreateGroup = function(callback, name, desc) {
    var data = {
        Action: "CreateGroup",
        Name: name,
        Desc: desc
    };
    Core.SendCommand(
		function(ret) {
		    callback(true);
		},
		function(ex) {
		    callback(false, ex);
		},
		Core.Utility.RenderJson(data), "Core.Web Common_CH", false
	);
}

Module.GetAccountInfo = function(callback, name) {
    var data = {
        Action: "GetAccountInfo",
        Name: name
    };
    Core.SendCommand(
		function(ret) {
		    callback(true, ret.Info);
		},
		function(ex) {
		    callback(false, ex);
		},
		Core.Utility.RenderJson(data), "Core.Web Common_CH", false
	);
}