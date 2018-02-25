<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Memo_SubView.aspx.cs" EnableViewState="false" Inherits="WC.WebUI.Manage.Common.Memo_SubView" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>查看日程报告</title>
<link type="text/css" href="/manage/style.css" rel="stylesheet" rev="stylesheet" media="all" />    
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/manage/include/common.js"></script>

</head>
<body>
    <form id="form1" runat="server">
    <div>
<table class="table">
<thead>
<tr>
	<td></td>
	<td>
	<asp:Button runat=server class="textbutton" ID=Button1 Text='导出日程' OnClick=Totxt_Btn OnClientClick='return confirm("确实要导出日程文件吗？")' />&nbsp;
	<input type=button class="textbutton" onclick='closebox()' value='关闭窗口' />&nbsp;&nbsp;(注意: 以下只可查阅 不可修改)
	</td>
</tr>
</thead>
<tr>
	<th style="width:65px;">日程详情&nbsp;</th>
	<td>
	<textarea runat=server readonly name=Bodys id=Bodys style="width:96%;height:346px;BACKGROUND-IMAGE: url(/img/line.gif); LINE-HEIGHT: 22px; padding-left:10px; background-repeat:repeat; font-weight:bold; color:#000; font-size:10pt;" ></textarea>
	</td>
</tr>

</table>    
    </div>
    </form>
</body>
</html>
