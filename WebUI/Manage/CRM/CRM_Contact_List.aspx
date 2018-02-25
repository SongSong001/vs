<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CRM_Contact_List.aspx.cs" Inherits="WC.WebUI.Manage.CRM.CRM_Contact_List" %>
<%@ Register Src="~/Controls/Page.ascx" TagName="Page" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>客户接触列表</title>
<link type="text/css" href="/manage/Style/InterFace.Css" rel="stylesheet" rev="stylesheet" media="all" />
<link type="text/css" href="/manage/style.css" rel="stylesheet" rev="stylesheet" media="all" />
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/manage/include/common.js"></script>

<script type="text/javascript" src="/js/popup/popup.js"></script>
<script type="text/javascript">
    function depView(ud) {
        var pop = new Popup({ contentType: 1, scrollType: 'yes', isReloadOnClose: false, width: 685, height: 385 });
        pop.setContent("contentUrl", '/manage/CRM/CRM_Contact_View.aspx?ctid=' + ud + '&cid=<%=c %>');
        pop.setContent("title", "客户接触详情");
        pop.build();
        pop.show();
    }
</script> 
</head>
<body >
    <form id="form1" runat="server">
<div id="interface_inside">
  <div id="interface_quick">
    <div class="interface_quick_left">您现在的操作 >> 我的客户 >> 客户接触列表</div>
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

<div id="PanelDefault">
	
<table class="table">
<thead>
	<tr>
		<th width="50">
		<asp:LinkButton ID="LinkButton1" runat=server  OnClientClick="javascript:return confirm('您确定要批量删除数据吗？')" OnClick=Del_All>删除</asp:LinkButton>
		<input type="checkbox" name=ckb class="checkall">
		</th>
		<td width="50"><span style="margin-left:15px;">序</span></td>
			<td>接触主题</td>
			<td width="190">参与人</td>
			<td width="115">接触时间</td>
			<td width="175">管理</td>
	</tr>
</thead>
 
 <asp:Repeater runat=server ID=rpt><ItemTemplate>
	<tr>
		<th width="50"><input runat=server id=chk type="checkbox" value=<%#Eval("id") %> class="checkdelete"></th>
		<td><span style="margin-left:10px;"><%# Container.ItemIndex+1 %></span></td>
		<td class="vtip" style="font-weight:bold;" title=<%# Eval("ContactAim") %> onclick='depView(<%#Eval("id") %>)'>
			<a  href='#@' ><%# WC.Tool.Utils.GetSubString2(Eval("ContactAim")+"",26,"..") %></a>
		</td>	
		<td >
		<%# WC.Tool.Utils.GetSubString2(Eval("ContactPeople")+"",12,"..") %>
		</td>
		<td>
		<%# WC.Tool.Utils.ConvertDate0(Eval("AddTime")) %>
		</td>
		<td class="manage">
		    <a onclick='depView(<%#Eval("id") %>)' href='#@' class="show">查看</a>
			<a href=CRM_Contact_Manage.aspx?ctid=<%#Eval("id") %>&cid=<%=c %> class="show">编辑</a>
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

      <!-- 模块 -->

    </div>
  </div>
</div>
    </form>
</body>
</html>
