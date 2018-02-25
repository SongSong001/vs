<%@ Import Namespace="DXBBS.Business"%>
<%@ Control Language="C#" AutoEventWireup="true" EnableViewState="true"%>
<% if (Sessions.UserID==0){ %>
<div class="DottedBlock Hidden">
用户名：<asp:TextBox ID="UserName" Width="80px" Height="12px" runat="server"/>密码：<asp:TextBox ID="Password" TextMode="password" Width="80px" Height="12px" runat="server"/><asp:PlaceHolder ID="LoginCode" runat="server">&nbsp;验证码：<asp:TextBox ID="UserCode" Width="50px" Height="12px" runat="server"></asp:TextBox> <img src="ShowCode.aspx" style="vertical-align:middle"></asp:PlaceHolder>
            保存登录：<asp:DropDownList ID="UserCookies" Height="20" runat="server"><asp:ListItem Value="0" Text="不保存" /><asp:ListItem Value="1" Text="保存一天" /><asp:ListItem Value="7" Text="保存一周" /><asp:ListItem Value="30" Text="保存一月" /><asp:ListItem Value="365" Text="保存一年" /></asp:DropDownList>
            &nbsp;<asp:CheckBox ID="HideLogin" Text="隐身登录" runat="server" /><asp:Button CssClass="Button" ID="LoginButton" Text="登录" Height="21px" runat="server" /><input type="button" class="Button" value="注册" name="B2" style="height:21px" onclick="window.location='Register.aspx'">
</div>
<%}%>