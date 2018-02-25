<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="User_Manage.aspx.cs" Inherits="WC.WebUI.Manage.Sys.User_Manage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>编辑员工资料</title>
<script type="text/javascript" src="/js/validator.js"></script>
<link type="text/css" href="/manage/Style/InterFace.Css" rel="stylesheet" rev="stylesheet" media="all" />
<link type="text/css" href="/manage/style.css" rel="stylesheet" rev="stylesheet" media="all" />
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/manage/include/common.js"></script>

<script type="text/javascript" src="/js/formV/datepicker/WdatePicker.js"></script>
<script type="text/javascript" src="/js/popup/popup.js"></script>
<script type="text/javascript">

    function fAddAttach() {
        var gAttchHTML = '<div><input type="file" name="attachfile"><input type="button" name="Submit" value=" 删除 " id="btnDeleteReadAttach" /></div><span></span>';
        var Attach = document.getElementById("dvReadAttach");
        var spnList = Attach.getElementsByTagName("SPAN");
        var spn = document.createElement("DIV");
        spn.innerHTML = gAttchHTML;
        spn.childNodes[0].name = "attachfile[]" + spnList.length;
        Attach.appendChild(spn); //增加gAttchHTML
        fGetObjInputById(spn, "btnDeleteReadAttach").onclick = function () { fDeleteAttach(this); };
        document.getElementById("aAddAttach").innerHTML = "继续添加档案文件";
        Attach.style.display = "";
    }

    function fGetObjInputById(obj, id) {
        var inputList = obj.getElementsByTagName("INPUT");
        for (var i = 0; i < inputList.length; i++) {
            if (inputList[i].id == id) {
                return inputList[i];
            }
        }
        return null;
    }

    function fDeleteAttach(obj) {
        obj.parentNode.parentNode.parentNode.removeChild(obj.parentNode.parentNode);
        var Attach = document.getElementById("dvReadAttach");
        var spnList = Attach.getElementsByTagName("SPAN");
        if (spnList.length == 0) {
            document.getElementById("aAddAttach").innerHTML = "添加档案文件";
            Attach.style.display = "none";
        }
        else {
            document.getElementById("aAddAttach").innerHTML = "继续添加档案文件";
        }
    }

    function ShowIframe() {
        var users = document.getElementById("userlist");
        var pop = new Popup({ contentType: 1, scrollType: 'yes', isReloadOnClose: false, width: 468, height: 395 });
        pop.setContent("contentUrl", "/Manage/Utils/SelectPeople.aspx");
        pop.setContent("title", "上司领导选择");
        pop.build();
        pop.show();
    } 
</script>   
</head>
<body >
    <form id="form1" runat="server" enctype="multipart/form-data" onsubmit="return Validator.Validate(this.form,3);">
<div id="interface_inside">
  <div id="interface_quick">
    <div class="interface_quick_left">您现在的操作 >> 系统管理 >> 用户管理</div>
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
<a href="/manage/sys/User_List.aspx" class="selected">用户列表</a>
<a href="/manage/sys/HR_List.aspx?action=zz" class="selected">人事资料列表</a>
<a href="/manage/sys/User_Manage.aspx" class="selected">添加用户</a>
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
	<td> 编辑员工资料&nbsp;<a href="#" title='查看所有帮助' class="helpall">[?]</a></td>
	<td>&nbsp;
	<asp:Button runat=server class="button" ID=Button1 Text='保存' OnClick=Save_Btn OnClientClick="return Validator.Validate(this.form,3);" />
	&nbsp;&nbsp;<input type="reset" class="button" value='重置' />
	</td>	
</tr>
</thead>

<tr >
	<th style="width:145px; font-weight:bold;">* 系统用户名&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">本系统登录的用户名 2-16位 字母(小写)或数字组成</span>
			<input runat=server size=30 dataType="Custom" regexp="\w{2,16}" maxlength=16
			msg="用户名 2-16位 字母(小写)或数字组成" name="UUserName" type="text" id="UUserName" />
	</td>
</tr>

<tr >
	<th style="width:145px; font-weight:bold;">用户密码&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">用户登录密码 最好在6位以上</span>
			<input runat=server size=30 maxlength=16
			 name="PassWord" type=password id="PassWord" />
	</td>
</tr>

<tr >
	<th style="width:145px; font-weight:bold;">确认用户密码&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请重新输入一次 密码</span>
			<input runat=server size=30 dataType="Repeat" to="PassWord" msg="两次输入的密码不一致" maxlength=16
			 name="PassWord2" type=password id="PassWord2" />
	</td>
