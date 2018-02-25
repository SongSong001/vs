// Images Dir Path
var imagesDir = "editor/simple/";

// fonts setting
var Fonts = new Array("宋体","黑体","仿宋_gb2312","幼圆","楷体_gb2312","Arial","Sans Serif","Tahoma","Verdana","Courier New","Georgia","Times New Roman","Impact","Comic Sans MS");

// use this buttons
var buttonNameGroup = new Array
						(
							["Cut", "Copy", "Paste","RemoveFormat"],
						 	["ForeColor","BackColor","Bold", "Italic", "Underline", "JustifyCenter"],
							["CreateLink","InsertImage","InsertFlash","InsertVideo","InsertTable"],
							["Undo", "Redo","AddSize","CutSize"]
						);


// all buttons can be used
var ToolbarList = {
	//Name            buttonTitle			buttonImage							HTML Code
	"Bold":           ['粗体',				imagesDir + 'bold.gif',				'<strong>*</strong>'],
	"Italic":         ['斜体',				imagesDir + 'italics.gif',			'<em>*</em>'],
	"Underline":      ['下划线',			imagesDir + 'underline.gif',		'<u>*</u>'],
	"StrikeThrough":  ['删除线',			imagesDir + 'strikethrough.gif',	'<strike>*</strike>'],
	"Seperator":      ['',					imagesDir + 'seperator.gif',		''],
	"Subscript":      ['上标',				imagesDir + 'subscript.gif',		'<sub>*</sub>'],
	"Superscript":    ['下标',				imagesDir + 'superscript.gif',		'<sup>*</sup>'],
	"JustifyLeft":    ['左对齐',			imagesDir + 'justify_left.gif',		'<div align="left">*</div>'],
	"JustifyCenter":  ['居中对齐',			imagesDir + 'justify_center.gif',	'<div align="center">*</div>'],
	"JustifyRight":   ['右对齐',			imagesDir + 'justify_right.gif',	'<div align="right">*</div>'],
	"InsertUnorderedList":['非排序列表',	imagesDir + 'list_unordered.gif',	''],
	"InsertOrderedList":['排序列表',		imagesDir + 'list_ordered.gif',		''],
	"Outdent":        ['减少缩进',			imagesDir + 'outdent.gif',			false],
	"Indent":         ['增加缩进',			imagesDir + 'indent.gif',			'<blockquote>*</blockquote>'],
	"RemoveFormat":	  ['清除格式',			imagesDir + 'removeformat.gif',		''],
	"Cut":            ['剪切',				imagesDir + 'cut.gif',				true],
	"Copy":           ['复制',				imagesDir + 'copy.gif',				true],
	"Paste":          ['粘贴',				imagesDir + 'paste.gif',			true],
	"PasteText":      ['纯文本粘贴',		imagesDir + 'pasteText.gif',		true],
	"ForeColor":      ['颜色',				imagesDir + 'forecolor.gif',		''],
	"BackColor":      ['背景色',			imagesDir + 'backcolor.gif',		''],
	"Undo":           ['撤消',				imagesDir + 'undo.gif',				true],
	"Redo":           ['重做',				imagesDir + 'redo.gif',				true],
	"InsertTable":	  ['插入表格',			imagesDir + 'table.gif',			''],	
	"InsertRow":	  ['插入行',			imagesDir + 'InsertRow.gif',		''],	
	"DeleteRow":	  ['删除行',			imagesDir + 'DeleteRow.gif',		''],	
	"InsertColumn":	  ['插入列',			imagesDir + 'InsertColumn.gif',		''],	
	"DeleteColumn":	  ['删除列',			imagesDir + 'DeleteColumn.gif',		''],		
	"InsertImage":    ['插入图片',			imagesDir + 'insert_picture.gif',	''],
	"InsertFlash":    ['插入Flash',			imagesDir + 'insert_flash.gif',		''],
	"InsertVideo":    ['插入视频',			imagesDir + 'insert_video.gif',		''],
	"CreateLink":     ['链接',				imagesDir + 'insert_hyperlink.gif',	''],
	"Unlink":		  ['取消链接',			imagesDir + 'unlink.gif',			''],
	"SelectFont":     ['选择字体',			imagesDir + 'select_font.gif',		''],
	"SelectSize":     ['选择大小',			imagesDir + 'select_size.gif',		''],
	"InsertHorizontalRule":['插入水平线',	imagesDir + 'hr.gif',				'*<hr>'],
	"SelectAll":	  ['全选',				imagesDir + 'SelectAll.gif',		true],
	"specialchar":	  ['插入特殊符号',		imagesDir + 'specialchar.gif',		''],
	"Quote":		  ['插入引用',			imagesDir + 'quote.gif',			'<div class="Quote">*</div>'],	
	"Code":			  ['插入代码',			imagesDir + 'code.gif',				'<div class="Code">*</div>'],
	"replace":		  ['替换',				imagesDir + 'replace.gif',			'']	,
	"Help":			  ['帮助',				imagesDir + 'help.gif',				'']	,
	"AddSize":		  ['增加高度',				imagesDir + 'content_expand.gif',				'']	,
	"CutSize":		  ['减少高度',				imagesDir + 'content_contract.gif',				'']	
};

