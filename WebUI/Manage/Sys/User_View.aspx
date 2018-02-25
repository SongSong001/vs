<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="User_View.aspx.cs" Inherits="WC.WebUI.Manage.Sys.User_View" EnableViewState="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<link type="text/css" href="/manage/style.css" rel="stylesheet" rev="stylesheet" media="all" />
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/manage/include/common.js"></script>
    <style type="text/css">
        .style1
        {
            width: 265px;
        }
        .style2
        {
            width: 119px; 
background-color:#fff; border-width:1px;
        }
    </style>
</head>
<body id="C_News">

<div id="PanelShow">
	
<table class="table">
	<thead>
	<tr>
		<td>用户名/真实姓名 
		</td>
		<td colspan="3">
		<div runat=server ID=UUserName5></div> <div runat=server ID=URealName5></div>
		</td>
	</tr>
	</thead>
	
	<tr>
		<th style="width:135px;">职能部门：</th>
		<td class="style1">
				<div runat=server ID=UDepName5></div>
		</td>
		<td class="style2" rowspan="6">
        <asp:Image runat="server" ImageUrl="~/Manage/images/touxiang.jpg" ID='PerPic' 
                Width='118px' Height='138px' style="border:solid 1px #999999" />
            </td>
		<td>
				&nbsp;</td>
	</tr>
	
	<tr>
		<th style="width:135px;">职务名称：</th>
		<td class="style1">
				<div runat=server ID=PositionName5></div>
		</td>
		<td>
				&nbsp;</td>
	</tr>		
	
	<tr>
		<th style="width:135px;">上司领导：</th>
		<td class="style1">
				<div runat=server ID=DirectSupervisor5></div>
		</td>
		<td>
				&nbsp;</td>
	</tr>		
	
	<tr>
		<th style="width:135px;">入职时间：</th>
		<td class="style1">
				<div runat=server ID=JoinTime5></div>
		</td>
		<td>
				&nbsp;</td>
	</tr>	
	
	<tr>
		<th style="width:135px;">性别：</th>
		<td class="style1">
				<div runat=server ID=Sex5></div>
		</td>
		<td>
				&nbsp;</td>
	</tr>
	
	<tr>
		<th style="width:135px;">年龄：</th>
		<td class="style1">
				<div runat=server ID=Birthday5></div>
		</td>
		<td>
				&nbsp;</td>		
	</tr>
	
	<tr>
		<th style="width:135px;">移动电话：</th>
		<td colspan="3">
				<div runat=server ID=Phone5></div>
		</td>
	</tr>	
	
	<tr>
		<th style="width:135px;">固定电话：</th>
		<td colspan="3">
				<div runat=server ID=Tel5></div>
		</td>
	</tr>	
	
	<tr>
		<th style="width:135px;">电子邮件：</th>
		<td colspan="3">
				<div runat=server ID=Email5></div>
		</td>
	</tr>
	
	<tr>
		<th style="width:135px;">腾讯QQ：</th>
		<td colspan="3">
				<div runat=server ID=QQ5></div>
		</td>
	</tr>		
	
	<tr>
		<th style="width:135px;">居住地址：</th>
		<td colspan="3">
				<div runat=server ID=HomeAddress5></div>
		</td>
	</tr>		
	
	<tr>
		<th style="width:135px;">状态：</th>
		<td colspan="3">
				<div runat=server ID=Status5></div>
		</td>
	</tr>
	
	<tr>
		<th style="width:135px;">日程状态：</th>
		<td colspan="3">
				<div runat=server ID=MemoShare5></div>
		</td>
	</tr>	

    	<tr>
		<th style="width:135px;">档案文件：</th>
		<td colspan="3" style="font-weight:bold;">
			<%=fjs %>
		</td>
	</tr>
	
	<tr>
		<th style="width:135px;">备注：</th>
		<td colspan="3">
				<p><div runat=server ID=Notes5></div></p>
		</td>
	</tr>

<tr>
	<td>&nbsp;</td>
	<td colspan="3" class="manage"><a href="javascript:closebox();">关闭本页</a></td>
</tr>
</table>
</div>

</body>
</html>
