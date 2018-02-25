<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WorkLog_List.aspx.cs" Inherits="WC.WebUI.Manage.Common.WorkLog_List" %>
<%@ Register Src="~/Controls/Page.ascx" TagName="Page" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>我的工作汇报</title>
<link type="text/css" href="/manage/Style/InterFace.Css" rel="stylesheet" rev="stylesheet" media="all" />
<link type="text/css" href="/manage/style.css" rel="stylesheet" rev="stylesheet" media="all" />
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/manage/include/common.js"></script> 
<script type="text/javascript" src="/js/formV/datepicker/WdatePicker.js"></script>
<script type="text/javascript" src="/js/popup/popup.js"></script>
<script type="text/javascript">
    function depView(ud) {
        var pop = new Popup({ contentType: 1, scrollType: 'yes', isReloadOnClose: false, width: 685, height: 435 });
        pop.setContent("contentUrl", '/Manage/Common/WorkLog_View.aspx?wid=' + ud);
        pop.setContent("title", "汇报详情");
        pop.build();
        pop.show();
    }
</script> 
</head>
<body >
    <form id="form1" runat="server">
<div id="interface_inside">
  <div id="interface_quick">
    <div class="interface_quick_left">您现在的操作 >> 工作汇报列表</div>
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
<a href="/Manage/Common/WorkLog_List.aspx?action=mydoc" >我的汇报列表</a>
<a href="/Manage/Common/WorkLog_List.aspx?action=shared" >他人汇报列表</a>
<a href="/Manage/Common/WorkLog_Manage.aspx" >新建工作汇报</a>
	  </td>
	  <td style="text-align:right">
<input type=button name="s_bt" value="高级搜索" id="s_bt" onclick="javascript:$('#s_div').slideToggle('fast');" class="textbutton" />
	  </td>
	</tr>
  </thead>
</table>
<br />           

<div id="PanelDefault">
<div id=s_div style="display:none">
<asp:Panel ID="panLogin" runat="server" DefaultButton="search_bt">
<table class="table">
<thead>
<tr>
	<td><a href="#" class="helpall">[?]</a></td>
	<td>
		<asp:Button runat=server class="button" ID=search_bt Text='搜 索' OnClick=Search_Btn  />
	</td>
</tr>
</thead>
<tr>
	<th style="width:140px; font-weight:bold;">&nbsp; 关键字：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请输入 你要搜索的关键字(标题/姓名等).</span>
	<input runat=server name="TaskName"  maxlength=15 type="text" value="" id="TaskName" size=56 /></td>
</tr>
<tr>
	<th style="width:140px; font-weight:bold;">&nbsp; 日期范围：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请选择 汇报日期 的范围. </span>
	<INPUT runat=server id=StartTime name=StartTime type=text class="Wdate" readonly onclick="WdatePicker()"> 到
<INPUT runat=server id=EndTime name=EndTime type=text class="Wdate" readonly onclick="WdatePicker()">  
	</td>
</tr>

</table>
</asp:Panel>
<br />
</div>	

<table class="table">
<thead>
	<tr>
		<th width="40">
		<input type="checkbox" name=ckb class="checkall">
		</th>
		<td width="40"><span style="margin-left:15px;">序</span></td>
			<td>汇报标题</td>
			<td width="90">汇报人</td>
			<td width="120">汇报日期</td>
			<td width="160">管理</td>
	</tr>
</thead>
 
 <asp:Repeater runat=server ID=rpt OnItemDataBound=RowDataBind><ItemTemplate>
	<tr>
		<th width="50"><input runat=server id=chk type="checkbox" value=<%#Eval("id") %> class="checkdelete"></th>
		<td><span style="margin-left:10px;"><%# Container.ItemIndex + 1%></span></td>
		<td class="vtip" title='<%#Eval("LogTitle") %>' >
			<a href='#@' onclick='depView(<%#Eval("id") %>)'><strong><%# WC.Tool.Utils.GetSubString2(Eval("LogTitle") + "", 33, "..")%></strong></a>
		</td>
		<td style="color:Blue;">
		<%#Eval("CreatorRealName")%>
		</td>
		<td>
		<%#Eval("AddTime")%>
		</td>
		<td class="manage">
		    <a href='#@' onclick='depView(<%#Eval("id") %>)' class="show">查看</a>
		    <asp:Label runat=server ID=c Text='<%#Eval("CreatorID") %>' Visible=false></asp:Label>
		    
		    <asp:Panel runat=server ID=d Visible=false>
			<a href=WorkLog_Manage.aspx?wid=<%#Eval("id") %> class="show">编辑</a>
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
