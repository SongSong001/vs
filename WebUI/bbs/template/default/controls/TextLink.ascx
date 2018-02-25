<%@ Control Language="C#" AutoEventWireup="true"%>
<asp:PlaceHolder ID="ShowList" runat="server">
<asp:Repeater ID="LinkList" runat="server">
<itemtemplate>
    &nbsp;<a href="<%# Eval("URL") %>" target="_blank" title="<%# Eval("Introduce") %>"><%# Eval("Title") %></a>
</itemtemplate>
</asp:Repeater>
</asp:PlaceHolder>