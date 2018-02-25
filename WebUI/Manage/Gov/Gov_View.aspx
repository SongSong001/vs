<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Gov_View.aspx.cs" Inherits="WC.WebUI.Manage.Gov.Gov_View" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
<meta http-equiv="refresh" content="600">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>工作公文</title>    
<link type="text/css" href="/manage/Style/InterFace.Css" rel="stylesheet" rev="stylesheet" media="all" />
<link type="text/css" href="/manage/style.css" rel="stylesheet" rev="stylesheet" media="all" />
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/manage/include/common.js"></script>
<script type="text/javascript">
function keyDown()
{
var keycode=event.keyCode;
var keyChar=String.fromCharCode(keycode);
if(event.keyCode==13 && event.srcElement.type!='button' && event.srcElement.type!='submit' && event.srcElement.type!='reset' && event.srcElement.type!=''&& event.srcElement.type!='textarea')
{
event.keyCode=9;
}
};
document.onkeydown=keyDown;
</script>

<script type="text/javascript">
    function fAddAttach()
    {
        var gAttchHTML='<div><input type="file" name="attachfile"><input type="button" name="Submit" value=" 删除 " id="btnDeleteReadAttach" /></div><span></span>';
        var Attach=document.getElementById("dvReadAttach");
        var spnList=Attach.getElementsByTagName("SPAN");
        var spn=document.createElement("DIV");
        spn.innerHTML=gAttchHTML;
        spn.childNodes[0].name="attachfile[]" + spnList.length;
        Attach.appendChild(spn); //增加gAttchHTML
        fGetObjInputById(spn,"btnDeleteReadAttach").onclick=function(){fDeleteAttach(this);};
        document.getElementById("aAddAttach").innerHTML="继续添加附件";
        Attach.style.display="";
    }

    function fGetObjInputById(obj,id)
    {
        var inputList=obj.getElementsByTagName("INPUT");
        for(var i=0;i<inputList.length;i++)
        {
            if(inputList[i].id==id)
            {
            return inputList[i];
            }
        }
        return null;
    }

    function fDeleteAttach(obj)
    {
        obj.parentNode.parentNode.parentNode.removeChild(obj.parentNode.parentNode);
        var Attach=document.getElementById("dvReadAttach");
        var spnList=Attach.getElementsByTagName("SPAN");
        if(spnList.length==0)
        {
            document.getElementById("aAddAttach").innerHTML="点击添加附件";
            Attach.style.display="none";
        }
        else
        {
            document.getElementById("aAddAttach").innerHTML="继续添加附件";
        }
    }
</script> 

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
                    'rowspacingtop', 'rowspacingbottom', 'lineheight', '|', 'print', 'preview','|',
                    'customstyle', 'paragraph', 'fontfamily', 'fontsize', '|',
                    'justifyleft', 'justifycenter', 'justifyright', '|',
                    'inserttable', 'deletetable', 'insertparagraphbeforetable', 'insertrow', 'deleterow', 'insertcol', 'deletecol', 'mergecells', 'mergeright', 'mergedown', 'splittocells', 'splittorows', 'splittocols'
                ]
                ],
                    autoHeightEnabled: false, readonly: <%=ke_isread %>
                });
            });
    </script>

<script type="text/javascript" language="javascript">

    function SetSeal() {
        var s = $("#seallist").val();
        var p = $("#pwd").val();
        $.ajax({
            type: "GET",
            url: "/manage/Utils/Seal.ashx",
            dataType: 'html',
            data: 's=' + s + '&p=' + p,
            success: function (data) {
                if (data != "1") {
                    UE.getEditor('DocBody').execCommand('insertHtml', "<img src=" + data + " />");
                } else {
                    alert('密码错误!');
                }
            }
        });

    }
</script> 

</head>
<body >
    <form id="myform" name="myform" runat="server" onkeypress=keyDown() enctype="multipart/form-data">
<div id="interface_inside">
  <div id="interface_quick">
    <div class="interface_quick_left">您现在的操作 >> 我的公文 >> 发文审核/查阅</div>
    <div class="interface_quick_right">
    <a href="javascript:void(0)" onclick="javascript:window.location.replace(window.location.href);"><img style="vertical-align:middle;" src="/manage/images/reload.png" /><strong>刷新</strong></a>
    &nbsp; &nbsp;
    <a href="javascript:history.back();"><img style="vertical-align:middle;" src="/manage/images/ico_up1.gif" /><strong>后退</strong></a>  
    </div>
    <div class="clearboth"></div>
  </div>
  <div id="interface_main">
    <div id="tabs_config" class="tabsbox">

      <div class="clearboth"></div>
      
      
      <!-- 模块 -->
        <table width="100%" border="0" cellspacing="0" cellpadding="0" >
          <tr>
            <td>
            
 <div id="config_basic1" class="tabs_wrapper">
