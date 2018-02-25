<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WorkAttendAdd.aspx.cs" Inherits="WC.WebUI.Manage.Attend.WorkAttendAdd" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>考勤登记</title>
<link type="text/css" href="/manage/Style/InterFace.Css" rel="stylesheet" rev="stylesheet" media="all" />
<link type="text/css" href="/manage/style.css" rel="stylesheet" rev="stylesheet" media="all" />
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/manage/include/common.js"></script>
<script type="text/javascript" src="/js/validator.js"></script>
<script type="text/javascript" src="/js/formV/datepicker/WdatePicker.js"></script>
</head>
<body>
    <form id="form1" runat="server" onsubmit="return Validator.Validate(this.form,1);">
    <div id="interface_inside">
  <div id="interface_quick">
    <div class="interface_quick_left">您现在的操作 >> 个人考勤 >> 考勤登记<%=TypeStr() %></div>
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
    
<div id="PanelConfig">
<table class="table subsubmenu">
  <thead>
	<tr>
	  <td>
<a href='WorkAttendAdd.aspx?type=1'>上下班登记</a>
<a href='WorkAttendAdd.aspx?type=2'>外出登记</a>
<a href='WorkAttendAdd.aspx?type=3'>请假登记</a>
<a href='WorkAttendAdd.aspx?type=4'>出差登记</a>	 	  
	  </td>
	  <td style="text-align:right">

	  </td>
	</tr>
  </thead>
</table>
<br /> 

<asp:Panel runat=server ID=type1 Visible=false>

<table class="table">
<thead>
	<tr>
		<th width="50">
		<input type="checkbox" name=ckb class="checkall">
		</th>
		<td width="50"><span style="margin-left:25px;">序</span></td>
			<td width="100">登记类型</td>
			<td width="100">规定时间</td>
			<td width="120">登记时间</td>
            <td width="80">状态</td>
            <td>备注</td>
			<td width="100">操作</td>
	</tr>
</thead>
 
 <asp:Repeater runat=server ID=rpt1><ItemTemplate>
	<tr>
		<th width="50"><input runat=server id=chk type="checkbox" value=<%#Eval("id") %> class="checkdelete"></th>
		<td><span style="margin-left:25px;"><%# Container.ItemIndex+1 %></span></td>
		<td>
			<%#Eval("AttendNames")%>
		</td>
		<td style="font-weight:bold;">
		<%#Eval("AttendTimes")%>
		</td>
		<td style="color:#0055ff;font-weight:bold;">
		<%#Eval("SignTimes")%>
		</td>
		<td>
		<%#SignJudge(Eval("SignJudge"))%>
		</td>
		<td class="vtip" title='<%# Eval("Notes") %>'>
        <%# WC.Tool.Utils.GetSubString2(Eval("Notes") + "", 20, "..") %>
		</td>
        <td class="manage">
           <%# SignClick(Eval("id"), Eval("wid"))%>
        </td>
	</tr>
 </ItemTemplate></asp:Repeater>
 
</table><br /><br />

<asp:Panel runat=server ID=Attend1 Visible=false>
<table class="table">
<tr>
	<th style="width:140px; font-weight:bold;">&nbsp; 备注信息：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请输入 备注信息.</span>
	<textarea runat=server style="BACKGROUND-IMAGE: url(/img/line.gif); LINE-HEIGHT: 22px; padding-left:10px; background-repeat:repeat;" name=Notes1 id=Notes1 rows=6 cols=75></textarea>
    </td>
</tr>
</table>

<br />
<div style="text-align:center;">
	<asp:Button runat=server class="button" ID=Button11 Text='确定登记' OnClick=Sign_Btn1 OnClientClick="javascript:return confirm('确实要以当前时间登记考勤吗？')" />
	&nbsp;&nbsp;<input type=button class="button" value='取消登记' onclick="javascript:window.location.href='WorkAttendAdd.aspx?type=1'" />
</div>

</asp:Panel>

</asp:Panel>

<asp:Panel runat=server ID=type2 Visible=false>

