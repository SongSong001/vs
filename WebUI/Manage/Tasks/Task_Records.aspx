<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Task_Records.aspx.cs" Inherits="WC.WebUI.Manage.Tasks.Task_Records" EnableViewState="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/>
<title>任务操作日志</title>
<link type="text/css" href="/manage/Style/InterFace.Css" rel="stylesheet" rev="stylesheet" media="all" />
<link type="text/css" href="/manage/style_s.css" rel="stylesheet" rev="stylesheet" media="all" />
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/manage/include/common.js"></script>
<style type="text/css">
html { width: 760; height:100%; _height: 100%; }
body { margin: 0; padding: 0;  font-size: 12px; font-family: tahoma,verdana; background: #ffffff; }
</style>
</head>
<body>
<form id="form1" runat="server">
<br>
<TABLE width="760" height="100%" border=0 align="center" cellPadding=0 cellSpacing=0 bgcolor="#FFFFFF" style="WORD-BREAK: break-all">
	<tr>
		<td width="100" height="25"><span style="font-size:14px;font-weight:bolder;" id=Subject runat=server></span></td>
	</tr>
	<tr>
		<td height="6">
		</td>
	</tr>
	<tr>
		<td><div runat=server id=bodys style="min-height:100px;_height:100px;margin:10px 10px 1px 1px; border:1px solid #E3E197; padding:10px 10px 10px 10px;"></div>
		</td>
	</tr>
	<tr>
		<TD style="HEIGHT: 30px" align="right"><A style="margin-right:5px; border:1px solid #ccd1dc; background:#edfcfe; padding:0px 3px 2px;font-size:14px;" href="javascript:window.print()">&nbsp;打印本文</A>　　<A style="margin-right:5px; border:1px solid #ccd1dc; background:#edfcfe; padding:0px 3px 2px;font-size:14px; " href="javascript:window.close()">&nbsp;关闭窗口</A></TD>
	</tr>
</table>  
</form>     
</body>
</html>
