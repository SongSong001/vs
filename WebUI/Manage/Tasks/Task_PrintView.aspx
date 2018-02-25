<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Task_PrintView.aspx.cs" Inherits="WC.WebUI.Manage.Tasks.Task_PrintView" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>任务打印预览</title>
<link type="text/css" href="/manage/Style/InterFace.Css" rel="stylesheet" rev="stylesheet" media="all" />
<link type="text/css" href="/manage/style_s.css" rel="stylesheet" rev="stylesheet" media="all" />
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/manage/include/common.js"></script>
<style type="text/css">
html { width: 760; height:100%; _height: 100%; overflow: hidden; }
body { margin: 0; padding: 0;  font-size: 12px; font-family: tahoma,verdana; background: #ffffff; }
</style>
</head>
<body>
    <form id="form1" runat="server">
<br>
<TABLE width="760" height="100%" border=0 align="center" cellPadding=0 cellSpacing=0 bgcolor="#FFFFFF" style="WORD-BREAK: break-all">
	<tr>
		<td width="100" height="25"><span style="font-size:14px;font-weight:bolder;color:#ff0000;TEXT-DECORATION:underline;" id=Subject runat=server></span></td>
	</tr>
	<tr>
		<td style="color:#000">
		<span style="color:#006600; font-weight:bold;">任务状态：</span>&nbsp;<span style="color:#000; font-weight:bold;" runat=server id=status></span> &nbsp;&nbsp; &nbsp;&nbsp;
		<span style="color:#006600; font-weight:bold;">创建人员：</span>&nbsp;<span style="color:#000; " runat=server id=Creator></span> &nbsp;&nbsp; &nbsp;&nbsp;
		<span style="color:#006600; font-weight:bold;">任务分类：</span>&nbsp;<span style="color:#000; " runat=server id=TypeName></span> &nbsp;&nbsp; &nbsp;&nbsp;
		<span style="color:#006600; font-weight:bold;">流水编号：</span>&nbsp;<span style="color:#000; " runat=server id=TaskNO></span><br>
        <span style="color:#006600; font-weight:bold;">更新时间：</span>&nbsp;<span style="color:#000; " runat=server id=UpdateTime></span> &nbsp;&nbsp; &nbsp;&nbsp;
        <span style="color:#006600; font-weight:bold;">创建时间：</span>&nbsp;<span style="color:#000; " runat=server id=AddTime></span> &nbsp;&nbsp; &nbsp;&nbsp;
		<span style="color:#006600; font-weight:bold;">期待完成时间：</span>&nbsp;<span style="color:#000; " runat=server id=ExpectTime></span><br>
		<span style="color:#006600; font-weight:bold;">任务级别：</span>&nbsp;<span style="color:#000; font-weight:bold;" runat=server id=Important></span> &nbsp;&nbsp; &nbsp;&nbsp;
		<span style="color:#006600; font-weight:bold;">管理人员：</span>&nbsp;<span style="color:#000; " runat=server id=ManageNameList></span>
		</td>
	</tr>
	<tr>
		<td><div runat=server id=bodys1 style="min-height:100px;_height:100px;margin:10px 10px 1px 1px; border:1px solid #E3E197; padding:10px 10px 10px 10px;"></div>
        <%=this.fjs %>
		</td>
	</tr>
	<tr>
		<TD style="HEIGHT: 30px" align="right"><A style="margin-right:5px; border:1px solid #ccd1dc; background:#edfcfe; padding:0px 3px 2px;font-size:14px;" href="javascript:window.print()">&nbsp;打印本文</A>　　<A style="margin-right:5px; border:1px solid #ccd1dc; background:#edfcfe; padding:0px 3px 2px;font-size:14px; " href="javascript:window.close()">&nbsp;关闭窗口</A></TD>
	</tr>
</table>  
    </form>
</body>
</html>
