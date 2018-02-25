<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Mail_View.aspx.cs" Inherits="WC.WebUI.Manage.Common.Mail_View" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>查看邮件</title>
<link type="text/css" href="/manage/Style/InterFace.Css" rel="stylesheet" rev="stylesheet" media="all" />
<link type="text/css" href="/manage/style.css" rel="stylesheet" rev="stylesheet" media="all" />
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/manage/include/common.js"></script>
<script type="text/javascript">
function repayClick()
{
    if(document.getElementById("replay").value=='在这里输入快捷回复')
    {document.getElementById("replay").value='';}
}
</script>
</head>
<body >
    <form id="form1" runat="server">
<div id="interface_inside">
  <div id="interface_quick">
    <div class="interface_quick_left">您现在的操作 >> 查阅邮件内容</div>
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
<asp:LinkButton runat=server OnClientClick="javascript:return confirm('确实将该邮件删除至垃圾箱吗？')" ID=lb1 OnClick=MoveToLJ>删除至垃圾箱</asp:LinkButton>
<asp:LinkButton runat=server OnClientClick="javascript:return confirm('确实要彻底删除该邮件吗？')" ID=lb2 OnClick=Del_Mail>彻底删除</asp:LinkButton>
<a href="Mail_Manage.aspx">发送新邮件</a>
<a href=Mail_Manage.aspx?mid=<%=mid %> >回复邮件</a>
<a href=Mail_Manage.aspx?zid=<%=mid %> >转发邮件</a>
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
		<td style="width:10px;"></td>
		<td><span style="color:#ff0000;font-size:12pt; font-weight:bolder;" id=Subject runat=server></span></td>
	</tr>
	</thead>
	<tr>
		<th style="width:10px;"></th>
		<td style="color:#333333">
		<span style="font-weight:bold; color:#006600;">发件人</span>：<span runat=server id=Sender style="font-weight:bold;"></span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<a href=Mail_Series.aspx?bet=<%=bet %>><u>查看往来邮件(通信记录)</u></a>
		<br>
	<span style="font-weight:bold; color:#006600;">时 &nbsp;&nbsp;&nbsp;间</span>：<span runat=server id=Sendtime></span>  <br>
		<span style='font-weight:bold; color:#006600;'>收件人</span>：<span runat=server id=sjr></span> 
		<%=this.csr %>
		</td>
	</tr>
	
	<tr>
		<th style="width:10px;"></th>
		<td><span style="font-weight:bold; color:#006600;">正 &nbsp;&nbsp;&nbsp;文</span>：
        <div runat=server id=bodys style="min-height:135px;_height:135px;margin:10px 10px 1px 1px; border:1px solid #E3E197; padding:10px 10px 10px 10px; background-color: #FFFFDD;"></div>
				<%=this.fjs %>
		</td>
	</tr>	
	
	<tr>
		<th style="width:10px;"></th>
		<td>
<span>
<textarea id="replay" name="replay" rows=2 onclick=repayClick() style="overflow:hidden;float:left; padding-left:5px; width:58%;">
在这里输入快捷回复</textarea>
<asp:Button runat=server ID=bt style="cursor:pointer;margin-left:3px; height:38px;border:1px #999999 solid;background:#ebf0f4;" Text=' 发送快捷回复 ' OnClick=Replay_Btn />
&nbsp;&nbsp;<input type=button onclick="javascript:window.location.href='Mail_Manage.aspx?mid=<%=this.mid %>'" style="cursor:pointer;margin-left:1px; height:38px;border:1px #999999 solid;background:#ebf0f4;" value=' 我要完全回复 ' />
</span>
		</td>
	</tr>
	

<tr>
	<td style="width:10px;">&nbsp;</td>
	<td colspan="2" class="manage"><a href="javascript:history.back()">返回上一页</a> <a target=_blank href="Mail_View_Print.aspx?fid=0&mid=<%=mid %>" >打印邮件</a></td>
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
