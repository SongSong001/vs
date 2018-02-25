﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Module_List.aspx.cs" Inherits="WC.WebUI.Manage.Sys.Module_List" %>
<%@ Register Src="~/Controls/Page.ascx" TagName="Page" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>模块权限列表</title>
<link type="text/css" href="/DK_Css/page_css.css" rel="stylesheet" />
<link type="text/css" href="/manage/Style/InterFace.Css" rel="stylesheet" rev="stylesheet" media="all" />
<link type="text/css" href="/manage/style.css" rel="stylesheet" rev="stylesheet" media="all" />
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/manage/include/common.js"></script>
</head>
<body>
    <form id="form1" runat="server">
<div id="interface_inside">
  <div id="interface_quick">
    <div class="interface_quick_left">您现在的操作 >> 权限列表</div>
    <div class="interface_quick_right">
  
    </div>
    <div class="clearboth"></div>
  </div>
  <div id="interface_main">
    <div id="tabs_config" class="tabsbox">
      


      <div class="clearboth"></div>
      
      
      <!-- 模块 -->
      <div id="config_basic" class="tabs_wrapper"><div class="tabs_main" align='center'>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" >
          <tr>
            <td><div id="Div1" class="tabsbox">

              <div id="config_basic1" class="tabs_wrapper"><div class="tabs_main" align="left">  

<table class="table subsubmenu">
  <thead>
	<tr>
	  <td><a href="#">&gt;&gt;&nbsp;模块权限系统</a>
	  <a href="Module_List.aspx">模块权限列表</a>
	  <a href="Module_Manage.aspx">新增模块权限</a>
	  </td>
	  <td style="text-align:right; margin-right:50px;"><asp:Panel ID="panLogin" runat="server" DefaultButton="search_bt">
	  <input type="text" name="keyword"  maxlength=10  id="keyword" />
	  <asp:Button runat=server ID=search_bt CssClass="textbutton" OnClick=Search_Btn Text=搜索 /></asp:Panel>
	  </td>
	</tr>
  </thead>
</table>
<br />

<div id="PanelDefault">
	
<table class="table">
<thead>
	<tr>
		<th width="40">
		<asp:LinkButton runat=server  OnClientClick="javascript:return confirm('您确定要批量删除数据吗？')" OnClick=Del_All>删除</asp:LinkButton>
		<input type="checkbox" name=ckb class="checkall">
		</th>
		<td width="40"><span style="margin-left:15px;">序</span></td>
			<td width="100">权限分类</td>
			<td width="170">权限名称</td>
			<td width="270">权限地址</td>
			<td width="70">是否显示</td>
		<td width="115">管理</td>
	</tr>
</thead>
 
 <asp:Repeater runat=server ID=rpt><ItemTemplate>
	<tr>
		<th width="50"><input runat=server id=chk type="checkbox" value=<%#Eval("id") %> class="checkdelete"></th>
		<td><span style="margin-left:10px;"><%# Container.ItemIndex+1 %></span></td>
		<td>
			<%#Eval("TypeName")%>
		</td>	
		<td style="font-weight:bold;">
			<%#Eval("ModuleName")%>
		</td>
		<td>
			<%# WC.Tool.Utils.GetSubString2(Eval("ModuleUrl")+"",50,"...") %>
		</td>
		<td>
			<%# WC.Tool.Utils.GetStringByInt(Convert.ToInt32(Eval("IsShow")))%>
		</td>
		<td class="manage">
			<a href=Module_Manage.aspx?mid=<%#Eval("id") %> class="show">编辑</a>
			<asp:LinkButton runat=server ID=lb_del OnClick=Del_Btn class="delete" title="你确定要删除这一项吗？">删除</asp:LinkButton>
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
      </div></div>
      <!-- 模块 -->

    </div>
  </div>
</div>
    </form>
</body>
</html>
