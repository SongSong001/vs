<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FlowView.aspx.cs" Inherits="WC.WebUI.Mobile.Flows.FlowView" %>

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
            流程审批</div>
        <div id="leftbutton">
            <a href="../Index.aspx" class="noeffect">主页</a>
        </div>
        <div id="rightnav">
            <a href="../LoginOut.aspx" class="noeffect" onclick="return confirm('您确实要安全退出吗？')">注销</a>
        </div>
    </div>

    <div id="tributton">
        <div class="links">
            <a href="../Menu.aspx">功能菜单</a><a href="../Users/User_OnLine.aspx">在线用户</a><a href="FlowMenu.aspx">上级菜单</a></div>
    </div>

    <div id="content">
        <span class="graytitle">
            <span id="Label1">
            标题： 
            <span style='color:#ff0000' runat=server ID=Flow_Name1></span>
            </span>
        </span>

        <ul class="pageitem">
            <li class="textbox">
            <span class="header">流程状态：<span runat=server ID=status style=' color:#009900;'></span></span>
            <span class="header">创建人员：<span runat=server ID=creator style=' color:#000'></span></span>
            <span class="header">创建日期：<span runat=server ID=addtime style=' color:#000;'></span></span>
            <span class="header">当前环节：<span runat=server ID=currentstepname style=' color:#000'></span></span>
            <span class="header">当前审批者：<span runat=server ID=currentuserlist style=' color:#000;'></span></span>
            </li>
        </ul>   

        <ul class="pageitem">
            <li class="textbox">
            <span class="header">流程内容：</span>
                    <p>
                    <input type=hidden runat=server id=filepath name=filepath />
                    <div runat=server ID=DocBody style='overflow: auto; overflow-y:hidden;font-size:13pt'></div></p>
            </li>
        </ul> 

        <ul class="pageitem">
            <li class="textbox">
            <span class="header">流程说明：</span>
                    <div runat=server ID=bodys style='overflow: auto; overflow-y:hidden;font-size:13pt'></div>
            </li>
        </ul> 

            <span class="graytitle">相关附件：</span>
             <ul class="pageitem">
             
                <li class="textbox">
		<asp:Repeater runat=server ID=rpt><ItemTemplate>
        <span style='display:none'><input runat=server id=chk type="checkbox" disabled=disabled checked=checked value=<%#Eval("Tmp1") %> /></span>
		<%#Eval("Tmp2") %> &nbsp;<a href='/Manage/Utils/Download.aspx?destFileName=<%# Server.UrlEncode(Eval("Tmp3")+"") %>' ><img src='/img/mail_attachment.gif' />下载</a>
		<br><%#Eval("Tmp4") %>
		<br>
	    </ItemTemplate></asp:Repeater>
                </li>
            </ul>
        
        <ul class="pageitem">
            <li class="textbox">
            <span class="header">审批意见列表：</span>
                    <div style='overflow: auto; overflow-y:hidden;font-size:12pt'><%=yjs %></div>
            </li>
        </ul>
        
        <ul class="pageitem">
            <li class="textbox">
            <span class="header">有效期限：<span runat=server ID=vlidtime style=' color:#000'></span></span>
            <span class="header">抄送呈报：<span runat=server ID=viewuserlist style=' color:#000;'></span></span>
            </li>
        </ul>           

        <asp:PlaceHolder runat=server ID=displays Visible=false>
        <span class="graytitle">审批操作：</span>
            <ul class="pageitem">
                <li class="textbox">
                    <textarea runat="server" name="FlowRemark" id="FlowRemark" placeholder="在这里输入审批意见" rows="2" style="width:100%;"></textarea>
                </li>
                <li class="button" style="text-align: center;">
                    <asp:Button ID="b1" runat="server" OnClientClick='javascript:return confirm("确实要批准吗?")' Text="我要批准" OnClick="VerifyStep_Btn" Enabled=false />
                </li>
            </ul>

        <ul class="pageitem">
            <li class="button" style="text-align: center;">
            <asp:Button ID="b2" runat="server" OnClientClick='javascript:return confirm("确实不同意审批吗？流程将被打回上个环节")' Text="我不同意" OnClick="RefuseStep_Btn" Enabled=false />
            </li>
        </ul>  

        <ul class="pageitem">
            <li class="button" style="text-align: center;">
            <asp:Button ID="b3" runat="server" OnClientClick='javascript:return confirm("确实要强制完成吗？流程将提前完成")' Text="强制完成流程" OnClick="CompleteStep_Btn" Visible=false Enabled=false />
            </li>
        </ul>  
        </asp:PlaceHolder>
    </div>
    </form>
