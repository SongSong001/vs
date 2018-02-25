//菜单
var menuOffX=-2	//菜单距连接文字最左端距离
var menuOffY=15	//菜单距连接文字顶端距离

var steps = 10;	//下拉步数	//faisun

var ie4=document.all&&navigator.userAgent.indexOf("Opera")==-1
var ns6=document.getElementById&&!document.all
var menuobj,ondropmenuobj;

function createpopmenu(n,l,array){
	var i,str="<div id='"+n+"' class='MenuSkin'><div id='"+n+"inner' class='MenuSkinInner' onmouseout=\"dynamichide(event,'"+n+"')\">";
	for(i=0;i<array.length;i++)	
		str+="<div class='MenuItems' onmouseover=\"highlightmenu(this,'on')\" onmouseout=\"highlightmenu(this,'off');\"><a href=\""+l.replace("$BoardID",array[i][0])+"\">"+array[i][1]+"</a></div>";
	str+="</div></div>";
	document.write(str);
}

function oo(vid){
	return document.getElementById(vid);
}

function dropmenu(vmenu,th,h){
	var obj = oo(vmenu);
	if(obj.timer) clearTimeout(obj.timer);
	obj.style.height = h;
	obj.scrollTop = th;
	var newhight = Math.min(h+parseInt(th/steps),th); 
	if(newhight<th){
		obj.timer = setTimeout("dropmenu('"+vmenu+"',"+th+","+newhight+")",20);
	}else{
		menuobj = null;
	}
}

function showmenu(e,vmenu,mod){
	menuobj = oo(vmenu)
	if (menuobj && document.all)
	{
		if(window.ondropmenuobj && window.ondropmenuobj.id!=window.menuobj.id) hidemenu();
		ondropmenuobj = menuobj;
		ondropmenuobj.style.zIndex = 101;
		
		menuobjin=oo(vmenu+"inner");
		if(menuobjin.innerHTML=='') return false;
		
		menuobj.contentwidth=menuobj.offsetWidth
		eventX=e.clientX
		eventY=e.clientY
		var rightedge=document.body.clientWidth-eventX
		var bottomedge=document.body.clientHeight-eventY
		
		if (rightedge<menuobj.contentwidth)
			menuobj.style.left=document.body.scrollLeft+eventX-menuobj.contentwidth+menuOffX
		else
			menuobj.style.left=ie4? ie_x(event.srcElement)+menuOffX : ns6? window.pageXOffset+eventX : eventX
		
		if (bottomedge<menuobj.contentheight&&mod!=0)
			menuobj.style.top=document.body.scrollTop+eventY-menuobj.contentheight-event.offsetY+menuOffY-23
		else
			menuobj.style.top=ie4? ie_y(event.srcElement)+menuOffY : ns6? window.pageYOffset+eventY+10 : eventY
	
		if(menuobjin.storeValue!=1||menuobj.style.visibility=='hidden' ){	
			menuobj.style.height=1;
			menuobjin.storeValue = 1;
			dropmenu(vmenu,menuobjin.offsetHeight,1);
		}
		menuobj.style.visibility="visible"
	}
}

function risemenu(vmenu,th,h){
	if(window.menuobj && window.menuobj.id==vmenu){
		eval("dropmenu('"+vmenu+"',"+th+","+h+")");
		return false;
	}
	var obj = oo(vmenu);
	var objin=oo(vmenu+"inner");
	if(obj.timer) clearTimeout(obj.timer);
	obj.style.height = h;
	obj.scrollTop = th;
	var newhight = Math.max(h-parseInt(th/steps),0); 
	if(newhight>0){
		obj.timer = setTimeout("risemenu('"+vmenu+"',"+th+","+newhight+")",20);
	}else{
		obj.style.visibility="hidden";
	}
}

function hidemenu(){
	if (window.ondropmenuobj){
		var vmenu = ondropmenuobj.id;
		var objin=oo(vmenu+"inner");
		ondropmenuobj.style.zIndex = 100;
		risemenu(vmenu,objin.offsetHeight,window.ondropmenuobj.offsetHeight);
		//ondropmenuobj=null;
	}
}

function ie_y(e){  
	var t=e.offsetTop;  
	while(e=e.offsetParent){  
		t+=e.offsetTop;  
	}  
	return t;  
}  
function ie_x(e){  
	var l=e.offsetLeft;  
	while(e=e.offsetParent){  
		l+=e.offsetLeft;  
	}  
	return l;  
}

function highlightmenu(el,state){
	if(!el.cn) el.cn=el.className;
	el.className=(state=="on")? el.cn+" MouseoverStyle" : el.cn;
}

function dynamichide(e,vmenu){
	var obj=oo(vmenu);
	if ((ie4||ns6)&&!obj.contains(e.toElement)) hidemenu();
}
//function dynamichide(e){hidemenu()}
document.onclick = hidemenu