document.write('<link href="'+imagesDir+'style.css" rel="stylesheet" type="text/css">');

var viewSourceMode = new Array();

var isIE = document.all;

var dropdownID = null;

function oo(ID){
	return document.getElementById(ID);
}
String.prototype.trim=function(){return this.replace(/(^\s*)|(\s*$)/g,"");}

function createEditor(n,_myeditor_Width,_myeditor_Height,_content) {
	viewSourceMode[n] = 0;
	var toolbar = '<table cellpadding="1" cellspacing="0" border="0" height=31 width="100%" id="toolBar_'+n+'" unselectable="on" background=' + imagesDir  + 'bg.gif style="width:' + _myeditor_Width + ';BORDER-BOTTOM: #c5c5c5 1px solid"><tr><td unselectable="on" class="editor_toolbar">';
	for(var i=0; i<buttonNameGroup.length;i++) {
		if(buttonNameGroup[i]==='')	{
			toolbar += '<div class="toolbarnewline"></div>';
			continue;
		}
		toolbar += '<div class="toolbarblock"><table cellpadding="0" cellspacing="0" border="0"><tr><td><img src="' +ToolbarList["Seperator"][1]+ '" border=0></td>';
		if(i==1){
			toolbar += '<td><span id="FontSelect' + n + '" class="editor_select_off"></span></td>';
			toolbar += '<td><span id="FontSizes'  + n + '" class="editor_select_off"></span></td>';
		}
		var buttonName = buttonNameGroup[i];
    	for(var j=0; j<buttonName.length; j++){
			var buttonID			= buttonName[j];
	    	var buttonObj 			= ToolbarList[buttonID];
	     	var buttonTitle         = buttonObj[0];
	        var buttonImage         = buttonObj[1];
	    	toolbar += '<td width=24 height=24 align="center" onmouseover="BorderOn(this); " onmouseout="BorderDown(this);"><span id="' + n + '_' + buttonID + '_exp" onClick="formatText(\''+buttonID+'\',\'' + n + '\');"><img src="' +buttonImage+ '" border=0 title="' +buttonTitle+ '" width="20" height="20"></span></td>';
		}
		if (i+1==buttonNameGroup.length)
		{
			toolbar += '<td align="center" onmouseover="BorderOn(this); " onmouseout="BorderDown(this);"><input type="checkbox" onclick="switchmode(\''+n+'\',this)" title="编辑源代码"></td>';
		}
		toolbar += '</tr></table></div>';
	}

	toolbar += '</td></tr></table>';
	
	var iframe = '<table cellpadding="0" cellspacing="0" border="0" class="editor_content" width="100%"><tr><td valign="top" id="_parent_of_'+n+'" style="width:' + _myeditor_Width + '; height:' + _myeditor_Height + ';">\n'
  	+ '<iframe frameborder="0" id="_myeditor_' + n + '" scrolling="auto" style="width:100%; height:' + _myeditor_Height + '; margin:1px 0;"></iframe>\n'
  	+ '<textarea name="' + n + '" id="' + n + '" style="width:100%; height:' + _myeditor_Height + ';  display:none; border:0px; margin:0px; font-size:12px; font-family:Courier New,verdana; background-color:#F9F9F9"></textarea>'
	+ '</td></tr></table>\n';
  	document.write('<table cellpadding="0" cellspacing="0" border="0" style="BORDER-RIGHT: #c5c5c5 1px solid; BORDER-TOP: #c5c5c5 1px solid; BORDER-LEFT: #c5c5c5 1px solid; BORDER-BOTTOM: #c5c5c5 1px solid" style="width:' + _myeditor_Width + ';"><tr><td class="editor_table">' + toolbar + iframe + '</td></tr></table>');

	outputFontSelect(n);
	outputFontSizes(n); 
	outputColor('ForeColor',n); 
	outputColor('BackColor',n); 

	var doc = oo("_myeditor_" + n).contentWindow.document;
	if (!(isIE) && _content == "")
	{
		_content="<br>";
	}
	doc.open();
	doc.write("<HTML><head><link href='"+imagesDir+"iframe.css' rel='stylesheet' type='text/css' /></head><BODY bgcolor='#FFFFFF' width='100%' height='100%'>"+_content+"</BODY></HTML>");
	doc.close();
	
	if (isIE){
		doc.body.contentEditable = true ;
		for (var idx=0; idx < document.forms.length; idx++){
	  		document.forms[idx].attachEvent('onsubmit', function() { updateValues(n); });
		}
		document.attachEvent('onmouseup', function() { if(dropdownID && ((event.srcElement.tagName!='IMG'&&event.srcElement.tagName!='BUTTON')||!oo('toolBar_'+n).contains(event.srcElement))){oo(dropdownID).style.display='none'; }  });
		doc.attachEvent('onmouseup', function() { editor_buttons_on(n); });
	}else{
		doc.designMode = 'on';
		for (var idx=0; idx < document.forms.length; idx++){
			document.forms[idx].addEventListener('submit', function OnSubmit() {updateValues(n);}, true);
		}
	}
	doc.execCommand('LiveResize', false, true);
};

