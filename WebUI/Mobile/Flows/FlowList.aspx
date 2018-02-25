<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FlowList.aspx.cs" Inherits="WC.WebUI.Mobile.Flows.FlowList" %>
<%@ Register Src="~/Controls/Page.ascx" TagName="Page" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%--<html xmlns="http://www.w3.org/1999/xhtml">
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
    <link type="text/css" href="/DK_Css/page_css.css" rel="stylesheet" />

</head>
<body class="applist">
    <div id="topbar">
        <div id="title">
            <%=flow_list %></div>
        <div id="leftbutton">
            <a href="../Index.aspx" class="noeffect">主页</a>
        </div>
        <div id="rightnav">
            <a href="../LoginOut.aspx" onclick="return confirm('您确实要安全退出吗？')">注销</a>
        </div>
    </div>
    <div id="tributton">
        <div class="links">
            <a href="../Menu.aspx">功能菜单</a><a href="../Users/User_OnLine.aspx">在线用户</a><a href="FlowMenu.aspx">上级菜单</a></div>
    </div>
    <div class="searchbox">
        <form action='FlowList.aspx?type=<%=Request.QueryString["action"] %>' method="post">
        <fieldset>
            <input name="keywords" id="keywords" placeholder="查找(标题/姓名)" type="text" />
        </fieldset>
        </form>
    </div>

<form id="form1" runat="server">
    <div id="content">
        <ul>
            <asp:Repeater runat=server ID=rpt EnableViewState=false><ItemTemplate>
            <li><a class="effect" href='FlowView.aspx?fl=<%#Eval("id") %>'>
            <span class="image" style="background-image: url('../Style/Mobile/thumbs/other.png')"></span>
                <span class="comment"><%#Eval("CreatorRealName")%> (发起人)</span> 
                <span class="name">
                <%# WC.Tool.Utils.GetSubString2(Eval("Flow_Name") + "", 17, "..")%>
                </span> 
                <span class="stars4">
                <%# WC.Tool.Utils.ConvertDate1(Eval("AddTime"))%> (创建)
                </span>
                <span class="arrow"></span>
                <span class="price"></span></a> </li>
            </ItemTemplate>
            </asp:Repeater>

        </ul>
    </div>

<div id="footer">
<span style="float:left;" id=num runat=server></span><br><br>
<uc1:Page ID="Page1" runat="server" />
</div>
</form>
</body>
</html>--%>

<html>
<head id="Head1" runat="server">
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <title>智能移动办公平台-在线用户</title>
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
            <li><a href="FlowMenu.aspx">上级菜单</a></li>
        </ul>
    </div>
    <div>
        <div class="list_edit">
            <ul>
                <li>
                    <form action='FlowList.aspx?type=<%=Request.QueryString["action"] %>' method="post">
                        <label>搜索公文：</label>

                        <input runat="server"
                            name="keywords" id="keywords" placeholder="查找(姓名/部门)" type="text" />

                    </form>
                </li>
            </ul>
        </div>

    </div>
    <form id="form1" runat="server">
        <div class="user">
            <asp:Repeater runat="server" ID="rpt" EnableViewState="false">
                <ItemTemplate>
                    <dl>
                        <a href='FlowView.aspx?fl=<%#Eval("id") %>'>

                            <dt>
                                <img alt="" src="../image/user.jpg" /></dt>
                            <dd>
                                <dd>
                                    <h4><%#Eval("CreatorRealName")%> (发起人)</h4>
                                    <p><%# WC.Tool.Utils.GetSubString2(Eval("Flow_Name") + "", 17, "..")%>%></p>
                                    <span> <%# WC.Tool.Utils.ConvertDate1(Eval("AddTime"))%> (创建)</span>
                                </dd>
                        </a>

                    </dl>
                </ItemTemplate>
            </asp:Repeater>


            <div id="footer" class="tongji">
                当前总计：<span id="num" runat="server"></span>条&nbsp;&nbsp;&nbsp;&nbsp; 记录数据
                <uc1:Page ID="Page1" runat="server" />
            </div>

        </div>
    </form>
</body>
</html>
