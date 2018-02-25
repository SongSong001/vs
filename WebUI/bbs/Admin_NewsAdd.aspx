<%@ Page Language="c#" %>
<%@ Register TagPrefix="DXBBS" Namespace="DXBBS.Controls" Assembly="DXBBS.Controls" %>
<DXBBS:Contentcontainer runat="server" id="MPContainer" MasterPageFile="AdminMasterPage.ascx">
   <DXBBS:Content id="Main" runat="server">
	  <DXBBS:Admin_NewsAdd ID="Admin_NewsAdd1" runat="server"/>
   </DXBBS:Content>
</DXBBS:Contentcontainer>