</tr>

<tr >
	<th style="width:145px; font-weight:bold;">* 真实姓名&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请输入真实姓名 要求中文</span>
			<input runat=server size=30 dataType="Chinese" msg="真实姓名只允许中文" maxlength=6
			 name="URealName" type="text" id="URealName" />
	</td>
</tr>

<tr >
	<th style="width:145px; font-weight:bold;">* 职务名称&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请输入职务名称 </span>
			<input runat=server size=30 dataType="Require" msg="职务名称不能为空" maxlength=26
			 name="PositionName" type="text" id="PositionName" />
	</td>
</tr>

<tr>
	<th style="width:145px; font-weight:bold;">* 职能部门&nbsp;<a href="#" class="help">[?]</a>
	</th>
	<td>
	<span class="note">请选择员工 相应的职能部门 </span>
    <asp:DropDownList runat=server ID="parentID" dataType="Require" msg="职能部门不能为空"></asp:DropDownList>
	</td>
</tr>

<tr >
	<th style="width:145px; font-weight:bold;">* 系统角色&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请选择员工所属的系统角色</span>
        <asp:DropDownList runat=server ID=RoleID dataType="Require" msg="请选择系统角色"></asp:DropDownList>       
	</td>
</tr>

<tr >
	<th style="width:145px; font-weight:bold;">性别&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请选择 性别</span>
          <asp:RadioButtonList RepeatDirection=Horizontal runat=server ID=Sex1>
          <asp:ListItem Selected=True Text='男' Value='0'></asp:ListItem>
          <asp:ListItem Text='女' Value='1'></asp:ListItem>
          </asp:RadioButtonList>            
	</td>
</tr>

<tr >
	<th style="width:145px; font-weight:bold;">生日&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">员工的出生日期 选填</span>
<INPUT runat=server
id=Birthday name=Birthday type=text size=30 class="Wdate"   readonly onClick="WdatePicker()">        
	</td>
</tr>

<tr >
	<th style="width:145px; font-weight:bold;">* 移动电话&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">员工的移动电话 (手机短信接收号码)</span>
<INPUT runat=server
id=Phone name=Phone type=text size=30> 手机短信接收号码
	</td>
</tr>

<tr >
	<th style="width:145px; font-weight:bold;">固定电话&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">员工的固定电话 (固定电话 将出现在 登陆用户的通讯录中)</span>
<INPUT runat=server
id=Tel name=Tel type=text size=30>        
	</td>
</tr>

<tr >
	<th style="width:145px; font-weight:bold;">电子邮件&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">员工的电子邮件 选填</span>
<INPUT runat=server
id=Email name=Email type=text size=30>        
	</td>
</tr>

<tr >
	<th style="width:145px; font-weight:bold;">腾讯QQ&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">员工的腾讯QQ 选填</span>
<INPUT runat=server
id=QQ name=QQ type=text size=30>        
	</td>
</tr>

<tr >
	<th style="width:145px; font-weight:bold;">居住地址&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请输入居住地址 选填</span>
			<input runat=server size=30 maxlength=60
			 name="HomeAddress" type="text" id="HomeAddress" />
	</td>
</tr>

<tr >
	<th style="width:145px; font-weight:bold;">入职日期&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">员工的入职日期 </span>
<INPUT runat=server
id=JoinTime name=JoinTime size=30 type=text class="Wdate"   readonly onClick="WdatePicker()">        
	</td>
</tr>

<tr >
	<th style="width:145px; font-weight:bold;">个人照片&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">员工的个人照片 </span>
<asp:FileUpload ID="Fup" runat="server" />      
	</td>
</tr>

<tr >
	<th style="width:145px; font-weight:bold;">在职/离职&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请选择 该员工 在职/离职</span>
          <asp:RadioButtonList RepeatDirection=Horizontal runat=server ID=Status1>
          <asp:ListItem Selected=True Text='在 职' Value='0'></asp:ListItem>
          <asp:ListItem Text='离 职' Value='1'></asp:ListItem>
          </asp:RadioButtonList>                
	</td>
</tr>

<tr >
	<th style="width:145px; font-weight:bold;">是否锁定&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">此项勾上 表示该员工已锁定 将无法登录系统</span>
            <input runat=server id="IsLock" type="checkbox" name="IsLock" />
	</td>
</tr>

