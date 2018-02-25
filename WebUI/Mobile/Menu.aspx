<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Menu.aspx.cs" Inherits="WC.WebUI.Mobile.Menu" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html>
<head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <title>智能移动办公平台-功能菜单</title>
    <meta name="keywords" content="" />
    <meta name="description" content="" />
    <meta name="format-detection" content="telephone=no" />
    <meta name="format-detection" content="email=no" />
    <meta name="format-detection" content="address=no" />
    <meta name="format-detection" content="date=no" />
    <link href="css/index.css" rel="stylesheet" />
</head>
<body>
    <div class="head">
        <a href="../Index.aspx" class="prev"><i class="icon"></i></a>
        <div class="head_bt">智能移动办公平台</div>
        <a href="../LoginOut.aspx" onclick="return confirm('您确实要安全退出吗？')" class="close"><i class="icon"></i></a>
    </div>
    <div class="daohang">
        <ul>
            <li><a href="../Mobile/Menu.aspx">功能菜单</a></li>
            <li><a href="../Mobile/Users/User_OnLine.aspx">在线用户</a></li>
            <li><a href="../Mobile/Users/User_PwdEditNew.aspx">修改密码</a></li>
        </ul>
    </div>
    <div class="list">
        <ul>
            <li>
                <h4>基本功能菜单</h4>
            </li>
            <li>
                <span>欢迎您，<%=RealName %></span>
                <p>&gt;&gt;基本功能菜单</p>
            </li>
        </ul>
    </div>
    <div class="menus">
        <ul>
            <li>
                <a href="Users/UserMenu.aspx"><i class="icon icon_list1"></i>
                    <p>个人设置</p>
                </a>
            </li>
            <li>
                <a href="AddrBook/Menu.aspx"><i class="icon icon_list2"></i>
                    <p>单位通讯录</p>
                </a>
            </li>
            <li>
                <a href="News/NewsMenu.aspx"><i class="icon icon_list3"></i>
                    <p>我的资讯</p>
                </a>
            </li>
            <li>
                <a href="Mails/MailMenu.aspx"><i class="icon icon_list4"></i>
                    <p>内部邮件</p>
                </a>
            </li>
            <li>
                <a href="Flows/FlowMenu.aspx"><i class="icon icon_list5"></i>
                    <p>工作流程</p>
                </a>
            </li>
            <li>
                <a href="GovApp/AppMenu.aspx"><i class="icon icon_list6"></i>
                    <p>公文批阅</p>
                </a>
            </li>
            <li>
                <a href="GovRec/RecMenu.aspx"><i class="icon icon_list7"></i>
                    <p>公文签收</p>
                </a>
            </li>
            <li>
                <a href="Tasks/TaskMenu.aspx"><i class="icon icon_list8"></i>
                    <p>工作任务</p>
                </a>
            </li>
            <li>
                <a href="Files/FileMenu.aspx"><i class="icon icon_list9"></i>
                    <p>我的文档</p>
                </a>
            </li>
            <li>
                <a href="WorkLog/WorkLogMenu.aspx"><i class="icon icon_list10"></i>
                    <p>工作汇报</p>
                </a>
            </li>
        </ul>
    </div>
    <div class="fix">
        <ul>
            <li><a href="./News/NewsMenu.aspx"><i class="icon information"></i><span>资讯</span></a></li>
            <li><a href="./AddrBook/Menu.aspx"><i class="icon contacts"></i><span>联系人</span></a></li>
            <li><a href="./Tasks/TaskMenu.aspx"><i class="icon work"></i><span>工作</span></a></li>
            <li><a href="./Files/FileMenu.aspx"><i class="icon word"></i><span>文档</span></a></li>
            <li><a href="./Users/UserMenu.aspx"><i class="icon my"></i><span>我的</span></a></li>
        </ul>
    </div>
    <script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
     <script type="text/javascript">
        if ($(".fixed").length > 0) {
            $(".list").last().css({ paddingBottom: $(".fixed").outerHeight() })
        }
    </script>
</body>
</html>
