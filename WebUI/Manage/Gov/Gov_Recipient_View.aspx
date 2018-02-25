<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Gov_Recipient_View.aspx.cs" Inherits="WC.WebUI.Manage.Gov.Gov_Recipient_View" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>公文签收</title> 
<link type="text/css" href="/manage/Style/InterFace.Css" rel="stylesheet" rev="stylesheet" media="all" />
<link type="text/css" href="/manage/style.css" rel="stylesheet" rev="stylesheet" media="all" />
<script type="text/javascript">
function menuHide(){
window.parent.document.getElementById("back_manage_submenu").style.display="none";
window.parent.document.getElementById("menubox").style.display="none";
}
function keyDown()
{
var keycode=event.keyCode;
var keyChar=String.fromCharCode(keycode);
if(event.keyCode==13 && event.srcElement.type!='button' && event.srcElement.type!='submit' && event.srcElement.type!='reset' && event.srcElement.type!=''&& event.srcElement.type!='textarea')
{
event.keyCode=9;
}
};
document.onkeydown=keyDown;
</script>

<script type="text/javascript" src="/js/jquery.js"></script>
    <script type="text/javascript" charset="utf-8" src="/ueditor/editor_config.js"></script>
    <script src="/ueditor/editor_all_min.js" type="text/javascript"></script>
    <script src="/ueditor/lang/zh-cn/zh-cn.js" type="text/javascript"></script>
    <link href="/ueditor/themes/default/css/ueditor.css" rel="stylesheet" />
        <script type="text/javascript">
            $("document").ready(function () {
                UE.getEditor('DocBody', {
                    initialFrameWidth: 890, initialFrameHeight: 835, toolbars: [
                ['source', '|', 'undo', 'redo', '|',
                    'bold', 'italic', 'underline', 'strikethrough', 'superscript', 'subscript', 'removeformat', 'formatmatch', 'autotypeset', 'blockquote', 'pasteplain', '|', 'forecolor', 'backcolor', 'insertorderedlist', 'insertunorderedlist', 'selectall', 'cleardoc', '|',
                    'rowspacingtop', 'rowspacingbottom', 'lineheight', '|', 'print', 'preview', '|',
                    'customstyle', 'paragraph', 'fontfamily', 'fontsize', '|',
                    'justifyleft', 'justifycenter', 'justifyright', '|',
                    'inserttable', 'deletetable', 'insertparagraphbeforetable', 'insertrow', 'deleterow', 'insertcol', 'deletecol', 'mergecells', 'mergeright', 'mergedown', 'splittocells', 'splittorows', 'splittocols'
                ]
                ],
                    autoHeightEnabled: false, readonly: true
                });
            });
    </script>

    </head>
<body >
<asp:Panel runat=server ID=jss Visible=false>
<script type="text/javascript"> 
<!-- 
var wait = 15; //设置秒数(单位秒) 
var secs = 0;          
for(var i=1;i<=wait;i++) { 
 window.setTimeout("sTimer("+i+")",i*1000); 
} 
function sTimer(num) { 
 if(num==wait)  { 
  document.getElementById("BtnOk").value=" 我要签收 "; 
  document.getElementById("BtnOk").disabled=false; 
 }else{ 
  secs=wait-num; 
  document.getElementById("BtnOk").value="已阅公文才能签收 ("+secs+" 秒)"; 
 } 
} 
//--> 
</script>  
</asp:Panel>
    <form id="myform" runat="server" onsubmit="javascript:return confirm('确实要签收该篇公文吗？')">
<div id="interface_inside">
  <div id="interface_quick">
    <div class="interface_quick_left">您现在的操作 >> 我的公文 >> 收文管理 >> 公文签收/查阅</div>
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
<a href="Gov_Recipient.aspx?action=verify" >公文签收( <span id=wdpy runat=server style="color:#ff0000; font-weight:bold;">0</span> ) </a>
<a href="Gov_Recipient.aspx?action=verified" >已签收公文( <span id=yjpy runat=server style="font-weight:bold;">0</span> )</a>
<a href="Gov_Recipient.aspx?action=archived" >已归档公文( <span id=wdsq runat=server style="font-weight:bold;">0</span> )</a>
	  </td>
	  <td style="text-align:right">

	  </td>
	</tr>
  </thead>
</table>
<br />           

