<%@ Page Language="C#" EnableViewState="false" AutoEventWireup="true" CodeBehind="SelectPeople_r.aspx.cs" Inherits="WC.WebUI.Mobile.Utils.SelectPeople_r" %>


<html>
<head id="Head1" runat="server">
<title>人员选择</title>
    <meta content="yes" name="apple-mobile-web-app-capable" />
    <meta content="index,follow" name="robots" />
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
    <link href="../Style/Mobile/pics/homescreen.gif" rel="apple-touch-icon" />
    <meta content="minimum-scale=1.0, width=device-width, maximum-scale=0.6667, user-scalable=no"
        name="viewport" />
<style type="text/css">
<!--
body {
    font-family: Arial, Helvetica, sans-serif;
    font-size:12pt;
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
    font-size:12pt/18pt;
}
.buttom{
    padding:1px 3px;
    font-size:12pt;
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
	font-size:12pt;
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

}
table.t3 th{
	border:1px solid #b9f9dc;

}
table.t3 tr.a1{
	background-color:#fbd8e8;
}

-->
</style>  

<script type="text/javascript">

<!--
    String.prototype.replaceAll = replaceAll;

    function replaceAll(oldText, replaceText) {
        regExp = new RegExp(oldText, "g"); //g 全局
        return this.replace(regExp, replaceText)
    }

    String.prototype.trim = function () {
        return this.replace(/(^\s*)|(\s*$)/g, "");
    }
    //-->

    function CheckAll(form) {
        var name_txt = window.parent.document.getElementById("namelist");
        var user_txt = window.parent.document.getElementById("userlist");
        var objs = document.getElementsByTagName("input");
        var nums = 0;
        for (var i = 0; i < objs.length; i++) {
            var tmp_user = objs[i].value + ",";
            if (objs[i].type == "checkbox" && objs[i].name != 'chkAll' && objs[i].id != 'chkAll' && objs[i].disabled == false) {
                objs[i].checked = form.chkAll.checked;
                if (objs[i].checked) {
                    if (user_txt.value.indexOf(tmp_user) == -1) {
                        user_txt.value += tmp_user;
                    }
                    nums++;
                }
                else {
                    user_txt.value = user_txt.value.replaceAll(tmp_user, "");
                }
            }
        }

        var tmps = user_txt.value;
        var arr = tmps.split(',');
        name_txt.value = "";
        for (var i = 0; i < arr.length; i++) {
            if (arr[i] != null && arr[i] != "") {
                name_txt.value += arr[i].split('#')[0] + "(" + arr[i].split('#')[2] + "),";
            }
        }

        document.getElementById("number").innerHTML = nums;
    }

    function CheckAdd(form) {
        var name_txt = window.parent.document.getElementById("namelist");
        var user_txt = window.parent.document.getElementById("userlist");
        var objs = document.getElementsByTagName("input");
        var nums = 0;
        for (var i = 0; i < objs.length; i++) {
            var tmp_user = objs[i].value + ",";
            if (objs[i].type == "checkbox" && objs[i].name != 'chkAll' && objs[i].id != 'chkAll' && objs[i].disabled == false) {
                if (objs[i].checked) {
                    if (user_txt.value.indexOf(tmp_user) == -1) {
                        user_txt.value += tmp_user;
                    }
                    nums++;
                }
                else {
                    user_txt.value = user_txt.value.replaceAll(tmp_user, "");
                }
            }
        }

        var tmps = user_txt.value;
        var arr = tmps.split(',');
        name_txt.value = "";
        for (var i = 0; i < arr.length; i++) {
            if (arr[i] != null && arr[i] != "") {
                name_txt.value += arr[i].split('#')[0] + "(" + arr[i].split('#')[2] + "),";
            }
        }

        document.getElementById("number").innerHTML = nums;
    }

    function closeDiv() {
        //updateData();
        //window.parent.document.getElementById("dialogCase").close();
        window.parent.document.getElementById("dialogCase").style.display = 'none';
        var name_txt = window.parent.document.getElementById("namelist");
        name_txt.focus();
    }

    function initdata() {
        var tmp = window.parent.document.getElementById("userlist");
        var objs = document.getElementsByTagName("input");
        var tmps = tmp.value.split(',');
        var nums = 0;
        for (var i = 0; i < objs.length; i++) {
            if (objs[i].type == "checkbox" && objs[i].name != 'chkAll' && objs[i].id != 'chkAll' && objs[i].disabled == false) {
                for (var j = 0; j < tmps.length; j++) {
                    if (tmps[j].trim() != '') {
                        if (tmps[j].split('#')[1] == objs[i].value.split('#')[1]) {
                            objs[i].checked = true;
                            nums++;
                        }
                    }
                }
            }
        }
        document.getElementById("number").innerHTML = nums;
    }

    function selectAll() {
        var name_txt = window.parent.document.getElementById("namelist");
        var user_txt = window.parent.document.getElementById("userlist");

        var objs = document.getElementsByTagName("input");
        for (var i = 0; i < objs.length; i++) {
            if (objs[i].type == "checkbox" && objs[i].name != 'chkAll' && objs[i].id != 'chkAll' && objs[i].disabled == false) {
                objs[i].checked = true;
            }
        }
        name_txt.value = document.getElementById("allnamelist").value;
        user_txt.value = document.getElementById("alluserlist").value;
        document.getElementById("number").innerHTML = document.getElementById("allcount").value;
    }

    function clearAll() {
        var name_txt = window.parent.document.getElementById("namelist");
        var user_txt = window.parent.document.getElementById("userlist");

        var objs = document.getElementsByTagName("input");
        for (var i = 0; i < objs.length; i++) {
            if (objs[i].type == "checkbox" && objs[i].name != 'chkAll' && objs[i].id != 'chkAll' && objs[i].disabled == false) {
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
    <input type=hidden id=alluserlist name=alluserlist runat=server enableviewstate=false />
    <input type=hidden id=allnamelist name=allnamelist runat=server enableviewstate=false />
    <input type=hidden id=allcount name=allcount runat=server enableviewstate=false />   

    <div style="width:100%; text-align:left; ">
        <asp:Panel ID="panLogin" runat="server" DefaultButton="search_bt">
        <p><span> 
    <a href=#@ onclick=clearAll() >清除已选</a>
    &nbsp; &nbsp; <strong>您当前已选 <span runat=server style="color:#ff0000;font-weight:bold;" id=number></span>/<span runat=server style="color:blue;font-weight:bold;" id=total></span> 个</strong>   
        <br />
    <input type="text" name="keyword"  maxlength=10  id="keyword" size=11 />
    <asp:Button runat=server ID=search_bt CssClass="buttom" OnClick=Search_Btn Text='搜 索' /><SPAN style='font-size:9pt'> (姓名/部门)<SPAN>  
        </p></asp:Panel>
        

<table style='width:100%;' id="Table1"  border="1" class="t1">
  <tr>
    <td width="15%" title='选中/取消选中'>
    <input style='zoom:160%' name="chkAll" type="checkbox" id="chkAll" title='选中/取消选中' onclick=CheckAll(this.form) value="checkbox">
    </td>
    <td><span style="float:left; display:none">
    <asp:DropDownList runat=server ID=DepTree AutoPostBack=false></asp:DropDownList>
    </span>
    </td>
  </tr>
	</table>
	
<div style="height:380px;overflow: auto; overflow-x:hidden; border:2 inset;scrollbar-face-color: #DBEBFE; scrollbar-shadow-color: #B8D6FA; scrollbar-highlight-color: #FFFFFF; scrollbar-3dlight-color: #DBEBFE; scrollbar-darkshadow-color:#458CE4; scrollbar-track-color: #FFFFFF; scrollbar-arrow-color: #458CE4; ">

<table style=' width:100%;overflow: auto; overflow-x:hidden' id="mytab"  border="1" class="t1">
  <thead>
    <th style='width:45px;'>选择</th>
    <th style='width:85px;'>姓名</th>    
    <th>组织机构</th>
  </thead>

 <asp:Repeater runat=server ID=rpt><ItemTemplate>
  <tr>
    <td><input style='zoom:2' runat=server id=chk type="checkbox" value='<%# Eval("RealName").ToString().Trim()+"#"+Eval("id").ToString().Trim()+"#"+Eval("DepName").ToString().Trim() %>' onclick=CheckAdd(this.form) ></td>
    <td><span style="color:Black; font-weight:bold;"><%#Eval("RealName") %></span></td>    
    <td>
    <span style="float:left; color:#006600; font-weight:bold;">
    <%#Eval("DepName") %></span>
    </td>
  </tr>
 </ItemTemplate></asp:Repeater>  

</table>
</div>
        
           

    </div>
    </form>
    
</body>
</html>
