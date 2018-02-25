<%@ Control Language="C#" AutoEventWireup="true" %>
<div style="width:100%;height:50px;margin-top:-5px" class="Middle LH25"><asp:FileUpload ID="UploadFile" Width="250px" runat="server" /><br/>
最大体积限制：<asp:Label ID="MaxUploadSize" ForeColor="Red" Font-Bold="true" Text="0" runat="server"/>K　　　　　<asp:Button CssClass="Button" ID="UploadButton" Text="确定上传" Height="21" runat="server" /></div>