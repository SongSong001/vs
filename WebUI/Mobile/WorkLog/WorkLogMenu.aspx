<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WorkLogMenu.aspx.cs" Inherits="WC.WebUI.Mobile.WorkLog.WorkLogMenu" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%--<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>智能移动办公平台</title>
    <meta content="yes" name="apple-mobile-web-app-capable" />
    <meta content="index,follow" name="robots" />
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
    <link href="../Style/Mobile/pics/homescreen.gif" rel="apple-touch-icon" />
    <meta content="minimum-scale=1.0, width=device-width, maximum-scale=0.6667, user-scalable=no"
        name="viewport" />

    <link href="../Style/Mobile/css/Style.css" rel="stylesheet" media="screen" type="text/css" />

    <link href="../Style/Mobile/pics/startup.png" rel="apple-touch-startup-image" />
</head>
<body>
    <form id="form1" runat="server">
    <div id="topbar">
        <div id="title">
            智能移动办公平台</div>
        <div id="leftbutton">
            <a href="../Index.aspx" class="noeffect">主页</a>
        </div>
        <div id="rightbutton">
            <a href="../LoginOut.aspx" class="noeffect" onclick="return confirm('您确实要安全退出吗？')">注销</a>
        </div>
    </div>
    <div id="tributton">
        <div class="links">
            <a href="../Menu.aspx">功能菜单</a><a href="../Users/User_OnLine.aspx">在线用户</a><a href="../Menu.aspx">上级菜单</a></div>
    </div>
    <div id="content">
        <span class="graytitle">基本菜单</span>
        <ul class="pageitem">
            <li class="textbox"><span class="header">欢迎,<%=RealName %></span><p>
                工作汇报 >> 功能菜单</p>
            </li>

<li class="menu"><a href="WorkLogList.aspx?action=mydoc" id="A0">
<img  src="../Style/Mobile/thumbs/basics.png"/>
<span  class="name">我的汇报列表</span>
<span class="arrow"></span></a></li>

<li class="menu"><a href="WorkLogList.aspx?action=shared" id="A1">
<img  src="../Style/Mobile/thumbs/appstore.png"/>
<span  class="name">他人汇报列表</span>
<span class="arrow"></span></a></li>

<li class="menu"><a href="AddWorkLog.aspx" id="A2">
<img  src="../Style/Mobile/thumbs/start.png"/>
<span  class="name">新建工作汇报</span>
<span class="arrow"></span></a></li>

        </ul>
    </div>
    </form>
</body>
</html>--%>
<html>
<head>
 <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<title>智能移动办公平台-工作流程</title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<meta name="format-detection" content="telephone=no" />
<meta name="format-detection" content="email=no" />
<meta name="format-detection" content="address=no" />
<meta name="format-detection" content="date=no" />

    <link href="../css/index.css" rel="stylesheet" />
</head>
<body>
 <div class="head">
        <a href="../Index.aspx" class="prev"><i class="icon"></i></a>
        <div class="head_bt">智能移动办公平台</div>
        <a href="../LoginOut.aspx" onclick="return confirm('您确实要安全退出吗？')" class="close"><i class="icon"></i></a>
    </div>
    <div class="daohang">
        <ul>
            <li><a href="../Menu.aspx">功能菜单</a></li>
            <li><a href="../Users/User_OnLine.aspx">在线用户</a></li>
            <li><a href="../Menu.aspx">上级菜单</a></li>
        </ul>
    </div>
<div class="list">
    <ul>
        <li><h4>基本功能菜单</h4></li>
        <li>
            <span>欢迎您，<%=RealName %></span>
            <p>工作汇报&gt;&gt;功能菜单</p>
        </li>
        <li>
            <a href="WorkLogList.aspx?action=mydoc"><i class="icon icon_list7"></i>我的汇报列表</a>
        </li>
        <li>
            <a href="WorkLogList.aspx?action=shared"><i class="icon icon_list8"></i>他人汇报列表</a>
        </li>
        <li>
            <a href="AddWorkLog.aspx"><i class="icon icon_list9"></i>新建工作汇报</a>
        </li>
      
    </ul>
</div>
        <div class="fix">
        <ul>
            <li><a href="../News/NewsMenu.aspx"><i class="icon information"></i><span>资讯</span></a></li>
            <li><a href="../AddrBook/Menu.aspx"><i class="icon contacts"></i><span>联系人</span></a></li>
            <li><a href="../Tasks/TaskMenu.aspx"><i class="icon work"></i><span>工作</span></a></li>
            <li><a href="../Files/FileMenu.aspx"><i class="icon word"></i><span>文档</span></a></li>
            <li><a href="../Users/UserMenu.aspx"><i class="icon my"></i><span>我的</span></a></li>
        </ul>
    </div>
</body>
</html>