<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Vote_List.aspx.cs" Inherits="WC.WebUI.Manage.Common.Vote_List" %>
<%@ Register Src="~/Controls/Page.ascx" TagName="Page" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>投票列表</title>
<link type="text/css" href="/manage/Style/InterFace.Css" rel="stylesheet" rev="stylesheet" media="all" />
<link type="text/css" href="/manage/style.css" rel="stylesheet" rev="stylesheet" media="all" />
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/manage/include/common.js"></script>    
</head>
<body >
    <form id="form1" runat="server">
<div id="interface_inside">
  <div id="interface_quick">
    <div class="interface_quick_left">您现在的操作 >> 我的投票 >> 投票列表</div>
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
<a href="Vote_List.aspx">投票列表</a>
<a href="Vote_Manage.aspx">新建投票</a>
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
		<th width="20">
		<input type="checkbox" name=ckb class="checkall">		</th>
		<td width="30"><span style="margin-left:15px;">序</span></td>
			<td> &nbsp; 投票主题</td>
			<td width="90">属性</td>
			<td width="55">状态</td>
			<td width="75">创建者</td>
			<td width="90">创建时间</td>
			<td width="200">管理</td>
	</tr>
</thead>
 
 <asp:Repeater runat=server ID=rpt OnItemDataBound=RowDataBind><ItemTemplate>
	<tr>
		<th width="50"><input runat=server id=chk type="checkbox" value=<%#Eval("id") %> class="checkdelete"></th>
		<td><span style="margin-left:10px;"><%# Container.ItemIndex + 1%></span></td>
		<td class="vtip" title='<%# Eval("VoteTitle") %>'>
			<a href=Vote_View.aspx?vid=<%#Eval("id") %> ><strong><%# WC.Tool.Utils.GetSubString2(Eval("VoteTitle") + "", 40, "..")%></strong></a>
		</td>	
		<td>
		<%# Convert.ToBoolean(Eval("IsMultiple")) ? "多选" : "单选" %> &nbsp; <%# Convert.ToBoolean(Eval("ShowUser")) ? "记名" : "匿名" %>
		</td>
		<td>
		<%# Convert.ToBoolean(Eval("IsValide")) ? "<span style='color:#ff0000'>已启用</span>" : "<span style='color:#006600'>已停止</span>"%>
		</td>
		<td style="color:Blue;">
		<%#Eval("CreateRealName")%>
		</td>
		<td>
		<%# WC.Tool.Utils.ConvertDate0(Eval("AddTime"))%>
		</td>
		<td class="manage">
		    <a href=Vote_View.aspx?vid=<%#Eval("id") %> class="show">查看</a>
		    <asp:Label runat=server ID=c Text='<%#Eval("CreateUserID") %>' Visible=false></asp:Label>
		    <asp:Panel runat=server ID=d Visible=false>
			<a href=Vote_Manage.aspx?vid=<%#Eval("id") %> class="show">编辑</a>
			<asp:LinkButton runat=server ID=lk class="show" CommandArgument='<%# Eval("id") %>' OnClick=Valide_Btn ><%# Convert.ToBoolean(Eval("IsValide")) ? "停止" : "启用"%> </asp:LinkButton>
			<asp:LinkButton runat=server ID=lb_del OnClick=Del_Btn class="delete" title="你确定要删除这一项吗？">删除</asp:LinkButton>
			</asp:Panel>
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
