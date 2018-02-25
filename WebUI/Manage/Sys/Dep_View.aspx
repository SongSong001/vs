<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dep_View.aspx.cs" Inherits="WC.WebUI.Manage.Sys.Dep_View" EnableViewState="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>查看资料</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link type="text/css" href="/manage/style.css" rel="stylesheet" rev="stylesheet" media="all" />
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/manage/include/common.js"></script>
</head>
<body id="C_News">
<form id="form1" runat="server">

<div id="PanelShow">
	
<table class="table">
	<thead>
	<tr>
		<td colspan="2">职能机构： <div runat=server ID=UDepName5></div></td>
	</tr>
	</thead>
	
	<tr>
		<th style="width:120px;">上级 部门/职位：</th>
		<td>
				<div runat=server ID=father5></div>
		</td>
	</tr>
	
	<tr>
		<th style="width:120px;">联系电话：</th>
		<td>
				<div runat=server ID=Phone5></div>
		</td>
	</tr>	
	
	<tr>
		<th style="width:120px;">类别：</th>
		<td>
				<div runat=server ID=IsPosition5></div>
		</td>
	</tr>
	
	<tr>
		<th style="width:120px;">排序：</th>
		<td>
			<div runat=server ID=Orders5></div>
		</td>
	</tr>	
	
	<tr>
		<th style="width:120px;">备注：</th>
		<td>
				<p><div runat=server ID=Notes5></div></p>
		</td>
	</tr>

<tr>
	<td>&nbsp;</td>
	<td colspan="2" class="manage"><a href="javascript:closebox()">关闭本页</a></td>
</tr>
</table>
</div>

</form>
</body>
</html>
