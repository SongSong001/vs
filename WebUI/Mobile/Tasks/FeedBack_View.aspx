<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FeedBack_View.aspx.cs" Inherits="WC.WebUI.Mobile.Tasks.FeedBack_View" %>

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
<script type="text/javascript">
    function pzs() {
        if (document.form1.pz.value == "") {
            alert("您还没有输入任何批注内容！");
            document.form1.pz.focus();
            return false;
        }
    }
</script>
</head>
<body>
    <form id="form1" runat="server">
    <div id="topbar">
        <div id="title">
            任务执行详情</div>
        <div id="leftbutton">
            <a href="../Index.aspx" class="noeffect">主页</a>
        </div>
        <div id="rightnav">
            <a href="../LoginOut.aspx" class="noeffect" onclick="return confirm('您确实要安全退出吗？')">注销</a>
        </div>
    </div>

    <div id="tributton">
        <div class="links">
            <a href="../Menu.aspx">功能菜单</a><a href="../Users/User_OnLine.aspx">在线用户</a><a href="TaskMenu.aspx">上级菜单</a></div>
    </div>

    <div id="content">
        <span class="graytitle">
            <span id="Label1">
            标题： 
            <span style='color:#ff0000' runat=server ID=TaskName></span>
            </span>
        </span>

        <ul class="pageitem">
            <li class="textbox">
            <span class="header">执行人员：<span runat=server ID=TaskUser style=' color:#000;'></span></span>
            <span class="header">提交标题：<span runat=server ID=WorkTitle style=' color:#000'></span></span>
            <span class="header">提交时间：<span runat=server ID=AddTime style=' color:#000;'></span></span>
            </li>
        </ul>   

        <ul class="pageitem">
            <li class="textbox">
            <span class="header">提交内容：</span>
                    <p><div runat=server ID=Notes style='overflow: auto; overflow-y:hidden;font-size:13pt'></div></p>
            </li>
        </ul> 

        <ul class="pageitem">
            <li class="textbox"><span class="header">相关附件：</span>
            <div style="font-weight:bold;"><%=fjs %></div>
            </li>
        </ul>

        <ul class="pageitem">
            <li class="textbox">
            <span class="header">批注信息：</span>
                    <p><div runat=server ID=Instruction style='overflow: auto; overflow-y:hidden;font-size:13pt'></div></p>
            </li>
        </ul> 

        <asp:PlaceHolder runat=server ID=pizhu1s Visible=false>
        <span class="graytitle">添加批注：</span>
            <ul class="pageitem">
                <li class="textbox">
                    <textarea runat="server" name="pz" id="pz" placeholder="管理者批注的内容" rows="4" style="width:100%;"></textarea>
                </li>
                <li class="button" style="text-align: center;">
                    <asp:Button Visible=false ID="pizhu3" runat="server" OnClientClick='return pzs()' Text="添加批注" OnClick="Save_Btn" />
                </li>
            </ul>
            </asp:PlaceHolder>
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
                <li><a href="TaskMenu.aspx">上级菜单</a></li>
            </ul>
        </div>
        <div class="list">
            <ul>
                <li>
                    <h4 runat='server' id='TaskName'></h4>
                </li>
                <li>
                    <span>执行人员：<b runat='server' id='TaskUser'></b></span>
                    <span>提交标题：<b runat='server' id='WorkTitle'></b></span>
                    <span>提交时间：<b runat='server' id='AddTime'></b></span>

                </li>
            </ul>
        </div>
        <div class="list">
            <ul>
                <li><span>提交内容：</span>
                    <div runat="server" id="Notes" class="textarea"></div>
                </li>
            </ul>
        </div>
        <div class="list">
            <ul>
                <li>
                    <span>相关附件：<b><%=fjs %></b></span>
                </li>
            </ul>
        </div>
        <div class="list">
            <ul>
                <li><span>批注信息：</span>
                    <div runat="server" id="Instruction" class="textarea"></div>
                </li>
            </ul>
        </div>
        <asp:PlaceHolder runat="server" ID="pizhu1s" Visible="false">
          <%--  <span class="graytitle">：</span>--%>
            <div class="list">
                <ul class="pageitem">
                    <li><h4>添加批注</h4></li>
                    <li class="textbox">
                        <textarea runat="server" name="pz" id="pz" placeholder="管理者批注的内容" rows="4"></textarea>
                    </li>
                </ul>

            </div>
            <div class="fixed">
                <asp:Button Visible="false" ID="pizhu3" runat="server" OnClientClick='return pzs()' Text="添加批注" OnClick="Save_Btn" />
            </div>
        </asp:PlaceHolder>

        <script type="text/javascript" src="../js/jquery-1.7.2.min.js"></script>
        <script type="text/javascript">
            if ($(".fixed").length > 0) {
                $(".list").last().css({ paddingBottom: $(".fixed").outerHeight() })
            }
        </script>
    </form>
</body>
</html>
