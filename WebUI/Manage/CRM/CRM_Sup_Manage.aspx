<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CRM_Sup_Manage.aspx.cs" Inherits="WC.WebUI.Manage.CRM.CRM_Sup_Manage" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>供应商编辑</title>
<script type="text/javascript" src="/js/validator.js"></script>
<link type="text/css" href="/manage/Style/InterFace.Css" rel="stylesheet" rev="stylesheet" media="all" />
<link type="text/css" href="/manage/style.css" rel="stylesheet" rev="stylesheet" media="all" />
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/manage/include/common.js"></script>
    
    
</head>
<body >
    <form id="form1" runat="server" onsubmit="return Validator.Validate(this.form,1);" enctype="multipart/form-data">
<div id="interface_inside">
  <div id="interface_quick">
    <div class="interface_quick_left">您现在的操作 >> 我的客户 >> 供应商资料编辑</div>
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
	  <a href="CRM_Sup_List.aspx">供应商列表</a>
	  <a href="CRM_Sup_Manage.aspx">新建供应商</a>
	  </td>
	  <td style="text-align:right">	  
	  </td>
	</tr>
  </thead>
</table>
<br /> 
<table class="table1">
<thead>
<tr>
	<td><a href="#" class="helpall">[?]</a></td>
	<td>
		<asp:Button runat=server class="button" ID=Button1 Text='保存' OnClick=Save_Btn OnClientClick="return Validator.Validate(this.form,1);" />
	&nbsp;&nbsp;<input type="reset" class="button" value='重置' />
	</td>
</tr>
</thead>
<tr>
	<th style="width:145px; font-weight:bold;">&nbsp;* 供应商名称：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请输入 供应商名称.</span>
	<input runat=server name="Sup_Name" dataType="Require" msg="供应商名称不能为空" type="text" value="" id="Sup_Name" size=97 /></td>
</tr>

<tr>
	<th style="width:145px; font-weight:bold;">&nbsp;* 主要负责人：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请输入 主要负责人.</span>
	<input runat=server name="MainPeople" dataType="Require" msg="主要负责人不能为空" type="text" value="" id="MainPeople" size=45 /></td>
</tr>

<tr>
	<th style="width:145px; font-weight:bold;">&nbsp;* 联系电话：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请输入 联系电话.</span>
	<input runat=server name="Tel" dataType="Require" msg="电话不能为空" type="text" value="" id="Tel" size=45 /> 
	</td>
</tr>

<tr>
	<th style="width:145px; font-weight:bold;">&nbsp;* 供应商地址：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请输入 供应商地址.</span>
	<input runat=server name="Addr" dataType="Require" msg="供应商地址不能为空" type="text" value="" id="Addr" size=45 /></td>
</tr>

<tr>
	<th style="width:145px; font-weight:bold;">备注&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请输入 该供应商的备注信息. </span>
	<textarea runat=server style="BACKGROUND-IMAGE: url(/img/line.gif); LINE-HEIGHT: 22px; padding-left:3px; background-repeat:repeat;" name=Notes id=Notes rows=4 cols=83></textarea>
	</td>
</tr>



<tr>
	<th>&nbsp;</th>
	<td>
	<asp:Button runat=server class="button" ID=save_bt Text='保存' OnClick=Save_Btn OnClientClick="return Validator.Validate(this.form,1);" />
	&nbsp;&nbsp;<input type="reset" class="button" value='重置' />
</td>
</tr>

</table>

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

