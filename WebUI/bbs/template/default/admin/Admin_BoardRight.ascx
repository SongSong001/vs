<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true"%>
<%@ Register TagPrefix="DXBBS" Namespace="DXBBS.Controls" Assembly="DXBBS.Controls" %>
<div class="BodyBlock PTB5">
	<div class="Block Hidden">
		<div class="Title M1 LH22 TC">
			<asp:Label ID="BoardName" runat="server" /> -- 版面详细访问权限管理
		</div>
		<asp:Repeater ID="LevelList" runat="server">
		<HeaderTemplate>
			<div class="Header M1 LH22 TC">
				<strong><span class="Red">可访问的用户组：</span></strong>
			</div>
		</HeaderTemplate>
		<ItemTemplate>
			<div class="Middle M1 TL LH22">
				&nbsp;&nbsp;├&nbsp;<a href='Admin_BoardRightAdd.aspx?Action=Level&BoardID=<%# Eval("BoardID") %>&ID=<%# Eval("ItemID") %>'><DXBBS:LevelName DataSource='<%# Eval("ItemID") %>' runat="server" />&nbsp;<DXBBS:ModifyPower DataSource='<%# Eval("PowerType") %>' runat="server" /></a>
			</div>
		</ItemTemplate>
		</asp:Repeater>
		<asp:Repeater ID="TeamList" runat="server">
		<HeaderTemplate>
			<div class="Header M1 LH22 TC">
				<strong><span class="Red">可访问的个性圈子：</span></strong>
			</div>
		</HeaderTemplate>
		<ItemTemplate>
		<div class="Middle M1 TL LH22">
			&nbsp;&nbsp;├&nbsp;<a href='Admin_BoardRightAdd.aspx?Action=Team&BoardID=<%# Eval("BoardID") %>&ID=<%# Eval("ItemID") %>'><DXBBS:TeamName DataSource='<%# Eval("ItemID") %>' runat="server" /></a>
		</div>
		</ItemTemplate>
		</asp:Repeater>
	</div>
</div>