function editor_buttons_on(n){
	if(dropdownID) oo(dropdownID).style.display = 'none';
	if(!isIE) return false;

	var buttonOnIDs = ["Bold","Italic","Underline","Strikethrough","JustifyLeft","JustifyCenter","JustifyRight","InsertUnorderedList","InsertOrderedList"];
	try{
		for(var i=0;i<buttonOnIDs.length;i++){
			var id = buttonOnIDs[i];
			if(oo(n+'_'+id)){
				if(oo("_myeditor_" + n).contentWindow.document.queryCommandValue(id)==true){
					oo(n+'_'+id+'_exp').className = oo(n+'_'+id+'_exp').nowClassName = "buttonOn";
				}else{
					oo(n+'_'+id+'_exp').className = oo(n+'_'+id+'_exp').nowClassName = "button";
				}
			}
		}
	}catch(e){}	
}

function formatText(id, n, s) {
	
	if(id=='Help'){
		openModalWindow(imagesDir+"help.htm",300,200,n);
		return true;
	}
	if (viewSourceMode[n] == 1) {
		return SourceformatText(id,n,s)
	}
	var w = oo("_myeditor_" + n).contentWindow;
	w.focus();
	
	if(!s && (id=='ForeColor'||id=='BackColor')){
		return showColor(id,n);
	}
	else if(id == "PasteText"){
		if (window.clipboardData) {	
			var txt = window.clipboardData.getData("Text").replace( /\n/g, '<br />' );
			insertHTML( txt ,n);
		}else {
			openModalWindow(imagesDir+"paste_text.htm",350,200,n);
		}
		return false;
	}
	else if(id=='CreateLink' && !(isIE)){
		var sel = w.window.getSelection();
		var input = window.prompt("请输入网址地址:","");
		if(input==null) return;
		if (sel=="")
		{
			sel=input;
		}
		insertHTML('<a href="'+input+'">' + sel + '</a>',n);
	}
	else if (id == "InsertImage") {
		var input = window.prompt("请输入图片地址:","");
		if(input==null) return;
		insertHTML('<img src="'+input+'" border="0" />',n);
	}
	else if(id == "InsertFlash"){
		if(!s){
			var input = openModalWindow(imagesDir+"insert_flash.htm",350,200,n);
			if(input==null) return;
		}else input = s;
		insertHTML( '<img src="'+imagesDir+'spacer.gif" width="'+input[1]+'" height="'+input[2]+'" alt="'+input[0]+'" class="editor_flash" />',n);
	}
	else if(id == "InsertVideo"){
		if(!s){
			var input = openModalWindow(imagesDir+"insert_video.htm",350,250,n);
			if(input==null) return;
		}else input = s;
		insertHTML( '<img src="'+imagesDir+'spacer.gif" width="'+input[1]+'" height="'+input[2]+'" autoplay="'+input[3]+'" alt="'+input[0]+'" class="editor_video_'+input[4]+'" />',n );
	}else if(id == "specialchar"){
		if(!s){
			var input = openModalWindow(imagesDir+"insert_specialchars.htm",400,250,n);
			if(input==null) return;
		}else input = s;
		insertHTML( input,n );
		
	}
	else if(id == "InsertTable"){
		if(!s){
			var input = openModalWindow(imagesDir+"insert_table.htm?n="+n,350,350,n);
			if(input==null) return;
		}else input = s;
		insertHTML( input,n );
	}else if( id=='InsertRow' || id=='InsertColumn' || id=='DeleteRow' || id=='DeleteColumn' ){
		eval(id+'("'+n+'")');
	}
	else if(id=="Quote"||id=="Code"){
		var type = w.document.selection.type;
		if(type=="Text" || type=='None'){
			s = '<DIV class="'+id+'">'+w.document.selection.createRange().htmlText+'</DIV>';
			insertHTML(s,n);
		}else{
			alert('请选择相应内容！');
		}
	}
	else if(id=="replace"){
		if(!s){
			var input = openModalWindow(imagesDir+"replace.htm",250,200,n);
			if(input==null) return;
		}else input = s;
		var cr = w.document.selection.createRange();
		cr.expand('textedit');
		var k=0;
		while(cr.findText(input[0],0,input[2]) ){
			cr.select();
			insertHTML(input[1],n);
			cr.expand('textedit');	
			k++;
		}
		if(k) alert("找到并替换 "+k+" 个结果.");
		else alert("没找到相关内容.");
	}
	else if(id=='AddSize'){
		editor_resize(n,100);
		return true;
	}
	else if(id=='CutSize'){
		editor_resize(n,-100);
		return true;	
	}
	else{
		if(!isIE) w.document.execCommand( 'useCSS', false, true ) ;
		w.document.execCommand(id, false, s);
	}
	editor_buttons_on(n);
};

