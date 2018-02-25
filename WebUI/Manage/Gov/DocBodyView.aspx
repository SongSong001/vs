<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DocBodyView.aspx.cs" Inherits="WC.WebUI.Manage.Gov.DocBodyView" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>查看打印</title>
<link type="text/css" href="/manage/style.css" rel="stylesheet" rev="stylesheet" media="all" />   

<script type="text/javascript" src="/js/jquery.js"></script>
    <script type="text/javascript" charset="utf-8" src="/ueditor/editor_config.js"></script>
    <script src="/ueditor/editor_all_min.js" type="text/javascript"></script>
    <script src="/ueditor/lang/zh-cn/zh-cn.js" type="text/javascript"></script>
    <link href="/ueditor/themes/default/css/ueditor.css" rel="stylesheet" />
        <script type="text/javascript">
            $("document").ready(function () {
                UE.getEditor('DocBody', {
                    initialFrameWidth: 890, initialFrameHeight: 835, toolbars: [
                ['source', '|', 'undo', 'redo', '|',
                    'bold', 'italic', 'underline', 'strikethrough', 'superscript', 'subscript', 'removeformat', 'formatmatch', 'autotypeset', 'blockquote', 'pasteplain', '|', 'forecolor', 'backcolor', 'insertorderedlist', 'insertunorderedlist', 'selectall', 'cleardoc', '|',
                    'rowspacingtop', 'rowspacingbottom', 'lineheight', '|', 'print', 'preview', '|',
                    'customstyle', 'paragraph', 'fontfamily', 'fontsize', '|',
                    'justifyleft', 'justifycenter', 'justifyright', '|',
                    'inserttable', 'deletetable', 'insertparagraphbeforetable', 'insertrow', 'deleterow', 'insertcol', 'deletecol', 'mergecells', 'mergeright', 'mergedown', 'splittocells', 'splittorows', 'splittocols'
                ]
                ],
                    autoHeightEnabled: false, readonly: false
                });
            });
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <div>
     <table class="table subsubmenu">
  <thead>
	<tr>
	  <td><a href="#">&gt;&gt;&nbsp;查看内容</a>
	  <a href=# onclick='javascript:window.close()'>关闭页面</a>
	  </td>
	  <td style="text-align:right">
	  </td>
	</tr>
  </thead>
</table>

<table class="table1">
<tr>
	<th style="width:1px; font-weight:bold;"></th>
	<td align=center>
	<span style="color:#0077ff">提示：工具栏最后第二个为打印按钮</span>
		<textarea id="DocBody" style="width: 780px;" runat="server" ></textarea>
	</td>
</tr>

</table>

    </div>
    </form>
</body>
</html>
