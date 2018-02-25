<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Gov_Recipient_List.aspx.cs" Inherits="WC.WebUI.Manage.Gov.Gov_Recipient_List" %>
<%@ Register Src="~/Controls/Page.ascx" TagName="Page" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>公文签收情况列表</title>
<link type="text/css" href="/manage/Style/InterFace.Css" rel="stylesheet" rev="stylesheet" media="all" />
<link type="text/css" href="/manage/style.css" rel="stylesheet" rev="stylesheet" media="all" />
<link type="text/css" href="/DK_Css/page_css.css" rel="stylesheet" />
<%--<script type="text/javascript" src="/js/jquery.js"></script>--%> 
</head>
<body >
    <form id="form1" runat="server">
<div id="interface_inside">
  <div id="interface_quick">
    <div class="interface_quick_left">您现在的操作 >> 我的公文 >> 收文管理 >> 查看签收情况</div>
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
<a href="Gov_Recipient.aspx?action=verify" >公文签收( <span id=wdpy runat=server style="color:#ff0000; font-weight:bold;">0</span> ) </a>
<a href="Gov_Recipient.aspx?action=verified" >已签收公文( <span id=yjpy runat=server style="font-weight:bold;">0</span> )</a>
<a href="Gov_Recipient.aspx?action=archived" >已归档公文( <span id=wdsq runat=server style="font-weight:bold;">0</span> )</a>
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

<div id="PanelDefault">
	
<table class="table">
<thead>
	<tr>
		<th width="10">
		</th>
		<td width="40"><span style="margin-left:15px;">序</span></td>
			<td width="175">签收人</td>
			<td style="width:37%">反馈意见</td>
			<td width="150">签收时间</td>
			<td width="125">是否签收</td>
	</tr>
</thead>
 
 <asp:Repeater runat=server ID=rpt ><ItemTemplate>
	<tr>
		<th></th>
		<td><span style="margin-left:10px;"><%# Container.ItemIndex+1 %></span></td>
		<td style="font-weight:bold;">
		<%# Eval("UserRealName") + "(" + Eval("UserDepName") + ")"%>
		</td>	
		<td>
		<%# Eval("FeedBack")%>
		</td>
		<td>
		<%# SignTime(Eval("SignTime"),Eval("Sign"))%>
		</td>
	    <td>
            <%# IsSign(Eval("Sign"))%>
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
