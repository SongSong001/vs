<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true"%>
<%@ Register TagPrefix="DXBBS" Namespace="DXBBS.Controls" Assembly="DXBBS.Controls" %>
<div class="Block">
    <div class="Possition">
		<img src="<% = ForumConfig.ReadConfigInfo().SkinPath %>/boardicon.gif" align="absmiddle" /><DXBBS:Possition ID="Possition1" runat="server" />查看公告
	</div>
</div>
<div class="Block Hidden">
    <div class="Title LH22 TC">
		查看论坛公告
    </div>
    <div class="P5 Header M1">
    	<div class="Right">发表时间：<asp:Label ID="AddTime" runat="server" /></div>
        标题：<asp:Label ID="Title" runat="server" /></div>
    <div class="P5 Middle M1">
        <div class="P5"><asp:Label ID="Content" runat="server" /></div>
	</div>
	<div class="TC PTB5 Footer M1">
        <input type="button" class="Button" value="关闭窗口" onclick="window.close()" />
    </div>
</div>