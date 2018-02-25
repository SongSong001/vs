<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="User_InfoEdit.aspx.cs" Inherits="WC.WebUI.Manage.Common.User_InfoEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>用户资料编辑</title>

<link type="text/css" href="/manage/Style/InterFace.Css" rel="stylesheet" rev="stylesheet" media="all" />
<link type="text/css" href="/manage/style.css" rel="stylesheet" rev="stylesheet" media="all" />
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/manage/include/common.js"></script>
<script type="text/javascript" src="/js/validator.js"></script>    
<script type="text/javascript" src="/js/formV/datepicker/WdatePicker.js"></script>
<script type="text/javascript" src="/js/popup/popup.js"></script>
<script type="text/javascript">
    function changePwd() {
        var pop = new Popup({ contentType: 1, scrollType: 'yes', isReloadOnClose: false, width: 535, height: 300 });
        pop.setContent("contentUrl", "/Manage/Common/User_PwdEdit.aspx");
        pop.setContent("title", "个人密码修改");
        pop.build();
        pop.show();
    }
    function personView() {
        var pop = new Popup({ contentType: 1, scrollType: 'yes', isReloadOnClose: false, width: 585, height: 465 });
        pop.setContent("contentUrl", '/manage/Sys/User_View.aspx?uid=<%=Uid %>');
        pop.setContent("title", "个人资料预览");
        pop.build();
        pop.show();
    }
</script> 
<script type="text/javascript">
	    function ShowIframe()
		{
		    var users = document.getElementById("userlist");
            var pop=new Popup({ contentType:1,scrollType:'no',isReloadOnClose:false,width:468,height:395});
            pop.setContent("contentUrl","/Manage/Utils/SelectPeople.aspx");
            pop.setContent("title","上司领导选择");
            pop.build();
            pop.show();
        } 
</script>
</head>
<body >
    <form id="form1" runat="server" onsubmit="return Validator.Validate(this.form,3);">
   <div id="interface_inside">
  <div id="interface_quick">
    <div class="interface_quick_left">您现在的操作 >> 个人资料编辑</div>
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

<table class="table subsubmenu">
  <thead>
	<tr>
	  <td>
<a href="#@" onclick="changePwd()">修改密码</a>
<a href="#@" onclick="personView()">个人资料预览</a>
	  </td>
	  <td style="text-align:right">

	  </td>
	</tr>
  </thead>
</table>
<br />            
    
<div id="PanelConfig">

<table class="table">
<thead>
<tr>
	<td colspan="2"><a href="#" class="helpall">[?]</a></td>
</tr>
</thead>

<tr >
	<th style="width:135px;font-weight:bold;">* 职务名称&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请输入职务名称 </span>
			<input runat=server size=30 maxlength=26 dataType="Require" msg="职务名称不能为空" 
			 name="PositionName" type="text" id="PositionName" />
	</td>
</tr>

<tr runat=server id=zjss visible=true>
	<th style="width:135px;font-weight:bold;color:#0055ff;">上司领导&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请选择员工的上司领导 (可选多人)</span>
        <input runat=server type=hidden id=userlist name=userlist value="" />
		<input runat=server size=30 name="namelist" type="text" id="namelist" readonly=readonly />        
        <input type=button value=上司领导 class="textbutton" onclick=ShowIframe() />
	</td>
</tr>

<tr >
	<th style="width:135px;font-weight:bold;color:#008800;">* 启用日程汇报&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">是否启用 工作日程的日程汇报. 启用后 您的上司领导将可以查看您的 工作日程汇报. </span>
		&nbsp; &nbsp; &nbsp; <input runat=server id="MemoShare" type="checkbox" name="MemoShare" /> &nbsp;&nbsp;&nbsp; 启用后 您的上司领导将可以查看您的 工作日程汇报. (默认不启用)
	</td>
</tr>

