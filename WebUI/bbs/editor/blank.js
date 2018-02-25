// Images Dir Path
var imagesDir = "editor/simple/";

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
	var iframe = '<table cellpadding="0" cellspacing="0" border="0" class="editor_content" width="100%"><tr><td valign="top" id="_parent_of_'+n+'" style="width:' + _myeditor_Width + '; height:' + _myeditor_Height + ';">\n'
  	+ '<iframe frameborder="0" id="_myeditor_' + n + '" scrolling="auto" style="width:100%; height:' + _myeditor_Height + '; margin:1px 0;"></iframe>\n'
  	+ '<textarea name="' + n + '" id="' + n + '" style="width:100%; height:' + _myeditor_Height + ';  display:none; border:0px; margin:0px; font-size:12px; font-family:Courier New,verdana; background-color:#F9F9F9"></textarea>'
	+ '</td></tr></table>\n';
  	document.write('<table cellpadding="0" cellspacing="0" border="0" style="BORDER-RIGHT: #c5c5c5 1px solid; BORDER-TOP: #c5c5c5 1px solid; BORDER-LEFT: #c5c5c5 1px solid; BORDER-BOTTOM: #c5c5c5 1px solid" style="width:' + _myeditor_Width + ';"><tr><td class="editor_table">' + iframe + '</td></tr></table>');

	var doc = oo("_myeditor_" + n).contentWindow.document;

	doc.open();
	if (!(isIE) && _content == "")
	{
		_content="<br>";
	}
	doc.write("<HTML><head><link href='"+imagesDir+"iframe.css' rel='stylesheet' type='text/css' /></head><BODY bgcolor='#FFFFFF'>"+_content+"</BODY></HTML>");
	doc.close();
	
	if (isIE){
		doc.body.contentEditable = true ;
		for (var idx=0; idx < document.forms.length; idx++){
	  		document.forms[idx].attachEvent('onsubmit', function() { updateValues(n); });
		}
	}else{
		doc.designMode = 'on';
		for (var idx=0; idx < document.forms.length; idx++){
			document.forms[idx].addEventListener('submit', function OnSubmit() {updateValues(n);}, true);
		}
	}
	doc.execCommand('LiveResize', false, true);
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

