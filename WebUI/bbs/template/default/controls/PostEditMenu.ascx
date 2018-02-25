<%@ Import Namespace="DXBBS.Components" %>
<%@ Control Language="C#" AutoEventWireup="true" %>
                        <asp:HyperLink ID="ShowAsk" runat="server"><img src="<% = ForumConfig.ReadConfigInfo().SkinPath %>/post_ask.gif" border="0" align="absmiddle" /></asp:HyperLink>
                        <asp:HyperLink ID="ShowQuote" runat="server"><img src="<% = ForumConfig.ReadConfigInfo().SkinPath %>/post_quote.gif" border="0" style="cursor:pointer" align="absmiddle" /></asp:HyperLink>
                        <asp:HyperLink ID="ShowHide" runat="server"><img src="<% = ForumConfig.ReadConfigInfo().SkinPath %>/post_hide.gif" border="0" align="absmiddle" /></asp:HyperLink>
                        <asp:HyperLink ID="ShowDeleteHide" runat="server"><img src="<% = ForumConfig.ReadConfigInfo().SkinPath %>/post_deletehide.gif" border="0" align="absmiddle" /></asp:HyperLink>
                        <asp:HyperLink ID="ShowEdit" runat="server"><img src="<% = ForumConfig.ReadConfigInfo().SkinPath %>/post_edit.gif" border="0" align="absmiddle" /></asp:HyperLink>
                        <asp:HyperLink ID="ShowDelete" runat="server"><img src="<% = ForumConfig.ReadConfigInfo().SkinPath %>/post_delete.gif" border="0" align="absmiddle" /></asp:HyperLink>