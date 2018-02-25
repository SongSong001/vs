<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PaperList.aspx.cs" Inherits="WC.WebUI.Manage.Paper.PaperList" %>
<%@ Register Src="~/Controls/Page.ascx" TagName="Page" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>档案列表</title>
<link type="text/css" href="/manage/Style/InterFace.Css" rel="stylesheet" rev="stylesheet" media="all" />
<link type="text/css" href="/manage/style.css" rel="stylesheet" rev="stylesheet" media="all" />
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/manage/include/common.js"></script>
<link type="text/css" href="/DK_Css/page_css.css" rel="stylesheet" />
<script type="text/javascript" src="/js/formV/datepicker/WdatePicker.js"></script>

<script type="text/javascript" src="/js/popup/popup.js"></script>
<script type="text/javascript">
    function depView(ud) {
        var pop = new Popup({ contentType: 1, scrollType: 'yes', isReloadOnClose: false, width: 600, height: 375 });
        pop.setContent("contentUrl", '/manage/Paper/PaperView.aspx?pid=' + ud);
        pop.setContent("title", "查看电子档案");
        pop.build();
        pop.show();
    }
</script> 
</head>
<body >
    <form id="form1" runat="server">
<div id="interface_inside">
  <div id="interface_quick">
    <div class="interface_quick_left">您现在的操作 >> 电子档案 >> 档案查询</div>
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

        <table width="98%" border="0" cellspacing="0" cellpadding="0" >
          <tr>
            <td>
            
  <div id="config_basic1" class="tabs_wrapper">
<div class="tabs_main" align="left">  
<div id="PanelConfig">

<table class="table subsubmenu">
  <thead>
	<tr>
	  <td>
<a href="PaperList.aspx" >档案查询</a>
<a href="TypeList_ForView.aspx">档案分类导航</a>
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
	<th style="width:140px; font-weight:bold;">&nbsp; 档案分类：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请选择 发起档案的分类.</span>
	<asp:DropDownList runat=server ID=TypeID EnableViewState=false></asp:DropDownList>
	</td>
</tr>
<tr>
	<th style="width:140px; font-weight:bold;">&nbsp; 文件标题：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请输入 你要搜索的文件标题.</span>
	<input runat=server name="PaperName"  maxlength=15 type="text" value="" id="PaperName" size=56 /></td>
</tr>
<tr>
	<th style="width:140px; font-weight:bold;">&nbsp; 文 号：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请输入 你要搜索的文号.</span>
	<input runat=server name="PaperSymbol"  maxlength=15 type="text" value="" id="PaperSymbol" size=56 /></td>
</tr>
<tr>
	<th style="width:140px; font-weight:bold;">&nbsp; 来文单位：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请输入 你要搜索的来文单位.</span>
	<input runat=server name="SendDep"  maxlength=15 type="text" value="" id="SendDep" size=56 /></td>
</tr>
<tr>
	<th style="width:140px; font-weight:bold;">&nbsp; 密级：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请输入 你要搜索的密级.</span>
	<input runat=server name="PaperGrade"  maxlength=15 type="text" value="" id="PaperGrade" size=56 /></td>
</tr>

<tr>
	<th style="width:140px; font-weight:bold;">&nbsp; 时间范围：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请选择 来文日期的时间范围. </span>
	<INPUT runat=server id=StartTime name=StartTime type=text class="Wdate"   readonly onclick="WdatePicker({dateFmt:'yyyyMMdd'})"> 到
<INPUT runat=server id=EndTime name=EndTime type=text class="Wdate"   readonly onclick="WdatePicker({dateFmt:'yyyyMMdd'})">  
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
		<td width="50"><span style="margin-left:15px;">序</span></td>
			<td >文件标题</td>
			<td width="130">文号</td>
			<td width="130">来文单位</td>
			<td width="110">管理</td>
	</tr>
</thead>
 
 <asp:Repeater runat=server ID=rpt ><ItemTemplate>
	<tr>
		<th width="50"><input runat=server id=chk type="checkbox" value=<%#Eval("id") %> class="checkdelete"></th>
		<td><span style="margin-left:10px;"><%# Container.ItemIndex+1 %></span></td>
		<td style="font-weight:bold;">
		[<%# GetTypeName(Eval("TypeID")) %>] &nbsp; <a href='#@' onclick='depView(<%#Eval("id") %>)' ><%#Eval("PaperName")%></a>
		</td>	
		<td>
		<%#Eval("PaperSymbol")%>
		</td>
		<td>
		<%#Eval("SendDep")%>
		</td>
	    <td class="manage">
<a href='#@' onclick='depView(<%#Eval("id") %>)' class="show">查看</a>
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
