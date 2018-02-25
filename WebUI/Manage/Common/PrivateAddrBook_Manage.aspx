<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PrivateAddrBook_Manage.aspx.cs" Inherits="WC.WebUI.Manage.Common.PrivateAddrBook_Manage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>个人通讯录</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link type="text/css" href="/manage/Style/InterFace.Css" rel="stylesheet" rev="stylesheet" media="all" />
<link type="text/css" href="/manage/style.css" rel="stylesheet" rev="stylesheet" media="all" />
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/manage/include/common.js"></script>
<script type="text/javascript" src="/js/validator.js"></script>    
</head>
<body >
    <form id="form1" runat="server" onsubmit="return Validator.Validate(this.form,3);">
    <div id="interface_inside">
  <div id="interface_quick">
    <div class="interface_quick_left">您现在的操作 >> 我的工具 >> 添加联系人</div>
    <div class="interface_quick_right">
    <a href="javascript:void(0)" onclick="javascript:window.location.replace(window.location.href);"><img style="vertical-align:middle;" src="/manage/images/reload.png" /><strong>刷新</strong></a>
    &nbsp; &nbsp;
    <a href="javascript:history.back();"><img style="vertical-align:middle;" src="/manage/images/ico_up1.gif" /><strong>后退</strong></a>  
    </div>
    <div class="clearboth"></div>
  </div>
  <div id="interface_main">
    <div id="tabs_config" class="tabsbox">
      

      <div class="clearboth"></div>
      
      
      <!-- 模块 -->
        <table width="100%" border="0" cellspacing="0" cellpadding="0" >
          <tr>
            <td>
            
 <div id="config_basic1" class="tabs_wrapper">
<div class="tabs_main" align="left">  
<div id="Div1">           
    
<div id="PanelConfig">
<table class="table subsubmenu">
  <thead>
	<tr>
	  <td>
	  <a href="PrivateAddrBook.aspx">个人通讯录</a>
	  <a href="PrivateAddrBook_Manage.aspx">添加联系人</a>
	  </td>
	  <td style="text-align:right">	  
	  </td>
	</tr>
  </thead>
</table>
<br />       
<table class="table">
<thead>
<tr>
	<td colspan="2"><a href="#" class="helpall">[?]</a></td>
</tr>
</thead>
<tr>
	<th style="width:135px;">&nbsp;* 姓名：<a href="#" class="help">[?]</a></th>
	<td><span class="note">联系人姓名</span>
	<input runat=server name="Person" dataType="Require" msg="姓名不能为空" type="text" value="" id="Person" style="width:400px;" /></td>
</tr>
<tr>
	<th style="width:135px;">&nbsp;* 标签：<a href="#" class="help">[?]</a></th>
	<td><span class="note">联系人标签 如：同学、朋友等.</span>
	<input runat=server name="TagName" dataType="Require" msg="标签不能为空" type="text" value="朋友" id="TagName" style="width:400px;" /></td>
</tr>
<tr>
	<th style="width:135px;">&nbsp;* 电话：<a href="#" class="help">[?]</a></th>
	<td><span class="note">联系人电话号码</span>
	<input runat=server name="Phone" dataType="Require" msg="电话不能为空" type="text" value="" id="Phone" style="width:400px;" /></td>
</tr>
<tr >
	<th style="width:135px;">备注&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">备注</span>
	        <textarea runat=server name=Notes id=Notes rows=6 cols=60></textarea>
	</td>
</tr>
</table>

<br />
<div style="text-align:center;">
	<asp:Button runat=server class="button" ID=save_bt Text='保存' OnClick=Save_Btn OnClientClick="return Validator.Validate(this.form,3);" />
	&nbsp;&nbsp;<input type="reset" class="button" value='重置' />
</div>

    </div>
    
                  </div></div></div>
            </td>
          </tr>
        </table>
      <!-- 模块 -->

    </div>
  </div>
</div>
    </form>
</body>
</html>