<div class="tabs_main" align="left">  
<div id="PanelConfig">

<table class="table subsubmenu">
  <thead>
	<tr>
	  <td>
<a href="/Manage/gov/gov_Manage.aspx" >发文拟稿</a>
<a href="TypeList_ForView.aspx">分类导航</a>
<a href="/Manage/gov/Gov_List.aspx?action=verify">我的审批( <span id=wdpy runat=server style="color:#ff0000; font-weight:bold;">0/0</span> ) </a>
<a href="/Manage/gov/Gov_List.aspx?action=verified">已经批阅( <span id=yjpy runat=server style="font-weight:bold;">0</span> )</a>
<a href="/Manage/gov/Gov_List.aspx?action=apply">我的发文( <span id=wdsq runat=server style="font-weight:bold;">0</span> )</a>
	  </td>
	  <td style="text-align:right">

	  </td>
	</tr>
  </thead>
</table>
<br />             
    
<table class="table1">
	<thead>
	<tr>
		<td style="width:10px;"></td>
		<td><span style="color:#ff0000;font-size:12pt; font-weight:bolder;" id=Flow_Name1 runat=server>公文审核.</span>
		</td>
	</tr>
	</thead>
	<tr>
		<th style="width:10px;"></th>
		<td style="color:#000">
		<span style="color:#006600; font-weight:bold;">公文状态：</span>&nbsp;<span style="color:#ff0000; font-weight:bold;" runat=server id=status></span> &nbsp;&nbsp; &nbsp;&nbsp;
		<span style="color:#006600; font-weight:bold;">公文密级：</span>&nbsp;<span style="color:#000; font-weight:bold;" runat=server id=secret></span> &nbsp;&nbsp; &nbsp;&nbsp;
		<span style="color:#006600; font-weight:bold;">发文字号：</span>&nbsp;<span style="color:#000; " runat=server id=DocNo></span> &nbsp;&nbsp; &nbsp;&nbsp;
        <span style="color:#006600; font-weight:bold;">公文分类：</span>&nbsp;<span style="color:#000; " runat=server id=ModelType></span> <br>
		<span style="color:#006600; font-weight:bold;">拟稿人员：</span>&nbsp;<span style="color:#000; " runat=server id=creator></span> &nbsp;&nbsp; &nbsp;&nbsp;
		<span style="color:#006600; font-weight:bold;">查看图例：</span>&nbsp;<span style="color:#000; " runat=server id=tuli></span> <br>
		<span style="color:#006600; font-weight:bold;">拟稿日期：</span>&nbsp;<span style="color:#000; " runat=server id=addtime></span> &nbsp;&nbsp; &nbsp;&nbsp;
		<span style="color:#006600; font-weight:bold;">归档日期：</span>&nbsp;<span style="color:#000; " runat=server id=vlidtime></span><br>
		<span style="color:#006600; font-weight:bold;">当前环节：</span>&nbsp;<span style="color:#000; font-weight:bold;" runat=server id=currentstepname></span> &nbsp;&nbsp; &nbsp;&nbsp;
		<span style="color:#006600; font-weight:bold;">当前环节审批人：</span>&nbsp;<span style="color:#000; " runat=server id=currentuserlist></span>
		</td>
	</tr>
	
	<tr>
		<th style="width:10px;"></th>
		<td><span style="color:#0099ff; font-weight:bold; font-size:10pt">该公文正文：</span> &nbsp;&nbsp;<span><a target=_blank href=DocBodyView.aspx?fid=<%=Request.QueryString["fl"] %>>>>查看打印</a></span>
        <div style="margin:10px 10px 10px 1px; border:1px solid #bddbef; padding:0px 10px 10px 10px;">
        <input type=hidden runat=server id=filepath name=filepath />
        <div align=center>
        <textarea id="DocBody" style="width: 780px;" runat="server" ></textarea>
        </div>
		</td>
	</tr>
	
	<tr>
		<th style="width:10px;"></th>
		<td><span style="color:#0099ff; font-weight:bold;">该公文说明：</span><br>
        <div runat=server id=bodys style="margin:10px 10px 10px 1px; border:1px solid #E3E197; padding:0px 10px 10px 10px; background-color: #FFFFDD;"></div>
		</td>
	</tr>	
	
	<tr>
		<th style="width:10px;"></th>
		<td><span style="color:#0099ff; font-weight:bold;">该公文附件：</span><br>
		
		&nbsp;&nbsp;<div style="text-align:left; float:left; margin-top:1px;">
		<asp:Repeater runat=server ID=rpt><ItemTemplate>
		<input runat=server id=chk type="checkbox" checked=checked value=<%#Eval("Tmp1") %> disabled=disabled />
		<%#Eval("Tmp2") %> &nbsp;&nbsp;&nbsp;&nbsp;<a href='/Manage/Utils/Download.aspx?destFileName=<%# Server.UrlEncode(Eval("Tmp3")+"") %>' ><img src='/img/mail_attachment.gif' />下载附件</a>
		
		<br>
	    </ItemTemplate></asp:Repeater></div>
	    
		</td>
	</tr>
	
	<tr>
	    <th style="width:10px;"></th>
	    <td><span style="color:#0099ff; font-weight:bold;">签收人员列表(<%=qsrscount %>)：</span><a href='#@' onclick=$("#yjj").slideToggle("fast") >[点击查看]</a><br>
	    <div style="display:none;" id=yjj><%=qsrs %></div>
	    <br />
	    </td>
	</tr>		
		
	<tr>
	    <th style="width:10px;"></th>
	    <td><span style="color:#0099ff; font-weight:bold;">公文审核意见列表：</span><a target=_blank href='Gov_ViewTable.aspx?fl=<%=Request.QueryString["fl"] %>'>[查看打印]</a><br>
	    <%=yjs %>
	    <br />
	    </td>
	</tr>	
		

