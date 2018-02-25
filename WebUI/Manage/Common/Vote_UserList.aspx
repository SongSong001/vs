<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Vote_UserList.aspx.cs" Inherits="WC.WebUI.Manage.Common.Vote_UserList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>公开投票列表</title>
<link type="text/css" href="/manage/Style/InterFace.Css" rel="stylesheet" rev="stylesheet" media="all" />
<link type="text/css" href="/manage/style.css" rel="stylesheet" rev="stylesheet" media="all" />
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/manage/include/common.js"></script>    
</head>
<body >
    <form id="form1" runat="server">
<div id="interface_inside">
  <div id="interface_quick">
    <div class="interface_quick_left">您现在的操作 >> 我的投票 >> 公开投票情况</div>
    <div class="interface_quick_right">
     <div class="interface_quick_right">
    <a href="javascript:void(0)" onclick="javascript:window.location.replace(window.location.href);"><img style="vertical-align:middle;" src="/manage/images/reload.png" /><strong>刷新</strong></a>
    &nbsp; &nbsp;
    <a href="javascript:history.back();"><img style="vertical-align:middle;" src="/manage/images/ico_up1.gif" /><strong>后退</strong></a>  
    </div>
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
<a href="Vote_List.aspx">投票列表</a>
<a href="Vote_Manage.aspx">新建投票</a>
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
		<th width="10">
		</th>
		<td width="40"><span style="margin-left:15px;">序</span></td>
			<td >选项名称</td>
			<td width="60%">投票情况</td>
	</tr>
</thead>
 
 <asp:Repeater runat=server ID=rpt ><ItemTemplate>
	<tr>
		<th></th>
		<td><span style="margin-left:10px;"><%# Container.ItemIndex+1 %></span></td>
		<td style="font-weight:bold;">
        <%# Eval("Tmp1")%>
		</td>	
	    <td>
<a href='#@' onclick=$('#yjj<%# Container.ItemIndex+1 %>').slideToggle('fast') >获得 <span style='color:#ff0000; font-weight:bold;'><%# GetCount(Eval("Tmp1") + "") %></span> 张选票 [点击查看] </a> &nbsp; <div style='display:none; color:#006600;' id='yjj<%# Container.ItemIndex+1 %>' ><%# GetCountDetail(Eval("Tmp1") + "")%></div>
		</td>	
	</tr>
 </ItemTemplate></asp:Repeater>
 
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