<TABLE style="BORDER-COLLAPSE: collapse" id=AutoNumber4 border=0 cellSpacing=0 
borderColor=#111111 cellPadding=0 width="100%" height=1>
  <TBODY>
  <TR height=30>
    <TD  bgColor=#c0d9e6 background="" width="3%"><FONT 
      color=#003366 size=3><IMG src="../images/031.gif" width=16 
      height=16></FONT></TD>
    <TD  bgColor=#c0d9e6 background="">
    <span style="font-weight:bold;" runat=server id=top></span>
      </TD></TR></TBODY></TABLE>
<TABLE style="BORDER-COLLAPSE: collapse" id=AutoNumber1 border=0 cellSpacing=0 
borderColor=#111111 cellPadding=0 width="100%" >
  <TBODY>
  <TR>
    <TD colSpan=2 style="WIDTH: 100%; HEIGHT: 3px;">
      <P align=center></P></TD></TR>
  <TR>
    <TD style="WIDTH: 100%; HEIGHT: 40px; color:#ff0000;font-size:13pt; font-weight:bolder;"
     colSpan=2 align=center>
     <span runat=server id=NewsTitle></span>
     </TD></TR>

  <TR>
    <TD style="WIDTH: 100%; COLOR: #0066cc"  height=19 colSpan=2 
    align=center>
拟稿人：<span runat=server id=Creator></span> &nbsp;&nbsp;<span runat=server id=addtime></span>
    </TD>
    </TR>
    
  <TR>
    <TD style="COLOR: #0066cc;" 
    align=middle></TD>
    <TD ></TD></TR>
  <TR>
    <TD style="COLOR: #0066cc; "  
    vAlign=top align=left ></TD>
    <TD style="WORD-BREAK: break-all; vertical-align:text-top;">
    
      <div runat=server id=Notes style="min-height:220px;_height:220px; margin-bottom:10px;margin-top:8px;margin-left:35px; margin-right:30px;border:1px solid #dddddd; padding:1px 12px 12px 12px; background-color: #EEF6FC;">
		<div align=center>
        
        <textarea id="DocBody" style="width: 780px;" runat="server" ></textarea>
        
        </div>
      </div>
      
      </TD></TR>
      
  <TR>
    <TD style="COLOR: #0066cc"  height=24 
    vAlign=top align=left></TD>
    <TD style="WORD-BREAK: break-all">
    <div style="margin-left:50px; margin-right:20px;">
    <%=sm %>
    <%=fjs %>
    <%=gd %>
    </div>
    </TD></TR>      
      
  <TR>
    <TD style="COLOR: #0066cc" 
    vAlign=top align=left></TD>
    <TD style="HEIGHT: 18px; WORD-BREAK: break-all" ></TD></TR>
  <TR>
    <TD style="COLOR: #0066cc"  height=20 
    vAlign=top align=middle ></TD>
    <TD>
    <div style="margin-left:50px; margin-right:20px;"><span style="float:left; font-weight:bold; color:#006600;">签收公文/反馈意见：</span><span style="float:right; margin-right:20px; font-weight:bold; color:#ff0000;" ><a target=_blank href=DocBodyView.aspx?fid=<%=Request.QueryString["fl"] %>>>>查看打印</a> &nbsp; &nbsp; <a href=Gov_Recipient_List.aspx?fl=<%=Request.QueryString["fl"] %> >查看签收情况( <%=advice_count %> )</a> </span><br />
    <textarea name=FeedBack id=FeedBack rows=3 style="margin:10px 10px 10px 1px; border:1px solid #999; padding:0px 10px 10px 10px; background-color: #fff; width:97%;"></textarea>
    <asp:Panel runat=server ID=pal Visible=false>
    <asp:Button runat=server ID="BtnOk" CssClass="textbutton" Text="已阅公文才能签收" OnClick=Save_Btn Enabled=false />
    </asp:Panel>
    <asp:Panel runat=server ID=back Visible=true>
    <input type=button value='返回上页' onclick=javascript:history.back() class="textbutton" /></asp:Panel>
    </div>
    </TD></TR>
  <TR>
    <TD  height=14 colSpan=2 
      align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD></TR></TBODY></TABLE>&nbsp; 
<BR><BR>
<TABLE border=0 cellSpacing=0 cellPadding=0 width="100%">
  <TBODY>
  <TR>
    <TD style="WIDTH: 312px">
    <IMG src="../images/temp.gif" width=250 
      height=25></TD>
    <TD align=right>
    <IMG src="../images/endbott.gif" width=279 
      height=25 style="margin-right:30px;">
      </TD></TR></TBODY></TABLE>

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
