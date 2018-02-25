<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true"%>
<%@ Register TagPrefix="DXBBS" Namespace="DXBBS.Controls" Assembly="DXBBS.Controls" %>
<div class="Block">
    <div class="Possition H22 LH22">
		<img src="<%= ForumConfig.ReadConfigInfo().SkinPath %>/leadicon.gif" align="absmiddle" /><DXBBS:Possition ID="Possition1" runat="server" />在线用户
    </div>
</div>
<div class="Block Hidden">
    <ul class="Title">
		<li style="width:150px" class="Left TC">用户名</li>
		<li class="Right" style="width:150px">最后活动时间</li>
		<li class="Right" style="width:100px">用户IP</li>
		<li>论坛位置</li>
    </ul>
<asp:Repeater ID="OnlineList" runat="server">
<ItemTemplate>
    <dl>
        <dd style="width:150px" class="Left TC"><a href='ControlPanel.aspx?UserID=<%# Eval("UserID") %>'><%# Eval("UserName") %></a></dd>
        <dd class="Right" style="width:150px"><%# Eval("ActiveTime") %></dd>
        <dd class="Right" style="width:100px"><%# Eval("IP") %></dd>
        <dd style="margin-left:150px"><a href='<%# Eval("URL") %>' target="_blank"><%# Eval("Possition") %></a></dd>
    </dl>
</ItemTemplate>
</asp:Repeater>
</div>
<div class="BlankBlock">
    <DXBBS:ForumPager ID="CommonPager" runat="server" />
</div>
