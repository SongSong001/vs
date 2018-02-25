<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Mail_List.aspx.cs" Inherits="WC.WebUI.Manage.Common.Mail_List" %>
<%@ Register Src="~/Controls/Page.ascx" TagName="Page" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>邮件列表</title>
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
    <div class="interface_quick_left">您现在的操作 >> 我的邮件 >> <%=mail_tags %></div>
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
<div id="config_basic1" class="tabs_wrapper">
<div class="tabs_main" align="left">  
<div id="PanelConfig">      
      
 <table class="table subsubmenu">
  <thead>
	<tr>
	  <td>
	  <asp:LinkButton runat=server OnClientClick="javascript:return checkValues('你确定要将选中的邮件删除至垃圾箱吗？')" ID=lb1 OnClick=MoveToLJ>删除至垃圾箱</asp:LinkButton>
	  <asp:LinkButton runat=server OnClientClick="javascript:return checkValues('你确定要彻底删除选中的邮件吗？')" ID=lb2 OnClick=Del_All>彻底删除</asp:LinkButton>
	  <a href="Mail_Manage.aspx">发送新邮件</a>	  
	  </td>
	  <td style="text-align:right; margin-right:50px;">
	  <asp:Panel ID="panLogin" runat="server" DefaultButton="search_bt">
	  <input type="text" name="keyword"  maxlength=10  title="在这里输入关键字" id="keyword" />
	  <asp:Button runat=server ID=search_bt CssClass="textbutton" OnClick=Search_Btn Text=搜索 /></asp:Panel> 
	  </td>
	</tr>
  </thead>
</table>
<br>
<div id="PanelDefault">
	
<table class="table">
<thead>
	<tr>
		<th style="width:8%">
		<asp:LinkButton ID="LinkButton1" runat=server  OnClientClick="return checkValues('您确定要批量删除数据吗？')" OnClick=Del_All>删除</asp:LinkButton>
		<input type="checkbox" name=ckb class="checkall">
		</th>
		<td style="width:4%"><span style="margin-left:15px;"></span></td>
			<td style="width:15%">发件人</td>
			<td>主题</td>
			<td style="width:25%">时间</td>
	</tr>
</thead>
 
 <asp:Repeater runat=server ID=rpt><ItemTemplate>
	<tr>
		<th width="50"><input runat=server id=chk type="checkbox" value=<%#Eval("id") %> class="checkdelete"></th>
		<td><span style="margin-left:10px;"><a href=Mail_View.aspx?mid=<%#Eval("id") %>&fid=<%=fid %> ><asp:Image runat=server ID=img ImageUrl=<%# Convert.ToBoolean(Eval("IsRead"))?"~/img/mail_isread.gif":"~/img/mail_noread.gif" %> /></a></span></td>
		<td>
			<a href=Mail_View.aspx?mid=<%#Eval("id") %>&fid=<%=fid %>><%#Eval("SenderRealName")%>(<%#Eval("SenderDepName")%>)</a>
		</td>	
		<td class="vtip" title='<%#Eval("Subject") %>'>
			<a href=Mail_View.aspx?mid=<%#Eval("id") %>&fid=<%=fid %>><%# Convert.ToBoolean(Eval("IsRead")) ? GetSendTypeName(Eval("SendType")) + "" + Eval("Subject") : "<strong>" + GetSendTypeName(Eval("SendType")) + Eval("Subject")+"</strong>"%></a>
		</td>	
		<td>
			<%# WC.Tool.Utils.ConvertDate3(Eval("SendTime"))%>
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
 

      <!-- 模块 -->

    </div>
 
 </div></div></div>
 
  </div>
</div>
    </form>
</body>
</html>
