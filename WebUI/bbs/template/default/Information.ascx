<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true"%>
<%@ Register TagPrefix="DXBBS" Namespace="DXBBS.Controls" Assembly="DXBBS.Controls" %>
<div class="Block">
    <div class="Possition">
		<img src="<% = ForumConfig.ReadConfigInfo().SkinPath %>/boardicon.gif" align="absmiddle" /><DXBBS:Possition ID="Possition1" runat="server" />提示信息
	</div>
</div>
<div class="Block Hidden TC">
    <div class="Title TC P5">
         提示信息
    </div>
	<asp:PlaceHolder ID="Common" Visible="false" runat="server">
	<div style="padding:10px" class="Middle TC">
		◆　<asp:Label ID="Message1" ForeColor="red" Font-Bold="true" runat="server" /><br /><br /><img src='<% = ForumConfig.ReadConfigInfo().SkinPath %>/dot.gif' />&nbsp;<a href="Login.aspx?URL=<% = Requests.GetStringQueryString("URL") %>">我要登录</a>&nbsp;<img src='<% = ForumConfig.ReadConfigInfo().SkinPath %>/dot.gif' />&nbsp;<a href="Index.aspx">论坛首页</a>&nbsp;<img src='<% = ForumConfig.ReadConfigInfo().SkinPath %>/dot.gif' />&nbsp;<asp:HyperLink ID="Back1" Text="返回上页" runat="server" /></div>
	</asp:PlaceHolder>
	<asp:PlaceHolder ID="WithBoard" Visible="false" runat="server">
	<div style="padding:10px" class="Middle TC">
		◆　<asp:Label ID="Message2" ForeColor="red" Font-Bold="true" runat="server" /><br /><br /><img src='<% = ForumConfig.ReadConfigInfo().SkinPath %>/dot.gif' />&nbsp;<a href="<%= URLConfig.BoardURL.Replace("$BoardID",Requests.GetIntQueryString("BoardID").ToString()).Replace("$GroupID","0")  %>">返回版面</a>&nbsp;<img src='<% = ForumConfig.ReadConfigInfo().SkinPath %>/dot.gif' />&nbsp;<a href="Index.aspx">论坛首页</a>&nbsp;<img src='<% = ForumConfig.ReadConfigInfo().SkinPath %>/dot.gif' />&nbsp;<asp:HyperLink ID="Back2" Text="返回上页" runat="server" /></div>
	</asp:PlaceHolder>
	<asp:PlaceHolder ID="WithTopic" Visible="false" runat="server">
	<div style="padding:10px" class="Middle TC">
		◆　<asp:Label ID="Message3" ForeColor="red" Font-Bold="true" runat="server" /><br /><br /><img src='<% = ForumConfig.ReadConfigInfo().SkinPath %>/dot.gif' />&nbsp;<a href="<%= URLConfig.BoardURL.Replace("$BoardID",Requests.GetIntQueryString("BoardID").ToString()).Replace("$GroupID","0")  %>">返回版面</a>&nbsp;<img src='<% = ForumConfig.ReadConfigInfo().SkinPath %>/dot.gif' />&nbsp;<a href="<% = URLConfig.TopicURL.Replace("$BoardID",Requests.GetIntQueryString("BoardID").ToString()).Replace("$TopicID",Requests.GetIntQueryString("TopicID").ToString()) %>">返回主题</a>&nbsp;<img src='<% = ForumConfig.ReadConfigInfo().SkinPath %>/dot.gif' />&nbsp;<a href="Index.aspx">论坛首页</a>&nbsp;<img src='<% = ForumConfig.ReadConfigInfo().SkinPath %>/dot.gif' />&nbsp;<asp:HyperLink ID="Back3" Text="返回上页" runat="server" /></div>
	</asp:PlaceHolder>
</div>