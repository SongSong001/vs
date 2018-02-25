<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Task_Manage.aspx.cs" Inherits="WC.WebUI.Manage.Tasks.Task_Manage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>工作任务编辑/发布</title>
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
            document.getElementById("aAddAttach").innerHTML = "继续添加任务附件";
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
                document.getElementById("aAddAttach").innerHTML = "添加任务附件";
                Attach.style.display = "none";
            }
            else {
                document.getElementById("aAddAttach").innerHTML = "继续添加任务附件";
            }
        }
</script> 

    <script type="text/javascript">
        function ShowIframe() {
            var users = document.getElementById("userlist");
            var pop = new Popup({ contentType: 1, scrollType: 'yes', isReloadOnClose: false, width: 468, height: 395 });
            pop.setContent("contentUrl", "/Manage/Utils/SelectPeople.aspx");
            pop.setContent("title", "任务发布 - 工作任务管理人员");
            pop.build();
            pop.show();
        }

        function ShowIframe_cc() {
            var users = document.getElementById("userlist_cc");
            var pop = new Popup({ contentType: 1, scrollType: 'yes', isReloadOnClose: false, width: 468, height: 400 });
            pop.setContent("contentUrl", "/Manage/Utils/SelectPeople_cc.aspx");
            pop.setContent("title", "任务发布 - 工作任务执行人员");
            pop.build();
            pop.show();
        }

        function select_btn() {
            var s = document.form1.se.value;
            if (s != '0') {
                var td = new Date();
                td.setDate(td.getDate() + parseInt(s));
                var n = td.getMonth() + 1;
                if (n < 10)
                    n = '0' + n;
                document.form1.ExpectTime.value = td.getFullYear() + '-' + n + '-' + td.getDate();
            }
            else
                document.form1.ExpectTime.value = '';
        }            
                 
    </script>   
</head>
<body >
    <form id="form1" runat="server" onsubmit="return Validator.Validate(this.form,1);" enctype="multipart/form-data">
<div id="interface_inside">
  <div id="interface_quick">
    <div class="interface_quick_left">您现在的操作 >> 工作任务发布</div>
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
	  <a href="Task_List.aspx?type=all"> 所有参与任务( <span id=t_all runat=server style="font-weight:bold;">0</span> ) </a>
	  <a href="Task_List.aspx?type=exeute"> 我执行的任务( <span id=t_exeute runat=server style="font-weight:bold;color:#ff0000; ">0</span> ) </a>
	  <a href="Task_List.aspx?type=manage"> 我管理的任务( <span id=t_manage runat=server style="font-weight:bold;color:#ff0000; ">0</span> ) </a>
	  <a href="Task_List.aspx?type=create"> 我创建的任务( <span id=t_create runat=server style="font-weight:bold;">0</span> ) </a>
	  <a href="Task_Manage.aspx">新建工作任务</a>
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
	<td> 编辑任务&nbsp;<a href="#" title='查看所有帮助' class="helpall">[?]</a></td>
	<td>&nbsp;
	<asp:Button runat=server class="button" ID=Button2 Text='保存' OnClick=Save_Btn OnClientClick='return confirm("您确定要保存本次任务吗?")' />
	&nbsp;&nbsp;<input type="reset" class="button" value='重置' />

	</td>
</tr>
</thead>

<tr >
	<th style="width:140px; font-weight:bold;">* 任务名称&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请输入 任务名称</span>
			<input runat=server size=97 dataType="Require" maxlength=200
			msg="任务名称不能为空" name="TaskName" type="text" id="TaskName" />
			
	</td>
</tr>

<tr>
	<th style="width:140px; font-weight:bold;">&nbsp;* 任务分类：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请选择 工作任务类别. (您可以在 工作任务类别管理 中添加分类)</span>
	<asp:DropDownList runat=server ID=TypeID dataType="Require" msg="您还没选择任何任务分类" style="width:580px;"></asp:DropDownList>
	</td>
</tr>

