<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CRM_Manage.aspx.cs" Inherits="WC.WebUI.Manage.CRM.CRM_Manage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>客户编辑</title>
<script type="text/javascript" src="/js/validator.js"></script>
<link type="text/css" href="/manage/Style/InterFace.Css" rel="stylesheet" rev="stylesheet" media="all" />
<link type="text/css" href="/manage/style.css" rel="stylesheet" rev="stylesheet" media="all" />
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/manage/include/common.js"></script> 
    
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

	    function ShowIframe()
		{
		    var users = document.getElementById("userlist");
            var pop=new Popup({ contentType:1,scrollType:'no',isReloadOnClose:false,width:468,height:395});
            pop.setContent("contentUrl","/Manage/Utils/SelectPeople.aspx");
            pop.setContent("title","文档共享 - 共享人员选择");
            pop.build();
            pop.show();
        } 
</script>     
    
    
</head>
<body >
    <form id="form1" runat="server" onsubmit="return Validator.Validate(this.form,1);" enctype="multipart/form-data">
<div id="interface_inside">
  <div id="interface_quick">
    <div class="interface_quick_left">您现在的操作 >> 我的客户 >> 编辑客户</div>
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
	<th style="width:145px; font-weight:bold;">&nbsp;* 客户名称：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请输入 客户名称.</span>
	<input runat=server name="CRM_Name" dataType="Require" msg="客户名称不能为空" type="text" value="" id="CRM_Name" size=97 /></td>
</tr>

<tr>
	<th style="width:145px; font-weight:bold;">&nbsp;* 联系方式：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请输入 联系方式.</span>&nbsp;&nbsp;
	* 电话：<input runat=server name="Tel" dataType="Require" msg="电话不能为空" type="text" value="" id="Tel" size=19 /> 
	传真：<input runat=server name="Fax" type="text" value="" id="Fax" size=17 /> 
	邮编：<input runat=server name="Zip" type="text" value="" id="Zip" size=17 /> 
	</td>
</tr>

<tr>
	<th style="width:145px; font-weight:bold;">&nbsp; 互联网资料：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请输入 联系方式.</span>&nbsp;&nbsp;
	&nbsp;&nbsp;网址：<input runat=server name="Site" type="text" value="" id="Site" size=19 /> 
	QQ：<input runat=server name="QQ" type="text" value="" id="QQ" size=17 /> 
	EMail：<input runat=server name="Email" type="text" value="" id="Email" size=17 /> 
	</td>
</tr>

<tr>
	<th style="width:145px; font-weight:bold;">&nbsp;* 客户地址：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请输入 客户地址.</span>
	<input runat=server name="Address" dataType="Require" msg="客户地址不能为空" type="text" value="" id="Address" size=45 /></td>
</tr>

<tr>
	<th style="width:145px; font-weight:bold;">&nbsp;* 主要负责人：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请输入 主要负责人.</span>
	<input runat=server name="MainPeople" dataType="Require" msg="主要负责人不能为空" type="text" value="" id="MainPeople" size=45 /></td>
</tr>

<tr>
	<th style="width:145px; font-weight:bold;">&nbsp;负责人职位：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请输入 负责人职位.</span>
	<input runat=server name="Position" type="text" value="" id="Position" size=45 /></td>
</tr>

<tr>
	<th style="width:145px; font-weight:bold;">&nbsp;产品：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请输入 相关产品名称.</span>
	<input runat=server name="Product" type="text" value="" id="Product" size=45 /></td>
</tr>

<tr>
	<th style="width:145px; font-weight:bold;">&nbsp;客户性质：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请选择 客户性质.</span>
	<asp:DropDownList runat=server ID=TypeName>
	<asp:ListItem Text="请选择" Value=""></asp:ListItem>
	<asp:ListItem Text="政府机关" Value="政府机关"></asp:ListItem>
	<asp:ListItem Text="国企" Value="国企"></asp:ListItem>
	<asp:ListItem Text="民营" Value="民营"></asp:ListItem>
	<asp:ListItem Text="外资" Value="外资"></asp:ListItem>
	<asp:ListItem Text="上市" Value="上市"></asp:ListItem>
	<asp:ListItem Text="个体经营者" Value="个体经营者"></asp:ListItem>
	<asp:ListItem Text="其他" Value="其他"></asp:ListItem>
	</asp:DropDownList>
	</td>
</tr>

<tr>
	<th style="width:145px; font-weight:bold;">&nbsp;* 客户级别：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请输入 相关产品名称.</span>
        <asp:RadioButtonList ID="Grade" runat=server RepeatDirection=Horizontal >
        <asp:ListItem Selected=True Text="A(暂无需求，潜在培养的客户)" Value="A"></asp:ListItem>
        <asp:ListItem Text="B(有需求，正在跟进客户)" Value="B"></asp:ListItem>
        <asp:ListItem Text="C(短期可签入的客户)" Value="C"></asp:ListItem>
        <asp:ListItem Text="D(已签约客户/老客户)" Value="D"></asp:ListItem>
        </asp:RadioButtonList>
	</td>
</tr>

<tr>
	<th style="width:145px; font-weight:bold;">&nbsp;是否协同共享：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请选择 是否要 共享该客户 (共享后将可以 查看客户资料)</span>
	<select runat=server id=IsShare style="width:610px;" onchange='javascript:if(this.value=="1"){document.getElementById("tr").style.display=""}else{document.getElementById("tr").style.display="none";document.getElementById("userlist").value="";document.getElementById("namelist").value="";} '>
	<option value=0 selected>这是我个人客户 不需要协同共享</option>
	<option value=1>我要将该客户 协同共享给其他同事</option> 
	</select>   
	</td>
</tr>
<tr id=tr runat=server style="display:none;">
	<th style="width:145px; font-weight:bold;">&nbsp;协同共享人员：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请选择 协同共享人员：点击右侧 [协同共享人员] 按钮.</span>
	<input runat=server type=hidden id=userlist name=userlist value="" />
	<textarea runat=server id=namelist name=namelist readonly=readonly 
	rows=3 cols=55 ></textarea>
	<input type=button value=协同共享人员 class="textbutton" onclick=ShowIframe() />
	</td>
</tr>
<tr>
	<th style="width:145px; font-weight:bold;">备注&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请输入 该客户的备注信息. </span>
	<textarea runat=server style="BACKGROUND-IMAGE: url(/img/line.gif); LINE-HEIGHT: 22px; padding-left:3px; background-repeat:repeat;" name=Notes id=Notes rows=4 cols=83></textarea>
	</td>
</tr>
<tr >
	<th style="width:145px; font-weight:bold;">附件&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">可批量添加附件,附件总大小上限 50M. </span>
		&nbsp;&nbsp;<span style="font-weight:bold;"><a href="javascript:fAddAttach();" id="aAddAttach">添加附件</a></span>
		<br />
		<div runat=server id="dvReadAttach" style="float:left;"></div>
	</td>
</tr>

<asp:Panel ID="Attachword" runat="server" Visible="false">
<tr >
	<th style="width:145px; font-weight:bold;">已添加附件&nbsp;<a href="#" class="help">[?]</a></th>
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


