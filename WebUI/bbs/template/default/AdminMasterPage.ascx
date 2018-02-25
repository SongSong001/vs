<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true" %>
<%@ Register TagPrefix="DXBBS" Namespace="DXBBS.Controls" Assembly="DXBBS.Controls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<title>论坛 後台管理</title>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="<%=ForumConfig.ReadConfigInfo().SkinPath %>/style.css" type="text/css" rel="stylesheet" media="all" />
<base target="right">
</head>
<body scroll="yes">
<DXBBS:Form runat="server" id="form1">
<DXBBS:Region id="Main" runat="server"></DXBBS:Region>
</DXBBS:Form>
</body>
</html>