var isIE = document.all;
//返回上传后的文件地址
function SetUploadValue(filename,filepath,filetype,fileid,types)
{
	filetype=filetype.toLowerCase();
	var tempfilename="";
	var imagefiletype=".gif.jpg.jpeg.bmp.png";
	if (imagefiletype.indexOf(filetype) > -1)
	{
		tempfilename="[img]" + filepath + "[/img]";
	}
	if (filetype == ".swf" || filetype == ".flv")
	{
		tempfilename="[flash=400,300]" + filepath + "[/flash]";
	}
	if (tempfilename == "")
	{
		filename=filename.replace(/\[/g,"<");
		filename=filename.replace(/\]/g,">");
		tempfilename="[download=" + filename + "]Download.aspx?ID=" + fileid + "[/download]";
	}
	var n="_ctl0:Main:Post1:_ctl0:Content";
	if (types==1)
	{
		var n="_ctl0:Main:Reply1:_ctl0:Content";
	}
	if (types==2)
	{
		var n="_ctl0:Main:PostEdit1:_ctl0:Content";
	}
	var obj=oo(n);
	if (obj==null)
	{
		n=ChangeID(n);
	}
	if (window.parent.viewSourceMode[n])
	{
		insertSource('',tempfilename,n);
	}
	else
	{
		insertHTML( tempfilename ,n);
	}
	window.location=window.document.location.search;
}
function oo(ID){
	return window.parent.document.getElementById(ID);
}
function ChangeID(ID)
{
	if (oo(ID)==null)
	{
		ID=ID.replace(/(_ctl)/g,"ctl0");
		ID=ID.replace(/(:)/g,"$");
	}
	return ID;
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
//返回上传后的头像地址
function SetUploadFaceValue(filename,fwidth,fheight)
{
    	var n=ChangeID("_ctl0:Main:ControlPanel1:_ctl0:MPhoto");
    	var obj=oo(n);
    	obj.value=filename;
    
    	n=ChangeID("_ctl0_Main_ControlPanel1__ctl0_MPhotoImage");
    	obj=oo(n);
    	obj.src=filename;
    	obj.value=filename;
    	obj.style.height=fheight;
    	obj.style.width=fwidth;
    
    	n=ChangeID("_ctl0_Main_ControlPanel1__ctl0_MPhotoHeight");
    	obj=oo(n);
    	obj.value=fheight;
    
    	n=ChangeID("_ctl0_Main_ControlPanel1__ctl0_MPhotoWidth");
    	obj=oo(n);
    	obj.value=fwidth;
	history.back(-1);
}
//引用帖子
function Quote(ReplyID,UserName,AddTime)
{
	var n="_ctl0:Main:Topic1:_ctl0:Content";
	var obj=oo(n);
	if (obj==null)
	{
		n=ChangeID(n);
	}
	if (oo(n)==null)
	{
		return false;
	}
	var html= "<div class=Quote>以下是引用 <font color=red>" + UserName+ "</font> 于 <font color=blue>" + AddTime+ " </font>的发言<br>" + oo("Post" + ReplyID).innerHTML + "</div>";
	if (window.viewSourceMode[n])
	{
		insertSource('',html,n);
	}
	else
	{
		insertHTML( html ,n);
	}
	return false;
}
//选择颜色
function SelectColor(n,ColorLabel)
{
	if (document.getElementById(n)==null)
	{
		n=ChangeID(n);
	}
	var obj=document.getElementById(n);
	if (obj != null)
	{
		var arr = showModalDialog("color.htm", "", "dialogWidth:18.5em; dialogHeight:17.5em; status:0; help:0");
		if (arr != null)
		{
			obj.value=arr;
			if (document.getElementById(ColorLabel)==null)
			{
				ColorLabel=ChangeID(ColorLabel);
			}
			var cl=document.getElementById(ColorLabel);
			if (cl != null)
			{
				cl.style.backgroundColor=arr;
			}
		}
	}
}