<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PublicAddrBook.aspx.cs" Inherits="WC.WebUI.Mobile.AddrBook.PublicAddrBook" %>

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
            <li><a href="Menu.aspx">上级菜单</a></li>
        </ul>
    </div>

        <div>
        <div class="list_edit">
            <ul>
                <li>
                     <form action='PublicAddrBook.aspx?type=search' method="post">
                        <label>搜索电话：</label>

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
                        <a href='wtai://wp/mc;<%#Eval("Phone")%>'>

                            <dt>
                                <img alt="" src="../image/user.jpg" /></dt>
                            <dd>
                                <dd>
                                    <h4><%#Eval("DepName")%></h4>
                                    <p><%#Eval("RealName")%></p>
                                    <span><%# WC.WebUI.Dk.Help.ValidateMobile(Eval("Phone") + "") ? Eval("Phone")+" (拨号)" : Eval("Phone")%></span>
                                </dd>
                        </a>

                    </dl>
                </ItemTemplate>
            </asp:Repeater>


            <div id="footer" class="tongji">
                当前总计：<span id="num1" runat="server"></span>条&nbsp;&nbsp;&nbsp;&nbsp; 记录数据
            <br>
                <br>
                <uc1:Page ID="Page1" runat="server" />
            </div>

        </div>
    </form>
</body>
</html>
