<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewsView.aspx.cs" Inherits="WC.WebUI.Mobile.News.NewsView" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%--<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>智能移动办公平台</title>
    <meta content="yes" name="apple-mobile-web-app-capable" />
    <meta content="index,follow" name="robots" />
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
    <link href="../Style/Mobile/pics/homescreen.gif" rel="apple-touch-icon" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" /> 
    <link href="../Style/Mobile/css/Style.css" rel="stylesheet" media="screen" type="text/css" />
    <link href="../Style/Mobile/css/developer-style.css" rel="stylesheet" type="text/css" />

    <link href="../Style/Mobile/pics/startup.png" rel="apple-touch-startup-image" />
</head>
<body>
    <form id="form1" runat="server">
    <div id="topbar">
        <div id="title">
            查看资讯内容</div>
        <div id="leftbutton">
            <a href="../Index.aspx" class="noeffect">主页</a>
        </div>
        <div id="rightnav">
            <a href="../LoginOut.aspx" class="noeffect" onclick="return confirm('您确实要安全退出吗？')">注销</a>
        </div>
    </div>

    <div id="tributton">
        <div class="links">
            <a href="../Menu.aspx">功能菜单</a><a href="../Users/User_OnLine.aspx">在线用户</a><a href="NewsMenu.aspx">上级菜单</a></div>
    </div>

    <div id="content">
        <span class="graytitle">
            <span id="Label1">
            标题： 
            <span style='color:#ff0000' runat=server ID=NewsTitle></span>
            </span>
        </span>

        <ul class="pageitem">
            <li class="textbox">
            <span class="header">发布人员：<span runat=server ID=Creator style=' color:#000;'></span></span>
            <span class="header">发布日期：<span runat=server ID=addtime style=' color:#000'></span></span>
            </li>
        </ul>   

        <ul class="pageitem">
            <li class="textbox">
            <span class="header">文章内容：</span>
                    <p>
                    
                    <div runat=server ID=Notes style='overflow: auto; overflow-y:hidden;font-size:13pt'></div></p>
            </li>
        </ul> 

        <ul class="pageitem">
            <li class="textbox"><span class="header">相关附件：</span>
            <div style="font-weight:bold;"><%=fjs %></div>
            </li>
        </ul> 

        <ul class="pageitem">
            <li class="textbox">
            <span class="header">接受范围：<span runat=server ID=Deps style=' color:#000;'></span></span>
            </li>
        </ul>  

    </div>
    </form>
</body>
</html>--%>


<html>
<head id="Head1" runat="server">
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
            <li><a href="NewsMenu.aspx">上级菜单</a></li>
        </ul>
    </div>
    <div class="list">
        <ul>
            <li>
                <h4  runat='server' ID='NewsTitle'></h4>
            </li>
            <li>
                <span>发布人员：<b runat='server' ID='Creator'></b></span>
                <span>发布日期：<b runat='server' ID='addtime'></b></span>
                <span>文章内容：<b runat='server' ID='Notes'></b></span>
                <span>相关附件：<b><%=fjs %></b></span>
                <span>接收范围：<b runat='server' ID='Deps'></b></span>
            </li>
        </ul>
    </div>

    <script type="text/javascript" src="../js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript">
        if ($(".fixed").length > 0) {
            $(".list").last().css({ paddingBottom: $(".fixed").outerHeight() })
        }
    </script>
         </form>
</body>
</html>
