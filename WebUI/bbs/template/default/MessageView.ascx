<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true"%>
<%@ Register TagPrefix="DXBBS" Namespace="DXBBS.Controls" Assembly="DXBBS.Controls" %>
<div class="Block">
    <div class="Possition">
		<img src="<% = ForumConfig.ReadConfigInfo().SkinPath %>/boardicon.gif" align="absmiddle" /><DXBBS:Possition ID="Possition1" runat="server" />查看短消息
	</div>
</div>
<div class="Block Hidden">
    <div class="Title LH22 TC">
		查看短消息
    </div>
    <div class="P5 Middle M1">
    	标题： <asp:Label ID="Title" runat="server" /></div>
    <div class="P5 Middle M1">
    	<div>内容：</div>
    	<div class="P5"><asp:Label ID="Content" runat="server" /></div></div>
    <div class="P5 Middle M1">
		发送用户：&nbsp;<asp:Label ID="SendUser" runat="server" /></div>
    <div class="P5 Middle M1">
		接收用户：&nbsp;<asp:Label ID="RecieveUser" runat="server" /></div>
	<div class="TC PTB5 Footer M1">
        <asp:Button CssClass="Button" ID="Recieve" Text="回复信息" Visible="false" runat="server" />&nbsp;<input type="button" class="Button" value="关闭窗口" onclick="window.close()" />
    </div>
</div>