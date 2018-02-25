<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TopicSet.aspx.cs" Inherits="WC.WebUI.Manage.Common.TopicSet" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>桌面主题设置</title>
<script type="text/javascript" src="/js/validator.js"></script>
<link type="text/css" href="/manage/Style/InterFace.Css" rel="stylesheet" rev="stylesheet" media="all" />
<link type="text/css" href="/manage/style.css" rel="stylesheet" rev="stylesheet" media="all" />
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/manage/include/common.js"></script>
<script type="text/javascript">
    function changeList() {
        var select = document.getElementById("tlist");
        var index = select.selectedIndex;
        var text = select.options[index].text;
        var val = select.options[index].value;
        if (text != '自定义主题') {
            $("#display5").hide();
        } else { $("#display5").show(); }
         document.getElementById("links").href = val;
        //alert(val);
     }
     function setValue() {
         var select = document.getElementById("tlist");
         var index = select.selectedIndex;
         document.getElementById("t1").value = index + '';
     }
</script>
</head>
<body onload=changeList()>
    <form id="form1" runat="server">
    <input type=hidden id=t1 value='' runat=server />
<div id="interface_inside">
  <div id="interface_quick">
    <div class="interface_quick_left">您现在的操作 >> 桌面主题设置</div>
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
<a href="TopicSet.aspx" class="selected">桌面主题设置</a>
	  </td>
	  <td style="text-align:right">

	  </td>
	</tr>
  </thead>
</table>
<br />    
    
<div id="PanelManage">
	
<table class="table">
<thead>
<tr>
	<td>主题设置<a href="#" class="helpall">[?]</a></td>
	<td>&nbsp;
	</td>
</tr>
</thead>

<tr>
	<th style="width:140px; font-weight:bold;">* 主题列表&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请选择 主题列表，可点击旁边 预览主题图片</span>
		 <asp:DropDownList runat=server ID=tlist onchange="changeList()" >
         </asp:DropDownList> &nbsp; &nbsp; 
         <a href=# target=_blank id=links><strong>点击预览</strong></a>  &nbsp; &nbsp;  &nbsp; &nbsp; (保存确定后刷新网页生效)
	</td>
</tr>

<tr runat=server id=display5 style='display:none'>
	<th style="width:140px; font-weight:bold;">自定义主题&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">自定义上传主题图片</span>
	<asp:FileUpload ID="Fup" runat="server" />  &nbsp; &nbsp; (扩展名必须是 .jpg) 保存确定后刷新网页生效
	</td>
</tr>


<tr>
	<th>&nbsp;</th>
	<td>&nbsp;
	<asp:Button runat=server class="button" ID=save_bt Text='保存' OnClick=Save_Btn OnClientClick=setValue() />
	&nbsp;&nbsp;<input type="reset" class="button" value='重置' />
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
