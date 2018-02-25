function createEditor(n,_myeditor_Width,_myeditor_Height,_content) {
	_content=_content.replace(/<\$br>/g,"\r\n");
	var iframe = '<table cellpadding="0" cellspacing="0" border="0" class="editor_content" width="100%"><tr><td valign="top" id="_parent_of_'+n+'" style="width:' + _myeditor_Width + '; height:' + _myeditor_Height + ';">\n'
  	+ '<textarea name="' + n + '" id="' + n + '" cols="50" rows="10" style="width:' + _myeditor_Width + '; height:' + _myeditor_Height + ';  border:0px; margin:0px; font-size:12px; font-family:Courier New,verdana; background-color:#F9F9F9">' + _content + '</textarea>'
	+ '</td></tr></table>\n';
  	document.write('<table cellpadding="0" cellspacing="0" border="0" style="BORDER-RIGHT: #c5c5c5 1px solid; BORDER-TOP: #c5c5c5 1px solid; BORDER-LEFT: #c5c5c5 1px solid; BORDER-BOTTOM: #c5c5c5 1px solid" style="width:' + _myeditor_Width + ';"><tr><td class="editor_table">' + iframe + '</td></tr></table>');
};