<table class="table">
<thead>
<tr>
	<td colspan="2"><a href="#" class="helpall">[?]</a></td>
</tr>
</thead>
<tr>
	<th style="width:140px; font-weight:bold;">&nbsp;* 外出时间：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请输入 外出时间.</span>
   <input id="BeginTime2" name="BeginTime2" class="Wdate" dataType="Require" msg="开始时间不能为空!" type="text" value=""  readonly onClick="WdatePicker()" />
    <select name="B1_2" id="B1_2" size="1">
	<option value="0">0</option>
	<option value="1">1</option>
	<option value="2">2</option>
	<option value="3">3</option>
	<option value="4">4</option>
	<option value="5">5</option>
	<option value="6">6</option>
	<option value="7">7</option>
	<option value="8">8</option>
	<option value="9">9</option>
	<option value="10">10</option>
	<option value="11">11</option>
	<option value="12">12</option>
	<option value="13">13</option>
	<option value="14">14</option>
	<option value="15">15</option>
	<option value="16">16</option>
	<option value="17">17</option>
	<option value="18">18</option>
	<option value="19">19</option>
	<option value="20">20</option>
	<option value="21">21</option>
	<option value="22">22</option>
	<option value="23">23</option>
</select>
时
<select name="B2_2" id="B2_2" size="1">
	<option value="0">0</option>
	<option value="5">5</option>
	<option value="10">10</option>
	<option value="15">15</option>
	<option value="20">20</option>
	<option value="25">25</option>
	<option value="30">30</option>
	<option value="35">35</option>
	<option value="40">40</option>
	<option value="45">45</option>
	<option value="50">50</option>
	<option value="55">55</option>
</select>分 &nbsp; <strong>到</strong>&nbsp;
<input id="EndTime2" name="EndTime2" class="Wdate" dataType="Require" msg="结束时间不能为空!" type="text" value=""  readonly onClick="WdatePicker()" />
<select name="E1_2" id="E1_2" size="1">
	<option value="0">0</option>
	<option value="1">1</option>
	<option value="2">2</option>
	<option value="3">3</option>
	<option value="4">4</option>
	<option value="5">5</option>
	<option value="6">6</option>
	<option value="7">7</option>
	<option value="8">8</option>
	<option value="9">9</option>
	<option value="10">10</option>
	<option value="11">11</option>
	<option value="12">12</option>
	<option value="13">13</option>
	<option value="14">14</option>
	<option value="15">15</option>
	<option value="16">16</option>
	<option value="17">17</option>
	<option value="18">18</option>
	<option value="19">19</option>
	<option value="20">20</option>
	<option value="21">21</option>
	<option value="22">22</option>
	<option value="23">23</option>
</select>
时
<select name="E2_2" id="E2_2" size="1">
	<option value="0">0</option>
	<option value="5">5</option>
	<option value="10">10</option>
	<option value="15">15</option>
	<option value="20">20</option>
	<option value="25">25</option>
	<option value="30">30</option>
	<option value="35">35</option>
	<option value="40">40</option>
	<option value="45">45</option>
	<option value="50">50</option>
	<option value="55">55</option>
</select>分	
    </td>
</tr>
<tr>
	<th style="width:140px; font-weight:bold;">&nbsp; 外出备注：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请输入 备注信息.</span>
	<textarea runat=server style="BACKGROUND-IMAGE: url(/img/line.gif); LINE-HEIGHT: 22px; padding-left:10px; background-repeat:repeat;" name=Notes2 id=Notes2 rows=8 cols=75></textarea>
    </td>
</tr>
</table>

<br />
<div style="text-align:center;">
	<asp:Button runat=server class="button" ID=Button2 Text='登记' OnClick=Sign_Btn2 OnClientClick="javascript:return confirm('确实要登记外出吗？')" />
	&nbsp;&nbsp;<input type="reset" class="button" value='重置' />
</div>

</asp:Panel>

<asp:Panel runat=server ID=type3 Visible=false>

<table class="table">
<thead>
<tr>
	<td colspan="2"><a href="#" class="helpall">[?]</a></td>
