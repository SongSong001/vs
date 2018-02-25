<%@ Page ValidateRequest="false" Language="C#" AutoEventWireup="true" CodeBehind="Mail_Manage.aspx.cs" Inherits="WC.WebUI.Manage.Common.Mail_Manage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>邮件编辑/发送</title>
<script type="text/javascript" src="/js/validator.js"></script>
<link type="text/css" href="/manage/Style/InterFace.Css" rel="stylesheet" rev="stylesheet" media="all" />
<link type="text/css" href="/manage/style.css" rel="stylesheet" rev="stylesheet" media="all" />
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/manage/include/common.js"></script>

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
        document.getElementById("aAddAttach").innerHTML="继续添加附件";
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
            document.getElementById("aAddAttach").innerHTML="添加附件";
            Attach.style.display="none";
        }
        else
        {
            document.getElementById("aAddAttach").innerHTML="继续添加附件";
        }
    }
</script> 

    <script type="text/javascript">
	    function ShowIframe()
		{
		    var users = document.getElementById("userlist");
            var pop=new Popup({ contentType:1,scrollType:'no',isReloadOnClose:false,width:468,height:395});
            pop.setContent("contentUrl","/Manage/Utils/SelectPeople.aspx");
            pop.setContent("title","邮件发送 - 收件人员选择");
            pop.build();
            pop.show();
        }
        
	    function ShowIframe_cc()
		{
		    var users = document.getElementById("userlist_cc");
            var pop=new Popup({ contentType:1,scrollType:'no',isReloadOnClose:false,width:468,height:400});
            pop.setContent("contentUrl","/Manage/Utils/SelectPeople_cc.aspx");
            pop.setContent("title","邮件发送 - 抄送人员选择");
            pop.build();
            pop.show();
        }
        
	    function ShowIframe_bcc()
		{
		    var users = document.getElementById("userlist_bcc");
            var pop=new Popup({ contentType:1,scrollType:'no',isReloadOnClose:false,width:468,height:400});
            pop.setContent("contentUrl","/Manage/Utils/SelectPeople_bcc.aspx");
            pop.setContent("title","邮件发送 - 密送人员选择");
            pop.build();
            pop.show();
        }                   
                 
    </script>   
</head>
<body >
    <form id="form1" runat="server" onsubmit="return Validator.Validate(this.form,1);" enctype="multipart/form-data">
<div id="interface_inside">
  <div id="interface_quick">
    <div class="interface_quick_left">您现在的操作 >> 撰写邮件</div>
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
	  <a href="Mail_List.aspx?fid=0"> 收件箱( <span id=sjx runat=server style="color:#ff0000; font-weight:bold;">0/0</span> ) </a>
	  <a href="Mail_List.aspx?fid=1"> 草稿箱( <span id=cgx runat=server style="font-weight:bold;">0</span> ) </a>
	  <a href="Mail_List.aspx?fid=2"> 发件箱( <span id=fjx runat=server style="font-weight:bold;">0</span> ) </a>
	  <a href="Mail_List.aspx?fid=3"> 垃圾箱( <span id=ljx runat=server style="font-weight:bold;">0</span> ) </a>
	  <a href="Mail_Manage.aspx">发送新邮件</a>
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
	<td> 撰写新邮件&nbsp;<a href="#" title='查看所有帮助' class="helpall">[?]</a></td>
	<td>&nbsp;
	<asp:Button runat=server class="button" ID=Button2 Text='发送' OnClick=Save_Btn OnClientClick="return Validator.Validate(this.form,1);" />
	&nbsp;&nbsp;<asp:Button runat=server class="button" ID=Button3 Text='存草稿' OnClick=Caogao_Btn OnClientClick="return Validator.Validate(this.form,1);" />
	&nbsp;&nbsp;保存到发件箱<input runat=server id="IsSave" type="checkbox" checked=checked name="IsSave" />
	&nbsp;&nbsp;已读回执<input runat=server id="ReadBack" type="checkbox" name="ReadBack" />
    &nbsp;&nbsp;<input type=button class=buttoms value='添加抄送' onclick=javascript:if(document.getElementById('cc').style.display='none'){document.getElementById('cc').style.display=""} />
    &nbsp;&nbsp;<input type=button class=buttoms value='添加密送' onclick=javascript:if(document.getElementById('bcc').style.display='none'){document.getElementById('bcc').style.display=""} />
	</td>
</tr>
</thead>

<tr >
	<th style="width:140px; font-weight:bold;">* 主题&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请输入 邮件主题</span>
			<input runat=server size=97 dataType="Require" maxlength=200
			msg="邮件主题不能为空" name="Subject" type="text" id="Subject" />
			
	</td>
</tr>

<tr >
	<th style="width:140px; font-weight:bold;">* 收件人&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请选择 收件人：点击右侧 [收件人] 按钮</span>
	<input runat=server type=hidden id=userlist name=userlist value="" />
	<textarea runat=server id=namelist name=namelist readonly=readonly 
	rows=3 cols=70 dataType="Require" msg="收件人不能为空"></textarea>
	<input type=button value=收件人 class="textbutton" onclick=ShowIframe() />
	</td>
</tr>

<tr id=cc style=display:none>
	<th style="width:140px; font-weight:bold;">抄送&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请选择 抄送人员 点击右侧 [抄送人] 按钮</span>
	<input runat=server type=hidden id=userlist_cc name=userlist_cc value="" />
	<input runat=server size=81 name="namelist_cc" type="text" id="namelist_cc" readonly=readonly  />
	<input type=button value=抄送人 class="textbutton" onclick=ShowIframe_cc() />
	</td>
</tr>

<tr id=bcc style=display:none>
	<th style="width:140px; font-weight:bold;">密送&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请选择 密送人员 点击右侧 [密送人] 按钮. &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;密送人员姓名将不显示在 信件中</span>
	<input runat=server type=hidden id=userlist_bcc name=userlist_bcc value="" />
	<input runat=server size=81 name="namelist_bcc" type="text" id="namelist_bcc" readonly=readonly  />
	<input type=button value=密送人 class="textbutton" onclick=ShowIframe_bcc() />
	</td>
</tr>

<tr>
	<th style="width:140px; font-weight:bold;">正文&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请输入 邮件正文内容. &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Shift+Enter 换行, Enter 段落</span>
	<textarea id="Bodys" style="width:80%;height:450px;visibility:hidden;" runat="server" enableviewstate=false></textarea>
	</td>
</tr>

<tr >
	<th style="width:140px; font-weight:bold;">手机提醒&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">该条资讯是否 发送手机短信通知资讯接收人</span>
    <asp:CheckBox runat=server ID=IsSms Checked=false /> (是否发送手机短信通知资讯接收人)
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
	<asp:Button runat=server class="button" ID=save_bt Text='发送' OnClick=Save_Btn OnClientClick="return Validator.Validate(this.form,1);" />
	&nbsp;&nbsp;<asp:Button runat=server class="button" ID=Button1 Text='存草稿' OnClick=Caogao_Btn OnClientClick="return Validator.Validate(this.form,1);" />
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
