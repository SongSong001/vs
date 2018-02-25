<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Seal_Manage.aspx.cs" Inherits="WC.WebUI.Manage.Sys.Seal_Manage" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>编辑印章/签名</title>
<script type="text/javascript" src="/js/validator.js"></script>
<link type="text/css" href="/manage/Style/InterFace.Css" rel="stylesheet" rev="stylesheet" media="all" />
<link type="text/css" href="/manage/style.css" rel="stylesheet" rev="stylesheet" media="all" />
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/manage/include/common.js"></script>   
    <style type="text/css">
        .style1
        {
            width: 293px;
            height: 115px;
        }
        .style2
        {
            width: 125px;
            height: 115px;
        }
        .style3
        {
            width: 145px;
            height: 115px;
        }
        .style4
        {
            height: 115px;
        }
    </style>
</head>
<body  >
    <form id="form1" runat="server" onsubmit="return Validator.Validate(this.form,3);">
<div id="interface_inside">
  <div id="interface_quick">
    <div class="interface_quick_left">您现在的操作 >> 系统管理 >> 印章/签名管理</div>
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
	  <a href="Seal_Manage.aspx">新增印章签名</a>
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
	<td> 编辑印章/签名&nbsp;<a href="#" title='查看所有帮助' class="helpall">[?]</a></td>
	<td colspan="3">&nbsp;
	<asp:Button runat=server class="button" ID=Button1 Text='保存' OnClick=Save_Btn OnClientClick="return Validator.Validate(this.form,3);" />
	&nbsp;&nbsp;<input type="reset" class="button" value='重置' />
	</td>	
</tr>
</thead>

<tr >
	<th style="width:145px; font-weight:bold;">* 印章/签名名称&nbsp;<a href="#" class="help">[?]</a></th>
	<td colspan="3">
	<span class="note">请输入印章/签名的名称 如：XX部门 </span>
			<input runat=server size=50 dataType="Require" maxlength=100
			msg="印章/签名名称不能为空" name="SealName" type="text" id="SealName" />
	</td>
</tr>

<tr >
	<th style="width:145px; font-weight:bold;">* 印章/签名标签&nbsp;<a href="#" class="help">[?]</a></th>
	<td colspan="3">
	<span class="note">请输入印章/签名标签 如：盖章</span>
			<input runat=server size=50 dataType="Require" maxlength=50
			msg="标签不能为空" name="TagName" type="text" id="TagName" />
	</td>
</tr>

<tr >
	<th style="width:145px; font-weight:bold;">* 印章/签名使用人&nbsp;<a href="#" class="help">[?]</a></th>
	<td colspan="3">
	<span class="note">请在下拉框中 选择印章/签名 使用人</span>
            <asp:DropDownList runat=server ID=uids EnableViewState=false dataType="Require" msg="请选择使用人"></asp:DropDownList>
	</td>
</tr>

<tr >
	<th style="width:145px; font-weight:bold;"> 印章/签名使用密码&nbsp;<a href="#" class="help">[?]</a></th>
	<td colspan="3">
	<span class="note">印章/签名密码 将在电子印章、电子签名时使用 </span>
		<input runat=server id="PWD" type=password name="PWD" />
	</td>
</tr>

<tr >
	<th style="font-weight:bold;" class="style3"> 上传印章签名&nbsp;<a href="#" class="help">[?]</a></th>
	<td class="style1">
	<span class="note">在这里上传印章和签名的图片，限jpg/gif/png格式</span>
		<asp:FileUpload ID="Fup" runat="server" /> (jpg/gif/png格式)
	</td>
	<td class="style2">
	<asp:Image runat="server" ImageUrl="~/Manage/images/zanwu.gif" ID='PerPic' 
                Width='120px' Height='120px' style="border:solid 1px #999999" />
	</td>
	<td class="style4">
	    </td>
</tr>

<tr >
	<th style="width:145px; font-weight:bold;">* 是否启用&nbsp;<a href="#" class="help">[?]</a></th>
	<td colspan="3">
	<span class="note">是否显示该印章/签名 </span>
		<input runat=server id="Status" type="checkbox" checked=checked name="Status" /> (勾上表示启用)
	</td>
</tr>

<tr >
	<th style="width:145px; font-weight:bold;">印章/签名说明&nbsp;<a href="#" class="help">[?]</a></th>
	<td colspan="3">
	<span class="note">请输入该印章/签名 备注说明</span>
	        <textarea runat=server name=Notes id=Notes rows=3 cols=50></textarea>
	</td>
</tr>

<tr>
	<th>&nbsp;</th>
	<td colspan="3">&nbsp;
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

