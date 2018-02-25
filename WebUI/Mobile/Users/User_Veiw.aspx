<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="User_Veiw.aspx.cs" Inherits="WC.WebUI.Mobile.Users.User_Veiw" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html>
<head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <title>智能移动办公平台-管理员</title>
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
    <div class="list">
        <ul>
            <li>
                <h4>用户名/真实姓名：<%=UserName %>/<%=RealName %></h4>
            </li>
            <li>
                <span>职能部门：<b><%=DepName %></b></span>
                <span>职务名称：<b><%=PositionName %></b></span>
                <span>上司领导：<b><%=DirectSupervisor %></b></span>
                <span>入职时间：<b><%=JoinTime %></b></span>
                <span>性别/年龄：<b><%=Sex %>（<%=Birthday %>）</b></span>
                <span>移动电话：<b><%=Phone %></b></span>
                <span>固定电话：<b><%=Tel%></b></span>
                <span>电子邮件：<b><%=Email %></b></span>
                <span>腾讯QQ：<b><%=QQ %></b></span>
                <span>居住地址：<b><%=HomeAddress %></b></span>
                <span>状态：<b><%=Status %></b></span>
            </li>
        </ul>
    </div>
    <div class="list">
        <ul>
            <li><span>档案文件：<b><%=fjs %></b></span></li>
        </ul>
    </div>
    <div class="list">
        <ul>
            <li><span>备注：<b><%=Notes %></b></span></li>
        </ul>
    </div>
    <div class="list">
        <ul>
            <li>
                <span>个人图片：<b></b></span>
                <div class="pic">
                    <%if (!string.IsNullOrEmpty(ImageUrl))
                        { %>
                    <img src="<%=ImageUrl %>">
                    <%}
                    else
                    { %>
                   <img src="../image/pic.jpg" />
                    <%} %>
                </div>
            </li>
        </ul>
    </div>
</body>
</html>
