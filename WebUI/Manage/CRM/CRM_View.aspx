<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CRM_View.aspx.cs" Inherits="WC.WebUI.Manage.CRM.CRM_View" EnableViewState="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>查看客户</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link type="text/css" href="/manage/Style/InterFace.Css" rel="stylesheet" rev="stylesheet" media="all" />
<link type="text/css" href="/manage/style.css" rel="stylesheet" rev="stylesheet" media="all" />
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/manage/include/common.js"></script>
</head>
<body id="C_News">
<form id="form1" runat="server">
<div id="interface_inside">
  <div id="interface_quick">
    <div class="interface_quick_left">您现在的操作 >> 我的客户 >> 客户资料查看</div>
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
<a href="/Manage/crm/CRM_List.aspx?action=mycrm">我的客户列表</a>
<a href='/Manage/crm/CRM_View.aspx?cid=<%=c %>' >客户资料</a>
<a href="/Manage/crm/CRM_Contact_List.aspx?cid=<%=c %>">接触列表</a>
<a href="/Manage/crm/CRM_Contact_Manage.aspx?cid=<%=c %>">添加接触</a>
	  </td>
	  <td style="text-align:right">

	  </td>
	</tr>
  </thead>
</table>
<br />             

<div id="PanelShow">
	
<table class="table">
	<thead>
	<tr>
		<td colspan=2>
		</td>
	</tr>
	</thead>
	
	<tr>
		<th style="width:135px; font-weight:bold">客户名称：</th>
		<td>
			<span id=CRM_Name1 runat=server style="font-weight:bold; color:Red"></span>
		</td>
	</tr>	
	
	<tr>
		<th style="width:135px; font-weight:bold">客户级别：</th>
		<td>
			<asp:Label runat=server ID=Grade></asp:Label>
		</td>
	</tr>	
	
	<tr runat=server id=div>
		<th style="width:135px; font-weight:bold">接触情况：</th>
		<td>
				<asp:Label runat=server ID=Contact></asp:Label>
		</td>
	</tr>	
	
	<tr>
		<th style="width:135px; font-weight:bold">联系方式：</th>
		<td>
				<asp:Label runat=server ID=lx></asp:Label>
		</td>
	</tr>
	
	<tr>
		<th style="width:135px; font-weight:bold">客户地址：</th>
		<td>
				<asp:Label runat=server ID=Address></asp:Label>
		</td>
	</tr>	

	<tr>
		<th style="width:135px; font-weight:bold">互联网资料：</th>
		<td>
				<asp:Label runat=server ID=hlw></asp:Label>
		</td>
	</tr>		
	
	<tr>
		<th style="width:135px; font-weight:bold">主要负责人：</th>
		<td>
				<asp:Label runat=server ID=MainPeople></asp:Label>
		</td>
	</tr>		
	
	<tr>
		<th style="width:135px; font-weight:bold">负责人职位：</th>
		<td>
				<asp:Label runat=server ID=Position></asp:Label>
		</td>
	</tr>	
	
	<tr>
		<th style="width:135px; font-weight:bold">产品：</th>
		<td>
				<asp:Label runat=server ID=Product></asp:Label>
		</td>
	</tr>	
	
	<tr>
		<th style="width:135px; font-weight:bold">客户性质：</th>
		<td>
				<asp:Label runat=server ID=TypeName></asp:Label>
		</td>
	</tr>
	
	<tr>
		<th style="width:135px; font-weight:bold">附件：</th>
		<td>
		<%=fjs %>
		</td>
	</tr>	
	
	<tr>
		<th style="width:135px; font-weight:bold">备注：</th>
		<td>
			 <p><asp:Label runat=server ID=Notes></asp:Label></p>
		</td>
	</tr>

<tr>
	<td>&nbsp;</td>
	<td colspan="2" class="manage">
	<a href="javascript:history.back()">返回上一页</a>
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
