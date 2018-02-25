<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Operate_Success.aspx.cs" Inherits="WC.WebUI.InfoTip.Operate_Success" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML xmlns:v>
<head><meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>系统提示 - 您的操作成功!</title>
<META content="text/html; charset=utf-8" http-equiv=Content-Type>
<META name=description content="页面中止程序">
<META name=GENERATOR content="MSHTML 8.00.6001.18876">
<meta http-equiv=refresh content="<%=times %>; url=<%=return_page %>">
<META name=usefor content="application termination">
<STYLE rel="stylesheet">v\:* {
	BEHAVIOR: url(#default#vml)
}
BODY {
	LINE-HEIGHT: 19px; FONT-FAMILY: tahoma, arial, 'courier new', verdana, sans-serif; COLOR: #222222; FONT-SIZE: 14px;background: #fff
}
DIV {
	LINE-HEIGHT: 19px; FONT-FAMILY: tahoma, arial, 'courier new', verdana, sans-serif; COLOR: #222222; FONT-SIZE: 14px
}
SPAN {
	LINE-HEIGHT: 19px; FONT-FAMILY: tahoma, arial, 'courier new', verdana, sans-serif; COLOR: #222222; FONT-SIZE: 14px
}
LI {
	LINE-HEIGHT: 19px; FONT-FAMILY: tahoma, arial, 'courier new', verdana, sans-serif; COLOR: #222222; FONT-SIZE: 14px
}
TD {
	LINE-HEIGHT: 19px; FONT-FAMILY: tahoma, arial, 'courier new', verdana, sans-serif; COLOR: #222222; FONT-SIZE: 14px
}
A {
	LINE-HEIGHT: 19px; FONT-FAMILY: tahoma, arial, 'courier new', verdana, sans-serif; COLOR: #222222; FONT-SIZE: 14px
}
A {
	COLOR: #2c78c5; TEXT-DECORATION: none
}
A:hover {
	COLOR: red; TEXT-DECORATION: none
}
</STYLE>
</head>
<BODY style="TEXT-ALIGN: center; MARGIN: 90px 20px 50px">
<form id="form1" runat="server">
<DIV style="TEXT-ALIGN: center; MARGIN: auto; WIDTH: 450px"><v:roundrect 
style="POSITION: relative; TEXT-ALIGN: left; PADDING-BOTTOM: 15px; MARGIN: auto; PADDING-LEFT: 15px; WIDTH: 480px; PADDING-RIGHT: 15px; DISPLAY: table; HEIGHT: 200px; OVERFLOW: hidden; PADDING-TOP: 15px" 
arcsize = "3201f" coordsize = "21600,21600" fillcolor = "#fdfdfd" strokecolor = 
"#e6e6e6" strokeweight = ".75pt">
<TABLE style="BORDER-BOTTOM: #cccccc 1px solid; PADDING-BOTTOM: 6px" border=0 
cellSpacing=0 cellPadding=0 width="100%">
  <TBODY>
  <TR>
    <TD><B>恭喜您，操作成功！</B></TD>
    <TD style="COLOR: #f8f8f8" align=right>--- WINCAN TECHNOLOGY SOFTWARE</TD></TR></TBODY></TABLE>
<TABLE style="OVERFLOW: hidden; WORD-BREAK: break-all" border=0 cellSpacing=0 
cellPadding=0 width="100%">
  <TBODY>
  <TR>
    <TD style="PADDING-TOP: 14px" vAlign=top width=80>&nbsp;&nbsp;
    <img src="../img/info_success.gif" />
    </TD>
    <TD style="PADDING-TOP: 17px" vAlign=top>
    <ul>
    <li><%=tip %></li>
    <li>非常感谢您的使用</li>
    <li><%=times %>秒钟后 将自动返回上一页</li>
    </ul>
      <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<A href=<%=return_page %> ><strong>返回上一页 我要继续操作</strong></A>
</TD></TR></TBODY></TABLE></v:roundrect></DIV>
</form>
</BODY></HTML>



