<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true" %>
<%@ Register TagPrefix="DXBBS" Namespace="DXBBS.Controls" Assembly="DXBBS.Controls" %>
<asp:Repeater ID="OnlineList" runat="server">
    <ItemTemplate>
        &nbsp;<DXBBS:OnlineImage DataSource='<%# Eval("LevelType") %>' runat="server" />&nbsp;<a href='ControlPanel.aspx?UserID=<%# Eval("UserID") %>' target="_blank" title='当前位置：<%# Eval("Possition") %>&#13;活动时间：<%# Eval("ActiveTime") %>&#13;等级：<%# Eval("LevelName") %>&#13;IP：<%# Eval("IP") %>'><%# Eval("UserName") %></a>
    </ItemTemplate>
</asp:Repeater>