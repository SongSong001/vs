<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="User_PwdEdit.aspx.cs" Inherits="WC.WebUI.Mobile.Users.User_PwdEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>智能移动办公平台</title>
    <meta content="yes" name="apple-mobile-web-app-capable" />
    <meta content="index,follow" name="robots" />
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
    <link href="../Style/Mobile/pics/homescreen.gif" rel="apple-touch-icon" />
    <meta content="minimum-scale=1.0, width=device-width, maximum-scale=0.6667, user-scalable=no"
        name="viewport" />


    <link href="../Style/Mobile/css/Style.css" rel="stylesheet" media="screen" type="text/css" />
    <link href="../Style/Mobile/css/developer-style.css" rel="stylesheet" type="text/css" />

    <link href="../Style/Mobile/pics/startup.png" rel="apple-touch-startup-image" />
 
</head>
<body>
    <form id="form1" runat="server" >
    <div id="topbar">
        <div id="title">
            修改个人密码</div>
        <div id="leftbutton">
            <a href="../Index.aspx" class="noeffect">主页</a>
        </div>
        <div id="rightnav">
            <a href="../LoginOut.aspx" class="noeffect" onclick="return confirm('您确实要安全退出吗？')">注销</a>
        </div>
    </div>

    <div id="tributton">
        <div class="links">
            <a href="../Menu.aspx">功能菜单</a><a href="../Users/User_OnLine.aspx">在线用户</a><a href="UserMenu.aspx">上级菜单</a></div>
    </div>

    <div id="content">
        <fieldset>
            <span class="graytitle">个人密码修改</span>
            <ul class="pageitem">
                <li class="textbox">
                    <span class="header">用户名： <span runat=server ID=Uname style=' color:#000;'></span></span>
                    <span class="header">真实姓名： <span runat=server ID=Urealname style=' color:#000;'></span></span>
                </li>
            </ul>

            <span class="graytitle">输入区域(密码)：</span>
            <ul class="pageitem">
                <li class="bigfield">
                <input runat=server maxlength=16  name="Oldpwd" type=password id="Oldpwd" placeholder="输入原来的密码" style="width:100%;" />
                </li>
                <li class="bigfield">
                <input runat=server maxlength=16  name="newpwd" type=password id="newpwd" placeholder="输入新密码" style="width:100%;" />
                </li>
                <li class="bigfield">
                <input runat=server maxlength=16  name="newpwd1" type=password id="newpwd1" placeholder="再次输入新密码" style="width:100%;" />
                </li>
            </ul>

            <ul class="pageitem">
                <li class="button" style="text-align: center;">
                 <asp:Button ID="bt5" OnClientClick='javascript:return confirm("您确定吗?")' runat="server" Text="确定保存" OnClick="Save_Btn" />
                </li>
            </ul>




        </fieldset>
    </div>

    </form>
</body>
</html>
