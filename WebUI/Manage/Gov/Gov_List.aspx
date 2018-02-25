<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Gov_List.aspx.cs" Inherits="WC.WebUI.Manage.Gov.Gov_List" %>
<%@ Register Src="~/Controls/Page.ascx" TagName="Page" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>我的公文列表</title>
<link type="text/css" href="/manage/Style/InterFace.Css" rel="stylesheet" rev="stylesheet" media="all" />
<link type="text/css" href="/manage/style.css" rel="stylesheet" rev="stylesheet" media="all" />
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/manage/include/common.js"></script>
<link type="text/css" href="/DK_Css/page_css.css" rel="stylesheet" />
</head>
<body >
    <form id="form1" runat="server">
<div id="interface_inside">
  <div id="interface_quick">
    <div class="interface_quick_left">您现在的操作 >> 我的公文 >> 发文管理 <%=flow_list %></div>
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
<a href="/Manage/gov/gov_Manage.aspx" >发文拟稿</a>
<a href="TypeList_ForView.aspx">分类导航</a>
<a href="/Manage/gov/Gov_List.aspx?action=verify">我的审批( <span id=wdpy runat=server style="color:#ff0000; font-weight:bold;">0/0</span> ) </a>
<a href="/Manage/gov/Gov_List.aspx?action=verified">已经批阅( <span id=yjpy runat=server style="font-weight:bold;">0</span> )</a>
<a href="/Manage/gov/Gov_List.aspx?action=apply">我的发文( <span id=wdsq runat=server style="font-weight:bold;">0</span> )</a>
	  </td>
	  <td style="text-align:right">
   <asp:Panel ID="panLogin" runat="server" DefaultButton="search_bt">
	  <input type="text" name="keyword" style="width:100px;" maxlength=10  id="keyword" />
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
		<th width="10">
		</th>
		<td width="40"><span>序</span></td>
			<td>公文名称</td>
			<td width="80">拟稿人</td>
			<td width="95">拟稿时间</td>
			<td width="130">当前环节</td>
			<td width="80">公文状态</td>
			<td width="115">管理</td>
	</tr>
</thead>
 
 <asp:Repeater runat=server ID=rpt ><ItemTemplate>
	<tr>
		<th></th>
		<td><span style="margin-left:10px;"><%# Container.ItemIndex+1 %></span></td>
		<td style="font-weight:bold;" title='<%# GetTrTitle(Eval("Flow_Name"))%>' class="vtip">
		<a href=Gov_View.aspx?fl=<%#Eval("id") %> ><%#Eval("Flow_Name")%></a>
		</td>	
		<td>
		<%#Eval("CreatorRealName")%>
		</td>
		<td>
		<%# WC.Tool.Utils.ConvertDate_(Eval("AddTime")) %>
		</td>
		<td>
		<%#Eval("CurrentStepName")%>
		</td>
		<td >
            <%# GetStatus(Eval("status"))%>
		</td>
	    <td class="manage">
	    <asp:Label runat=server ID=lb1 Text=<%#Eval("CurrentStepUserList") %> Visible=false></asp:Label>
            <a href=Gov_View.aspx?fl=<%#Eval("id") %> >查看</a>
            <a href=Gov_Graph.aspx?fl=<%#Eval("id") %> target=_blank>图例</a>
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
