<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Role_Manage.aspx.cs" Inherits="WC.WebUI.Manage.Sys.Role_Manage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>编辑用户角色</title>
<script type="text/javascript" src="/js/validator.js"></script>
<link type="text/css" href="/manage/Style/InterFace.Css" rel="stylesheet" rev="stylesheet" media="all" />
<link type="text/css" href="/manage/style.css" rel="stylesheet" rev="stylesheet" media="all" />
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/manage/include/common.js"></script>   
<script type="text/javascript">
function CheckAll(form)
{
	 for (var i=0;i<form.elements.length;i++)
	 {
		var e = form.elements[i];
		if (e.Name != 'chkAll'&&e.disabled==false)
		e.checked = form.chkAll.checked;
	}
 } 
</script> 
</head>
<body  >
    <form id="form1" runat="server" onsubmit="return Validator.Validate(this.form,3);">
<div id="interface_inside">
  <div id="interface_quick">
    <div class="interface_quick_left">您现在的操作 >> 系统管理 >> 角色管理</div>
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
	  <a href="Role_Manage.aspx">新增用户角色</a>
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
	<td> 编辑用户角色&nbsp;<a href="#" title='查看所有帮助' class="helpall">[?]</a></td>
	<td>&nbsp;
	<asp:Button runat=server class="button" ID=Button1 Text='保存' OnClick=Save_Btn OnClientClick="return Validator.Validate(this.form,3);" />
	&nbsp;&nbsp;<input type="reset" class="button" value='重置' />
	</td>	
</tr>
</thead>

<tr >
	<th style="width:145px; font-weight:bold;">* 用户角色名称&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请输入用户角色的名称 如：系统操作人员</span>
			<input runat=server size=50 dataType="Require" maxlength=50
			msg="用户角色名称不能为空" name="RoleName" type="text" id="RoleName" />
	</td>
</tr>

<tr >
	<th style="width:145px; font-weight:bold; vertical-align:top">角色权限列表&nbsp;<a href="#" class="help">[?]</a>
	<br/>
	<input name="chkAll" type="checkbox" id="chkAll" onclick=CheckAll(this.form) value="checkbox">全选/取消 &nbsp;
	</th>
	<td>
	<span class="note">请选择该角色 所具备的权限 </span>
    <asp:CheckBoxList ID=powerList runat=server RepeatDirection=Vertical></asp:CheckBoxList>
	</td>
</tr>

<tr >
	<th style="width:145px; font-weight:bold;">角色说明&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请输入该角色的 备注说明</span>
	        <textarea runat=server name=Notes id=Notes rows=4 cols=60></textarea>
	</td>
</tr>

<tr>
	<th>&nbsp;</th>
	<td>
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