</body>
</html>--%>



<html>
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
                <li><a href="FlowList.aspx">上级菜单</a></li>
            </ul>
        </div>
        <div class="list">
            <ul>
                <li>
                    <h4 runat="server" id="Flow_Name1"></h4>
                </li>
                <li>
                    <span>流程状态：<b runat="server" id="status"></b></span>
                    <span>创建人员：<b runat="server" id="creator"></b></span>
                    <span>创建日期：<b runat="server" id="addtime"></b></span>
                    <span>当前环节：<b runat="server" id="currentstepname"></b></span>
                    <span>当前审批者：<b runat="server" id="currentuserlist"></b></span>
                </li>
            </ul>
        </div>
        <div class="list">
            <ul>
                <li><span>流程内容：</span>

                    <input type="hidden" runat="server" id="filepath" name="filepath" />
                    <div runat="server" id="DocBody" class="textarea" ></div>
                   <%--  <textarea runat="server"  id="DocBody" placeholder="" ></textarea>--%>
                </li>
            </ul>
        </div>
        <div class="list">
            <ul>
                <li>
                    <span>流程说明：<b runat="server" id="bodys"></b></span>
                    <span>相关附件：<b>
                        <asp:Repeater runat="server" ID="rpt">
                            <ItemTemplate>
                                <span style='display: none'>
                                    <input runat="server" id="chk" type="checkbox" disabled="disabled" checked="checked" value='<%#Eval("Tmp1") %>' /></span>
                                <%#Eval("Tmp2") %> &nbsp;<a href='/Manage/Utils/Download.aspx?destFileName=<%# Server.UrlEncode(Eval("Tmp3")+"") %>'><img src='/img/mail_attachment.gif' />下载</a>
                                <br>
                                <%#Eval("Tmp4") %>
                                <br>
                            </ItemTemplate>
                        </asp:Repeater>
                    </b></span>
                    <span>审批意见列表：<b><%=yjs %></b></span>
                    <span>有效期限：<b runat="server" id="vlidtime"></b></span>
                    <span>抄送呈报：<b runat="server" id="viewuserlist"></b></span>
                </li>
            </ul>
        </div>
        <div class="list">
            <ul>
                <li><span>审批意见：</span>
                    <textarea runat="server" name="FlowRemark" id="FlowRemark" placeholder="在这里输入审批意见" rows="2" ></textarea>
                </li>
            </ul>
        </div>
        <div class="fixed">
             <asp:PlaceHolder runat=server ID=displays Visible=false>
            <asp:Button ID="b1" runat="server" OnClientClick='javascript:return confirm("确实要批准吗?")' Text="我要批准" OnClick="VerifyStep_Btn" Enabled=false />
            <asp:Button ID="b2" runat="server" OnClientClick='javascript:return confirm("确实不同意审批吗？流程将被打回上个环节")' Text="我不同意" OnClick="RefuseStep_Btn" Enabled=false />
            <asp:Button ID="b3" runat="server" OnClientClick='javascript:return confirm("确实要强制完成吗？流程将提前完成")' Text="强制完成流程" OnClick="CompleteStep_Btn" Visible=false Enabled=false />
</asp:PlaceHolder>
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
