<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Flow_ListAll.aspx.cs" Inherits="WC.WebUI.Manage.Flow.Flow_ListAll" %>
<%@ Register Src="~/Controls/Page.ascx" TagName="Page" TagPrefix="uc1" %>
<%@ Register TagPrefix="ajax" Namespace="MagicAjax.UI.Controls" Assembly="MagicAjax" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>所有流程列表</title>
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
    <div class="interface_quick_left">您现在的操作 >> 系统管理 >> 流程管理</div>
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
<a href="/Manage/flow/Flow_ListAll.aspx" >所有流程监控</a>
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
<ajax:ajaxpanel ID="Ajaxpanel1" runat="server">
<tr>
	<th style="width:140px; font-weight:bold;">&nbsp; 流程分类&nbsp;</th>
	<td>
	<asp:DropDownList runat=server ID=Model_Type AutoPostBack=true OnSelectedIndexChanged=ModelType_btn style='width:400px'></asp:DropDownList>
	</td>
</tr>
<tr>
	<th style="width:140px; font-weight:bold;">&nbsp; 流程模型：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请选择 发起流程的模型.</span>
	<asp:DropDownList runat=server ID=Model EnableViewState=false style='width:400px'></asp:DropDownList>
	</td>
</tr></ajax:ajaxpanel>
<tr>
	<th style="width:140px; font-weight:bold;">&nbsp; 关键字：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请输入 你要搜索的关键字(如部分 流程名、发起人等).</span>
	<input runat=server name="keyword"  maxlength=10  dataType="Require" msg="关键字不能为空" type="text" value="" id="keyword" size=56 /></td>
</tr>
<tr>
	<th style="width:140px; font-weight:bold;">&nbsp; 发起时间：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请选择 发起时间区域. 一处留空不填代表 今天的日期.</span>
	<INPUT runat=server id=StartTime name=StartTime type=text class="Wdate"   readonly onClick="WdatePicker()"> 到
<INPUT runat=server id=EndTime name=EndTime type=text class="Wdate"   readonly onClick="WdatePicker()">  
	</td>
</tr>
<tr>
	<th style="width:140px; font-weight:bold;">&nbsp; 流程状态：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请选择 你要搜索的流程状态.</span>
	<select name=state id=state>
	<option value=''>请选择公文状态</option>
	<option value='1'>流程已完成</option>
	<option value='0'>流程审批中</option>
	<option value='-1'>流程已锁定</option>
	<option value='-2'>流程已退回</option>
	<option value='2'>已过期</option>
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
		<th width="40">
		<input type="checkbox" name=ckb class="checkall">
		</th>
		<td width="50"><span style="margin-left:15px;">序</span></td>
			<td >流程名称</td>
			<td width="65">创建者</td>
			<td width="70">创建时间</td>
			<td width="120">当前环节</td>
			<td width="70">流程状态</td>
			<td width="165">管理</td>
	</tr>
</thead>
 
 <asp:Repeater runat=server ID=rpt ><ItemTemplate>
	<tr>
		<th width="50"><input runat=server id=chk type="checkbox" value=<%#Eval("id") %> class="checkdelete"></th>
		<td><span style="margin-left:10px;"><%# Container.ItemIndex+1 %></span></td>
		<td style="font-weight:bold;">
		<a href=Flow_View.aspx?fl=<%#Eval("id") %> ><%#Eval("Flow_Name")%></a>
		</td>	
		<td>
		<%#Eval("CreatorRealName")%>
		</td>
		<td>
		<%# WC.Tool.Utils.ConvertDate(Eval("AddTime"))%>
		</td>
		<td>
		<%#Eval("CurrentStepName")%>
		</td>
		<td >
            <%# GetStatus(Eval("status"))%>
		</td>
	    <td class="manage">
	    <asp:Label runat=server ID=lb1 Text=<%#Eval("CurrentStepUserList") %> Visible=false></asp:Label>
	    <asp:LinkButton runat=server ID=b1 OnClick=Del OnClientClick="javascript:return confirm('确实要删除该流程吗？')">删除</asp:LinkButton>
	    <asp:LinkButton runat=server ID=b2 OnClick=Lock CommandArgument=<%#Eval("status") %> OnClientClick="javascript:return confirm('审批中的流程才能被锁定! 确定?')"><%# Eval("status") + "" == "-1" ? "解锁" : "锁定" %></asp:LinkButton>
            <a href=Flow_Graph.aspx?fl=<%#Eval("id") %> target=_blank>图例</a>
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