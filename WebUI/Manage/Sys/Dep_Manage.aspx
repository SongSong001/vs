<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dep_Manage.aspx.cs" Inherits="WC.WebUI.Manage.Sys.Dep_Manage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>编辑部门职位</title>
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
<body >
    <form id="form1" runat="server" onsubmit="return Validator.Validate(this.form,3);">
<div id="interface_inside">
  <div id="interface_quick">
    <div class="interface_quick_left">您现在的操作 >> 系统管理 >> 组织机构管理</div>
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
	  <a href="Dep_Manage.aspx">新增组织机构</a>
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
	<td> 编辑部门职位&nbsp;<a href="#" title='查看所有帮助' class="helpall">[?]</a></td>
	<td>&nbsp;
	<asp:Button runat=server class="button" ID=Button1 Text='保存' OnClick=Save_Btn OnClientClick="return Validator.Validate(this.form,3);" />
	&nbsp;&nbsp;<input type="reset" class="button" value='重置' />
	</td>	
</tr>
</thead>

<tr >
	<th style="width:145px; font-weight:bold;">* 职能部门名称&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请输入该组织机构的名称 如：行政部</span>
			<input runat=server size=50 dataType="Require" msg="职能部门名称不能为空" maxlength=50
			 name="UDepName" type="text" id="UDepName" />
	</td>
</tr>

<tr >
	<th style="width:145px; font-weight:bold;">联系电话&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请输入联系电话 (联系电话 将出现在 登陆用户的组织机构通讯录中)</span>
			<input runat=server size=50 maxlength=50
			 name="Phone" type="text" id="Phone" />
	</td>
</tr>

<tr >
	<th style="width:145px; font-weight:bold;">组织机构类别&nbsp;<a href="#" class="help">[?]</a>
	</th>
	<td>
	<span class="note">请选择该组织机构的类别 部门/职位</span>
    <asp:DropDownList runat=server ID='IsPosition'>
    <asp:ListItem Text='部门' Value='1'></asp:ListItem>
    <asp:ListItem Text='职位' Value='0'></asp:ListItem>
    </asp:DropDownList>
	</td>
</tr>

<tr >
	<th style="width:145px; font-weight:bold;">* 上级组织机构&nbsp;<a href="#" class="help">[?]</a>
	</th>
	<td>
	<span class="note">请选择该组织机构 的上级部门/职位 </span>
    <asp:DropDownList runat=server ID="parentID" dataType="Require" msg="上级职位不能为空"></asp:DropDownList>
	</td>
</tr>

<tr >
	<th style="width:145px; font-weight:bold;">组织机构排序&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请输入组织机构排序 4位以下正整数 (排序指 同一层次中的序号)</span>
			<input runat=server size=30 dataType="Custom" regexp="^(0|[1-9]\d*)$" maxlength=3 
			msg="组织机构排序只能为正整数" name="Orders" type="text" id="Orders" />
	</td>
</tr>

<tr >
	<th style="width:145px; font-weight:bold;">备注&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请输入备注 如：行政部主要负责公司日常行政管理管理工作...</span>
	        <textarea runat=server name=Notes id=Notes rows=6 cols=60></textarea>
	</td>
</tr>

<tr >
	<th style="width:145px; font-weight:bold; vertical-align:top;">系统权限&nbsp;<a href="#" class="help">[?]</a>
	<br/>
	<input name="chkAll" type="checkbox" id="chkAll" onclick=CheckAll(this.form) value="checkbox">全选/取消 &nbsp;
	</th>
	<td>
	<span class="note">请选择该部门/职位 所具备的系统权限 </span>
    <asp:CheckBoxList ID=powerList runat=server RepeatDirection=Vertical></asp:CheckBoxList>
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
