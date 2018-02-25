<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Task_AllList.aspx.cs" Inherits="WC.WebUI.Manage.Tasks.Task_AllList" %>
<%@ Register Src="~/Controls/Page.ascx" TagName="Page" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>所有任务列表</title>
<link type="text/css" href="/manage/Style/InterFace.Css" rel="stylesheet" rev="stylesheet" media="all" />
<link type="text/css" href="/manage/style.css" rel="stylesheet" rev="stylesheet" media="all" />
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/manage/include/common.js"></script>
<link type="text/css" href="/DK_Css/page_css.css" rel="stylesheet" />

<script type="text/javascript" src="/js/formV/datepicker/WdatePicker.js"></script>
</head>
<body >
    <form id="form1" runat="server">
<div id="interface_inside">
  <div id="interface_quick">
    <div class="interface_quick_left">您现在的操作 >> 工作任务 >> 所有任务列表</div>
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

        <table width="98%" border="0" cellspacing="0" cellpadding="0" >
          <tr>
            <td>
            
  <div id="config_basic1" class="tabs_wrapper">
<div class="tabs_main" align="left">  
<div id="PanelConfig">

<table class="table subsubmenu">
  <thead>
	<tr>
	  <td>
	  <a href="Task_AllList.aspx">所有任务列表</a>
	  </td>
	  <td style="text-align:right">
<input type=button name="s_bt" value="高级搜索" id="s_bt" onclick="javascript:$('#s_div').slideToggle('fast');" class="textbutton" />
	  </td>
	</tr>
  </thead>
</table>
<br />           

<div id="PanelDefault">
<div id=s_div style="display:none">
<asp:Panel ID="panLogin" runat="server" DefaultButton="search_bt">
<table class="table">
<thead>
<tr>
	<td><a href="#" class="helpall">[?]</a></td>
	<td>
		<asp:Button runat=server class="button" ID=search_bt Text='搜 索' OnClick=Search_Btn  />
	</td>
</tr>
</thead>
<tr>
	<th style="width:140px; font-weight:bold;">&nbsp; 任务分类：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请选择 任务的分类.</span>
	<asp:DropDownList runat=server ID=TypeID EnableViewState=false></asp:DropDownList>
	</td>
</tr>
<tr>
	<th style="width:140px; font-weight:bold;">&nbsp; 任务名称：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请输入 你要搜索的任务名称.</span>
	<input runat=server name="TaskName"  maxlength=15 type="text" value="" id="TaskName" size=56 /></td>
</tr>
<tr>
	<th style="width:140px; font-weight:bold;">&nbsp; 日期范围：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请选择 工作任务创建日期的范围. </span>
	<INPUT runat=server id=StartTime name=StartTime type=text class="Wdate" readonly onclick="WdatePicker()"> 到
<INPUT runat=server id=EndTime name=EndTime type=text class="Wdate" readonly onclick="WdatePicker()">  
	</td>
</tr>
<tr>
	<th style="width:140px; font-weight:bold;">&nbsp; 任务状态：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请选择 你要搜索的任务状态.</span>
	<select name=state id=state>
	<option value=''>请选择任务状态</option>
	<option value='1'>任务进行中</option>
	<option value='-1'>任务已停止</option>
	<option value='2'>任务已完成</option>
	</select>
	</td>
</tr>
</table>
</asp:Panel>
<br />
</div>
	
<table class="table">
<thead>
	<tr>
		<th width="10">
		<input type="checkbox" name=ckb class="checkall">
		</th>
		<td width="10"><span style="margin-left:5px;">序</span></td>
			<td width="38%">任务名称</td>
			<td width="70">任务级别</td>
			<td width="65">创建者</td>
			<td width="90">更新时间</td>
            <td width="65">任务状态</td>
			<td width="135">操作</td>
	</tr>
</thead>
 
 <asp:Repeater runat=server ID=rpt ><ItemTemplate>
	<tr>
		<th width="10"><input runat=server id=chk type="checkbox" value=<%#Eval("id") %> class="checkdelete"></th>
		<td><span style="margin-left:5px;"><%# Container.ItemIndex+1 %></span></td>
		<td>
		[<%# Eval("TypeName")%>] &nbsp; <a style="font-weight:bold;" href=Task_View.aspx?tid=<%#Eval("id") %> ><%#Eval("TaskName")%></a>
		</td>	
		<td>
		<%#Eval("Important")%>
		</td>
		<td>
		<%#Eval("CreatorRealName")%>
		</td>
		<td>
		<%#Eval("UpdateTime")%>
		</td>
		<td>
		<%# GetStatus(Eval("Status"))%>
		</td>
	    <td class="manage">
        <a href=Task_View.aspx?tid=<%#Eval("id") %> >查看</a>
        <asp:LinkButton runat=server ID=b1 OnClick=Del_Btn OnClientClick="javascript:return confirm('确实要删除该任务吗？')">删除</asp:LinkButton>
		</td>	
	</tr>
 </ItemTemplate></asp:Repeater>
 
</table>
<table class="table">
<tr>
	<td class="page">
	<span style="float:left;" id=num runat=server></span>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<uc1:Page ID="Page1" runat="server" />&nbsp;&nbsp;&nbsp;&nbsp;</td>
</tr>
</table>
<br />
 
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
