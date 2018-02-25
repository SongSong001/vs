<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NoteBook_Manage.aspx.cs" Inherits="WC.WebUI.Manage.Common.NoteBook_Manage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>记事便笺</title>
<script type="text/javascript" src="/js/validator.js"></script>
<link type="text/css" href="/manage/Style/InterFace.Css" rel="stylesheet" rev="stylesheet" media="all" />
<link type="text/css" href="/manage/style.css" rel="stylesheet" rev="stylesheet" media="all" />
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/manage/include/common.js"></script>    
</head>
<body >
    <form id="form1" runat="server" onsubmit="return Validator.Validate(this.form,1);" >
<div id="interface_inside">
  <div id="interface_quick">
    <div class="interface_quick_left">您现在的操作 >> 我的工具 >> 添加记事便笺</div>
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
<a href="NoteBook_List.aspx">便笺列表</a>
<a href="NoteBook_Manage.aspx">添加便笺</a>
	  </td>
	  <td style="text-align:right">

	  </td>
	</tr>
  </thead>
</table>
<br />            
            

<table class="table">
<thead>
<tr>
	<td><a href="#" class="helpall">[?]</a></td>
	<td>&nbsp;
	<asp:Button runat=server class="button" ID=Button1 Text='保存' OnClick=Save_Btn OnClientClick="return Validator.Validate(this.form,1);" />&nbsp;&nbsp;
	<input type="reset" class="button" value='重置' />
	</td>
</tr>
</thead>
<tr>
	<th style="width:100px;">* 便笺主题&nbsp;<a href="#" class="help">[?]</a></th>
	<td><span class="note">便笺主题 如 工作小结、任务申请</span>
    <input runat=server name="Subject" type="text" dataType="Require" msg="主题不能为空" id="Subject" style="width:504px;" />
	</td>
</tr>
<tr>
	<th style="width:100px;">记事内容&nbsp;<a href="#" class="help">[?]</a></th>
	<td><span class="note">请在这里输入内容 完毕点击保存</span>
	<textarea runat=server name=Bodys id=Bodys style="width:96%;height:320px;BACKGROUND-IMAGE: url(/img/line.gif); LINE-HEIGHT: 22px; padding-left:10px; background-repeat:repeat; font-weight:bold; color:#000; font-size:10pt;" dataType="Require" msg="便笺内容不能为空!"></textarea>
	</td>
</tr>
<tr>
	<th  style="width:100px;">&nbsp;</th>
	<td>&nbsp;
	<asp:Button runat=server class="button" ID=save_bt Text='保存' OnClick=Save_Btn OnClientClick="return Validator.Validate(this.form,1);" />&nbsp;&nbsp;
	<input type="reset" class="button" value='重置' />
	</td>
</tr>
</table>

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
