<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="User_OnLine.aspx.cs" Inherits="WC.WebUI.Mobile.Users.User_OnLine" %>

<%@ Register Src="~/Controls/Page.ascx" TagName="Page" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
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
            <li><a href="UserMenu.aspx">上级菜单</a></li>
        </ul>
    </div>
    <form id="form1" runat="server">
        <div class="user">
            <asp:Repeater runat="server" ID="rpt_person" EnableViewState="false">
                <ItemTemplate>
                    <dl class="<%# Convert.ToBoolean(Eval("IsOnline"))?"":"gray" %>">
                        <a href='User_Veiw.aspx?uid=<%#Eval("id") %>'>

                            <dt>
                                <img alt="" src="<%#Eval("PerPic")%>"></dt>
                            <dd>
                                <h4><%#Eval("DepName")%></h4>
                                <p><%# Convert.ToBoolean(Eval("IsOnline")) ? Eval("RealName") +" (活动)" :  Eval("RealName") + " (离开)"%></p>
                                <span><%#  WC.Tool.Utils.ConvertDate5(Eval("LastLoginTime")) %></span>
                            </dd>
                        </a>
                    </dl>
                </ItemTemplate>
            </asp:Repeater>
            <%--<div class="tongji" id="footer">当前总计：<span>1</span>位&nbsp;&nbsp;&nbsp;&nbsp;在线用户</div>--%>

             <div id="footer" class="tongji">
            当前总计：<span  id="num1" runat="server" ></span>位&nbsp;&nbsp;&nbsp;&nbsp;在线用户
            <br>
            <br>
            <uc1:Page ID="Page1" runat="server" />
        </div>

        </div>
    </form>
</body>
</html>
