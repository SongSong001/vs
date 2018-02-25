<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WorkSet.aspx.cs" Inherits="WC.WebUI.Manage.Attend.WorkSet" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>设置上下班时间</title>
<link type="text/css" href="/manage/Style/InterFace.Css" rel="stylesheet" rev="stylesheet" media="all" />
<link type="text/css" href="/manage/style.css" rel="stylesheet" rev="stylesheet" media="all" />
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/manage/include/common.js"></script>
<script type="text/javascript" src="/js/validator.js"></script> 
</head>
<body>
    <form id="form1" runat="server" onsubmit="return Validator.Validate(this.form,1);">
    <div id="interface_inside">
  <div id="interface_quick">
    <div class="interface_quick_left">您现在的操作 >> 系统管理 >> 考勤管理-设置上下班时间</div>
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
    
<div id="PanelConfig">
<table class="table subsubmenu">
  <thead>
	<tr>
	  <td>
	  <a href="WorkSet.aspx?type=edit">添加上下班时间</a>
	  </td>
	  <td style="text-align:right">

	  </td>
	</tr>
  </thead>
</table>
<br />

<asp:Panel runat=server ID=p_list Visible=false>   

<table class="table">
<thead>
	<tr>
		<th width="50">
		<input type="checkbox" name=ckb class="checkall">
		</th>
		<td width="50"><span style="margin-left:25px;">序</span></td>
			<td width="260">登记类型</td>
			<td width="220">规定时间</td>
			<td width="155">管理</td>
	</tr>
</thead>
 
 <asp:Repeater runat=server ID=rpt><ItemTemplate>
	<tr>
		<th width="50"><input runat=server id=chk type="checkbox" value=<%#Eval("id") %> class="checkdelete"></th>
		<td><span style="margin-left:25px;"><%# Container.ItemIndex+1 %></span></td>
		<td>
			<span style="color:#666; font-weight:bold;"><%# Eval("AttendNames")%></span>
		</td>	
		<td>
		<%#Eval("AttendTimes")%>
		</td>
        <td class="manage">
 			<a href=WorkSet.aspx?type=edit&manage=<%#Eval("id") %> class="show">编辑</a>
            <a href=WorkSet.aspx?type=del&manage=<%#Eval("id") %> class="delete" title="确定删除吗?">删除</a>             
        </td>
	</tr>
 </ItemTemplate></asp:Repeater>
 
</table>
    
<table class="table">
<tr>
	<td class="page">
	<span style="float:left;" id=num runat=server></span> &nbsp; &nbsp; &nbsp; 
	</td>
</tr>
</table>

</asp:Panel>

<asp:Panel runat=server ID=p_edit Visible=false>

<table class="table">
<thead>
<tr>
	<td colspan="2"><a href="#" class="helpall">[?]</a></td>
</tr>
</thead>

<tr>
	<th style="width:140px; font-weight:bold;">&nbsp;* 登记类型：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请输入 登记类型 (如：上班).</span>
	<asp:DropDownList runat=server ID=AttendNames1>
    <asp:ListItem Text='上班登记' Value='上班登记'></asp:ListItem>
    <asp:ListItem Text='下班登记' Value='下班登记'></asp:ListItem>
    <asp:ListItem Text='值班登记' Value='值班登记'></asp:ListItem>
    <asp:ListItem Text='加班登记' Value='加班登记'></asp:ListItem>
    </asp:DropDownList>
    
    </td>
</tr>

<tr>
	<th style="width:140px; font-weight:bold;">&nbsp;* 规定时间：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请选择 规定时间.</span>
	<asp:DropDownList runat=server ID=ddl_hour>
    <asp:ListItem Text='0' Value='0'></asp:ListItem>
    <asp:ListItem Text='1' Value='1'></asp:ListItem>
    <asp:ListItem Text='2' Value='2'></asp:ListItem>
    <asp:ListItem Text='3' Value='3'></asp:ListItem>
    <asp:ListItem Text='4' Value='4'></asp:ListItem>
    <asp:ListItem Text='5' Value='5'></asp:ListItem>
    <asp:ListItem Text='6' Value='6'></asp:ListItem>
    <asp:ListItem Text='7' Value='7'></asp:ListItem>
    <asp:ListItem Text='8' Value='8'></asp:ListItem>
    <asp:ListItem Text='9' Value='9'></asp:ListItem>

    <asp:ListItem Text='10' Value='10'></asp:ListItem>
    <asp:ListItem Text='11' Value='11'></asp:ListItem>
    <asp:ListItem Text='12' Value='12'></asp:ListItem>
    <asp:ListItem Text='13' Value='13'></asp:ListItem>
    <asp:ListItem Text='14' Value='14'></asp:ListItem>
    <asp:ListItem Text='15' Value='15'></asp:ListItem>
    <asp:ListItem Text='16' Value='16'></asp:ListItem>
    <asp:ListItem Text='17' Value='17'></asp:ListItem>
    <asp:ListItem Text='18' Value='18'></asp:ListItem>
    <asp:ListItem Text='19' Value='19'></asp:ListItem>

    <asp:ListItem Text='20' Value='20'></asp:ListItem>
    <asp:ListItem Text='21' Value='21'></asp:ListItem>
    <asp:ListItem Text='22' Value='22'></asp:ListItem>
    <asp:ListItem Text='23' Value='23'></asp:ListItem>
    </asp:DropDownList> 

    <asp:DropDownList runat=server ID=ddl_minute>
    <asp:ListItem Text='00' Value='00'></asp:ListItem>
    <asp:ListItem Text='05' Value='05'></asp:ListItem>
    <asp:ListItem Text='10' Value='10'></asp:ListItem>
    <asp:ListItem Text='15' Value='15'></asp:ListItem>
    <asp:ListItem Text='20' Value='20'></asp:ListItem>
    <asp:ListItem Text='25' Value='25'></asp:ListItem>
    <asp:ListItem Text='30' Value='30'></asp:ListItem>
    <asp:ListItem Text='35' Value='35'></asp:ListItem>
    <asp:ListItem Text='40' Value='40'></asp:ListItem>
    <asp:ListItem Text='45' Value='45'></asp:ListItem>
    <asp:ListItem Text='50' Value='50'></asp:ListItem>
    <asp:ListItem Text='55' Value='55'></asp:ListItem>
    </asp:DropDownList>
    </td>
</tr>

</table>

<br />
<div style="text-align:center;">
	<asp:Button runat=server class="button" ID=save_bt Text='保存' OnClick=Save_Btn OnClientClick="return Validator.Validate(this.form,1);" />
	&nbsp;&nbsp;<input type="reset" class="button" value='重置' />
</div>

</asp:Panel>
      
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
