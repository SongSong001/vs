<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CRM_Contact_View.aspx.cs" Inherits="WC.WebUI.Manage.CRM.CRM_Contact_View" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>查看客户接触</title>
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
		<th style="width:135px; font-weight:bold">客户名称：</th>
		<td>
			<span id=CRM_Name1 runat=server style="font-weight:bold; color:Red"></span>
		</td>
	</tr>	
	
	<tr>
		<th style="width:135px; font-weight:bold">接触主题：</th>
		<td>
			<asp:Label runat=server ID=ContactAim></asp:Label>
		</td>
	</tr>	
	
	<tr runat=server id=div>
		<th style="width:135px; font-weight:bold">参与人员：</th>
		<td>
				<asp:Label runat=server ID=ContactPeople></asp:Label>
		</td>
	</tr>	
	
	<tr>
		<th style="width:135px; font-weight:bold">接触时间：</th>
		<td>
				<asp:Label runat=server ID=AddTime></asp:Label>
		</td>
	</tr>	
	
	<tr>
		<th style="width:135px; font-weight:bold">接触方式：</th>
		<td>
				<asp:Label runat=server ID=ContactType></asp:Label>
		</td>
	</tr>	
	
	<tr>
		<th style="width:135px; font-weight:bold">接触状态：</th>
		<td>
				<asp:Label runat=server ID=ContactState></asp:Label>
		</td>
	</tr>
	
	<tr>
		<th style="width:135px; font-weight:bold">发生费用：</th>
		<td>
				<asp:Label runat=server ID=ContactCharge></asp:Label>
		</td>
	</tr>		
	
	<tr>
		<th style="width:135px; font-weight:bold">费用用途：</th>
		<td>
				<asp:Label runat=server ID=ContactChargeType></asp:Label>
		</td>
	</tr>			
	
	<tr>
		<th style="width:135px; font-weight:bold">接触内容：</th>
		<td>
				<asp:Label runat=server ID=ContactDetail></asp:Label>
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

