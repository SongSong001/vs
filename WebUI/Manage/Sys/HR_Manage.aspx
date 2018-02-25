<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HR_Manage.aspx.cs" Inherits="WC.WebUI.Manage.Sys.HR_Manage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>编辑员工人事资料</title>
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
        document.getElementById("aAddAttach").innerHTML = "继续添加证件扫描件";
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
            document.getElementById("aAddAttach").innerHTML = "添加证件扫描件";
            Attach.style.display = "none";
        }
        else {
            document.getElementById("aAddAttach").innerHTML = "继续添加证件扫描件";
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
    <div class="interface_quick_left">您现在的操作 >> 系统管理 >> 用户人事资料管理</div>
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
	<td> 编辑员工人事资料&nbsp;<a href="#" title='查看所有帮助' class="helpall">[?]</a></td>
	<td>&nbsp;
	<asp:Button runat=server class="button" ID=Button1 Text='保存' OnClick=Save_Btn OnClientClick="return Validator.Validate(this.form,3);" />
	&nbsp;&nbsp;<input type="reset" class="button" value='重置' />
	</td>	
</tr>
</thead>

<tr >
	<th style="width:165px; font-weight:bold;">* 身份证号码&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">身份证号码不能为空</span>
			<input runat=server size=50 dataType="Require" msg="身份证号码不能为空" maxlength=20
			 name="SFZNO" type="text" id="SFZNO" />
	</td>
</tr>

<tr >
	<th style="width:165px; font-weight:bold;">* 民族&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">民族不能为空</span>
			<input runat=server size=50 dataType="Require" msg="民族不能为空" maxlength=16
			 name="MinZu" type="text" id="MinZu" />
	</td>
</tr>

<tr >
	<th style="width:165px; font-weight:bold;">* 户口性质&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">户口性质不能为空</span>
			<input runat=server size=50 dataType="Require" msg="户口性质不能为空" maxlength=16
			 name="HuKouXZ" type="text" id="HuKouXZ" />
	</td>
</tr>

<tr >
	<th style="width:165px; font-weight:bold;">* 户口所在地&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">户口所在地不能为空</span>
			<input runat=server size=50 dataType="Require" msg="户口所在地不能为空" maxlength=36
			 name="HuKouSZD" type="text" id="HuKouSZD" />
	</td>
</tr>

<tr >
	<th style="width:165px; font-weight:bold;">参加工作时间&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">员工的参加工作时间</span>
<INPUT runat=server
id=WorkTime name=WorkTime type=text size=30 class="Wdate"   readonly onClick="WdatePicker()">        
	</td>
</tr>

<tr >
	<th style="width:165px; font-weight:bold;">毕业院校&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">毕业院校</span>
			<input runat=server size=50 maxlength=26
			 name="BiYeYX" type="text" id="BiYeYX" />
	</td>
</tr>

<tr >
	<th style="width:165px; font-weight:bold;">入学时间&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">员工的入学时间</span>
<INPUT runat=server
id=SchoolTime name=SchoolTime type=text size=30 class="Wdate"   readonly onClick="WdatePicker()">        
	</td>
</tr>

<tr >
	<th style="width:165px; font-weight:bold;">学历&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">学历</span>
			<input runat=server size=50 maxlength=16
			 name="XueLi" type="text" id="XueLi" />
	</td>
</tr>

<tr >
	<th style="width:165px; font-weight:bold;">专业&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">专业</span>
			<input runat=server size=50 maxlength=16
			 name="ZhuanYe" type="text" id="ZhuanYe" />
	</td>
</tr>

<tr >
	<th style="width:165px; font-weight:bold;">* 试用期(整数)&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">试用期</span>
			<input runat=server size=50 
			 name="SYQMonth" type="text" id="SYQMonth" dataType="Custom" regexp="^(0|[1-9]\d*)$" maxlength=3 msg="试用期为正整数" /> 月
	</td>
</tr>

<tr >
	<th style="width:165px; font-weight:bold;">* 转正日期&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">转正日期</span>
<INPUT runat=server
id=ZhuanZhengRQ name=ZhuanZhengRQ dataType="Require" msg="转正日期不能为空" type=text size=30 class="Wdate"   readonly onClick="WdatePicker()">        
	</td>
</tr>

<tr >
	<th style="width:165px; font-weight:bold;">* 劳动合同签订日期&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">劳动合同签订日期</span>
<INPUT runat=server
id=HTRQ name=HTRQ dataType="Require" msg="劳动合同签订日期不能为空" type=text size=30 class="Wdate"   readonly onClick="WdatePicker()">        
	</td>
</tr>

<tr >
	<th style="width:165px; font-weight:bold;">* 劳动合同年限&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">劳动合同年限</span>
			<input runat=server size=50
			 name="HTNX" type="text" id="HTNX" dataType="Custom" regexp="^(0|[1-9]\d*)$" maxlength=3 msg="劳动合同年限为正整数" /> 年
	</td>
</tr>

<tr >
	<th style="width:165px; font-weight:bold;">公司获奖情况&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请输入员工公司获奖情况</span>
	        <textarea runat=server name=HuoJiang id=HuoJiang rows=10 cols=85></textarea>
	</td>
</tr>


<tr >
	<th style="width:165px; font-weight:bold;">公司处罚情况&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请公司处罚情况</span>
	        <textarea runat=server name=ChuFa id=ChuFa rows=10 cols=85></textarea>
	</td>
</tr>

<tr >
	<th style="width:165px; font-weight:bold;">证件扫描件上传&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">可批量添加证件扫描件,证件扫描件总大小上限 50M. </span>
		&nbsp;&nbsp;<span style="font-weight:bold;"><a href="javascript:fAddAttach();" id="aAddAttach">添加证件扫描件</a></span>
		<br />
		<div runat=server id="dvReadAttach" style="float:left;"></div>
	</td>
</tr>

<asp:Panel ID="Attachword" runat="server" Visible="false">
<tr >
	<th style="width:165px; font-weight:bold;">已添加&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">勾选复选框 编辑已添加证件扫描件 </span>
		&nbsp;&nbsp;<div style="text-align:left; float:left;">
		<asp:Repeater runat=server ID=rpt><ItemTemplate>
		<input runat=server id=chk type="checkbox" checked=checked value=<%#Eval("Tmp1") %> />
		<%#Eval("Tmp2") %> &nbsp;&nbsp;&nbsp;&nbsp;<a href='/Manage/Utils/Download.aspx?destFileName=<%# Server.UrlEncode(Eval("Tmp3")+"") %>' ><img src='/img/mail_attachment.gif' />下载或打开证件扫描件</a>
		 
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
