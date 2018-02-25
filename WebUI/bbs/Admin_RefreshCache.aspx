<%@ Page Language="c#" %>
<%@ Register TagPrefix="DXBBS" Namespace="DXBBS.Controls" Assembly="DXBBS.Controls" %>
<DXBBS:Contentcontainer runat="server" id="MPContainer" MasterPageFile="AdminMasterPage.ascx">
   <DXBBS:Content id="Main" runat="server">
	  <DXBBS:Admin_RefreshCache ID="Admin_RefreshCache1" runat="server"/>
   </DXBBS:Content>
</DXBBS:Contentcontainer>