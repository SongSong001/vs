<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true"%>
<asp:PlaceHolder ID="ShowUserSign" Visible="false" runat="server">
                    <div class="UserSign">
                    <img src="<%=ForumConfig.ReadConfigInfo().SkinPath %>/sign.gif" />个人签名--------------------------------------------------------------------------------<br />
                    <asp:Label ID="Content" runat="server" />
                    </div>
</asp:PlaceHolder>
