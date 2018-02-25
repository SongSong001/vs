<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Mail_Series.aspx.cs" Inherits="WC.WebUI.Manage.Common.Mail_Series" %>
<%@ Register Src="~/Controls/Page.ascx" TagName="Page" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>通信记录</title>
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
    <div class="interface_quick_left">您现在的操作 >> 查看往来信件记录</div>
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
	  <a href="Mail_List.aspx?fid=0"> 收件箱( <span id=sjx runat=server style="color:#ff0000; font-weight:bold;">0/0</span> ) </a>
	  <a href="Mail_List.aspx?fid=1"> 草稿箱( <span id=cgx runat=server style="font-weight:bold;">0</span> ) </a>
	  <a href="Mail_List.aspx?fid=2"> 发件箱( <span id=fjx runat=server style="font-weight:bold;">0</span> ) </a>
	  <a href="Mail_List.aspx?fid=3"> 垃圾箱( <span id=ljx runat=server style="font-weight:bold;">0</span> ) </a>
	  <a href="Mail_Manage.aspx">发送新邮件</a>
	  </td>
	  <td style="text-align:right">
<asp:Panel ID="panLogin" runat="server" DefaultButton="search_bt">
	  <input type="text" name="keyword"  maxlength=10  title="在这里输入关键字" id="keyword" />
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
		<th width="70">
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
		<td><span style="margin-left:20px;"><a href=Mail_View.aspx?mid=<%#Eval("id") %>><asp:Image runat=server ID=img ImageUrl=<%# Convert.ToBoolean(Eval("IsRead"))?"~/img/mail_isread.gif":"~/img/mail_noread.gif" %> /></a></span></td>
		<td>
			<a href=Mail_View.aspx?mid=<%#Eval("id") %>><%#Eval("SenderRealName")%>(<%#Eval("SenderDepName")%>)</a>
		</td>	
		<td>
			<a href=Mail_View.aspx?mid=<%#Eval("id") %>><%# GetSendTypeName(Eval("SendType")) %><%#Eval("Subject")%></a>
		</td>	
		<td>
			<%# WC.Tool.Utils.ConvertDate1(Eval("SendTime"))%>
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