</tr>
</thead>
<tr>
	<th style="width:140px; font-weight:bold;">&nbsp;* 请假时间：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请输入 请假时间.</span>
   <input id="BeginTime3" name="BeginTime3" class="Wdate" dataType="Require" msg="开始时间不能为空!" type="text" value=""  readonly onClick="WdatePicker()" />
    <select name="B1_3" id="B1_3" size="1">
	<option value="0">0</option>
	<option value="1">1</option>
	<option value="2">2</option>
	<option value="3">3</option>
	<option value="4">4</option>
	<option value="5">5</option>
	<option value="6">6</option>
	<option value="7">7</option>
	<option value="8">8</option>
	<option value="9">9</option>
	<option value="10">10</option>
	<option value="11">11</option>
	<option value="12">12</option>
	<option value="13">13</option>
	<option value="14">14</option>
	<option value="15">15</option>
	<option value="16">16</option>
	<option value="17">17</option>
	<option value="18">18</option>
	<option value="19">19</option>
	<option value="20">20</option>
	<option value="21">21</option>
	<option value="22">22</option>
	<option value="23">23</option>
</select>
时
<select name="B2_3" id="B2_3" size="1">
	<option value="0">0</option>
	<option value="5">5</option>
	<option value="10">10</option>
	<option value="15">15</option>
	<option value="20">20</option>
	<option value="25">25</option>
	<option value="30">30</option>
	<option value="35">35</option>
	<option value="40">40</option>
	<option value="45">45</option>
	<option value="50">50</option>
	<option value="55">55</option>
</select>分 &nbsp; <strong>到</strong>&nbsp;
<input id="EndTime3" name="EndTime3" class="Wdate" dataType="Require" msg="结束时间不能为空!" type="text" value=""  readonly onClick="WdatePicker()" />
<select name="E1_3" id="E1_3" size="1">
	<option value="0">0</option>
	<option value="1">1</option>
	<option value="2">2</option>
	<option value="3">3</option>
	<option value="4">4</option>
	<option value="5">5</option>
	<option value="6">6</option>
	<option value="7">7</option>
	<option value="8">8</option>
	<option value="9">9</option>
	<option value="10">10</option>
	<option value="11">11</option>
	<option value="12">12</option>
	<option value="13">13</option>
	<option value="14">14</option>
	<option value="15">15</option>
	<option value="16">16</option>
	<option value="17">17</option>
	<option value="18">18</option>
	<option value="19">19</option>
	<option value="20">20</option>
	<option value="21">21</option>
	<option value="22">22</option>
	<option value="23">23</option>
</select>
时
<select name="E2_3" id="E2_3" size="1">
	<option value="0">0</option>
	<option value="5">5</option>
	<option value="10">10</option>
	<option value="15">15</option>
	<option value="20">20</option>
	<option value="25">25</option>
	<option value="30">30</option>
	<option value="35">35</option>
	<option value="40">40</option>
	<option value="45">45</option>
	<option value="50">50</option>
	<option value="55">55</option>
</select>分	
    </td>
</tr>
<tr>
	<th style="width:140px; font-weight:bold;">&nbsp; 请假备注：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请输入 备注信息.</span>
	<textarea runat=server style="BACKGROUND-IMAGE: url(/img/line.gif); LINE-HEIGHT: 22px; padding-left:10px; background-repeat:repeat;" name=Notes3 id=Notes3 rows=8 cols=75></textarea>
    </td>
</tr>
</table>

<br />
<div style="text-align:center;">
	<asp:Button runat=server class="button" ID=Button3 Text='登记' OnClick=Sign_Btn3 OnClientClick="javascript:return confirm('确实要登记请假吗？')" />
	&nbsp;&nbsp;<input type="reset" class="button" value='重置' />
</div>

</asp:Panel>

<asp:Panel runat=server ID=type4 Visible=false>

<table class="table">
<thead>
<tr>
	<td colspan="2"><a href="#" class="helpall">[?]</a></td>
