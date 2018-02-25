<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TaskType_Manage.aspx.cs" Inherits="WC.WebUI.Manage.Tasks.TaskType_Manage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>任务分类编辑</title>
<script type="text/javascript" src="/js/validator.js"></script>
<link type="text/css" href="/manage/Style/InterFace.Css" rel="stylesheet" rev="stylesheet" media="all" />
<link type="text/css" href="/manage/style.css" rel="stylesheet" rev="stylesheet" media="all" />
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/manage/include/common.js"></script>
<script type="text/javascript">
    function CheckAll(form) {
        for (var i = 0; i < form.elements.length; i++) {
            var e = form.elements[i];
            if (e.Name != 'chkAll' && e.disabled == false)
                e.checked = form.chkAll.checked;
        }
    } 
</script> 
 
</head>
<body >
    <form id="form1" runat="server" onsubmit="return Validator.Validate(this.form,3);">
<div id="interface_inside">
  <div id="interface_quick">
    <div class="interface_quick_left">您现在的操作 >> 工作任务 >> 任务分类编辑</div>
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
	  <a href="TaskType_Manage.aspx">新增任务分类</a>
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
	<td> 编辑任务分类&nbsp;<a href="#" title='查看所有帮助' class="helpall">[?]</a></td>
	<td>&nbsp;
	<asp:Button runat=server class="button" ID=Button1 Text='保存' OnClick=Save_Btn OnClientClick="return Validator.Validate(this.form,3);" />
	&nbsp;&nbsp;<input type="reset" class="button" value='重置' />
	</td>	
</tr>
</thead>

<tr >
	<th style="width:145px; font-weight:bold;">* 任务分类名称&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请输入该工作任务分类的名称 </span>
			<input runat=server size=50 dataType="Require" msg="任务分类名称不能为空" maxlength=50
			 name="TypeName" type="text" id="TypeName" />
	</td>
</tr>

<tr >
	<th style="width:145px; font-weight:bold;">* 上级工作分类&nbsp;<a href="#" class="help">[?]</a>
	</th>
	<td>
	<span class="note">请选择该分类 的上级分类(可添加多个根分类) </span>
    <asp:DropDownList runat=server ID="parentID" dataType="Require" msg="上级分类不能为空"></asp:DropDownList>
	</td>
</tr>

<tr >
	<th style="width:145px; font-weight:bold;">任务分类排序&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请输入任务分类排序 4位以下正整数 (排序指 同一层次分类中的序号)</span>
			<input runat=server value=1 size=30 dataType="Custom" regexp="^(0|[1-9]\d*)$" maxlength=3 
			msg="任务分类排序只能为正整数" name="Orders" type="text" id="Orders" />
	</td>
</tr>

<tr >
	<th style="width:145px; font-weight:bold;">备注&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请输入备注 </span>
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

      <!-- 模块 -->

    </div>
  </div>
</div>
    </form>
</body>
</html>
