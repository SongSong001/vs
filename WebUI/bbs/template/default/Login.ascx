<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true" EnableViewState="true"%>
<%@ Register TagPrefix="DXBBS" Namespace="DXBBS.Controls" Assembly="DXBBS.Controls" %>
<asp:HiddenField ID="HiddenURL" runat="server" />
<style type="text/css">
ul{
	background-color:#EFF4F8;
	margin:1px;
	height:25px;
	line-height:25px;
	overflow:hidden
}
li{
	float:left;
	width:45%;
}
</style>
<div class="Block">
    <div class="Possition">
		<img src="<%= ForumConfig.ReadConfigInfo().SkinPath %>/leadicon.gif" align="absmiddle" /><DXBBS:Possition ID="Possition1" runat="server" />用户登录
    </div>
</div>
<input type="hidden" name="URL" value="Index.aspx">
<div class="Block Hidden">
    <div class="Title LH22 TC">
        用户登录
    </div>
    <ul>
        <li class="TR" style="width:45%">用户名：</li>
		<li>&nbsp;<asp:TextBox ID="UserName" Width="150px" runat="server"/>&nbsp;<asp:RequiredFieldValidator ID="NeedName" ErrorMessage="请输入用户名" ControlToValidate="UserName" runat="server" /></li>
	</ul>
    <ul>
        <li class="TR" style="width:45%">密码：</li>
		<li>&nbsp;<asp:TextBox ID="Password" TextMode="password" Width="150px" runat="server"/>&nbsp;<asp:RequiredFieldValidator ID="NeedPassword" ErrorMessage="请输入密码" ControlToValidate="Password" runat="server" /></li>
	</ul>
	<asp:PlaceHolder ID="LoginCode" runat="server">
    <ul>
        <li class="TR" style="width:45%">验证码：</li>
		<li>&nbsp;<asp:TextBox ID="UserCode" Width="100px" runat="server"></asp:TextBox> <img src="ShowCode.aspx" align="absmiddle"> <asp:RequiredFieldValidator ID="NeedCode" ErrorMessage="请输入验证码" ControlToValidate="UserCode" Display="dynamic" runat="server" /></li>
	</ul>
	</asp:PlaceHolder>
    <ul>
        <li class="TR" style="width:45%">保存登录：</li>
		<li>&nbsp;<asp:DropDownList ID="UserCookies" Width="80px" runat="server"><asp:ListItem Value="0" Text="不保存" /><asp:ListItem Value="1" Text="保存一天" /><asp:ListItem Value="7" Text="保存一周" /><asp:ListItem Value="30" Text="保存一月" /><asp:ListItem Value="365" Text="保存一年" /></asp:DropDownList>&nbsp;<asp:CheckBox ID="HideLogin" Text=" 隐身登录" runat="server" /></li>
	</ul>
	<div class="Footer TC PTB5">
        <asp:Button CssClass="Button" ID="LoginButton" Text="确定登录" runat="server" />&nbsp;<input type="button" class="Button" value="还没注册" name="B2" onclick="window.location='Register.aspx'">
    </div>
</div>