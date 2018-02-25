<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PublicAddrBook.aspx.cs" Inherits="WC.WebUI.Manage.Common.PublicAddrBook" EnableViewState="false" %>
<%@ Register Src="~/Controls/Page.ascx" TagName="Page" TagPrefix="uc1" %>
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
    function personView(ud) {
        var pop = new Popup({ contentType: 1, scrollType: 'yes', isReloadOnClose: false, width: 585, height: 465 });
        pop.setContent("contentUrl", '/manage/Sys/User_View.aspx?uid=' + ud);
        pop.setContent("title", "个人资料预览");
        pop.build();
        pop.show();
    }
</script> 

</head>
<body >
    <form id="form1" runat="server">
<div id="interface_inside">
  <div id="interface_quick">
    <div class="interface_quick_left">您现在的操作 >> 我的工具 >> 员工通讯录</div>
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
<asp:Panel ID="panLogin" runat="server" DefaultButton="search_bt">
	  <input type="text" name="keyword"  maxlength=10  id="keyword" />
	  <asp:Button runat=server ID=search_bt CssClass="textbutton" OnClick=Search_Btn Text=搜索 />	 </asp:Panel> 
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
		<asp:LinkButton ID="LinkButton1" runat=server OnClick=DownLoad OnClientClick='return confirm("确定要导出 组织人员通讯录吗？")'>导出</asp:LinkButton>
		</th>
		<td width="50"><span style="margin-left:15px;">序</span></td>
			<td style="width:30%">姓名</td>
			<td style="width:15%">移动电话</td>
			<td style="width:15%">固定电话</td>
			<td style="width:20%">查看</td>			
			<td width="110"></td>
	</tr>
</thead>
 
 <asp:Repeater runat=server ID=rpt_person EnableViewState=false><ItemTemplate>
	<tr>
		<th></th>
		<td><span style="margin-left:10px;"><%# Container.ItemIndex+1 %></span></td>
		<td>
			<span style="color:#0099ff; font-weight:bold;"><%#Eval("RealName")%></span> ( <%#Eval("DepName")%> )
		</td>	
		<td style="color:#ff0000;">
		<%#Eval("Phone")%>
		</td>
		<td style="color:blue;">
		<%#Eval("Tel")%>
		</td>
		<td class="manage">
		<a href='#@' onclick='personView(<%#Eval("id")%>)'>查看详情</a>
		</td>		
        <td>      
        </td>
	</tr>
 </ItemTemplate></asp:Repeater>
 <tr>
	<td class="page" colspan=7>
	<span style="float:left;" id=num runat=server></span>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<uc1:Page ID="Page1" runat="server" />&nbsp;&nbsp;&nbsp;&nbsp;</td>
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
