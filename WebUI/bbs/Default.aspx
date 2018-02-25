<%@ Page Language="c#" %>
<%@ Import Namespace="DXBBS.Components"%>
<%@ Register TagPrefix="DXBBS" Namespace="DXBBS.Controls" Assembly="DXBBS.Controls" %>
<DXBBS:Contentcontainer runat="server" id="MPContainer" MasterPageFile="MasterPage.ascx">
   <DXBBS:Content id="Main" runat="server">
	  <DXBBS:Index ID="Index1" runat="server"/>
   </DXBBS:Content>
</DXBBS:Contentcontainer>