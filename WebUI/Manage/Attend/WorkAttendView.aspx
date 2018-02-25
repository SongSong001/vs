<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WorkAttendView.aspx.cs" Inherits="WC.WebUI.Manage.Attend.WorkAttendView" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>查看考勤信息</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link type="text/css" href="/manage/style.css" rel="stylesheet" rev="stylesheet" media="all" />
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/manage/include/common.js"></script>
</head>
<body id="C_News">

<div id="PanelShow">
	
<table class="table">
	<thead>
	<tr>
		<td colspan=2>
		</td>
	</tr>
	</thead>
	
	<tr>
		<th style="width:135px; font-weight:bold">考勤类别：</th>
		<td>
			<span id=WorkType runat=server style="font-weight:bold; color:Red"></span>
		</td>
	</tr>	

	<tr>
		<th style="width:135px; font-weight:bold">登记人员：</th>
		<td>
			<asp:Label runat=server ID=WorkPeople></asp:Label>
		</td>
	</tr>	
	
	<tr>
		<th style="width:135px; font-weight:bold">登记日期：</th>
		<td>
			<asp:Label runat=server ID=WorkDate></asp:Label>
		</td>
	</tr>	
	
	<tr>
		<th style="width:135px; font-weight:bold">考勤数据：</th>
		<td>
				<asp:Label runat=server ID=WorkInfo></asp:Label>
		</td>
	</tr>	

    <tr>
		<th style="width:135px; font-weight:bold">备注：</th>
		<td>
				<asp:Label runat=server ID=WorkNote></asp:Label>
		</td>
	</tr>
	

<tr>
	<td>&nbsp;</td>
	<td colspan="2" class="manage">
	<a href="javascript:closebox()">关闭本页</a>
	</td>
</tr>
</table>
</div>



</body>
</html>
