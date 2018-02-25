<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Com_Basic.aspx.cs" Inherits="WC.WebUI.Manage.Sys.Com_Basic" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>单位基本信息设置</title>
<script type="text/javascript" src="/js/validator.js"></script>
<link type="text/css" href="/manage/Style/InterFace.Css" rel="stylesheet" rev="stylesheet" media="all" />
<link type="text/css" href="/manage/style.css" rel="stylesheet" rev="stylesheet" media="all" />
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/manage/include/common.js"></script>

<script type="text/javascript" src="/js/formV/datepicker/WdatePicker.js"></script>  
</head>
<body >
    <form id="form1" runat="server" onsubmit="return Validator.Validate(this.form,3);">
<div id="interface_inside">
  <div id="interface_quick">
    <div class="interface_quick_left">您现在的操作 >> 系统管理 >> 基本设置</div>
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
<div id="PanelConfig">
    
<table class="table subsubmenu">
  <thead>
	<tr>
	  <td>
<a href="/Manage/sys/Com_Basic.aspx" class="selected">基本设置</a>
	  </td>
	  <td style="text-align:right">

	  </td>
	</tr>
  </thead>
</table>
<br />    
    
<div id="PanelManage">
	
<table class="table">
<thead>
<tr>
	<td>单位信息<a href="#" class="helpall">[?]</a></td>
	<td>&nbsp;
	<asp:Button runat=server class="button" ID=Button1 Text='保存' OnClick=Save_Btn OnClientClick="return Validator.Validate(this.form,3);" />
	&nbsp;&nbsp;<input type="reset" class="button" value='重置' />
	</td>
</tr>
</thead>

<tr >
	<th style="width:140px; font-weight:bold;">* 单位名称&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请输入单位的名称 如：云创科技</span>
			<input runat=server size=40 dataType="Require" msg="单位名称不能为空" name="ComName" type="text" id="ComName" />
	</td>
</tr>

<tr >
	<th style="width:140px; font-weight:bold;">单位简介&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请输入单位简介 如：我公司成立于2008.5.1，主要发展方向.....</span>
	        <textarea runat=server name=Notes id=Notes rows=6 cols=60></textarea>
	</td>
</tr>

<tr >
	<th style="width:140px; font-weight:bold;">* 单位网址&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请输入单位的网站地址 如：http://www.job18.net</span>
			<input runat=server size=40 name="WebUrl" type="text" id="WebUrl" /> 可与 登陆页底部单位名称 增加超链接
	</td>
</tr>

<tr >
	<th style="width:140px; font-weight:bold;">联系方式&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请输入单位的联系方式 </span>
			<input runat=server size=40 name="et4" type="text" id="et4" />
	</td>
</tr>

<tr >
	<th style="width:140px; font-weight:bold;">系统Logo&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请输入Logo地址 如：/logo.jpg ('/'开头表示根目录) </span>
			<input runat=server size=40 name="Logo" type="text" id="Logo" />(登陆处Logo，/logo.jpg 表示程序根目录下，默认尺寸320*250)
	</td>
</tr>

<tr style="display:none;">
	<th style="width:140px; font-weight:bold;">启用BBS&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">是否启用内部BBS论坛子系统</span>
		<input runat=server id="BBSState" type="checkbox" name="BBSState" /> 是否启用内部BBS论坛子系统
	</td>
</tr>

<tr >
	<th style="width:140px; font-weight:bold;">登录验证码&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">是否启用登录验证码</span>
		<input runat=server id="ValidCodeState" type="checkbox" name="ValidCodeState" /> 是否启用 系统用户登录验证码
	</td>
</tr>

<tr >
	<th style="width:140px; font-weight:bold;">桌面滚动公告&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">是否启用桌面滚动公告</span>
		<input runat=server id="TipsState" type="checkbox" name="TipsState" /> 是否启用桌面滚动公告
	</td>
</tr>

<tr >
	<th style="width:140px; font-weight:bold;">开启消息提示&nbsp;<a href="#" title='查看所有帮助' class="help">[?]</a></th>
	<td>
	<span class="note">请选择 是否开启消息提示(消息小秘书功能)</span>
	<select name="TypeID" id="TypeID" dataType="Require"  msg="请选择所属类别" runat=server>
		<option value="1">开启</option>
		<option value="0">停止</option>
	</select> 是否开启系统消息提示(消息小秘书功能) 注意：这是针对所有系统用户
	</td>
</tr>

<tr >
	<th style="width:140px; font-weight:bold;">系统默认风格&nbsp;<a href="#" title='查看所有帮助' class="help">[?]</a></th>
	<td>
	<span class="note">请选择 系统默认风格</span>
	<select name="et3" id="et3" dataType="Require"  msg="请选择系统默认风格" runat=server>
		<option value="1">经典风格</option>
		<option value="0">传统风格</option>
	</select> 用户登陆系统后的默认风格. 注意：这是针对所有系统用户
	</td>
</tr>

<tr >
	<th style="width:140px; font-weight:bold;">数据库备份&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">点击 进入数据库备份 页面.</span>&nbsp;
    <strong><a href=DbBackup.aspx target=_blank> 点击进行 数据库备份操作 </a></strong>   	
	</td>
</tr>

<tr runat=server id=reg visible=false>
	<th style="width:140px; font-weight:bold;">系统注册&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">点击 系统注册 页面.</span>&nbsp;
    <strong><a href='/InfoTip/Operate_Reg.aspx' target=_blank> 点击进行系统注册 </a></strong>   	
	</td>
</tr>

<tr>
	<th>&nbsp;</th>
	<td>&nbsp;
	<asp:Button runat=server class="button" ID=save_bt Text='保存' OnClick=Save_Btn OnClientClick="return Validator.Validate(this.form,3);" />
	&nbsp;&nbsp;<input type="reset" class="button" value='重置' />
	</td>
</tr>
</table>

</div>

              </div></div>
            </div></td>
          </tr>
        </table>

      <!-- 模块 -->

    </div>
  </div>
</div>
    </form>
</body>
</html>