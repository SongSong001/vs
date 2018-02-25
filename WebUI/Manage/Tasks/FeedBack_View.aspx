<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FeedBack_View.aspx.cs" Inherits="WC.WebUI.Manage.Tasks.FeedBack_View" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>任务执行情况</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link type="text/css" href="/manage/style.css" rel="stylesheet" rev="stylesheet" media="all" />
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/manage/include/common.js"></script>
<script type="text/javascript">
    function pzs() {
        if (document.form1.pz.value == "") {
            alert("您还没有输入任何批注内容！");
            document.form1.pz.focus();
            return false;
        }
    }
</script>
</head>
<body>
<form id="form1" runat="server">
<div id="PanelShow">
<table class="table">
	<thead>
	<tr>
		<th style="width:140px;"></th>
        <td>&nbsp;<div runat=server ID=TaskName style='color:#ff0000;font-weight:bolder; font-size:16px;'></div></td>
	</tr>
	</thead>
	
	<tr>
		<th style="width:140px;"><u><strong>执行人员</strong></u>：</th>
		<td>
				<div runat=server ID=TaskUser></div>
		</td>
	</tr>

	<tr>
		<th style="width:140px;"><u><strong>提交标题</strong></u>：</th>
		<td>
				<div style='color:#006600;font-weight:bold;' id=WorkTitle runat=server></div>
		</td>
	</tr>
	
	<tr>
		<th style="width:140px;"><u><strong>提交时间</strong></u>：</th>
		<td>
				<div runat=server ID=AddTime></div>
		</td>
	</tr>	

	<tr>
		<th style="width:140px;"><u><strong>提交内容</strong></u>：</th>
		<td>
				<p><div runat=server ID=Notes></div></p>
		</td>
	</tr>
	
	<tr>
		<th style="width:140px;"><u><strong>相关附件</strong></u>：</th>
		<td>
			<%=fjs %>
		</td>
	</tr>

	<tr>
		<th style="width:140px;"><u><strong>批注信息</strong></u>：</th>
		<td>
				<p><div runat=server ID=Instruction></div></p>
		</td>
	</tr>

	<tr runat=server id=pizhu1 visible=false>
		<th style="width:140px;"><u><strong>添加批注</strong></u>：</th>
		<td><textarea name="pz" dataType="Require" msg="添加批注没有任何内容" id="pz" rows="3" cols="55"></textarea>
		</td>
	</tr>

<tr>
	<td>&nbsp;</td>
	<td colspan="2" class="manage">
    <asp:LinkButton runat=server OnClick=Save_Btn OnClientClick='return pzs()' ID=pizhu3 Visible=false>添加批注</asp:LinkButton>
     <span><a href="javascript:window.print()">打印本页</a></span>
     <span><a href="javascript:closebox()">关闭本页</a></span>
	</td>
</tr>
</table>
<span id="Tip" style='display:none'></span> 
</div>

</form>
</body>
</html>
