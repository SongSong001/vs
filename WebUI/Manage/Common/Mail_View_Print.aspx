<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Mail_View_print.aspx.cs" Inherits="WC.WebUI.Manage.Common.Mail_View" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/>
<title>打印预览--邮件正文</title>
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/manage/include/common.js"></script>
<style type="text/css">
html { width: 760; height:100%; }
body { margin: 0; padding: 0;  font-size: 12px; font-family: tahoma,verdana; background: #ffffff; }
</style>
</head>
<body>
<TABLE width="760" height="100%" border=0 align="center" cellPadding=0 cellSpacing=0 bgcolor="#FFFFFF" style="WORD-BREAK: break-all">
	<tr>
		<td width="100" height="30"><span style="color:#ff0000;font-size:14pt; font-weight:bolder;" id=Subject runat=server></span></td>
	</tr>
	<tr>
		<td height="30">
		<span style="font-weight:bold; color:#006600;">发件人</span>：<span runat=server id=Sender style="font-weight:bold;"></span>
		<br>
	<span style="font-weight:bold; color:#006600;">时 &nbsp;&nbsp;&nbsp;间</span>：<span runat=server id=Sendtime></span>  <br>
		<span style='font-weight:bold; color:#006600;'>收件人</span>：<span runat=server id=sjr></span> 
		<%=this.csr %>
		</td>
	</tr>
	<tr>
		<td>
                <div runat=server id=bodys style="min-height:100px;_height:100px;margin:10px 10px 1px 1px; border:1px solid #E3E197; padding:10px 10px 10px 10px;"></div>
				<%=this.fjs %>
		</td>
	</tr>
	<tr>
		<TD style="HEIGHT: 30px" align="right"><A style="margin-right:5px; border:1px solid #ccd1dc; background:#edfcfe; padding:0px 3px 2px;font-size:14px;" href="javascript:window.print()">&nbsp;打印本文</A>　　<A style="margin-right:5px; border:1px solid #ccd1dc; background:#edfcfe; padding:0px 3px 2px;font-size:14px; " href="javascript:window.close()">&nbsp;关闭窗口</A></TD>
	</tr>
</table>       
</body>
</html>