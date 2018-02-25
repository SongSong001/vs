<%@ Page Language="C#" AutoEventWireup="true" Inherits="Management_AllUsers" %>

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
        .email
        {
        }
        .phone
        {
            width: 100px;
            text-align: right;
        }
        .telphone
        {
            width: 100px;
            text-align: right;
        }
        .operation
        {
            width: 100px;
            text-align: right;
        }
    </style>
    <script type="text/javascript" language="javascript">
        var CurrentWindow = parent.CurrentWindow;

        window.onload = function () {
            CurrentWindow.Completed();

            var state = GetState();
            if (state.Action == "") {
            }
            else if (state.Action == "Error") {
                parent.Core.Utility.ShowError(state.Exception.Message);
            }
        }

        function Delete(id, nickname, name) {
            if (confirm(String.format("您确定要删除员工\"{0}\"({1})", nickname, name))) {
                CurrentWindow.Waiting("正在删除员工...");
                DoCommand("Delete", id);
            }
        }

        function Update(name) {
            var config = {
                Left: 0, Top: 0,
                Width: 370, Height: 370,
                MinWidth: 370, MinHeight: 370,
                Title: {
                    InnerHTML: "修改员工资料"
                },
                Resizable: false,
                HasMaxButton: false,
                HasMinButton: true,
                AnchorStyle: parent.Core.WindowAnchorStyle.Left | parent.Core.WindowAnchorStyle.Top
            }

            var form = parent.Core.CreateWindow(config);
            form.MoveEx('CENTER', 0, 0, true);
            form.ShowDialog(CurrentWindow, 'CENTER', 0, 0, true, null);
            var url = parent.Core.GetPageUrl(String.format("Management/UpdateSelfInfo.aspx?random={0}&Name={1}", (new Date()).getTime(), name));
            form.Load(url, null);
        }

        function AddUser() {
            var name = document.getElementById("txtName").value;
            if (name != "") {
                if (!name.match(/[a-zA-Z0-9_-]{2,256}/ig)) {
                    alert("用户名格式不正确（用户名为2-256位字符，并且只能包含英文字符，数字和下划线）！");
                    document.getElementById("txtName").focus();
                    return;
                }
            } else {
                alert("请输入用户名！");
                document.getElementById("txtName").focus();
                return;
            }

            var nickname = document.getElementById("txtNickname").value;
            if (nickname == "") {
                alert("请输入昵称！");
                document.getElementById("txtNickname").focus();
                return;
            }
            var email = document.getElementById("txtEmail").value;
            if (email != "") {
                if (!email.match(/[a-zA-Z0-9._\-]+@[a-zA-Z0-9._\-]+/ig)) {
                    alert("Email格式不正确！");
                    document.getElementById("txtEmail").focus();
                    return;
                }
            }
            var phone = document.getElementById("txtPhone").value;
            if (phone != "") {
                if (!phone.match(/[0-9\-]{6,30}/ig)) {
                    alert("联系电话格式不正确！");
                    document.getElementById("txtPhone").focus();
                    return;
                }
            }
            var telphone = document.getElementById("txtTelPhone").value;
            if (telphone != "") {
                if (!telphone.match(/[0-9]{11,11}/ig)) {
                    alert("联系手机格式不正确！");
                    document.getElementById("txtTelPhone").focus();
                    return;
                }
            }
            DoCommand("NewUser", { Name: name, Nickname: nickname, TelPhone: telphone, Phone: phone, Email: email });
            return;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div class="table_blue">
        <table cellpadding="0" cellspacing="0">
            <tr class='header'>
                <td class='name'>
                    用户名
                </td>
                <td class='nickname'>
                    昵称
                </td>
                <td class='email'>
                    电子邮件
                </td>
                <td class='phone'>
                    联系电话
                </td>
                <td class='telphone'>
                    联系手机
                </td>
                <td class='operation'>
                    操作
                </td>
            </tr>
            <tr>
                <td class='name'>
                    <input type="text" id="txtName" name="txtName" style="width: 99%" />
                </td>
                <td class='nickname'>
                    <input type="text" id="txtNickname" name="txtNickname" style="width: 99%" />
                </td>
                <td class='email'>
                    <input type="text" id="txtEmail" name="txtEmail" style="width: 99%" />
                </td>
                <td class='phone'>
                    <input type="text" id="txtPhone" name="txtPhone" style="width: 99%" />
                </td>
                <td class='telphone'>
                    <input type="text" id="txtTelPhone" name="txtTelPhone" style="width: 99%" />
                </td>
                <td class='operation'>
                    <a href='javascript:AddUser();'>新增员工</a>
                </td>
            </tr>
            <%= RenderAllUsersList()%>
        </table>
    </div>
    <uc1:CommandCtrl ID="CommandCtrl" runat="server" />
    </form>
</body>
</html>
