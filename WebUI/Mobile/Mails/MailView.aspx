<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MailView.aspx.cs" Inherits="WC.WebUI.Mobile.Mails.MailView" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%--
<head id="Head1" runat="server">
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
    <form id="form1" runat="server">
    <div id="topbar">
        <div id="title">
            查看邮件内容</div>
        <div id="leftbutton">
            <a href="../Index.aspx" class="noeffect">主页</a>
        </div>
        <div id="rightnav">
            <a href="../LoginOut.aspx" class="noeffect" onclick="return confirm('您确实要安全退出吗？')">注销</a>
        </div>
    </div>

    <div id="tributton">
        <div class="links">
            <a href="../Menu.aspx">功能菜单</a><a href="../Users/User_OnLine.aspx">在线用户</a><a href="MailMenu.aspx">上级菜单</a></div>
    </div>

    <div id="content">
        <span class="graytitle">
            <span id="Label1">
            标题： 
            <span style='color:#ff0000' runat=server ID=Subject></span>
            </span>
        </span>

        <ul class="pageitem">
            <li class="textbox">
            <span class="header">发件人员：<span runat=server ID=Sender style=' color:#000;'></span></span>
            <span class="header">发件时间：<span runat=server ID=Sendtime style=' color:#000'></span></span>
            </li>
        </ul>   

        <ul class="pageitem">
            <li class="textbox">
            <span class="header">邮件内容：</span>
                    <p><div runat=server ID=bodys style='overflow: auto; overflow-y:hidden;font-size:13pt'></div></p>
            </li>
        </ul> 

        <ul class="pageitem">
            <li class="textbox"><span class="header">相关附件：</span>
            <div style="font-weight:bold;"><%=fjs %></div>
            </li>
        </ul> 

        <ul class="pageitem">
            <li class="textbox">
            <span class="header">收件人：<span runat=server ID=sjr style=' color:#000;'></span></span>
            </li>
        </ul>  

        <span class="graytitle">快捷回复：</span>
            <ul class="pageitem">
                <li class="textbox">
                    <textarea runat="server" name="replay" id="replay" placeholder="快捷回复的内容" rows="4" style="width:100%;"></textarea>
                </li>
                <li class="button" style="text-align: center;">
                    <asp:Button ID="bt5" runat="server" OnClientClick='javascript:return confirm("您确定吗?")' Text="发送快捷回复" OnClick="Replay_Btn" />
                </li>
            </ul>

    </div>
    </form>
</body>
</html>--%>


<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <title>智能移动办公平台-标题</title>
    <meta name="keywords" content="" />
    <meta name="description" content="" />
    <meta name="format-detection" content="telephone=no" />
    <meta name="format-detection" content="email=no" />
    <meta name="format-detection" content="address=no" />
    <meta name="format-detection" content="date=no" />

    <link href="../css/index.css" rel="stylesheet" />

</head>
<body>
    <form id="form1" runat="server">
        <div class="head">
            <a href="../Index.aspx" class="prev"><i class="icon"></i></a>
            <div class="head_bt">智能移动办公平台</div>
            <a href="../LoginOut.aspx" onclick="return confirm('您确实要安全退出吗？')" class="close"><i class="icon"></i></a>
        </div>
        <div class="daohang">
            <ul>
                <li><a href="../Menu.aspx">功能菜单</a></li>
                <li><a href="../Users/User_OnLine.aspx">在线用户</a></li>
                <li><a href="MailList.aspx">上级菜单</a></li>
            </ul>
        </div>
        <div class="list">
            <ul>
                <li>
                    <h4 runat='server' id='Subject'></h4>
                </li>
                <li>
                    <span>发件人员：<b runat='server' id='Sender'></b></span>
                    <span>发件时间：<b runat='server' id='Sendtime'></b></span>
                    <span>邮件内容：<b runat='server' id='bodys'></b></span>
                    <span>相关附件：<b><%=fjs %></b></span>
                    <span>收件人：<b runat="server" id="sjr"></b></span>
                </li>
            </ul>
        </div>
        <div class="list">
            <ul>
                <li><span>快捷回复：</span>
                    <textarea runat="server" name="replay" id="replay" placeholder="快捷回复的内容" rows="4"></textarea></li>
            </ul>
        </div>
        <div class="fixed"><a runat="server" onserverclick="Replay_Btn" id="bt5">发送快捷回复</a></div>
        <script type="text/javascript" src="../js/jquery-1.7.2.min.js"></script>
        <script type="text/javascript">
            if ($(".fixed").length > 0) {
                $(".list").last().css({ paddingBottom: $(".fixed").outerHeight() })
            }
        </script>
    </form>
</body>
</html>
