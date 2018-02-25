<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Meeting_Manage.aspx.cs" Inherits="WC.WebUI.Manage.Common.Meeting_Manage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>会议管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link type="text/css" href="/manage/Style/InterFace.Css" rel="stylesheet" rev="stylesheet" media="all" />
<link type="text/css" href="/manage/style.css" rel="stylesheet" rev="stylesheet" media="all" />
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/manage/include/common.js"></script>
<script type="text/javascript" src="/js/validator.js"></script>   

    <link rel="stylesheet" href="/KindEditor4/themes/default/default.css" />
	<link rel="stylesheet" href="/KindEditor4/plugins/code/prettify.css" />
	<script type="text/javascript" charset="utf-8" src="/KindEditor4/kindeditor.js"></script>
	<script type="text/javascript" charset="utf-8" src="/KindEditor4/lang/zh_CN.js"></script>
	<script type="text/javascript" charset="utf-8" src="/KindEditor4/plugins/code/prettify.js"></script>
	<script type="text/javascript">
	    KindEditor.ready(function (K) {
	        var editor1 = K.create('#Bodys', {
	            cssPath: '/KindEditor4/plugins/code/prettify.css',
	            resizeType: 1,
	            allowPreviewEmoticons: false,
	            items: [
				'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
				'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
				'insertunorderedlist', '|', 'emoticons', 'baidumap', 'link']

	        });
	        prettyPrint();
	    });
</script> 

<script type="text/javascript">
    function fAddAttach()
    {
        var gAttchHTML='<div><input type="file" name="attachfile"><input type="button" name="Submit" value=" 删除 " id="btnDeleteReadAttach" /></div><span></span>';
        var Attach=document.getElementById("dvReadAttach");
        var spnList=Attach.getElementsByTagName("SPAN");
        var spn=document.createElement("DIV");
        spn.innerHTML=gAttchHTML;
        spn.childNodes[0].name="attachfile[]" + spnList.length;
        Attach.appendChild(spn); //增加gAttchHTML
        fGetObjInputById(spn,"btnDeleteReadAttach").onclick=function(){fDeleteAttach(this);};
        document.getElementById("aAddAttach").innerHTML="继续添加会议附件";
        Attach.style.display="";
    }

    function fGetObjInputById(obj,id)
    {
        var inputList=obj.getElementsByTagName("INPUT");
        for(var i=0;i<inputList.length;i++)
        {
            if(inputList[i].id==id)
            {
            return inputList[i];
            }
        }
        return null;
    }

    function fDeleteAttach(obj)
    {
        obj.parentNode.parentNode.parentNode.removeChild(obj.parentNode.parentNode);
        var Attach=document.getElementById("dvReadAttach");
        var spnList=Attach.getElementsByTagName("SPAN");
        if(spnList.length==0)
        {
            document.getElementById("aAddAttach").innerHTML="添加会议附件";
            Attach.style.display="none";
        }
        else
        {
            document.getElementById("aAddAttach").innerHTML="继续添加会议附件";
        }
    }
</script>
</head>
<body >
    <form id="form1" runat="server" onsubmit="return Validator.Validate(this.form,1);" enctype="multipart/form-data">
    <div id="interface_inside">
  <div id="interface_quick">
    <div class="interface_quick_left">您现在的操作 >> 我的工具 >> 添加会议</div>
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
<a href="Meeting_List.aspx">会议列表</a>
<a href="Meeting_Manage.aspx">添加会议</a>
	  </td>
	  <td style="text-align:right">
 
	  </td>
	</tr>
  </thead>
</table>
<br />            
    
<div id="PanelConfig">
      
<table class="table1">
<thead>
<tr>
	<td><a href="#" class="helpall">[?]</a></td>
	<td>&nbsp;
	<asp:Button runat=server class="button" ID=Button1 Text='保存' OnClick=Save_Btn OnClientClick="return Validator.Validate(this.form,1);" />&nbsp;&nbsp;
	<input type="reset" class="button" value='重置' />
	</td>
</tr>
</thead>

<tr>
	<th style="width:145px; font-weight:bold;  color:#ff0000;">&nbsp;* 会议主题：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请输入 会议主题。</span>
	<input runat=server name="MainTopics" dataType="Require" msg="会议主题不能为空" type="text" value="" id="MainTopics" style="width:550px;" /></td>
</tr>

<tr>
	<th style="width:145px; font-weight:bold;">&nbsp; 时间和地点：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请输入 会议的时间和地点.</span>&nbsp;&nbsp;
	会议时间：<input runat=server name="CTime" type="text" value="" id="CTime" size=30 /> 
	会议地点：<input runat=server name="Address" type="text" value="" id="Address" size=30 /> 
	</td>
</tr>

<tr>
	<th style="width:145px; font-weight:bold;">&nbsp; 会议主持/记录：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请输入 会议的主持人和会议记录人.</span>&nbsp;&nbsp;
	会议主持：<input runat=server name="Chaired" type="text" value="" id="Chaired" size=30 /> 
	记录人员：<input runat=server name="Recorder" type="text" value="" id="Recorder" size=30 /> 
	</td>
</tr>

<tr >
	<th style="width:145px; font-weight:bold;  color:#ff0000;">* 会议参加者：&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请输入 会议参与者.</span>
	        <textarea runat=server name=ListPerson dataType="Require" msg="会议参与者不能为空" id=ListPerson rows=3 style="width:550px;"></textarea>
	</td>
</tr>

<tr>
	<th style="width:145px; font-weight:bold;">&nbsp; 会议缺席者：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请输入 会议缺席者.</span>
	<input runat=server name="AbsencePerson" type="text" value="" id="AbsencePerson" style="width:550px;" /></td>
</tr>

<tr >
	<th style="width:145px; font-weight:bold; color:#ff0000;">&nbsp; 会议纪要：&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请输入 会议纪要(会议内容).</span>
<textarea id="Bodys" name="Bodys" style="width:560px;height:250px;visibility:hidden;" runat="server" enableviewstate=false></textarea>   
	</td>
</tr>

<tr >
	<th style="width:145px; font-weight:bold;"> 备注：&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请输入 会议参与者.</span>
	        <textarea runat=server name=Remarks id=Remarks rows=3 style="width:550px;"></textarea>
	</td>
</tr>

<tr >
	<th style="width:145px; font-weight:bold;"> 会议附件&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">可批量添加附件,附件总大小上限 50M. </span>
		&nbsp;&nbsp;<span style="font-weight:bold;"><a href="javascript:fAddAttach();" id="aAddAttach">添加会议附件</a></span>
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
	<th  style="width:135px;">&nbsp;</th>
	<td>&nbsp;
	<asp:Button runat=server class="button" ID=save_bt Text='保存' OnClick=Save_Btn OnClientClick="return Validator.Validate(this.form,1);" />&nbsp;&nbsp;
	<input type="reset" class="button" value='重置' />
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
