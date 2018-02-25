<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true"%>
<%@ Register TagPrefix="DXBBS" Namespace="DXBBS.Controls" Assembly="DXBBS.Controls" %>
<script language="javascript">
//检查操作
function Check()
{
    if (!confirm("注意：确定删除吗？"))
    {
        return false;
    }
    return true;
}
</script>
<div class="BodyBlock PTB5">
    <div class="Block Hidden">
        <div class="Title H22 LH22 TC">
            论坛版面管理
        </div>
		<ul class="Header TC">
			<li style="width:50px">ID</li>
			<li class="Right" style="width:60px">管理</li>
			<li class="Right" style="width:100px">移动</li>
			<li class="Right" style="width:120px">添加时间</li>
			<li class="Right" style="width:100px">版面权限</li>
			<li class="TC">版面名称</li>
		</ul>
		<asp:Repeater ID="BoardList" runat="server">
		<ItemTemplate>
		<ul class="TC Hidden">
			<li style="width:50px"><%# Eval("ID") %></li>
			<li class="Right" style="width:60px"><a href='Admin_BoardAdd.aspx?ID=<%# Eval("ID") %>'>修改</a> <a href='Admin_Board.aspx?Action=Delete&ID=<%# Eval("ID") %>' onclick="return Check()">删除</a></li>
			<li class="Right" style="width:100px"><input type="button" class="Button" value="上移" onclick="window.location.href='?Action=Up&ID=<%# Eval("ID") %>&Orders=<%# Eval("Orders") %>&FatherID=<%# Eval("FatherID") %>'" /><input type="button" class="Button" value="下移" onclick="window.location.href='?Action=Down&ID=<%# Eval("ID") %>&Orders=<%# Eval("Orders") %>&FatherID=<%# Eval("FatherID") %>'" /></li>
			<li class="Right" style="width:120px"><%# Eval("AddTime") %></li>
			<li class="Right" style="width:100px"><a href="Admin_BoardRight.aspx?ID=<%# Eval("ID") %>"><span class="Red">权限管理</span></a></li>
			<li class="TL"><a href='Admin_BoardAdd.aspx?ID=<%# Eval("ID") %>'><%# Eval("BoardName") %></a></li>
		</ul>
		</ItemTemplate>
		</asp:Repeater>
		<div class="Footer PTB5 TC">
			<input type="button" class="Button" value="添加版面" onclick="window.location.href='Admin_BoardAdd.aspx'" />
		</div>
	</div>
</div>