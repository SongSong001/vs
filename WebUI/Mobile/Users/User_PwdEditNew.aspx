<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="User_PwdEditNew.aspx.cs" Inherits="WC.WebUI.Mobile.Users.User_PwdEditNew" %>

<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <title>智能移动办公平台-修改密码</title>
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
            <a  href="../Index.aspx"  class="prev"><i class="icon"></i></a>
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
                </li>
            </ul>
        </div>
        <div class="list">
            <ul>
                <li>
                    <h4>输入区域（密码）</h4>
                </li>
                <li>
                    <input runat="server" maxlength="16" name="Oldpwd" type="password" id="Oldpwd" placeholder="输入原来的密码" style="width: 100%;" />
                </li>
                <li>
                    <input runat="server" maxlength="16" name="newpwd" type="password" id="newpwd" placeholder="输入新密码" style="width: 100%;" />
                </li>
                <li>
                    <input runat="server" maxlength="16" name="newpwd1" type="password" id="newpwd1" placeholder="再次输入新密码" style="width: 100%;" />
                </li>
            </ul>
        </div>
        <div class="fixed"><asp:Button ID="bt5" OnClientClick='javascript:return confirm("您确定吗?")' runat="server" Text="确定保存" OnClick="Save_Btn" /></div>
    </form>
    <script src="../js/jquery-1.7.2.min.js"></script>
    <script>
        if ($(".fixed").length > 0) {
            $(".list").last().css({ paddingBottom: $(".fixed").outerHeight() })
        }
    </script>
</body>
</html>