<tr >
	<th style="width:145px; font-weight:bold;">上司领导&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请选择员工的上司领导 (可选多人)</span>
        <input runat=server type=hidden id=userlist name=userlist value="" />
		<input runat=server size=30 name="namelist" type="text" id="namelist" readonly=readonly />        
        <input type=button value=上司领导 class="textbutton" onclick=ShowIframe() />        
              
	</td>
</tr>

<tr >
	<th style="width:145px; font-weight:bold;">可否自选上司&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">用户是否可以 自行选择上司领导</span>
          <asp:RadioButtonList RepeatDirection=Horizontal runat=server ID=DepGuid>
          <asp:ListItem Selected=True Text='用户可以自行选择上司领导' Value=''></asp:ListItem>
          <asp:ListItem Text='不可以' Value='no'></asp:ListItem>
          </asp:RadioButtonList>
	</td>
</tr>

<tr >
	<th style="width:145px;font-weight:bold;color:#008800;">启用日程汇报&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">是否启用 工作日程的日程汇报. 启用后 他的上司领导将可以看到他的 工作日程汇报. </span>
		&nbsp; &nbsp; &nbsp; <input runat=server id="MemoShare" type="checkbox" name="MemoShare" /> &nbsp;&nbsp;&nbsp; 启用后 他的上司领导将可以看到他的 工作日程汇报. (默认不启用)
	</td>
</tr>

<tr >
	<th style="width:145px;font-weight:bold;color:#008800;">小秘书消息提示&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请选择 是否开启 小秘书消息提示</span>
	        <asp:DropDownList runat=server ID=RoleGUID>
	        <asp:ListItem Text='开启 小秘书消息提示(默认每10分钟提示一次)' Value='10'></asp:ListItem>
            <asp:ListItem Text='开启 小秘书消息提示(每2分钟提示一次)' Value='2'></asp:ListItem>
            <asp:ListItem Text='开启 小秘书消息提示(每5分钟提示一次)' Value='5'></asp:ListItem>
            <asp:ListItem Text='开启 小秘书消息提示(每20分钟提示一次)' Value='20'></asp:ListItem>
            <asp:ListItem Text='开启 小秘书消息提示(每30分钟提示一次)' Value='30'></asp:ListItem>
            <asp:ListItem Text='开启 小秘书消息提示(每1小时提示一次)' Value='60'></asp:ListItem>
            <asp:ListItem Text='开启 小秘书消息提示(每2小时提示一次)' Value='120'></asp:ListItem>
            <asp:ListItem Text='禁用 小秘书消息提示(不再提示)' Value='-1'></asp:ListItem>
            </asp:DropDownList>
	</td>
</tr>

<tr >
	<th style="width:145px; font-weight:bold;">排序&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">员工在所属组织机构中的 显示排序 (4位以下正整数，排序指 员工在同一部门中的顺序)</span>
<INPUT runat=server dataType="Custom" regexp="^(0|[1-9]\d*)$" maxlength=3 msg="排序只能为正整数"
 id=Orders name=Orders value='0' type=text size=30>        
	</td>
</tr>

<tr >
	<th style="width:145px; font-weight:bold;">员工备注&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请输入员工备注 如：张XX于2007年五月加入我公司......</span>
	        <textarea runat=server name=Notes id=Notes rows=6 cols=60></textarea>
	</td>
</tr>

<tr >
	<th style="width:145px; font-weight:bold;">档案文件&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">可批量添加档案文件,档案文件总大小上限 50M. </span>
		&nbsp;&nbsp;<span style="font-weight:bold;"><a href="javascript:fAddAttach();" id="aAddAttach">添加档案文件</a></span>
		<br />
		<div runat=server id="dvReadAttach" style="float:left;"></div>
	</td>
</tr>

<asp:Panel ID="Attachword" runat="server" Visible="false">
<tr >
	<th style="width:145px; font-weight:bold;">已添加&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">勾选复选框 编辑已添加档案文件 </span>
		&nbsp;&nbsp;<div style="text-align:left; float:left;">
		<asp:Repeater runat=server ID=rpt><ItemTemplate>
		<input runat=server id=chk type="checkbox" checked=checked value=<%#Eval("Tmp1") %> />
		<%#Eval("Tmp2") %> &nbsp;&nbsp;&nbsp;&nbsp;<a href='/Manage/Utils/Download.aspx?destFileName=<%# Server.UrlEncode(Eval("Tmp3")+"") %>' ><img src='/img/mail_attachment.gif' />下载档案文件</a>
		 
		<br>
	    </ItemTemplate></asp:Repeater></div>
	</td>
</tr>
</asp:Panel>

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