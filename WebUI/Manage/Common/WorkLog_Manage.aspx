<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WorkLog_Manage.aspx.cs" Inherits="WC.WebUI.Manage.Common.WorkLog_Manage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>工作汇报编辑</title>
<script type="text/javascript" src="/js/validator.js"></script>
<link type="text/css" href="/manage/Style/InterFace.Css" rel="stylesheet" rev="stylesheet" media="all" />
<link type="text/css" href="/manage/style.css" rel="stylesheet" rev="stylesheet" media="all" />
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/manage/include/common.js"></script>   
<script type="text/javascript" src="/js/formV/datepicker/WdatePicker.js"></script>    
    <link rel="stylesheet" href="/KindEditor4/themes/default/default.css" />
	<link rel="stylesheet" href="/KindEditor4/plugins/code/prettify.css" />
	<script type="text/javascript" charset="utf-8" src="/KindEditor4/kindeditor.js"></script>
	<script type="text/javascript" charset="utf-8" src="/KindEditor4/lang/zh_CN.js"></script>
	<script type="text/javascript" charset="utf-8" src="/KindEditor4/plugins/code/prettify.js"></script>
	<script type="text/javascript">
	    KindEditor.ready(function (K) {
	        var editor1 = K.create('#Bodys', {
	            cssPath: '/KindEditor4/plugins/code/prettify.css',
	            uploadJson: '/KindEditor4/upload_json.aspx',
	            fileManagerJson: '/KindEditor4/file_manager_json.aspx'
	        });
	        prettyPrint();
	    });
</script>

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
            document.getElementById("aAddAttach").innerHTML = "继续添加附件";
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
                document.getElementById("aAddAttach").innerHTML = "添加附件";
                Attach.style.display = "none";
            }
            else {
                document.getElementById("aAddAttach").innerHTML = "继续添加附件";
            }
        }

        function ShowIframe() {
            var users = document.getElementById("userlist");
            var pop = new Popup({ contentType: 1, scrollType: 'no', isReloadOnClose: false, width: 468, height: 395 });
            pop.setContent("contentUrl", "/Manage/Utils/SelectPeople.aspx");
            pop.setContent("title", "工作汇报 - 汇报领导选择");
            pop.build();
            pop.show();
        }   
</script>     
    
    
</head>
<body >
    <form id="form1" runat="server" onsubmit="return Validator.Validate(this.form,1);" enctype="multipart/form-data">
<div id="interface_inside">
  <div id="interface_quick">
    <div class="interface_quick_left">您现在的操作 >> 新增工作汇报</div>
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
<a href="/Manage/Common/WorkLog_List.aspx?action=mydoc" >我的汇报列表</a>
<a href="/Manage/Common/WorkLog_List.aspx?action=shared" >他人汇报列表</a>
<a href="/Manage/Common/WorkLog_Manage.aspx" >新建工作汇报</a>
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
	<th style="width:140px; font-weight:bold;">&nbsp;* 汇报标题：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请输入 标题.</span>
	<input runat=server name="LogTitle" dataType="Require" msg="标题不能为空" type="text" value="" id="LogTitle" size=97 /></td>
</tr>

<tr>
	<th style="width:140px; font-weight:bold;">&nbsp;* 汇报日期：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请选择 汇报日期.</span>
	<input runat=server name="addTime" type="text" dataType="Require" msg="汇报日期不能为空" id="addTime" class="Wdate" readonly="" onClick="WdatePicker()" size=97 />
    </td>
</tr>

<tr id=tr>
	<th style="width:140px; font-weight:bold;">&nbsp;汇报领导：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请选择 汇报领导：点击右侧 [汇报领导] 按钮.</span>
	<input runat=server type=hidden id=userlist name=userlist value="" />
	<textarea runat=server id=namelist name=namelist readonly=readonly dataType="Require" msg="汇报领导不能为空" 
	rows=3 cols=70 ></textarea>
	<input type=button value=汇报领导 class="textbutton" onclick=ShowIframe() />
	</td>
</tr>
<tr>
	<th style="width:140px; font-weight:bold;">* 汇报内容&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请输入 正文内容. &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Shift+Enter 换行, Enter 段落</span>
	<textarea id="Bodys" style="width:80%;height:350px;visibility:hidden;" runat="server" enableviewstate=false></textarea>
	</td>
</tr>


<tr >
	<th style="width:140px; font-weight:bold;">附件&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">可批量添加附件,附件总大小上限 50M. </span>
		&nbsp;&nbsp;<span style="font-weight:bold;"><a href="javascript:fAddAttach();" id="aAddAttach">添加附件</a></span>
		<br />
		<div runat=server id="dvReadAttach" style="float:left;"></div>
	</td>
</tr>

<asp:Panel ID="Attachword" runat="server" Visible="false">
<tr >
	<th style="width:140px; font-weight:bold;">已添加附件&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">勾选复选框 编辑已添加附件 </span>
		&nbsp;&nbsp;<div style="text-align:left; float:left;">
		<asp:Repeater runat=server ID=rpt><ItemTemplate>
		<input runat=server id=chk type="checkbox" checked=checked value=<%#Eval("Tmp1") %> />
		<%#Eval("Tmp2") %> &nbsp;&nbsp;&nbsp;&nbsp;<a href='/Manage/Utils/Download.aspx?destFileName=<%# Server.UrlEncode(Eval("Tmp3")+"") %>' ><img src='/img/mail_attachment.gif' />下载附件</a>
		
		<br>
	    </ItemTemplate></asp:Repeater></div>
	</td>
</tr>
</asp:Panel>

<tr>
	<th>&nbsp;</th>
	<td>
	<asp:Button runat=server class="button" ID=save_bt Text='保存' OnClick=Save_Btn OnClientClick="return Validator.Validate(this.form,1);" />
	&nbsp;&nbsp;<input type="reset" class="button" value='重置' />
</td>
</tr>

</table>

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
