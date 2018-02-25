<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Redirect.aspx.cs" Inherits="WC.WebUI.Mobile.Utils.Redirect" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>智能移动办公平台</title>
    <meta content="yes" name="apple-mobile-web-app-capable" />
    <meta content="index,follow" name="robots" />
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
    <link href="../Style/Mobile/pics/homescreen.gif" rel="apple-touch-icon" />
    <meta content="minimum-scale=1.0, width=device-width, maximum-scale=0.6667, user-scalable=no"
        name="viewport" />
    <meta http-equiv=refresh content="2; url=<%=return_page %>">
    <link href="../Style/Mobile/css/Style.css" rel="stylesheet" media="screen" type="text/css" />
    <link href="../Style/Mobile/css/developer-style.css" rel="stylesheet" type="text/css" />

    <link href="../Style/Mobile/pics/startup.png" rel="apple-touch-startup-image" />
    <link type="text/css" href="/DK_Css/page_css.css" rel="stylesheet" />
</head>
<body class="applist">

    <div id="topbar">
        <div id="title">
            操作提示语</div>
        <div id="leftbutton">
            <a href="../Index.aspx" class="noeffect">主页</a>
        </div>
        <div id="rightnav">
            <a href="../LoginOut.aspx" onclick="return confirm('您确实要安全退出吗？')">注销</a>
        </div>
    </div>
    <div id="tributton">
        <div class="links">
            <a href="../Menu.aspx">功能菜单</a><a href="../Users/User_OnLine.aspx">在线用户</a><a href="#" onclick="javascript:window.location.replace(window.location.href);">刷新本页</a></div>
    </div>


<form id="form1" runat="server">
    <div id="content">
        <ul>
            <li>
            </li>

        </ul>
        <ul>
            <li style=' text-align:center'>
            <span style='font-size:16pt; color:#006600; font-weight:bold;'>
            <%=tip %>
            </span>
            <br><br>
            <span>2秒后自动转向..</span>
            </li>
        </ul>
    </div>

<div id="footer">
<br>

</div>
</form>

</body>
</html>