<tr>
	<th style="width:140px; font-weight:bold;">&nbsp; 期待完成时间：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请输入 期待完成时间.</span>
    <select name=se id=se onclick="select_btn()">
    <option value=0>自己选择日期</option>
    <option value=7>一星期</option>
    <option value=30>一个月</option>
    <option value=90>三个月</option>
    <option value=180>六个月</option>
    <option value=365>一年</option>
    </select> &nbsp; &nbsp; 
	<input runat=server name="ExpectTime" size=60 type="text" class="Wdate" readonly onClick="WdatePicker()" value="" id="ExpectTime" /></td>
</tr>

<tr >
	<th style="width:140px; font-weight:bold;">* 管理者&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请选择管理者：管理者可全过程查看/编辑/批注执行情况，可设置任务状态(运行、停止、完成)</span>
	<input runat=server type=hidden id=userlist name=userlist value="" />
	<input runat=server id=namelist name=namelist readonly=readonly size=81
	 dataType="Require" msg="管理者不能为空"></input>
	<input id=user_manager runat=server type=button value=管理者 class="textbutton" onclick=ShowIframe() />
	</td>
</tr>

<tr id=cc>
	<th style="width:140px; font-weight:bold;">* 执行者&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请选择 执行者 点击右侧 [执行者] 按钮. 执行者可接收任务，提交任务执行情况</span>
	<input runat=server type=hidden id=userlist_cc name=userlist_cc value="" />
	<textarea runat=server name="namelist_cc" rows=3 cols=70 dataType="Require" msg="执行者不能为空" type="text" id="namelist_cc" readonly=readonly ></textarea>
	<input id=user_exec runat=server type=button value=执行者 class="textbutton" onclick=ShowIframe_cc() />
	</td>
</tr>

<tr>
	<th style="width:140px; font-weight:bold;">任务内容&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请输入 工作任务内容. &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Shift+Enter 换行, Enter 段落</span>
	<textarea id="Bodys" style="width:80%;height:250px;visibility:hidden;" runat="server" enableviewstate=false></textarea>
	</td>
</tr>

<tr >
	<th style="width:140px; font-weight:bold;">* 任务级别&nbsp;<a href="#" title='查看所有帮助' class="help">[?]</a></th>
	<td>
	<span class="note">请选择 任务级别</span>
	<select style='width:165px;' name="Important" id="Important" dataType="Require"  msg="请选择任务级别" runat=server>
		<option value="短期任务">短期任务</option>
        <option value="一般任务" selected>一般任务</option>
        <option value="长期任务">长期任务</option>
		<option value="重要任务">重要任务</option>
        <option value="紧急任务">紧急任务</option>
        <option value="绝密任务">绝密任务</option>
	</select>
	</td>
</tr>

<tr >
	<th style="width:140px; font-weight:bold;">* 执行者选项&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">执行者选项</span>
		<input runat=server id="IsOtherSee" checked=checked type="checkbox" name="IsOtherSee" /> 执行者的执行情况 相互可见 &nbsp; (执行者 可查看其它人员的执行详情)<br>
	    <input runat=server id="OnceSubmit" checked=checked type="checkbox" name="OnceSubmit" /> 执行者 可多次提交执行情况 &nbsp; (如不选 执行者只可提交一次)
    </td>
</tr>

<tr >
	<th style="width:140px; font-weight:bold;">任务附件&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">可批量添加任务附件,附件总大小上限 50M. </span>
		&nbsp;&nbsp;<span style="font-weight:bold;"><a href="javascript:fAddAttach();" id="aAddAttach">添加任务附件</a></span>
		<br />
		<div runat=server id="dvReadAttach" style="float:left;"></div>
	</td>
</tr>

<asp:Panel ID="Attachword" runat="server" Visible="false">
<tr >
	<th style="width:140px; font-weight:bold;">已添加任务附件&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">勾选复选框 编辑已添加任务附件 </span>
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
	<asp:Button runat=server class="button" ID=save_bt Text='保存' OnClick=Save_Btn OnClientClick='return confirm("您确定要保存本次任务吗?")' />
	&nbsp;&nbsp;<input type="reset" class="button" value='重置' />
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
