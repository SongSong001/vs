<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true"%>
<div class="BodyBlock PTB5 Hidden">
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
    <div class="P5 Middle M1">
		发送时间：&nbsp;<asp:Label ID="AddTime" runat="server" /></div>
</div>
</div>