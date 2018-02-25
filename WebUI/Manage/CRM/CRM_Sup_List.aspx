<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CRM_Sup_List.aspx.cs" Inherits="WC.WebUI.Manage.CRM.CRM_Sup_List" %>
<%@ Register Src="~/Controls/Page.ascx" TagName="Page" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>供应商关系管理-我的供应商列表</title>
<link type="text/css" href="/manage/Style/InterFace.Css" rel="stylesheet" rev="stylesheet" media="all" />
<link type="text/css" href="/manage/style.css" rel="stylesheet" rev="stylesheet" media="all" />
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/manage/include/common.js"></script>  
</head>
<body >
    <form id="form1" runat="server">
<div id="interface_inside">
  <div id="interface_quick">
    <div class="interface_quick_left">您现在的操作 >> 我的客户 >> 供应商管理列表</div>
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
    
<div id="PanelDefault">
<table class="table subsubmenu">
  <thead>
	<tr>
	  <td>
	  <a href="CRM_Sup_List.aspx">供应商列表</a>
	  <a href="CRM_Sup_Manage.aspx">新建供应商</a>
	  </td>
	  <td style="text-align:right">	  
        <asp:Panel ID="panLogin" runat="server" DefaultButton="search_bt">
	  <input type="text" name="keyword"  maxlength=10  id="keyword" />
	  <asp:Button runat=server ID=search_bt CssClass="textbutton" OnClick=Search_Btn Text=搜索 /></asp:Panel> 	  
	  </td>
	</tr>
  </thead>
</table>
<br /> 	
<table class="table">
<thead>
	<tr>
		<th width="50">
<%--		<asp:LinkButton ID="LinkButton1" runat=server  OnClientClick="javascript:return confirm('您确定要批量删除数据吗？')" OnClick=Del_All>删除</asp:LinkButton>--%>
		<input type="checkbox" name=ckb class="checkall">
		</th>
		<td width="45"><span style="margin-left:15px;">序</span></td>
			<td>供应商名称</td>
			<td width="100">联系人</td>
			<td width="100">电话</td>
			<td width="160">地址</td>
			<td width="190">管理</td>
	</tr>
</thead>
 
 <asp:Repeater runat=server ID=rpt><ItemTemplate>
	<tr>
		<th width="50"><input runat=server id=chk type="checkbox" value=<%#Eval("id") %> class="checkdelete"></th>
		<td><span style="margin-left:10px;"><%# Container.ItemIndex + 1%></span></td>
		<td class="vtip" title='<%# Eval("Sup_Name") %>'>
			<strong><%# WC.Tool.Utils.GetSubString2(Eval("Sup_Name") + "", 26, "..")%></strong>
		</td>	
		<td style="color:Blue;">
		<%#Eval("MainPeople")%>
		</td>
		<td>
		<%#Eval("Tel")%>
		</td>		
		<td class="vtip" title='<%# Eval("Addr") %>'>
		<%# WC.Tool.Utils.GetSubString2(Eval("Addr") + "", 16, "..")%>
		</td>
		<td class="manage">
		    <a href=# class="vtip" title='<%# Eval("notes") %>'>备注</a>
			<a href=CRM_Sup_Manage.aspx?cid=<%#Eval("id") %> class="show">编辑</a>
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

