<%@ Page Language="C#" AutoEventWireup="true" Inherits="Management_GroupList" %>

<%@ Register Src="../CommandCtrl.ascx" TagName="CommandCtrl" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title></title>
    <link href="../CurrentVersion/Themes/Default/table.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        body
        {
            margin: 8px;
        }
        .headimg
        {
            width: 20px;
            display: none;
        }
        .name
        {
            width: 100px;
        }
        .nickname
        {
        }
        .isexit
        {
            width: 60px;
        }
        
        .gtype
        {
            width: 40px;
        }
        .name input, .nickname input
        {
            width: 90%;
            border: solid 1px #D0D0D0;
            font-family: SimSun;
            font-size: 12px;
            padding: 3px;
        }
        .creator
        {
        }
        .operation
        {
            width: 120px;
            text-align: center;
        }
    </style>
    <script type="text/javascript" language="javascript">
        var CurrentWindow = parent.CurrentWindow;

        window.onload = function () {
            CurrentWindow.Completed();

            var state = GetState();
            if (state.Action == "RefreshFriendsList") {
                parent.Core.Session.GetGlobal("FriendsInfoCache").Refresh();
            }
            else if (state.Action == "Error") {
                parent.Core.Utility.ShowError(state.Exception.Message);
            }
        }

        function Update(name) {
            var config = {
                Left: 0, Top: 0,
                Width: 370, Height: 370,
                MinWidth: 370, MinHeight: 370,
                Title: {
                    InnerHTML: "修改群资料"
                },
                Resizable: false,
                HasMaxButton: false,
                HasMinButton: true,
                AnchorStyle: parent.Core.WindowAnchorStyle.Left | parent.Core.WindowAnchorStyle.Top
            }

            var form = parent.Core.CreateWindow(config);
            form.MoveEx('CENTER', 0, 0, true);
            form.ShowDialog(CurrentWindow, 'CENTER', 0, 0, true, null);
            var url = parent.Core.GetPageUrl(String.format("Management/UpdateAccountInfo.aspx?random={0}&Name={1}", (new Date()).getTime(), name));
            form.Load(url, null);
        }
        //by fj  2011-4-11  增加管理群成员
        function ManageGroupMember(name) {
            var config = {
                Left: 0, Top: 0,
                Width: 500, Height: 440,
                MinWidth: 500, MinHeight: 440,
                Title: {
                    InnerHTML: "管理群成员"
                },
                Resizable: false,
                HasMaxButton: false,
                HasMinButton: true,
                AnchorStyle: parent.Core.WindowAnchorStyle.Left | parent.Core.WindowAnchorStyle.Top
            }

            var form = parent.Core.CreateWindow(config);
            form.MoveEx('CENTER', 0, 0, true);
            form.ShowDialog(CurrentWindow, 'CENTER', 0, 0, true, null);
            var url = parent.Core.GetPageUrl(String.format("Management/AddMemberToGroup.aspx?random={0}&Name={1}", (new Date()).getTime(), name));
            form.Load(url, null);
        }

        function Delete(id, nickname, name, isCreator) {
            if (isCreator) {
                if (confirm(String.format("您确定要解散群组\"{0}\"({1})", nickname, name))) {
                    CurrentWindow.Waiting("正在删除群组...");
                    DoCommand("Delete", id);
                }
            }
            else {
                if (confirm(String.format("您确定要退出群组\"{0}\"({1})", nickname, name))) {
                    CurrentWindow.Waiting("正在退出群组...");
                    DoCommand("Exit", id);
                }
            }
        }

        function match(reg, str) {
            reg.lastIndex = 0;
            var ft = reg.exec(str);
            return (ft != null && ft.length == 1 && ft[0] == str)
        }

        function NewGroup() {
            var nameReg = /[a-zA-Z0-9_-]{2,256}/ig;

            var name = document.getElementById("new_group_name").value;
            if (name != "") {
                if (!match(nameReg, name)) {
                    alert("群账户名格式不正确（账户名为2-256位字符，并且只能包含英文字符，数字和下划线）！");
                    document.getElementById("new_group_name").focus();
                    return;
                }
            } else {
                name = "g" + (new Date()).getTime() + parseInt(Math.random() * 100000);
            }

            var nickname = document.getElementById("new_group_nickname").value;
            if (nickname == "") {
                alert("请输入群名称！");
                document.getElementById("new_group_nickname").focus();
                return;
            }
            var isExitGroup = 0;
            if (document.getElementById("chkIsExit").checked) {
                isExitGroup = 1;
            }
            var gtype = document.getElementById("cmbType").value;
            DoCommand("NewGroup", { Name: name, Nickname: nickname, IsExitGroup: isExitGroup, Type: gtype });
            return;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div class="table_blue">
        <div style="color: Red">
            友情提示：新建群时,群账号允许不输入,不输入会自动生成一个唯一码!</div>
        <br />
        <table cellpadding="0" cellspacing="0">
            <tr class='header'>
                <td class='headimg'>
                    &nbsp;
                </td>
                <td class='name'>
                    群账号
                </td>
                <td class='nickname'>
                    群简称
                </td>
                <td class='isexit'>
                    允许退群
                </td>
                <td class='gtype'>
                    类型
                </td>
                <td class='creator'>
                    群创建者
                </td>
                <td class='operation'>
                    操作
                </td>
            </tr>
            <tr>
                <td class='headimg'>
                    &nbsp;
                </td>
                <td class='name'>
                    <input type="text" id="new_group_name" name="new_group_name" />
                </td>
                <td class='nickname'>
                    <input type="text" id="new_group_nickname" name="new_group_nickname" />
                </td>
                <td class='isexit'>
                    <input type="checkbox" id="chkIsExit" name="chkIsExit" />
                </td>
                <td class='gtype'>
                    <select id="cmbType" name="cmbType">
                        <option value="1">群</option>
                        <option value="2">讨论组</option>
                    </select>
                </td>
                <td class='creator'>
                    &nbsp;
                </td>
                <td class='operation'>
                    <a href='javascript:NewGroup();'>新建群组</a>
                </td>
            </tr>
            <%= RenderFriendList()%>
        </table>
    </div>
    <uc1:CommandCtrl ID="CommandCtrl" runat="server" />
    </form>
</body>
</html>