function SourceformatText(id,n,s){
	
	if(s && s.indexOf('*')!=-1) return;

	oo(n).focus();

	var sourceCode = '';
	if(id == "PasteText") id = 'Paste';

	if(id=='FontName'){
		sourceCode = '<font face="'+s+'">*</font>';
	}
	else if(id=='ForeColor'){
		//the color window will get the focus ... 
		if(isIE) var cr = document.selection.createRange();
		else var cr = 1;
		if(!s)	return showColor(id,n,cr);
		cr = showColor(id,n,null);
		insertSource('<font color="'+s+'">','</font>',n,cr);
		return true;	
	}
	else if(id=='BackColor'){
		//the color window will get the focus ... 
		if(isIE) var cr = document.selection.createRange();
		else var cr = 1;
		if(!s)	return showColor(id,n,cr);
		cr = showColor(id,n,null);
		insertSource('<font style="background-color:'+s+'">','</font>',n,cr);
		return true;	
	}
	else if(id=='FontSize'){
		sourceCode = '<font size="'+s+'">*</font>';
	}
	else if(id=='CreateLink'){
		s = window.prompt("请输入链接地址:","http://");
		if(s==null || s.indexOf('*')!=-1 || s=='http://') return;
		if( docGetSelection(n) )
		{
			sourceCode = '<a href="'+s+'" target=_blank>*</a>';
		}
		else
		{
			str = '<a href="'+s+'" target=_blank>'+s+'</a>';
			insertSource('',str,n);
			return true;
		}	
	}
	else if(id=='InsertImage'){
		s = window.prompt("请输入图片地址","http://");
		if(s==null || s.indexOf('*')!=-1 || s=='http://') return;			
		str = '<img src="'+s+'" border="0" />';
		insertSource('',str,n);
		return true;

	}else if(id=='InsertUnorderedList'||id=='InsertOrderedList'){
		var str = (id=='InsertUnorderedList'?'<ul>':'<ol>');
		var sel = docGetSelection(n);
		if( sel ){
			strs = sel.split('\n');
			for(var i=0;i<strs.length;i++){
				if(strs[i].trim())	str += '\n<li>'+strs[i].trim()+'</li>';
			}
			str += '\n'+(id=='InsertUnorderedList'?'</ul>':'</ol>');
		}else{
			var i=0;
			while(s = window.prompt("请输入一个列表项目，留空或取消完成该列表:","")){
				str += "\n<li>" + s + "</li>";
				i++;
			}
			if(i==0) return false;
			str += '\n'+(id=='InsertUnorderedList'?'</ul>':'</ol>');
		}
		insertSource('',str,n);
		return true;
	}
	else if(id == "InsertFlash"){
		if(!s){
			var input = openModalWindow(imagesDir+"insert_flash.htm",350,200,n);
			if(input==null) return;
		}else input = s;
		var str = '[flash='+input[1]+','+input[2]+']'+input[0]+'[/flash]'; 
		insertSource('',str,n);
		return true;
	}
	else if(id == "InsertVideo"){
		if(!s){
			var input = openModalWindow(imagesDir+"insert_video.htm",350,250,n);
			if(input==null) return;
		}else input = s;		
		var str = '['+input[4]+'='+input[1]+','+input[2]+','+input[3]+']'+input[0]+'[/'+input[4]+']';
		insertSource('',str,n);
		return true;
	}	
	 if(id=="replace"){
		if(!s){
			var input = openModalWindow(imagesDir+"replace.htm",250,200,n);
			if(input==null) return;
		}else input = s;
		var str = oo(n).value;
		input[0] = input[0].replace(/(\W)/mig,"\\$1");
		var patten = new RegExp(input[0],(input[2]==4?'g':'gi'));
		str = str.replace(patten,input[1]);
		oo(n).value = str;
		return true;
	}
	else if(id=='Unlink'){
		var str = docGetSelection(n).replace(/(<\/?)(a[^>]*)(>)/mig,'');
		insertSource('',str,n);
		return true;
		
	}	
	else if(id=='RemoveFormat'){
		//keep img ,use '<*img>' for special string
		str = docGetSelection(n).replace(/(<)(img\s[^>]*)(>)/mig,'$1*$2$3');
		str = str.replace(/(<\/?)([^\*][^>]*)(>)/mig,'');
		str = str.replace(/(<)(\*)(img\s[^>]*)(>)/mig,'$1$3$4');
		insertSource('',str,n);
		return true;
	}
	else if(id=='AddSize'){
		editor_resize(n,100);
		return true;
	}
	else if(id=='CutSize'){
		editor_resize(n,-100);
		return true;	
	}
	else{
		sourceCode = ToolbarList[id][2];
		if(sourceCode===true){
			try{
				document.execCommand(id, false, s)	
			}catch(e){}
		}
	}
	if(sourceCode){
		var adds = sourceCode.split('*',2);
		insertSource( adds[0],adds[1],n);
	}
	
	if(dropdownID) oo(dropdownID).style.display = 'none';
	return true;
}


