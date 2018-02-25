<%@ Page Language="C#" AutoEventWireup="true" Inherits="Login_lesktop" %>

<%@ Register Src="Script/SubScript.ascx" TagName="SubScript" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>登录</title>
    <uc1:SubScript ID="SubScript1" runat="server" />
    <style type="text/css">
        html
        {
            overflow: hidden;
            border: 0px;
        }
        body
        {
            padding: 0px;
            margin: 0px;
            border: 0px;
        }
        .div_bk
        {
            background: url("images/login_bk.png" ) repeat-x;
            width: 580px;
            height: 380px;
            padding: 10px 10px 10px 10px;
        }
        .div_logo
        {
            background: url("images/login_logo.gif" ) no-repeat;
            width: 230px;
            height: 60px;
        }
        #txtUser, #txtuser_reg, #txtemail_reg, #txtnick_reg
        {
            position: absolute;
            font-size: 12px;
            padding: 5px;
            font-family: Courier New;
            border: solid 1px #7F9DB9;
        }
        #txtpwd, #txtpwd_reg, #txtpwd_confirm_reg
        {
            position: absolute;
            font-size: 14px;
            padding: 5px;
            font-family: 宋体;
            border: solid 1px #7F9DB9;
        }
        label
        {
            font-size: 12px;
            font-family: 宋体;
        }
        #login, #register
        {
            font-family: 宋体;
            font-size: 12px;
            height: 12px;
            padding: 4px 8px 4px 8px;
        }
        .link
        {
            font-family: 宋体;
            font-size: 12px;
            position: absolute;
            color: #229ACD;
            cursor: pointer;
            text-align: right;
            text-decoration: none;
        }
        .link:hover
        {
            text-decoration: underline;
        }
    </style>

    <script language="javascript" type="text/javascript">

        document.onkeydown = function() {
            if (event.keyCode == 116 || (event.ctrlKey && event.keyCode == 82)) {
                event.keyCode = 0;
                event.returnValue = false;
                return false;
            }
            if (event.keyCode == 70 && event.ctrlKey && !event.altKey && !event.shiftKey) {
                event.keyCode = 0;
                event.returnValue = false;
                return false;
            }

        }
    </script>

    <script language="javascript" type="text/javascript">
        function init() {
            //by fj 2011-3-24  修改为自动登录
            var s = document.getElementById("status").value;
            if (s == "login") {
                CurrentWindow.Completed();
                Core.OutputPanel.MoveEx("", 10000, 10000, true);
                Core.OutputPanel.Show();

                Core.OutputPanel.Load(
				Core.GetPageUrl("Output.aspx"),
				function() {
				    Core.OutputPanel.Hide();

				    var login_data = Core.Utility.ParseJson(document.getElementById("data").value);

				    Core.Session.InitService(
						login_data.UserInfo.Name,
						login_data.UserInfo,
						document.cookie,
						document.getElementById("sessionId").value
					);
				    Core.Taskbar.Show();
				    Core.Session.GetGlobal("SingletonForm").ShowFriendForm();
				    CurrentWindow.Close();
				}
			);
            }
            else if (s == "error") {
                CurrentWindow.Completed();
                Core.Utility.ShowError(document.getElementById("data").value);
            }
        }

        function ShowLoginPage() {

        }

        function ShowRegPage() {

        }

        function match(reg, str) {
            reg.lastIndex = 0;
            var ft = reg.exec(str);
            return (ft != null && ft.length == 1 && ft[0] == str)
        }

        function form1_onsubmit() {
            CurrentWindow.Waiting("");
            return true;
        }
    </script>

</head>
<body>
    <form id="form1" runat="server" onsubmit="return form1_onsubmit();">
    <input id="status" name="status" runat="server" type="hidden" value="none" />
    <input id="data" name="data" runat="server" type="hidden" value="" />
    <input id="sessionId" name="sessionId" runat="server" type="hidden" value="" />
    </form>
</body>
</html>
