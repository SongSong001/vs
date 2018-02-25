<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserMenu.aspx.cs" Inherits="WC.WebUI.Mobile.Users.UserMenu" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <title>智能移动办公平台-个人设置</title>
    <meta name="keywords" content="" />
    <meta name="description" content="" />
    <meta name="format-detection" content="telephone=no" />
    <meta name="format-detection" content="email=no" />
    <meta name="format-detection" content="address=no" />
    <meta name="format-detection" content="date=no" />
    <link rel="stylesheet" type="text/css" href="../css/index.css" />
</head>
<body>
    <form id="form2" runat="server">
        <div class="head">
            <a href="../Index.aspx" class="prev"><i class="icon"></i></a>
            <div class="head_bt">智能移动办公平台</div>
            <a href="../LoginOut.aspx" onclick="return confirm('您确实要安全退出吗？')" class="close"><i class="icon"></i></a>
        </div>
        <div class="daohang">
            <ul>
                <li><a href="../Menu.aspx">功能菜单</a></li>
                <li><a href="../Users/User_OnLine.aspx">在线用户</a></li>
                <li><a href="../Users/User_PwdEditNew.aspx">修改密码</a></li>
            </ul>
        </div>
        <div class="list">
            <ul>
                <li>
                    <h4>基本功能菜单</h4>
                </li>
                <li>
                    <span>欢迎您，<%=RealName %></span>
                    <p>个人设置&gt;&gt;功能菜单</p>
                </li>
                <li>
                    <a href="User_PwdEditNew.aspx"><i class="icon icon_list1"></i>密码修改</a>
                </li>
                <li>
                    <a href="User_InfoEdit.aspx"><i class="icon icon_list2"></i>个人资料编辑</a>
                </li>
                <li>
                    <a href="User_Veiw.aspx?uid=<%=Uid %>"><i class="icon icon_list3"></i>个人信息预览</a>
                </li>
                <li>
                    <a href="User_OnLine.aspx"><i class="icon icon_list4"></i>在线用户列表</a>
                </li>
            </ul>
        </div>
         <div class="fix">
        <ul>
            <li><a href="../News/NewsMenu.aspx"><i class="icon information"></i><span>资讯</span></a></li>
            <li><a href="../AddrBook/Menu.aspx"><i class="icon contacts"></i><span>联系人</span></a></li>
            <li><a href="../Tasks/TaskMenu.aspx"><i class="icon work"></i><span>工作</span></a></li>
            <li><a href="../Files/FileMenu.aspx"><i class="icon word"></i><span>文档</span></a></li>
            <li class="cur"><a href="javascript:;"><i class="icon my"></i><span>我的</span></a></li>
        </ul>
    </div>
    </form>
</body>
</html>
