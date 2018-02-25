<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PaperView.aspx.cs" Inherits="WC.WebUI.Manage.Paper.PaperView" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>电子档案查看</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link type="text/css" href="/manage/style.css" rel="stylesheet" rev="stylesheet" media="all" />
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/manage/include/common.js"></script>
</head>
<body>
<form id="form1" runat="server">

<div id="PanelShow">
	
<table class="table">
	<thead>
	<tr>
		<th style="width:140px;"></th>
        <td>&nbsp;<div runat=server ID=PaperName style='color:#ff0000;font-weight:bolder; font-size:16px;'></div></td>
	</tr>
	</thead>
	
	<tr>
		<th style="width:140px;"><u>档案分类</u>：</th>
		<td>
				<div id=TypeName runat=server></div>
		</td>
	</tr>

	<tr>
		<th style="width:140px;"><u>档案日期</u>：</th>
		<td>
				<div runat=server ID=PaperDate></div>
		</td>
	</tr>
	
	<tr>
		<th style="width:140px;"><u>来文单位</u>：</th>
		<td>
				<div runat=server ID=SendDep></div>
		</td>
	</tr>	
	
	<tr>
		<th style="width:140px;"><u>文号</u>：</th>
		<td>
				<div runat=server ID=PaperSymbol></div>
		</td>
	</tr>	

    	<tr>
		<th style="width:140px;"><u>密级</u>：</th>
		<td>
				<div runat=server ID=PaperGrade></div>
		</td>
	</tr>	

    	<tr>
		<th style="width:140px;"><u>发布范围</u>：</th>
		<td>
				<div runat=server ID=namelist_dep></div>
		</td>
	</tr>	

	<tr>
		<th style="width:140px;"><u>备注</u>：</th>
		<td>
				<p><div runat=server ID=Notes></div></p>
		</td>
	</tr>
	
	<tr>
		<th style="width:140px;"><u>档案文件</u>：</th>
		<td style="font-weight:bold;">
			<%=fjs %>
		</td>
	</tr>

<tr>
	<td>&nbsp;</td>
	<td colspan="2" class="manage"><a href="javascript:closebox()">关闭本页</a>
	</td>
</tr>
</table>

</div>

</form>
</body>
</html>
