<%@ Page Language="C#" AutoEventWireup="true" Inherits="Management_FriendSearch" %>

<%@ Register Src="../CommandCtrl.ascx" TagName="CommandCtrl" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title></title>
    <link href="../CurrentVersion/Themes/Default/table.css" rel="stylesheet" type="text/css" />
    <link href="../CurrentVersion/Themes/Default/skin.css" rel="stylesheet" type="text/css" />
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
        .email
        {
        }
        .operation
        {
            width: 100px;
            text-align: center;
        }
    </style>
    <script type="text/javascript" language="javascript">
        var CurrentWindow = parent.CurrentWindow;

        window.onload = function () {
            CurrentWindow.Completed();

            var state = GetState();
            if (state.Action == "") {
            }
        }

        function AddFriend(peer) {
            DoCommand("AddFriend", peer);
        }
        function Search() {
            DoCommand("Search", document.getElementById("txtName").value);
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div class="table_blue">
        <div style="margin: 2px">
            <span>用户名/昵称</span>&nbsp;<input type="text" id="txtName" style="width: 200px" class="TextBoxDefault" />&nbsp;&nbsp;<input
                type="button" id="btnSearch" value="查    找" onclick="Search()" class="BtnDefault" /></div>
        <div style="overflow: auto; width: 555px; height: 340px;">
            <table cellpadding="0" cellspacing="0">
                <tr class='header'>
                    <td class='headimg'>
                        &nbsp;
                    </td>
                    <td class='name'>
                        用户名
                    </td>
                    <td class='nickname'>
                        昵称
                    </td>
                    <td class='email'>
                        电子邮件
                    </td>
                    <td class='operation'>
                        操作
                    </td>
                </tr>
                <%= RenderFriendList()%>
            </table>
        </div>
    </div>
    <uc1:CommandCtrl ID="CommandCtrl" runat="server" />
    </form>
</body>
</html>