function insertSource(b,e,n,cr){
	var textarea = oo(n);
	textarea.focus();
	if (document.selection) {
		var range = cr?cr:document.selection.createRange();
		if(b==''){
			range.text = e;
			range.moveStart('character',0-e.length);
		}else{
			var len = range.text.length;
			range.text = b + range.text + e;	
			range.moveStart('character',0-e.length-len);
			range.moveEnd('character',0-e.length);			
		}
		range.select();
	}
	else if(window.getSelection&&textarea.selectionStart>-1){
		var st = textarea.selectionStart; 
		var ed = textarea.selectionEnd; 
		var selText = b?textarea.value.substring(st,ed):'';
		textarea.value = textarea.value.substring(0,st) + b + selText + e + textarea.value.slice(ed);
		textarea.selectionStart = st + b.length;
		textarea.selectionEnd = st + b.length + (b?selText.length:e.length);
	}
	else {
		textarea.value += b+e;
	}
}

function docGetSelection(n){
	var textarea = oo(n);
	if (!isIE){
		if (textarea.selectionStart!=undefined) {
			return textarea.value.substring(textarea.selectionStart, textarea.selectionEnd);
		}
	}else{
		if(window.getSelection) return window.getSelection();
		else if (document.getSelection)return document.getSelection();
		else if (document.selection)return document.selection.createRange().text;
	}
}

