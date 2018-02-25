<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true"%>
<%@ Register TagPrefix="DXBBS" Namespace="DXBBS.Controls" Assembly="DXBBS.Controls" %>
<div class="Block">
    <div class="Possition">
		<img src="<% = ForumConfig.ReadConfigInfo().SkinPath %>/boardicon.gif" align="absmiddle" /><DXBBS:Possition ID="Possition1" runat="server" />发送短信息
	</div>
</div>
<div class="Block Hidden">
    <div class="Title LH22 TC">
		发送短讯息
    </div>
    <div class="Middle M1">
    	&nbsp; 标题：&nbsp;<asp:TextBox ID="Title" ToolTip="请写入短讯标题" MaxLength="50" Width="30%" runat="server" /><asp:RequiredFieldValidator ID="NeedTitle" ControlToValidate="Title" ErrorMessage="*" Display="dynamic" runat="server" />&nbsp; 接收用户： <asp:TextBox ID="RecieveUser" ToolTip="请写入接收用户名" Width="100px" MaxLength="50" runat="server" /><asp:RequiredFieldValidator ID="NeedName" ControlToValidate="RecieveUser" ErrorMessage="*" Display="dynamic" runat="server" /><asp:PlaceHolder ID="ShowMessageCode" Visible="false" runat="server">
		 验证码： <asp:TextBox ID="MessageCode" runat="server" /> <img src="ShowCode.aspx" align="absmiddle"> <asp:RequiredFieldValidator ID="NeedCode" ErrorMessage="*" ControlToValidate="MessageCode" Display="dynamic" runat="server" />
		</asp:PlaceHolder>
    </div>
    <div class="Middle M1">
    	&nbsp; 内容：&nbsp;<asp:TextBox ID="Content" ToolTip="请写入短讯内容" TextMode="multiLine" Width="80%" Height="120" runat="server" /><asp:RequiredFieldValidator ID="NeedContent" ControlToValidate="Content" ErrorMessage="*" Display="dynamic" runat="server" /></div>
	<div class="PTB5 TC Footer M1">
        <asp:Button CssClass="Button" ID="SubmitButton" Text="确定发送" runat="server" />&nbsp;<input type="button" class="Button" value="取消发送" onclick="window.close()" />
    </div>
</div>