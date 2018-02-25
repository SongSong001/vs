<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="User_PwdEdit.aspx.cs" Inherits="WC.WebUI.Manage.Common.User_PwdEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>用户资料编辑</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<link type="text/css" href="/manage/style.css" rel="stylesheet" rev="stylesheet" media="all" />
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/manage/include/common.js"></script>
<script type="text/javascript" src="/js/validator.js"></script>    
</head>
<body>
    <form id="form1" runat="server" onsubmit="return Validator.Validate(this.form,3);">
 
<div id="PanelConfig">

<table class="table">
<thead>
<tr>
	<td colspan="2"><a href="#" class="helpall">[?]</a></td>
</tr>
</thead>
<tr>
	<th style="width:135px;">用户名&nbsp;<a href="#" class="help">[?]</a></th>
	<td><span class="note">用户名 不能修改</span><input readonly=readonly disabled=disabled runat=server name="Uname" type="text" value="暂无" id="Uname" style="width:200px;" /></td>
</tr>
<tr>
	<th style="width:135px;">真实姓名&nbsp;<a href="#" class="help">[?]</a></th>
	<td><span class="note">真实姓名 不能修改</span><input readonly=readonly disabled=disabled runat=server name="Urealname" type="text" value="暂无" id="Urealname" style="width:200px;" /></td>
</tr>
<tr>
	<th style="width:135px;">原密码&nbsp;<a href="#" class="help">[?]</a></th>
	<td><span class="note">请输入正确的 原密码</span><input runat=server maxlength=16 dataType="Require" msg="请输入原先的密码" name="Oldpwd" type=password value="暂无" id="Oldpwd" style="width:200px;" /></td>
</tr>
<tr>
	<th style="width:135px;">新密码&nbsp;<a href="#" class="help">[?]</a></th>
	<td><span class="note">请输入 新密码 最好在6位以上</span><input runat=server maxlength=16 dataType="Require" msg="请输入新密码" name="newpwd" type=password value="暂无" id="newpwd" style="width:200px;" /></td>
</tr>
<tr>
	<th style="width:135px;">确认密码&nbsp;<a href="#" class="help">[?]</a></th>
	<td><span class="note">请再一次输入 新密码</span><input runat=server maxlength=16 dataType="Repeat" to="newpwd" msg="两次输入的密码不一致" name="newpwd1" type=password value="暂无" id="newpwd1" style="width:200px;" /></td>
</tr>
</table>

<br />
<div style="text-align:center;">
	<asp:Button runat=server class="button" ID=save_bt Text='保存' OnClick=Save_Btn />
	<input type=button class="button" value='关闭' onclick='closebox()' />
</div>

</div>

    </form>
</body>
</html>