function openModalWindow(url,width,height,n){
	if(isIE){
		return window.showModalDialog(url,window,"dialogWidth: "+width+"px; dialogHeight:"+height+"px; edge: Raised; center: Yes; help: No; resizable: No; status: No;");
	}else{
		window.open(url,n,"modal=yes,width="+width+"px,height="+height+"px,resizable=no,scrollbars=no");
		return null;
	}
}

function insertHTML(html, n) {
	oo("_myeditor_" + n).contentWindow.focus();

	if (isIE) {	  
		var cr = oo('_myeditor_' + n).contentWindow.document.selection.createRange()
		cr.pasteHTML(html);
		cr.select();
	}else {
		oo('_myeditor_' + n).contentWindow.document.execCommand('insertHTML',false, html);
	}	
}

function outputFontSelect(n) {
	var FontSelectObj        = ToolbarList['SelectFont'];
	var FontSelect           = FontSelectObj[1];

	var FontSelectDropDown = '<table border="0" cellpadding="0" cellspacing="0"><tr><td onmouseover="BorderOn(this)" onmouseout="BorderDown(this)" width="24" height="24" title="选择字体"><img src="' + FontSelect + '" id="selectFont' + n + '" onClick="showFonts(\'' + n + '\');"><br>';
	FontSelectDropDown += '<span id="Fonts' + n + '" class="dropdown" style="width: 145px; display:none;">';
	
	for (var i = 0; i <= Fonts.length;) {
		if (Fonts[i]) {
			FontSelectDropDown += '<button type="button" onClick="formatText(\'FontName\',\'' + n + '\',\'' + Fonts[i] + '\')\;" onMouseOver="this.className=\'mouseOver\'" onMouseOut="this.className=\'mouseOut\'" class="mouseOut" style="width: 120px;"><table cellpadding="0" cellspacing="0" border="0"><tr><td align="left" style="font-family:' + Fonts[i] + '; font-size: 12px;">' + Fonts[i] + '</td></tr></table></button><br>';	
		}  
		i++;
	}
	FontSelectDropDown += '</span></td></tr></table>';
	oo('FontSelect' + n).innerHTML = FontSelectDropDown;
};

