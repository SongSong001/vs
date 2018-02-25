<%@ Page Language="C#" AutoEventWireup="true" Inherits="FloatFriendInfo" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>好友信息</title>
    <script type="text/javascript" src="CurrentVersion/Core/Common.js"></script>
    <link href="CurrentVersion/Themes/Default/skin.css" type="text/css" rel="Stylesheet" />
    <style type="text/css">
        .tdRight
        {
            width: 60px;
            margin: 5px;
            text-align: right;
        }
        .tr
        {
            height:18px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div style="margin: 2px">
        <table style="width: 248px; margin:2px;">
            <tr class="tr">
                <td class="tdRight">
                    昵称：
                </td>
                <td>
                    <span id="spanNickname"></span>
                </td>
            </tr>
            <tr class="tr">
                <td class="tdRight">
                    联系电话：
                </td>
                <td>
                    <span id="spanPhone"></span>
                </td>
            </tr>
            <tr class="tr">
                <td class="tdRight">
                    联系手机：
                </td>
                <td>
                    <span id="spanTelPhone"></span>
                </td>
            </tr>
            <tr class="tr">
                <td class="tdRight">
                    EMail：
                </td>
                <td>
                    <span id="spanEMail"></span>
                </td>
            </tr>
        </table>
    </div>
    <script type="text/javascript">
        document.getElementById("spanNickname").innerHTML = unescape(Core.Params["NickName"]);
        document.getElementById("spanPhone").innerHTML = unescape(Core.Params["Phone"]);
        document.getElementById("spanTelPhone").innerHTML = unescape(Core.Params["TelPhone"]);
        document.getElementById("spanEMail").innerHTML = unescape(Core.Params["EMail"]);
    </script>
    </form>
</body>
</html>
