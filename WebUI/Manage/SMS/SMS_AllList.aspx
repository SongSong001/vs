<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SMS_AllList.aspx.cs" Inherits="WC.WebUI.Manage.SMS.SMS_AllList" %>
<%@ Register Src="~/Controls/Page.ascx" TagName="Page" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>手机短信列表</title>
<link type="text/css" href="/manage/Style/InterFace.Css" rel="stylesheet" rev="stylesheet" media="all" />
<link type="text/css" href="/manage/style.css" rel="stylesheet" rev="stylesheet" media="all" />
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/manage/include/common.js"></script>
</head>
<body >
    <form id="form1" runat="server">
<div id="interface_inside">
  <div id="interface_quick">
    <div class="interface_quick_left">您现在的操作 >> 手机短信列表</div>
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
<a href="SMS_AllList.aspx">短信列表</a>
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
		<th width="65">
		<asp:LinkButton ID="LinkButton1" runat=server  OnClientClick="javascript:return checkValues('您确定要批量删除数据吗？')" OnClick=Del_All>删除</asp:LinkButton>
		<input type="checkbox" name=ckb class="checkall">
		</th>
		<td width="85"><span style="margin-left:20px;">序</span></td>
			<td>发送内容</td>
			<td width="220">发送人</td>
			<td width="175">发送时间</td>
	</tr>
</thead>
 
 <asp:Repeater runat=server ID=rpt><ItemTemplate>
	<tr>
		<th width="50"><input runat=server id=chk type="checkbox" value=<%#Eval("id") %> class="checkdelete"></th>
		<td><span style="margin-left:25px;"><%# Container.ItemIndex+1 %></span></td>
		<td style="font-weight:bold;">
		<%# WC.Tool.Utils.GetSubString2(Eval("Subject") + "", 30, "...")%>	
		</td>	
		<td>
        <%#Eval("RealName") + "(" + Eval("DepName") + ")"%>   
		</td>
		<td>
		<%#Eval("AddTime")%>
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
