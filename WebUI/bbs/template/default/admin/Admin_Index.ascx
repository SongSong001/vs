<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true"%>
<%@ Register TagPrefix="DXBBS" Namespace="DXBBS.Controls" Assembly="DXBBS.Controls" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<title>论坛 后台管理</title>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="<%=ForumConfig.ReadConfigInfo().SkinPath %>/style.css" type="text/css" rel="stylesheet" media="all" />
</head>
<body scroll="no" style="margin: 0">
<div style="min-width:800px;height:100%">
	<div style="width:100%;height:100%;overflow:hidden">
		<div class="Left" style="width:220px;height:100%;margin:0;padding:0;overflow:hidden">
			<iframe src="Admin_Left.aspx" frameborder="0" scrolling="auto" width="100%" height="100%"></iframe>
		</div>
		<div style="min-width:820px;height:100%;margin:0;padding:0;overflow:hidden">
			<iframe src="Admin_Right.aspx" name="right" frameborder="0" scrolling="auto" style="width:100%;height:100%"></iframe>
		</div>
	</div>
</div>
</body>
</html>