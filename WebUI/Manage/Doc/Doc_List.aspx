<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Doc_List.aspx.cs" Inherits="WC.WebUI.Manage.Doc.Doc_List" %>
<%@ Register Src="~/Controls/Page.ascx" TagName="Page" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>我的工作文档</title>
<link type="text/css" href="/manage/Style/InterFace.Css" rel="stylesheet" rev="stylesheet" media="all" />
<link type="text/css" href="/manage/style.css" rel="stylesheet" rev="stylesheet" media="all" />
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/manage/include/common.js"></script> 

<script type="text/javascript" src="/js/popup/popup.js"></script>
<script type="text/javascript">
    function depView(ud) {
        var pop = new Popup({ contentType: 1, scrollType: 'yes', isReloadOnClose: false, width: 685, height: 385 });
        pop.setContent("contentUrl", '/manage/Doc/Doc_View.aspx?did=' + ud);
        pop.setContent("title", "文件详情");
        pop.build();
        pop.show();
    }
</script> 
</head>
<body >
    <form id="form1" runat="server">
<div id="interface_inside">
  <div id="interface_quick">
    <div class="interface_quick_left">您现在的操作 >> 我的文档 >> 我的文件列表</div>
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
<a href="/Manage/doc/Doc_List.aspx?action=mydoc" >我的文件列表</a>
<a href="/Manage/doc/Doc_List.aspx?action=shared" >同事共享文件</a>
<a href="/Manage/doc/Doc_Manage.aspx" >新建上传</a>
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

<div id="PanelDefault">
	
<table class="table">
<thead>
	<tr>
		<th width="40">
		<input type="checkbox" name=ckb class="checkall">
		</th>
		<td width="40"><span style="margin-left:15px;">序</span></td>
			<td>文档标题</td>
			<td width="90">文档分类</td>
			<td width="70">创建人</td>
			<td width="75">是否共享</td>
			<td width="120">发布时间</td>
			<td width="160">管理</td>
	</tr>
</thead>
 
 <asp:Repeater runat=server ID=rpt OnItemDataBound=RowDataBind><ItemTemplate>
	<tr>
		<th width="50"><input runat=server id=chk type="checkbox" value=<%#Eval("id") %> class="checkdelete"></th>
		<td><span style="margin-left:10px;"><%# Container.ItemIndex + 1%></span></td>
		<td class="vtip" title='<%#Eval("DocTitle") %>' >
			<a href='#@' onclick='depView(<%#Eval("id") %>)'><strong><%# WC.Tool.Utils.GetSubString2(Eval("DocTitle") + "", 33, "..")%></strong></a>
		</td>
		<td><a href='Doc_List.aspx?action=mydoc&type=<%#Eval("DocTypeID") %>'>
		<%# GetDocType(Eval("DocTypeID"))%></a>
		</td>	
		<td style="color:Blue;">
		<%#Eval("CreatorRealName")%>
		</td>
		<td>
		<%# Convert.ToBoolean(Eval("IsShare"))?"共享":"不共享" %>
		</td>
		<td>
		<%# WC.Tool.Utils.ConvertDate1(Eval("AddTime"))%>
		</td>
		<td class="manage">
		    <a href='#@' onclick='depView(<%#Eval("id") %>)' class="show">查看</a>
		    <asp:Label runat=server ID=c Text='<%#Eval("CreatorID") %>' Visible=false></asp:Label>
		    
		    <asp:Panel runat=server ID=d Visible=false>
			<a href=Doc_Manage.aspx?did=<%#Eval("id") %> class="show">编辑</a>
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
