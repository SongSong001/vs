<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true"%>
<asp:PlaceHolder ID="ShowIndex" Visible="false" runat="server">
<a href="Index.aspx"><% =ForumConfig.ReadConfigInfo().ForumName%></a>&nbsp;-&nbsp;
</asp:PlaceHolder>
<asp:Repeater ID="Possition" runat="server">
<HeaderTemplate>
    <a href="Index.aspx" onMouseOver="showmenu(event,'menu')"><% =ForumConfig.ReadConfigInfo().ForumName%></a>&nbsp;-&nbsp;
</HeaderTemplate>
<itemtemplate>
    <a href="<%# URLConfig.BoardURL.Replace("$BoardID",Eval("ID").ToString()).Replace("$GroupID","0")  %>" title="<%# Eval("BoardName") %>" onMouseOver="showmenu(event,'menu<%# Eval("ID") %>')"><%# Eval("BoardName") %></a>&nbsp;-&nbsp;
</itemtemplate>
</asp:Repeater>