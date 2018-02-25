<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Gov_Graph.aspx.cs" Inherits="WC.WebUI.Manage.Gov.Gov_Graph" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>公文图例</title>    

<link type="text/css" href="/manage/style.css" rel="stylesheet" rev="stylesheet" media="all" />
</head>
<body >
    <form id="form1" runat="server">
    <div style="text-align:center;">
    <asp:Panel runat=server ID=model_flow Visible=true>
    
<table class="table" align="Center" border="0" style="width:100%;margin:auto;">
	<tr>
		<td align="Center" style="background-color:#FAFAFA; font-weight:bold; font-size:12pt;color:#ff0000;"><span runat=server id=fm_name></span></td>
	</tr>
	
	<asp:Repeater runat=server ID=rpt_mf><ItemTemplate>
	<tr>
		<td><table align="Center" bordercolor="#000000" border="0" style="border-color:#000000;border-width:1px;border-style:solid;left:100px;top:800px;width:500px;font-size:10pt;">
			<tr>
				<td align="Right" style="background-color:#FFF5F5;width:100px; font-weight:bold;">第 <%# Container.ItemIndex +1 %> 步</td>
				<td align="Left" style="background-color:#FFF5F5;width:300px; font-weight:bold;"><%#Eval("Step_Name")%></td>
			</tr><tr>
				<td align="Right" style="background-color:#F0F0F0;width:100px;">流转规则</td>
				<td align="Left" style="width:300px;background-color:#fff;"><%# Convert.ToBoolean(Eval("Step_Type")) ? "按职位/部门" : "按人员" %></td>
			</tr>
			<tr>
				<td align="Right" style="background-color:#F0F0F0;width:100px;">审批者</td>
				<td align="Left" style="width:300px; color:#0066ff;"><%# Convert.ToBoolean(Eval("Step_Type")) ? Eval("namelist_dep") : Eval("namelist")%></td>
			</tr>
			<tr>
				<td align="Right" style="background-color:#F0F0F0;width:100px;">强制签发</td>
				<td align="Left" style="width:300px;background-color:#fff;"><%# Convert.ToBoolean(Eval("RightToFinish")) ? "能" : "不能"%></td>
			</tr>			
		</table></td>
	</tr>
	<tr>
		<td align="Center" style="background-color:#FAFAFA;"><span><img src='/img/arrow.jpg' /></span></td>
	</tr>
	</ItemTemplate></asp:Repeater>
	
	<tr>
		<td align="Center" style="background-color:#FAFAFA; font-weight:bold; font-size:10pt;"><a href='#' onclick='window.close();'>公文审批结束 (点击关闭)</a></td>
	</tr>
</table>    

</asp:Panel>


    <asp:Panel runat=server ID=flow Visible=false>
    
<table class="table" align="Center" border="0" style="width:100%;margin:auto;">
	<tr>
		<td align="Center" style="background-color:#FAFAFA; font-weight:bold;color:#ff0000;font-size:12pt;"><span runat=server id=fl_name></span></td>
	</tr>
	<tr>
		<td align="Center" style="background-color:#FAFAFA; color:#666666;font-size:10pt;font-weight:bold;"><span runat=server id=fl_current></span></td>
	</tr>	
	<asp:Repeater runat=server ID=rpt_f><ItemTemplate>
	<tr>
		<td><table align="Center" bordercolor="#000000" border="0" style="border-color:#000000;border-width:1px;border-style:solid;left:100px;top:800px;width:500px;font-size:10pt;">
			<tr>
				<td align="Right" style="background-color:#FFF5F5;width:100px; font-weight:bold;">第 <%# Container.ItemIndex +1 %> 步</td>
				<td align="Left" style="background-color:#FFF5F5;width:300px; font-weight:bold;"><%#Eval("Step_Name")%></td>
			</tr>
			<tr>
				<td align="Right" style="background-color:#F0F0F0;width:100px;">审批者</td>
				<td align="Left" style="width:300px; color:#0066ff;"><%# Eval("namelist") %></td>
			</tr>
			<tr>
				<td align="Right" style="background-color:#F0F0F0;width:100px;">强制签发</td>
				<td align="Left" style="width:300px;background-color:#fff;"><%# Convert.ToBoolean(Eval("RightToFinish")) ? "能" : "不能"%></td>
			</tr>			
		</table></td>
	</tr>
	<tr>
		<td align="Center" style="background-color:#FAFAFA;"><span><img src='/img/arrow.jpg' /></span></td>
	</tr>
	</ItemTemplate></asp:Repeater>
	
	<tr>
		<td align="Center" style="background-color:#FAFAFA; font-weight:bold; font-size:10pt;"><a href='#' onclick='window.close();'>审批通过/公文签发 (点击关闭)</a></td>
	</tr>
</table>    

</asp:Panel>

</div>
    </form>
</body>
</html>
