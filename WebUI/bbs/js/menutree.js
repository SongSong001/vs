
document.write("<style type='text/css'>.hideme{overflow: visible;display:none;} .showme{overflow: visible;display:block;} .faisunMenu td{font-size:12px;} </style>");
	
function MenuTree(treeNo){

	this.iconfolder = "images/menutree/";

	this.treeNodes = new Array();
	this.treeStatus = new Array();
	
	this.showhideit = function(n,i){

		var itemNo = n+'_'+i;

		var showfolder=document.images["openedfolderimage"+itemNo];
		var hidefolder=document.images["closedfolderimage"+itemNo];
		var subfiles=document.getElementById("item"+itemNo);
		if(subfiles.className=="hideme") {
			hidefolder.className="hideme";
			showfolder.className="showme";
			subfiles.className="showme";
		}
		else {
			showfolder.className="hideme";
			hidefolder.className="showme";
			subfiles.className="hideme";
		}

	}

	this.addtree = function(sublen,text,url,target){
		var node = { 'l':sublen,'t':text,'u':url,'tg':target,'c':0 }
		this.treeNodes.push(node);
	}

	this.createtree = function(){
		var lastLen = 0;
		var newNodes = new Array();
		var endNode = new Array();
		var openedNodes = new Array();

		for(var i=this.treeNodes.length-1;i>=0;i--){
			var node = this.treeNodes[i];
			var l = node['l'].replace('*','').length;
			this.treeStatus[i] = 0;
			if(l<lastLen){ //有子目录
				endNode[lastLen] = 0;
				this.treeStatus[i] += 1;
			}
			if(!endNode[l]){ //结束位置
				endNode[l] = 1;
				this.treeStatus[i] += 2;
			}
			lastLen = l;
		}
		
		var echo="<div class='faisunMenu'>";
		for(i=0;i<this.treeNodes.length;i++){
			var node = this.treeNodes[i];
			var l = node['l'].replace('*','').length;
			var newtext = node['t'];
			var havechild = this.treeStatus[i] % 2;

			if( this.treeStatus[i]==2 || this.treeStatus[i]==3 ){
				openedNodes[l]=0;
				var barstatus=2;
			}else{
				openedNodes[l]=1;
				var barstatus=1;		 
			}
			var li=i-1;
			
			var showme = (i==0?0:this.treeNodes[li]['l'].indexOf('*')!=-1);

			var openfold = (node['l'].indexOf('*')!=-1);			
			
			if(i>0&&(this.treeStatus[li]==1||this.treeStatus[li]==3)){
				echo += "<div id='item"+treeNo+'_'+li+"' class='"+(showme?"showme":"hideme")+"'>";
			}
			echo += "<table border='0' cellspacing='0' cellpadding='0' onselectstart='return false;'><tr>\n";
			for(j=0;j<l;j++){
				echo += "<td width='20' valign=bottom><img src='"+this.iconfolder+(openedNodes[j]?"bar3.gif":"spacer.gif")+"' width='20' height='20'></td>\n";
			}

			if(havechild){
				var menubarNo = 2;
				if(i==0) menubarNo = 1;
				else if(this.treeStatus[i]>=2) menubarNo = 3;

				var clicktoshowhide=" onclick='var m=new MenuTree();m.showhideit(\""+treeNo+"\","+i+")' style='cursor:pointer;' ";
				echo += "<td width='20' valign=bottom "+clicktoshowhide+"><img name='openedfolderimage"+treeNo+"_"+i+"' src='"+this.iconfolder+"menubar_off_"+menubarNo+".gif' class='"+(openfold?"showme":"hideme")+"' width='20' height='20'><img name='closedfolderimage"+treeNo+"_"+i+"' src='"+this.iconfolder+"menubar_on_"+menubarNo+".gif' class='"+(openfold?"hideme":"showme")+"' width='20' height='20'></td>";
				echo += "<td width='20' valign=bottom "+clicktoshowhide+"><img src='"+this.iconfolder+"folder.gif'></td><td nowrap valign=bottom><a onmousedown='return false;' "+clicktoshowhide+" "+(node['u']?"href='"+node['u']+"'":"name='#'")+" target='"+node['tg']+"'>"+newtext+"</a></td></tr></table>\n\n";	
			}else{
				if(l>0){
					echo += "<td width='20' valign=bottom><img src='"+this.iconfolder+"bar"+barstatus+".gif' width='20' height='20'></td>";
				}			
				echo += "<td nowrap valign=bottom>&nbsp;<a onmousedown='return false;' "+(node['u']?"href='"+node['u']+"'":"name='#'")+" target='"+node['tg']+"'>"+newtext+"</a></td></tr></table>\n\n";	
				
			}
			
			if(barstatus==2&&!havechild){
				for(j=l;j>=0;j--){
					if(!openedNodes[j]) echo += "</div>";else break;
				}
			}			
		}
		echo += "</div>";
		document.write(echo);
		
	}

} 