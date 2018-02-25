<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true" %>
<div class="Block Hidden">
    <div class="Left"><asp:Literal ID="Logo" runat="server" /></div>
    <div class="TR"><asp:Literal ID="Banner" runat="server" /></div>
</div>
<div class="Block">
    <div class="MenuLead"><asp:Repeater ID="MenuList" runat="server"><itemTemplate><%# Eval("Content") %>&nbsp;<img src="images/spacer.gif" /> </itemTemplate></asp:Repeater></div>
</div>