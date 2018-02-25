<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WorkLog_View.aspx.cs" Inherits="WC.WebUI.Manage.Common.WorkLog_View" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>汇报情况</title>
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
        <td>&nbsp;<div runat=server ID=TaskName style='color:#ff0000;font-weight:bolder; font-size:16px;'></div></td>
	</tr>
	</thead>
	
	<tr>
		<th style="width:140px;"><u><strong>创建者</strong></u>：</th>
		<td>
				<div runat=server ID=TaskUser></div>
		</td>
	</tr>

	<tr>
		<th style="width:140px;"><u><strong>汇报标题</strong></u>：</th>
		<td>
				<div style='color:#006600;font-weight:bold;' id=WorkTitle runat=server></div>
		</td>
	</tr>
	
	<tr>
		<th style="width:140px;"><u><strong>汇报日期</strong></u>：</th>
		<td>
				<div runat=server ID=AddTime></div>
		</td>
	</tr>	

	<tr>
		<th style="width:140px;"><u><strong>更新日期</strong></u>：</th>
		<td>
				<div runat=server ID=UpdateTime></div>
		</td>
	</tr>	

	<tr>
		<th style="width:140px;"><u><strong>汇报内容</strong></u>：</th>
		<td>
				<p><div runat=server ID=Notes></div></p>
		</td>
	</tr>
	
	<tr>
		<th style="width:140px;"><u><strong>相关附件</strong></u>：</th>
		<td>
			<%=fjs %>
		</td>
	</tr>


<tr>
	<td>&nbsp;</td>
	<td colspan="2" class="manage">
     <span><a href="javascript:window.print()">打印本页</a></span>
     <span><a href="javascript:closebox()">关闭本页</a></span>
	</td>
</tr>
</table>
<span id="Tip" style='display:none'></span> 
</div>

</form>
</body>
</html>
