<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SMS_Send.aspx.cs" Inherits="WC.WebUI.Manage.SMS.SMS_Send" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>手机短信发送</title>
<script type="text/javascript" src="/js/validator.js"></script>
<link type="text/css" href="/manage/Style/InterFace.Css" rel="stylesheet" rev="stylesheet" media="all" />
<link type="text/css" href="/manage/style.css" rel="stylesheet" rev="stylesheet" media="all" />
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/manage/include/common.js"></script>
<script type="text/javascript" src="/js/popup/popup.js"></script>
<script type="text/javascript">
    function ShowIframe() {
        var users = document.getElementById("userlist");
        var pop = new Popup({ contentType: 1, scrollType: 'no', isReloadOnClose: false, width: 468, height: 395 });
        pop.setContent("contentUrl", "/Manage/Utils/SelectPeople.aspx");
        pop.setContent("title", "短信发送 - 接收人员选择");
        pop.build();
        pop.show();
    }
</script>
</head>
<body>
    <form id="form1" runat="server" onsubmit="return Validator.Validate(this.form,1);" enctype="multipart/form-data">
<div id="interface_inside">
  <div id="interface_quick">
    <div class="interface_quick_left">您现在的操作 >> 发送手机短信</div>
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
	  <a href="SMS_Send.aspx">发送短信</a>
	  </td>
	  <td style="text-align:right">

	  </td>
	</tr>
  </thead>
</table>
<br />

<div id="PanelManage" style="margin-top:0px;">
	
<table class="table1">
<thead>
<tr>
	<td> 撰写新短信&nbsp;<a href="#" title='查看所有帮助' class="helpall">[?]</a></td>
	<td>&nbsp;&nbsp;是否长短信<input runat=server id="IsLongMessage" type="checkbox" name="IsLongMessage" />
	</td>
</tr>
</thead>

<tr >
	<th style="width:140px; font-weight:bold;">内部人员&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请选择 内部接收人：点击右侧 [接收人] 按钮</span>
	<input runat=server type=hidden id=userlist name=userlist value="" />
	<textarea runat=server id=namelist name=namelist readonly=readonly 
	rows=3 cols=70 ></textarea>
	<input type=button value=接收人 class="textbutton" onclick=ShowIframe() />
	</td>
</tr>

<tr >
	<th style="width:140px; font-weight:bold;">手动输入&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请手动输入 接收人：多个手机号以 , 号隔开 (注意是英文状态下)</span>

	<textarea runat=server id=PhoneList name=PhoneList  
	rows=3 cols=70></textarea>多手机号以英文逗号隔开
	</td>
</tr>

<tr>
	<th style="width:140px; font-weight:bold;">* 短信内容&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请输入 手机短信内容. &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Shift+Enter 换行, Enter 段落</span>
	<textarea dataType="Require" msg="短信内容不能为空" id="Subject" rows=4 cols=70 runat="server" enableviewstate=false></textarea>
	</td>
</tr>



<tr>
	<th>&nbsp;</th>
	<td>
	<asp:Button runat=server class="button" ID=save_bt Text='发送' OnClick=Save_Btn OnClientClick="return Validator.Validate(this.form,1);" /> 短信一般数分钟后可接收!
	</td>
</tr>
<tr>
	<th>&nbsp;</th>
	<td>
短信通道为正规行业通道，禁止发送以下信息，如果发现网关立刻查封：<br>
1、中奖类信息　　2、骂人短信　　3、诽谤诈骗短信　　4、赌博违法短信　　5、彩票类短信　　6、欺骗短信<br>
7、聊天短信　　8、暧昧信息　　9、房产广告　　10、移动充值业务　　11、银行类业务　　12、考试作弊
	</td>
</tr>
</table>

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
