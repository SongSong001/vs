<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SelectDep.aspx.cs" Inherits="WC.WebUI.Manage.Utils.SelectDep" EnableViewState="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>组织机构选择</title>
<style type="text/css">
<!--
body {
    font-family: Arial, Helvetica, sans-serif;
    font-size:12px;
    color:#666666;
    background:#fff;
    text-align:center;

}

* {
    margin:0;
    padding:0;
}

a {
    color:#1E7ACE;
    text-decoration:none;    
}

a:hover {
    color:#000;
    text-decoration:underline;
}
h3 {
    font-size:14px;
    font-weight:bold;
}

pre,p {
    color:#1E7ACE;
    margin:4px;
}
input, select,textarea {
    padding:1px;
    margin:2px;
    font-size:12px/18px;
}
.buttom{
    padding:1px 3px;
    font-size:12px;
    border:1px #1E7ACE solid;
    background:#D0F0FF;
}
#formwrapper {
    width:450px;
    margin:15px auto;
    padding:20px;
    text-align:left;
    border:1px #1E7ACE solid;
}

fieldset {
    padding:10px;
    margin-top:5px;
    border:1px solid #1E7ACE;
    background:#fff;
}

fieldset legend {
    color:#1E7ACE;
    font-weight:bold;
    padding:3px 20px 3px 20px;
    border:1px solid #1E7ACE;    
    background:#fff;
}

fieldset label {
    float:left;
    width:90px;
    text-align:left;
    padding:4px;
    margin:1px;
}

fieldset div {
    clear:left;
    margin-bottom:2px;
}

.enter{ text-align:center;}
.clear {
    clear:both;
}

-->
<!--
body,table{
	font-size:12px;
}
table{
	table-layout:fixed;
	empty-cells:show; 
	border-collapse: collapse;

}z
td{
	height:20px;
}
h1,h2,h3{
	font-size:12px;
	margin:0;
	padding:0;
}

