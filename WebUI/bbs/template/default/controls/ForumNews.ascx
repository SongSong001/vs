<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true"%>
<asp:PlaceHolder ID="ShowNews" Visible="false" runat="server">
<div style="margin: 0px auto;text-align:left" class="DottedBlock">
<div style="width:100%;padding:5px 0px">
<marquee scrollamount="4" onmouseover="this.stop()" onmouseout="this.start()">
<asp:DataList RepeatDirection="horizontal" RepeatLayout="Flow" ID="ForumNews" runat="server">
<itemtemplate>
    <a href="NewsView.aspx?BoardID=<%= Requests.GetIntQueryString("BoardID") %>&ID=<%# Eval("ID") %>" target="_blank"><%# Eval("Title") %></a>　　
</itemtemplate>
</asp:DataList>
</marquee>
</div>
</div>
</asp:PlaceHolder>