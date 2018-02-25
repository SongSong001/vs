<%@ Control Language="C#" AutoEventWireup="true" %>
<%@ Register TagPrefix="DXBBS" Namespace="DXBBS.Controls" Assembly="DXBBS.Controls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<DXBBS:ForumKeyword ID="ForumKeyword1" runat="server" />
<DXBBS:ForumDescription ID="ForumDescription1" runat="server" />
<DXBBS:ForumCSS ID="CSS1" runat="server" />
<script src="js/menu.js"></script>
</head>
<body scroll="yes">
<DXBBS:Form runat="server" id="aspnetForm">
<div class="BodyBlock" style="min-width:800px">
<DXBBS:Header ID="Header" runat="server"/>
<DXBBS:Region id="Main" runat="server"></DXBBS:Region>
<DXBBS:Footer ID="Footer" runat="server"/>
</div>
</DXBBS:Form>
</body>
</html>