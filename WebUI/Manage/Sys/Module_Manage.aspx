<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Module_Manage.aspx.cs" Inherits="WC.WebUI.Manage.Sys.Module_Manage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>编辑模块权限</title>
<script type="text/javascript" src="/js/validator.js"></script>
<link type="text/css" href="/manage/Style/InterFace.Css" rel="stylesheet" rev="stylesheet" media="all" />
<link type="text/css" href="/manage/style.css" rel="stylesheet" rev="stylesheet" media="all" />
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/manage/include/common.js"></script>  
</head>
<body>
    <form id="form1" runat="server" onsubmit="return Validator.Validate(this.form,3);">
<div id="interface_inside">
  <div id="interface_quick">
    <div class="interface_quick_left">您现在的操作 >> 权限编辑</div>
    <div class="interface_quick_right">
  
    </div>
    <div class="clearboth"></div>
  </div>
  <div id="interface_main">
    <div id="tabs_config" class="tabsbox">

      <div class="clearboth"></div>
      
      
      <!-- 模块 -->
      <div id="config_basic" class="tabs_wrapper"><div class="tabs_main" align='center'>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" >
          <tr>
            <td><div id="Div1" class="tabsbox">

              <div id="config_basic1" class="tabs_wrapper"><div class="tabs_main" align="left">      
    
<table class="table subsubmenu">
  <thead>
	<tr>
	  <td><a href="#">&gt;&gt;&nbsp;模块权限系统</a>
	  <a href="Module_List.aspx">模块权限列表</a>
	  <a href="Module_Manage.aspx">新增模块权限</a>
	  </td>
	  <td style="text-align:right">
<%--	  <input type="text" name="keywords" title="请输入搜索关键字" id="keywords" >
	  <asp:Button ID=search_bt runat=server Text=搜索 OnClick=Search_Btn class="search" />--%>
	  </td>
	</tr>
  </thead>
</table>
<br />

<div id="PanelManage">
	
<table class="table">
<thead>
<tr>
	<td> 编辑模块权限&nbsp;<a href="#" title='查看所有帮助' class="helpall">[?]</a></td>
	<td>&nbsp;
	<asp:Button runat=server class="button" ID=Button1 Text='保存' OnClick=Save_Btn OnClientClick="return Validator.Validate(this.form,3);" />
	&nbsp;&nbsp;<input type="reset" class="button" value='重置' />
	</td>	
</tr>
</thead>

<tr >
	<th style="width:145px; font-weight:bold;">* 模块权限名称&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请输入模块权限的名称 如：权限管理模块</span>
			<input runat=server size=50 dataType="Require" maxlength=50
			msg="模块权限名称不能为空" name="ModuleName" type="text" id="ModuleName" />
	</td>
</tr>

<tr >
	<th style="width:145px; font-weight:bold;">* 模块权限Url地址&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请输入模块权限Url地址 如：/Admin/Sys/Module_Add.aspx</span>
			<input runat=server size=50 dataType="Require" maxlength=150
			msg="模块权限Url地址不能为空" name="ModuleUrl" type="text" id="ModuleUrl" />
	</td>
</tr>

<tr >
	<th style="width:145px; font-weight:bold;">* 模块权限类别&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请输入模块权限的类别 如：权限管理</span>
			<input runat=server size=30 dataType="Require" maxlength=50
			msg="模块权限类别不能为空" name="TypeName" type="text" id="TypeName" />
	</td>
</tr>

<tr >
	<th style="width:145px; font-weight:bold;">模块权限排序&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请输入模块权限排序 4位以下正整数</span>
			<input runat=server size=30 dataType="Custom" regexp="^(0|[1-9]\d*)$" maxlength=3 
			msg="模块权限排序只能为正整数" name="Orders" type="text" id="Orders" />
	</td>
</tr>

<tr >
	<th style="width:145px; font-weight:bold;">是否显示&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">是否显示该模块权限 </span>
		<input runat=server id="IsShow" type="checkbox" checked=checked name="IsShow" /> (勾上表示显示)
	</td>
</tr>

<tr >
	<th style="width:145px; font-weight:bold;">模块权限简介&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请输入该模块权限简介 权限备注说明</span>
	        <textarea runat=server name=Notes id=Notes rows=6 cols=60></textarea>
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
      </div></div>
      <!-- 模块 -->

    </div>
  </div>
</div>
    </form>
</body>
</html>
