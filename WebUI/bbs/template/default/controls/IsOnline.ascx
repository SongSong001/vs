<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true"%>
<asp:PlaceHolder ID="MaleOffline" Visible="false" runat="server"><img src="<%=ForumConfig.ReadConfigInfo().SkinPath %>/boyoff.gif" align="absmiddle" /></asp:PlaceHolder>
<asp:PlaceHolder ID="MaleOnline" Visible="false" runat="server"><img src="<%=ForumConfig.ReadConfigInfo().SkinPath %>/boy.gif" align="absmiddle"  /></asp:PlaceHolder>
<asp:PlaceHolder ID="FemaleOffline" Visible="false" runat="server"><img src="<%=ForumConfig.ReadConfigInfo().SkinPath %>/girloff.gif" align="absmiddle"  /></asp:PlaceHolder>
<asp:PlaceHolder ID="FemaleOnline" Visible="false" runat="server"><img src="<%=ForumConfig.ReadConfigInfo().SkinPath %>/girl.gif" align="absmiddle" /></asp:PlaceHolder>