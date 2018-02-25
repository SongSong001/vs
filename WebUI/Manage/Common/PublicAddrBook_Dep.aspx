<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PublicAddrBook_Dep.aspx.cs" Inherits="WC.WebUI.Manage.Common.PublicAddrBook_Dep" EnableViewState="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>企业通讯录</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link type="text/css" href="/manage/Style/InterFace.Css" rel="stylesheet" rev="stylesheet" media="all" />
<link type="text/css" href="/manage/style.css" rel="stylesheet" rev="stylesheet" media="all" />
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/manage/include/common.js"></script>
<script type="text/javascript" src="/js/validator.js"></script>

<script type="text/javascript" src="/js/popup/popup.js"></script>
<script type="text/javascript">
    function depView(ud) {
        var pop = new Popup({ contentType: 1, scrollType: 'yes', isReloadOnClose: false, width: 435, height: 255 });
        pop.setContent("contentUrl", '/manage/Sys/Dep_View.aspx?uid=' + ud);
        pop.setContent("title", "查看组织机构资料");
        pop.build();
        pop.show();
    }
</script>      
</head>
<body >
    <form id="form1" runat="server">
<div id="interface_inside">
  <div id="interface_quick">
    <div class="interface_quick_left">您现在的操作 >> 我的工具 >> 组织机构通讯录</div>
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
<a href="/Manage/Common/PublicAddrBook.aspx">员工通讯录</a>
<a href="/Manage/Common/PublicAddrBook_Dep.aspx">组织机构通讯录</a>
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
		<asp:LinkButton ID="LinkButton1" runat=server OnClick=DownLoad OnClientClick='return confirm("确定要导出 组织机构通讯录吗？")'>导出</asp:LinkButton>
		</th>
		<td width="50"><span style="margin-left:25px;">序</span></td>
			<td width="300">机构名称</td>
			<td>电话</td>
			<td width="110">查看</td>
	</tr>
</thead>
 
 <asp:Repeater runat=server ID=rpt_dep EnableViewState=false><ItemTemplate>
	<tr>
		<th></th>
		<td><span style="margin-left:25px;"><%# Container.ItemIndex+1 %></span></td>
		<td>
			<span style="color:#006600; font-weight:bold;"><%#Eval("DepName")%></span>
		</td>	
		<td style="color:#ff0000;">
		<%#Eval("Phone")%>
		</td>
        <td class="manage">
        <a href='#@' onclick='depView(<%#Eval("id") %>)'>查看详情</a>
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
