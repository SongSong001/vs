<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true" EnableViewState="true"%>
<%@ Register TagPrefix="DXBBS" Namespace="DXBBS.Controls" Assembly="DXBBS.Controls" %>
<div class="Block">
    <div class="Possition">
		<img src="<% = ForumConfig.ReadConfigInfo().SkinPath %>/boardicon.gif" align="absmiddle" /><DXBBS:Possition ID="Possition1" runat="server" />查看投票结果
	</div>
</div>
<div class="Block Hidden">
    <div class="Title LH22 TC">
         投票结果
    </div>
    <div class="Header LH22">
    &nbsp;投票：<asp:Label ID="VoteTitle" runat="server" /></div>
    <ul class="Middle">
    	<li style="width:40%">&nbsp;投票用户</li>
        <li>&nbsp;选择项目</li>
    </ul>
    <asp:Repeater ID="VoteList" runat="server">
    <ItemTemplate>
    <ul class="Middle">
    	<li style="width:40%">&nbsp;<a href="ControlPanel.aspx?UserID=<%# Eval("VoteUserID") %>" target="_blank"><%# Eval("VoteUserName") %></a></li>
        <li>&nbsp;<%# Eval("VoteSelect") %></li>
    </ul>
    </ItemTemplate>
    </asp:Repeater>
	<div class="Footer TC PTB5">
        <input type="button" class="Button" onclick="window.close()" value="关闭窗口" />
    </div>
</div>