<%@ Page Language="C#" AutoEventWireup="true" Inherits="Desktop" %>

<%@ Register Src="Script/MainScript.ascx" TagName="MainScript" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>即时通讯</title>
    <uc1:MainScript ID="MainScript1" runat="server" />

    <script language="javascript" type="text/javascript">
        window.onload = function () {
            if (GetCookie("IsOpen") == "") {
                SetCookie("IsOpen", "1");
                StartService();
            } else {
                window.onunload = null;
                window.opener = null;
                window.open("", "_self");
                window.close();
            }
        }

        window.onunload = function () {
            if (GetCookie("IsOpen") != "")
                DeleteCookie("IsOpen");
        }
    </script>

</head>
<body>
<bgsound src="#" id="music" loop="1" autostart="true">
    <form id="form1" runat="server">
    <div>
    </div>
    </form>
</body>
</html>