.title { background: #FFF; border: 0px solid #9DB3C5; padding: 1px; width:420px;;margin-bottom:2px; }
	.title h1 { line-height: 31px; text-align:center;  background: #2F589C url(img/th_bg2.gif); background-repeat: repeat-x; background-position: 0 0; color: #FFF; }
		.title th, .title tr { border: 1px solid #CAD9EA; padding: 5px;}


/*这个是借鉴一个论坛的样式*/
table.t1{
	border:1px solid #cad9ea;
	color:#666;
}
table.t1 th {
	background-image: url(img/th_bg1.gif);
	background-repeat::repeat-x;
	height:25px;
}
table.t1 td,table.t1 th{
	border:1px solid #cad9ea;
	padding:0 1em 0;
}
table.t1 tr.a1{
	background-color:#f5fafe;
}



table.t2{
	border:1px solid #9db3c5;
	color:#666;
}
table.t2 th {
	background-image: url(img/th_bg2.gif);
	background-repeat::repeat-x;
	height:25px;
	color:#fff;
}
table.t2 td{
	border:1px dotted #cad9ea;
	padding:0 2px 0;
}
table.t2 th{
	border:1px solid #a7d1fd;
	padding:0 2px 0;
}
table.t2 tr.a1{
	background-color:#e8f3fd;
}

table.t3{
	border:1px solid #fc58a6;
	color:#720337;
}
table.t3 th {
	background-image: url(img/th_bg3.gif);
	background-repeat::repeat-x;
	height:25px;
	color:#35031b;
}
table.t3 td{
	border:1px dashed #feb8d9;
	padding:0 1.5em 0;
}
table.t3 th{
	border:1px solid #b9f9dc;
	padding:0 2px 0;
}
table.t3 tr.a1{
	background-color:#fbd8e8;
}

-->
</style>  
<script type="text/javascript">

<!--
String.prototype.replaceAll = replaceAll;

function replaceAll(oldText,replaceText){
regExp = new RegExp(oldText,"g");//g 全局
return this.replace(regExp ,replaceText)
}

String.prototype.trim=function(){
　　    return this.replace(/(^\s*)|(\s*$)/g, "");
　　 }
//-->

function CheckAll(form)
{
    var name_txt = window.parent.document.getElementById("namelist_dep");
    var user_txt = window.parent.document.getElementById("userlist_dep");
   var objs = document.getElementsByTagName("input"); 
   var nums = 0;
    for(var i=0; i<objs.length; i++)   
    {
     var tmp_user = objs[i].value+",";
     if(objs[i].type=="checkbox" && objs[i].name !='chkAll' && objs[i].id!='chkAll' && objs[i].disabled==false)  
     { 
      objs[i].checked = form.chkAll.checked;
      if(objs[i].checked) 
      {
        if(user_txt.value.indexOf(tmp_user)==-1){
        user_txt.value += tmp_user;
        }  
        nums++;
      }
      else
      {
        user_txt.value = user_txt.value.replaceAll(tmp_user,"");
      }
     } 
    }	  
    
        var tmps = user_txt.value;
        var arr = tmps.split(',');
        name_txt.value = "";
        for(var i=0;i<arr.length;i++)
        {
            if(arr[i]!=null && arr[i]!="")
            {
                name_txt.value += arr[i].split('#')[0]+",";
            }
        }
    
    document.getElementById("number").innerHTML=nums;
 } 
 
function CheckAdd(form)
{
    var name_txt = window.parent.document.getElementById("namelist_dep");
    var user_txt = window.parent.document.getElementById("userlist_dep");
    var objs = document.getElementsByTagName("input"); 
    var nums = 0;
    for(var i=0; i<objs.length; i++)   
    {
     var tmp_user = objs[i].value+",";
     if(objs[i].type=="checkbox" && objs[i].name !='chkAll' && objs[i].id!='chkAll' && objs[i].disabled==false) 
     { 
      if(objs[i].checked) 
      {
        if(user_txt.value.indexOf(tmp_user)==-1){
        user_txt.value += tmp_user;
        }      
        nums++;
      }
      else
      {
        user_txt.value = user_txt.value.replaceAll(tmp_user,"");
      }
     } 
    }
      
        var tmps = user_txt.value;
        var arr = tmps.split(',');
        name_txt.value = "";
        for(var i=0;i<arr.length;i++)
        {
            if(arr[i]!=null && arr[i]!="")
            {
                name_txt.value += arr[i].split('#')[0]+",";
            }
        }    
      
    document.getElementById("number").innerHTML=nums;
}

function closeDiv()
{
        //updateData();
        //window.parent.document.getElementById("dialogCase").close();
        window.parent.document.getElementById("dialogCase").style.display='none';
        var name_txt = window.parent.document.getElementById("namelist");
        name_txt.focus();
}

function initdata()
{
   var tmp = window.parent.document.getElementById("userlist_dep");
   var objs = document.getElementsByTagName("input"); 
   var tmps = tmp.value.split(',');
   var nums = 0;
    for(var i=0; i<objs.length; i++)   
    {
     if(objs[i].type=="checkbox" && objs[i].name !='chkAll' && objs[i].id!='chkAll' && objs[i].disabled==false) 
     { 
      for(var j=0;j<tmps.length;j++){
        if(tmps[j].trim()!=''){
          if(tmps[j].split('#')[1] == objs[i].value.split('#')[1])
          {
            objs[i].checked = true;
            nums++;
          }
         }
        }  
     } 
    }	  
    document.getElementById("number").innerHTML=nums;
}

function clearAll()
{
    var name_txt = window.parent.document.getElementById("namelist_dep");
    var user_txt = window.parent.document.getElementById("userlist_dep");
    
   var objs = document.getElementsByTagName("input"); 
    for(var i=0; i<objs.length; i++)   
    {
     if(objs[i].type=="checkbox" && objs[i].name !='chkAll' && objs[i].id!='chkAll' && objs[i].disabled==false)  
     { 
      objs[i].checked = false;
     } 
    }
    name_txt.value = '';
    user_txt.value = '';
    document.getElementById("number").innerHTML = '0';
}

</script>   
</head>
<body style="overflow:hidden; overflow-x:hidden;overflow-y:hidden;" onload='initdata()'>
    <form id="form1" runat="server">
    
    <div style="margin-left:10px; text-align:left; margin-top:5px;">

        <p><strong>您已选择了 <span runat=server style="color:#ff0000;font-weight:bold;" id=number></span>/<span runat=server style="color:blue;font-weight:bold;" id=total></span> 个信息!</strong> 
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href=#@ onclick=clearAll() >清除已选</a>  
        </p>
        


	<table width="420px" id="Table1"  border="1" class="t1">
  <tr>
    <td  title='选中/取消选中'>
    <input name="chkAll" type="checkbox" id="chkAll" title='选中/取消选中' onclick=CheckAll(this.form) value="checkbox"> 全选 
<asp:Panel ID="panLogin" runat="server" DefaultButton="search_bt">
    
    <span style="float:right; display:none;">
    <input type="text" name="keyword"  maxlength=10  id="keyword" size=13 />
    <asp:Button runat=server ID=search_bt CssClass="buttom" OnClick=Search_Btn Text=搜索 />
    </span></asp:Panel>
    
    </td>
  </tr>
	</table>
	
<div style="width:420px;height:330px; overflow-y:scroll;border:2 inset;scrollbar-face-color: #DBEBFE; scrollbar-shadow-color: #B8D6FA; scrollbar-highlight-color: #FFFFFF; scrollbar-3dlight-color: #DBEBFE; scrollbar-darkshadow-color:#458CE4; scrollbar-track-color: #FFFFFF; scrollbar-arrow-color: #458CE4; margin-top:5px;">

<table width="400px" id="mytab"  border="1" class="t1">
  <thead>
    <th width="11%">选择</th>
    <th width="50%">组织机构名称</th>    
  </thead>

 <asp:Repeater runat=server ID=rpt><ItemTemplate>
  <tr>
    <td><input runat=server id=chk type="checkbox" value='<%# Eval("DepName").ToString().Trim() +"#" + Eval("id").ToString().Trim() + "#" + Eval("IsPosition").ToString().Trim() %>' onclick=CheckAdd(this.form) ></td>
    <td><span style="color:#006600; font-weight:bold;"><%# getstr(Eval("Ch"), Eval("DepName"))%></span></td>    

  </tr>
 </ItemTemplate></asp:Repeater>  

</table>
</div>
        
           

    </div>
    
    </form>
</body>
</html>
