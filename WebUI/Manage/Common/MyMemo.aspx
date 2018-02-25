<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MyMemo.aspx.cs" EnableViewState="false" Inherits="WC.WebUI.Manage.Common.MyMemo" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>下属列表</title>
<link type="text/css" href="/manage/Style/InterFace.Css" rel="stylesheet" rev="stylesheet" media="all" />
<link type="text/css" href="/manage/style.css" rel="stylesheet" rev="stylesheet" media="all" />
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/manage/include/common.js"></script>
<script type="text/javascript" src="/js/validator.js"></script>     
</head>
<body >
    <form id="form1" runat="server">
    <div id="interface_inside">
  <div id="interface_quick">
    <div class="interface_quick_left">您现在的操作 >> 下属日程汇报>> 下属列表</div>
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
<div id="Div1">

<table class="table subsubmenu">
  <thead>
	<tr>
	  <td>
<a href="/Manage/CalendarMemo/CalendarMemo.aspx" >我的日程</a>
<a href="/Manage/Common/Memo_General.aspx">导出我的日程</a>
<a href="/Manage/Common/MyMemo.aspx" >下属日程汇报</a>
	  </td>
	  <td style="text-align:right">

	  </td>
	</tr>
  </thead>
</table>
<br />           
    
<div id="PanelConfig">
 
<table class="table">
<thead>
	<tr>
		<th width="50">
		<input type="checkbox" name=ckb class="checkall">
		</th>
		<td width="60"><span style="margin-left:25px;">序</span></td>
			<td width="330">下属(部门)</td>
			<td width="155">日程状态</td>
			<td width="50"></td>
			<td width="135">操作</td>
	</tr>
</thead>
 
 <asp:Repeater runat=server ID=rpt><ItemTemplate>
	<tr>
		<th width="50"><input runat=server id=chk type="checkbox" value=<%#Eval("id") %> class="checkdelete"></th>
		<td><span style="margin-left:25px;"><%# Container.ItemIndex+1 %></span></td>
		<td>
			<span style="color:#333; font-weight:bold;"><%# Eval("RealName") + " (" + Eval("DepName") +")" %></span>
		</td>	
		<td style="color:#ff0000;">
		<%# GetStatus(Eval("MemoShare"))%>
		</td>
		<td>
		</td>
        <td class="manage">
 			<%# GetView(Eval("id"), Eval("MemoShare"))%>
             
        </td>
	</tr>
 </ItemTemplate></asp:Repeater>
 
</table>
    
<table class="table">
<tr>
	<td class="page">
	<span style="float:left;" id=num runat=server></span>
	</td>
</tr>
</table>    
    
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

