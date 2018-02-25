<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Memo_General.aspx.cs" Inherits="WC.WebUI.Manage.Common.Memo_General" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>导出我的工作日程</title>
<link type="text/css" href="/manage/Style/InterFace.Css" rel="stylesheet" rev="stylesheet" media="all" />
<link type="text/css" href="/manage/style.css" rel="stylesheet" rev="stylesheet" media="all" />
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/manage/include/common.js"></script>
<script type="text/javascript" src="/js/formV/datepicker/WdatePicker.js"></script> 
<script type="text/javascript" src="/js/validator.js"></script>     
</head>
<body >
    <form id="form1" runat="server" onsubmit="return Validator.Validate(this.form,1);">
    <div id="interface_inside">
  <div id="interface_quick">
    <div class="interface_quick_left">您现在的操作 >> 导出我的日程</div>
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
	<td><a href="#" class="helpall">[?]</a></td>
	<td>
		
	</td>
</tr>
</thead>
<tr>
	<th style="width:140px; font-weight:bold;">&nbsp; 日期范围：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请选择 开始和截止日期.</span>
	<INPUT dataType="Require" msg="开始日期不能为空" id=StartTime name=StartTime type=text class="Wdate"   readonly onClick="WdatePicker()"> 到
<INPUT dataType="Require" msg="截止日期不能为空" id=EndTime name=EndTime type=text class="Wdate"   readonly onClick="WdatePicker()">
	</td>
</tr>
<tr>
	<td></td>
	<td>&nbsp;&nbsp;
		<asp:Button runat=server class="button" ID=b1 Text='导 出' OnClick=Todo_Btn  />
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