</table>   
<br />
<asp:Panel runat=server ID=display Visible=false>
<table class="table">
<tr runat=server visible=false id=seal enableviewstate=false>
	<th style="width:10px;"></th>
	<td><span style="font-weight:bold;">电子印章(签名)：</span> 使用步骤：1、选择您的印章 2、输入印章密码 3、鼠标点击文档,移动光标到适当位置(印章处=当前光标处) 4、点击按钮<br>
    <br><u>选择印章</u> <asp:DropDownList runat=server ID=seallist EnableViewState=false></asp:DropDownList> &nbsp;&nbsp;&nbsp;
    <u>印章密码</u> <input type=password id=pwd /> &nbsp;&nbsp;&nbsp;
     <input type=button id=btt value=确定印章 onclick=SetSeal() class="textbutton" /> &nbsp;(印章可任意拖拽位置)
	</td>
</tr>	
<tr>
	<th style="width:10px;"></th>
	<td>
	<span style="color:Black; font-weight:bold;">我要发表审批意见：</span><br>
	<textarea name=FlowRemark id=FlowRemark rows=3 style="margin:10px 10px 10px 1px; border:1px solid #999; padding:0px 10px 10px 10px; background-color: #fff; width:97%;"></textarea>
	</td>
</tr>
<tr style="display:none;">
	<th style="width:10px;"></th>
	<td><span style="color:#000; font-weight:bold;">我要补充公文附件：</span>
	&nbsp;&nbsp;<span style="font-weight:bold;"><a href="javascript:fAddAttach();" id="aAddAttach">点击添加附件</a></span>
	<br />
	<div runat=server id="dvReadAttach" style="float:left;"></div>	        
	</td>
</tr>
</table>

    
  <br />
<div style="text-align:center;">
	<asp:Button runat=server id=b1 OnClick=VerifyStep_Btn CssClass="buttoms" Text='我要批准' OnClientClick="return confirm('确实要批准吗？')" Enabled=false />&nbsp;&nbsp; 
	<asp:Button runat=server ID=b2 OnClick=RefuseStep_Btn CssClass="buttoms" Text='我不同意' OnClientClick="return confirm('确实不同意吗？公文审核将被打回至上个环节!')" Enabled=false />&nbsp;&nbsp;
	<asp:Button runat=server ID=b3 OnClick=CompleteStep_Btn CssClass="buttoms" Text='强制签发公文' OnClientClick="return confirm('确实要强制签发吗？')" Enabled=false />&nbsp;&nbsp;  
	&nbsp;&nbsp; 
</div>   
</asp:Panel>
    

    <br /><br />
    
              </div></div>
            </div></td>
          </tr>
        </table>

      <!-- 模块 -->

    </div>
  </div>
</div>    
    </form>
</body>
</html>
