<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SMS_SetUp.aspx.cs" Inherits="WC.WebUI.Manage.SMS.SMS_SetUp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>短信设置</title>
<script type="text/javascript" src="/js/validator.js"></script>
<link type="text/css" href="/manage/Style/InterFace.Css" rel="stylesheet" rev="stylesheet" media="all" />
<link type="text/css" href="/manage/style.css" rel="stylesheet" rev="stylesheet" media="all" />
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/manage/include/common.js"></script>

<link type="text/css" href="/manage/style.css" rel="stylesheet" rev="stylesheet" media="all" /> 
</head>
<body>
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
<a href="SMS_SetUp.aspx" class="selected">短信设置</a>
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
	<td>短信配置<a href="#" class="helpall">[?]</a></td>
	<td>&nbsp;
	<asp:Button runat=server class="button" ID=Button1 Text='保存' OnClick=Save_Btn OnClientClick="return Validator.Validate(this.form,3);" />
	&nbsp;&nbsp;<input type="reset" class="button" value='重置' />
	</td>
</tr>
</thead>
<tr >
	<th style="width:140px; font-weight:bold; color:#ff0000">* 启用接口&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">是否启用短信接口</span>
			<asp:CheckBox runat=server ID=et2 Checked=false />
            &nbsp; &nbsp; 是否启用手机短信接口 (不勾选表示系统禁用 手机短信功能)
	</td>
</tr>

<tr >
	<th style="width:140px; font-weight:bold;">接口地址&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请输入短信接口地址 ？号之前的那部分</span>
			<input readonly=readonly runat=server size=70 dataType="Require" msg="接口地址不能为空" name="sms_url" type="text" id="sms_url" />
            该处请修改 根目录 sms.config文件!
	</td>
</tr>

<tr >
	<th style="width:140px; font-weight:bold;">接口用户&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请输入短信接口的用户名</span>
			<input readonly=readonly runat=server size=70 dataType="Require" msg="接口用户不能为空" name="sms_user" type="text" id="sms_user" />
            同上
	</td>
</tr>

<tr >
	<th style="width:140px; font-weight:bold;">接口密码&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请输入短信接口的用户密码</span>
			<input readonly=readonly runat=server size=70 dataType="Require" msg="接口密码不能为空" name="sms_pwd" type="text" id="sms_pwd" />
            同上
	</td>
</tr>

<tr >
	<th style="width:140px; font-weight:bold;">* 流程短信&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请输入流程短信的模板语，x为真实姓名 p为职位名 t为流程标题</span>
			<input runat=server size=70 dataType="Require" msg="流程短信不能为空" name="cont_f" type="text" id="cont_f" />
	</td>
</tr>

<tr >
	<th style="width:140px; font-weight:bold;">* 公文短信&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请输入公文短信的模板语，x为真实姓名 p为职位名 t为公文标题</span>
			<input runat=server size=70 dataType="Require" msg="公文短信不能为空" name="cont_g" type="text" id="cont_g" />
	</td>
</tr>

<tr >
	<th style="width:140px; font-weight:bold;">* 资讯短信&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请输入资讯短信的模板语，t为资讯标题</span>
			<input runat=server size=70 dataType="Require" msg="资讯短信不能为空" name="cont_n" type="text" id="cont_n" />
	</td>
</tr>

<tr >
	<th style="width:140px; font-weight:bold;">* 邮件短信&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请输入流程短信的模板语， t为邮件标题</span>
			<input runat=server size=70 dataType="Require" msg="邮件短信不能为空" name="cont_m" type="text" id="cont_m" />
	</td>
</tr>

<tr >
	<th style="width:140px; font-weight:bold;">短信余额&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">调用短信供应商的接口程序显示 短信余额数量.</span>&nbsp;
    <strong><asp:Label ID=DXYE runat=server></asp:Label> </strong>   	
	</td>
</tr>

<tr>
	<th>&nbsp;</th>
	<td>&nbsp;
	<asp:Button runat=server class="button" ID=save_bt Text='保存' OnClick=Save_Btn OnClientClick="return Validator.Validate(this.form,3);" />
	&nbsp;&nbsp;<input type="reset" class="button" value='重置' /> (保存配置后 重启服务器生效！) 非专业人士请慎重修改，以免出错！
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
