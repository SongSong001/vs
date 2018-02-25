<%@ Control Language="C#" AutoEventWireup="true" %>
<style>
body{
	background-color:transparent;margin:-3px 0 0;padding:0;
}
</style>
<asp:FileUpload ID="UploadFile" runat="server" /><asp:Button CssClass="Button" ID="UploadButton" Text="上传" Height="20" runat="server" />今天还可上传： <asp:Label ID="MaxUploadNum" ForeColor="Red" Font-Bold="true" Text="0" runat="server"/> 个，最大体积限制：<asp:Label ID="MaxUploadSize" ForeColor="Red" Font-Bold="true" Text="0" runat="server"/>K