<tr >
	<th style="width:135px;font-weight:bold;color:#008800;">* 小秘书消息提示&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请选择 是否开启 小秘书消息提示</span>
	        <asp:DropDownList runat=server ID=RoleGUID>
	        <asp:ListItem Text='开启 小秘书消息提示(默认每10分钟提示一次)' Value='10'></asp:ListItem>
            <asp:ListItem Text='开启 小秘书消息提示(每2分钟提示一次)' Value='2'></asp:ListItem>
            <asp:ListItem Text='开启 小秘书消息提示(每5分钟提示一次)' Value='5'></asp:ListItem>
            <asp:ListItem Text='开启 小秘书消息提示(每30分钟提示一次)' Value='30'></asp:ListItem>
            <asp:ListItem Text='开启 小秘书消息提示(每20分钟提示一次)' Value='20'></asp:ListItem>
            <asp:ListItem Text='开启 小秘书消息提示(每1小时提示一次)' Value='60'></asp:ListItem>
            <asp:ListItem Text='开启 小秘书消息提示(每2小时提示一次)' Value='120'></asp:ListItem>
            <asp:ListItem Text='禁用 小秘书消息提示(不再提示)' Value='-1'></asp:ListItem>
            </asp:DropDownList> &nbsp; &nbsp; F5 刷新生效
	</td>
</tr>

<tr >
	<th style="width:135px;font-weight:bold;">* 性别&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请选择 性别</span>
            <asp:DropDownList runat=server ID=Sex>
            <asp:ListItem Text='男' Value=0></asp:ListItem>
            <asp:ListItem Text='女' Value=1></asp:ListItem>
            </asp:DropDownList>
	</td>
</tr>

<tr >
	<th style="width:135px;font-weight:bold;">生日&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">员工的出生日期 选填</span>
<INPUT runat=server class="Wdate"   readonly onClick="WdatePicker()" 
id=Birthday name=Birthday type=text size=30>        
	</td>
</tr>

<tr >
	<th style="width:135px;font-weight:bold;">腾讯QQ&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">员工的腾讯QQ 选填</span>
<INPUT runat=server
id=QQ name=QQ type=text size=30>        
	</td>
</tr>

<tr >
	<th style="width:135px;font-weight:bold;">电子邮件&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">员工的电子邮件 选填</span>
<INPUT runat=server
id=Email name=Email type=text size=30>        
	</td>
</tr>

<tr >
	<th style="width:135px;font-weight:bold;">* 移动电话&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">员工的移动电话 (手机短信接收号码)</span>
<INPUT runat=server
id=Phone name=Phone type=text size=30> 手机短信接收号码   
	</td>
</tr>

<tr >
	<th style="width:135px;font-weight:bold;">固定电话&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">员工的固定电话 选填</span>
<INPUT runat=server
id=Tel name=Tel type=text size=30>        
	</td>
</tr>

<tr >
	<th style="width:135px;font-weight:bold;">居住地址&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请输入居住地址 选填</span>
			<input runat=server size=30 maxlength=60
			 name="HomeAddress" type="text" id="HomeAddress" />
	</td>
</tr>

<tr style=' display:none'>
	<th style="width:135px;font-weight:bold;">入职日期&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">员工的入职日期 </span>
<INPUT runat=server class="Wdate"   readonly onClick="WdatePicker()" 
id=JoinTime name=JoinTime size=30 type=text>        
	</td>
</tr>

<tr >
	<th style="width:135px;font-weight:bold;">个人照片&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">员工的个人照片 </span>
<asp:FileUpload ID="Fup" runat="server" />     
	</td>
</tr>

<%--<tr >
	<th style="width:135px;font-weight:bold;">印章管理&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">如果您是印章使用者，可以点击这里管理您的印章</span>
	        <span runat=server id=seal> 您目前不是印章使用者!</span>
	</td>
</tr>--%>

<tr >
	<th style="width:135px;font-weight:bold;">员工备注&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请输入员工备注 如：张XX毕业于XX大学，加入公司以来......</span>
	        <textarea runat=server name=Notes id=Notes rows=4 cols=60></textarea>
	</td>
</tr>

</table>

<br />
<div style="text-align:center;">
	<asp:Button runat=server class="button" ID=save_bt Text='保存' OnClick=Save_Btn />
	<input type="reset" class="button" value='重置' />
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