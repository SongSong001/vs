<%@ Control Language="C#" AutoEventWireup="true"%>
<asp:PlaceHolder ID="ShowList" runat="server">
<asp:Repeater ID="LinkList" runat="server">
<ItemTemplate>
    &nbsp;<a href="<%# Eval("URL") %>" target="_blank" title="<%# Eval("Introduce") %>"><img src="<%# Eval("Photo") %>" width="88" height="31" border="0" /></a>
</ItemTemplate>
<FooterTemplate><br /></FooterTemplate>
</asp:Repeater>
</asp:PlaceHolder>