function outputFontSizes(n) {

	var FontSizeObj        = ToolbarList['SelectSize'];
	var FontSize           = FontSizeObj[1];

	var FontSizesDropDown = '<table border="0" cellpadding="0" cellspacing="0"><tr><td onmouseover="BorderOn(this)" onmouseout="BorderDown(this)" width="24" height="24" title="选择字号"><img src="' + FontSize + '" id="selectSize' + n + '" onClick="showFontSizes(\'' + n + '\');"><br>';
	FontSizesDropDown += '<span id="Sizes' + n + '" class="dropdown" style="width:80px; display:none;">';
	
	for (var i = 1; i <= 7;i++) {
		FontSizesDropDown += '<button type="button" onClick="formatText(\'FontSize\',\'' + n + '\',\'' + i + '\')\;" onMouseOver="this.className=\'mouseOver\'" onMouseOut="this.className=\'mouseOut\'" class="mouseOut" style="width: 100%; font-family:arial"><font size="'+i+'">' + (i) + '</font></button><br>';		
	}
	FontSizesDropDown += '</span></td></tr></table>';
	oo('FontSizes' + n).innerHTML = FontSizesDropDown;
};

function outputColor(c,n){
	if(!oo(n+'_'+c+'_exp')) return false;
	var string = '<br><span id="' + c + n + '" class="dropdown" style="width: 200px;overflow:hidden;display:none;">';
	string += '<iframe name="'+c+'_win" src="'+imagesDir+'select_color.htm?color=000000&command='+c+'&_myeditor_=' + n +'" width="100%" height="140px" frameborder="0" scrolling="no" unselectable="on"></iframe></span>';
	oo(n+'_'+c+'_exp').innerHTML += string;
}

function showFonts(n) { 
	if (oo('Fonts' + n).style.display == 'block') {
		oo('Fonts' + n).style.display = 'none';
	}
	else {
		oo('Fonts' + n).style.display = 'block';
		if(dropdownID&&dropdownID!='Fonts' + n) oo(dropdownID).style.display = 'none';
		dropdownID = 'Fonts' + n;
	}
};

function showFontSizes(n) { 
	if (oo('Sizes' + n).style.display == 'block') {
		oo('Sizes' + n).style.display = 'none';
	}
	else {
		oo('Sizes' + n).style.display = 'block'; 
		if(dropdownID&&dropdownID!='Sizes' + n) oo(dropdownID).style.display = 'none';
		dropdownID = 'Sizes' + n;
	}
};

function showColor(c,n,cr) {
	if (oo(c + n).style.display == 'block') {
		oo(c + n).style.display = 'none';
	}
	else {
		oo(c + n).style.display = 'block'; 	
		if(dropdownID&&dropdownID!=c+n) oo(dropdownID).style.display = 'none';
		dropdownID = c + n;
	}
	if(cr) oo(c + n).cr = cr;
	if(oo(c + n).cr) return oo(c + n).cr;

};

function updateValues(n){
		if(viewSourceMode[n]){
			var doc = oo("_myeditor_" + n).contentWindow.document;
			doc.body.innerHTML = source_html( oo(n).value );
		}
		else{
			var doc = oo("_myeditor_" + n).contentWindow.document;	
			oo(n).value = html_source( n );
		}
}

function editor_resize(n,size){
	var obj=oo('_parent_of_'+n);
	if(size<0 && obj.offsetHeight<0-size*2) return false;
	oo(n).style.height = oo('_myeditor_' + n).style.height = obj.style.height = obj.offsetHeight + size;
}