</tr>
</thead>
<tr>
	<th style="width:140px; font-weight:bold;">&nbsp;* 出差地点：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请输入 出差地点.</span>
	<input runat=server name="TravelAddress4" dataType="Require" msg="出差地点不能为空" type="text" id="TravelAddress4" style="width:250px;" />
    </td>
</tr>
<tr>
	<th style="width:140px; font-weight:bold;">&nbsp;* 出差时间：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请输入 出差时间.</span>
   <input id="BeginTime4" name="BeginTime4" class="Wdate" dataType="Require" msg="开始时间不能为空!" type="text" value=""  readonly onClick="WdatePicker()" />
    <select name="B1_4" id="B1_4" size="1">
	<option value="0">0</option>
	<option value="1">1</option>
	<option value="2">2</option>
	<option value="3">3</option>
	<option value="4">4</option>
	<option value="5">5</option>
	<option value="6">6</option>
	<option value="7">7</option>
	<option value="8">8</option>
	<option value="9">9</option>
	<option value="10">10</option>
	<option value="11">11</option>
	<option value="12">12</option>
	<option value="13">13</option>
	<option value="14">14</option>
	<option value="15">15</option>
	<option value="16">16</option>
	<option value="17">17</option>
	<option value="18">18</option>
	<option value="19">19</option>
	<option value="20">20</option>
	<option value="21">21</option>
	<option value="22">22</option>
	<option value="23">23</option>
</select>
时
<select name="B2_4" id="B2_4" size="1">
	<option value="0">0</option>
	<option value="5">5</option>
	<option value="10">10</option>
	<option value="15">15</option>
	<option value="20">20</option>
	<option value="25">25</option>
	<option value="30">30</option>
	<option value="35">35</option>
	<option value="40">40</option>
	<option value="45">45</option>
	<option value="50">50</option>
	<option value="55">55</option>
</select>分 &nbsp; <strong>到</strong>&nbsp;
<input id="EndTime4" name="EndTime4" class="Wdate" dataType="Require" msg="结束时间不能为空!" type="text" value=""  readonly onClick="WdatePicker()" />
<select name="E1_4" id="E1_4" size="1">
	<option value="0">0</option>
	<option value="1">1</option>
	<option value="2">2</option>
	<option value="3">3</option>
	<option value="4">4</option>
	<option value="5">5</option>
	<option value="6">6</option>
	<option value="7">7</option>
	<option value="8">8</option>
	<option value="9">9</option>
	<option value="10">10</option>
	<option value="11">11</option>
	<option value="12">12</option>
	<option value="13">13</option>
	<option value="14">14</option>
	<option value="15">15</option>
	<option value="16">16</option>
	<option value="17">17</option>
	<option value="18">18</option>
	<option value="19">19</option>
	<option value="20">20</option>
	<option value="21">21</option>
	<option value="22">22</option>
	<option value="23">23</option>
</select>
时
<select name="E2_4" id="E2_4" size="1">
	<option value="0">0</option>
	<option value="5">5</option>
	<option value="10">10</option>
	<option value="15">15</option>
	<option value="20">20</option>
	<option value="25">25</option>
	<option value="30">30</option>
	<option value="35">35</option>
	<option value="40">40</option>
	<option value="45">45</option>
	<option value="50">50</option>
	<option value="55">55</option>
</select>分	
    </td>
</tr>
<tr>
	<th style="width:140px; font-weight:bold;">&nbsp; 出差备注：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请输入 备注信息.</span>
	<textarea runat=server style="BACKGROUND-IMAGE: url(/img/line.gif); LINE-HEIGHT: 22px; padding-left:10px; background-repeat:repeat;" name=Notes4 id=Notes4 rows=8 cols=75></textarea>
    </td>
</tr>
</table>

<br />
<div style="text-align:center;">
	<asp:Button runat=server class="button" ID=save_bt4 Text='登记' OnClick=Sign_Btn4 OnClientClick="javascript:return confirm('确实要登记出差吗？')" />
	&nbsp;&nbsp;<input type="reset" class="button" value='重置' />
</div>

</asp:Panel>

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
