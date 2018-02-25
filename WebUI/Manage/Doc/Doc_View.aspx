<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Doc_View.aspx.cs" Inherits="WC.WebUI.Manage.Doc.Doc_View" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title></title>
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
		<td colspan="2">&nbsp;<div runat=server ID=DocTitle5></div></td>
	</tr>
	</thead>
	
	<tr>
		<th style="width:120px;"><u>文档发布人</u>：</th>
		<td>
				<div runat=server ID=Creator5></div>
		</td>
	</tr>
	
	<tr>
		<th style="width:120px;"><u>文档分类</u>：</th>
		<td>
				<div runat=server ID=doctype5></div>
		</td>
	</tr>	
	
	<tr>
		<th style="width:120px;"><u>发布时间</u>：</th>
		<td>
				<div runat=server ID=AddTime5></div>
		</td>
	</tr>	
	
	<tr>
		<th style="width:120px;"><u>是否共享</u>：</th>
		<td>
				<div runat=server ID=IsShare5></div>
		</td>
	</tr>	
	
	<tr>
		<th style="width:120px;"><u>备注</u>：</th>
		<td>
				<p><div runat=server ID=Notes5></div></p>
		</td>
	</tr>
	
	<tr>
		<th style="width:120px;"><u>附件</u>：</th>
		<td style="font-weight:bold;">
			<%=fjs %>
		</td>
	</tr>

<tr>
	<td>&nbsp;</td>
	<td colspan="2" class="manage"><a href="javascript:closebox()">关闭本页</a>
	<asp:Panel runat=server ID=div Visible=false><asp:LinkButton style="margin-left:33px;" runat=server ID=lk OnClick=SaveToMe OnClientClick="javascript:return confirm('您确定要将该共享文档 保存为 自己的文档吗？')">转存至 我的文档</asp:LinkButton> </asp:Panel>
	</td>
</tr>
</table>

</div>

</form>
</body>
</html>