function switchmode(n,obj)
{
	if (obj.checked)
	{
		viewSource(n);
	}
	else
	{
		viewHTML(n);
	}
}
function viewSource(n) {
	updateValues(n);
	if(viewSourceMode[n]) return;
	oo("_myeditor_" + n).style.display = 'none'; 
	oo(n).style.display = 'block';
	oo(n).focus();
	viewSourceMode[n] = 1;	
	editor_buttons_on(n);
};

function viewHTML(n) { 
	updateValues(n);
	if(!viewSourceMode[n]) return;
	oo("_myeditor_" + n).style.display = 'block'; 
	oo(n).style.display = 'none';
	oo("_myeditor_" + n).focus();
	viewSourceMode[n] = 0;
};


function html_source(n){
	//the special images ...
	var doc = oo("_myeditor_" + n).contentWindow.document;
	var images = doc.getElementsByTagName("IMG");
	for(var i=images.length-1;i>=0;i--){
		if(images[i].className=='editor_flash')
			images[i].outerHTML = '[flash='+parseInt(images[i].style.width?images[i].style.width:images[i].width)+','+parseInt(images[i].style.height?images[i].style.height:images[i].height)+']'+images[i].alt+'[/flash]';
		else if(images[i].className=='editor_video_rm')
			images[i].outerHTML = '[rm='+parseInt(images[i].style.width?images[i].style.width:images[i].width)+','+parseInt(images[i].style.height?images[i].style.height:images[i].height)+','+images[i].autoplay+']'+images[i].alt+'[/rm]';
		else if(images[i].className=='editor_video_mp')
			images[i].outerHTML = '[mp='+parseInt(images[i].style.width?images[i].style.width:images[i].width)+','+parseInt(images[i].style.height?images[i].style.height:images[i].height)+','+images[i].autoplay+']'+images[i].alt+'[/mp]';
	}
	var links = doc.getElementsByTagName("A");
	for(i=links.length-1;i>=0;i--){
		if(links[i].href && !links[i].target)
			links[i].target='_blank';
	}
	var code = doc.body.innerHTML.trim();
	return code;
}

function source_html(code){
	var specialUbbCodes = { '[flash=*,*]*[/flash]' : '<img src="'+imagesDir+'spacer.gif" width="$1" height="$2" alt="$3" class="editor_flash" />',
							 '[mp=*,*,*]*[/mp]' : '<img src="'+imagesDir+'spacer.gif" width="$1" height="$2" autoplay="$3" alt="$4" class="editor_video_mp" />',
							 '[rm=*,*,*]*[/rm]' : '<img src="'+imagesDir+'spacer.gif" width="$1" height="$2" autoplay="$3" alt="$4" class="editor_video_rm" />'
							 }

	for(var pattern in specialUbbCodes){
		var newpat = pattern.replace(/([\[\]\/])/g,'\\$1').replace(/(\*)/g,"([^\\]]+)");
		code = code.replace(new RegExp(newpat,'ig'),specialUbbCodes[pattern]);
	}
	return code;
}

function BorderDown(obj) {
	obj.style.border="none";
	obj.height="24px";
	obj.width="24px";
}

function BorderOn(obj) {
	obj.height="22px";
	obj.width="22px";
	obj.style.borderRight="1px #cccccc solid";
	obj.style.borderBottom="1px #cccccc solid";
	obj.style.borderTop="1px #F3F8FC solid";
	obj.style.borderLeft="1px #F3F8FC solid";
}
function Emote(image,n)
{
	image='<img src="' + image + '">';
	var obj=oo(n);
	if (obj==null)
	{
		n=n.replace(/(_ctl)/g,"ctl0");
		n=n.replace(/(:)/g,"$");
	}
	if(viewSourceMode[n]) insertSource('',image,n);
	else insertHTML( image ,n);
}
