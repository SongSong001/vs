<%@ Page Language="c#" %>
<%@ Register TagPrefix="DXBBS" Namespace="DXBBS.Controls" Assembly="DXBBS.Controls" %>
<DXBBS:Contentcontainer runat="server" id="MPContainer" MasterPageFile="AdminMasterPage.ascx">
   <DXBBS:Content id="Main" runat="server">
	  <DXBBS:Admin_UserSearch ID="Admin_UserSearch1" runat="server"/>
   </DXBBS:Content>
</DXBBS:Contentcontainer>