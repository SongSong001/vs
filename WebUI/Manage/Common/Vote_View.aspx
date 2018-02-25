<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Vote_View.aspx.cs" Inherits="WC.WebUI.Manage.Common.Vote_View" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>用户投票</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="/js/validator.js"></script>
<link type="text/css" href="/manage/Style/InterFace.Css" rel="stylesheet" rev="stylesheet" media="all" />
<link type="text/css" href="/manage/style.css" rel="stylesheet" rev="stylesheet" media="all" />
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/manage/include/common.js"></script>    
<link href="css/jQuery.spider.poll.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/js/jQuery.spider.poll-min.js"></script>
<script type="text/javascript">
var data=<%=data %>; 
$(document).ready(function (){
	$("#poll_a").poll("poll1",{
		title:<%=title %>,
		titleColor:'red',
		width:'535px',
		data:data,
		showPoll:<%=showPoll %>,
		multiple:<%=multiple %>
	});
});	

function repayClick()
{
    if(document.getElementById("replay").value=='在这里输入投票评论')
    {document.getElementById("replay").value='';}
}

function postVote(){


var p = '';
var u = <%=Uid %>;
var v = <%=Request.QueryString["vid"] %>;
var n = $("#replay").val();
$("#poll_a").getChecked().each(function (i,n){
    p += $(n).val() +',';
});

    if(p != ''){
      if(confirm('确实要投票吗？')){  
        $.ajax({
        type:"GET",
        url:"/manage/Utils/vote.ashx",
        dataType: 'html',
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
        data: 'u='+u+'&p='+p+'&v='+v+'&n='+escape(n),
        success:function(data){
        if(data=="1"){
            alert('投票成功，谢谢参与!');
            window.location='Vote_View.aspx?vid='+v;
        } else{
            alert('网络错误，投票失败!');
            window.location='Vote_List.aspx';
         }
        }});
        
      }  
    }
    else{
    alert('您还没选择任何投票选项!');
    }    

}

</script>
</head>
<body >
    <form id="form1" runat="server" onsubmit="return Validator.Validate(this.form,1);" > 
<div id="interface_inside">
  <div id="interface_quick">
    <div class="interface_quick_left">您现在的操作 >> 我的投票 >> 用户投票</div>
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
      
<table class="table subsubmenu">
  <thead>
	<tr>
	  <td>
<a href="Vote_List.aspx">投票列表</a>
<a href="Vote_Manage.aspx">新建投票</a>
	  </td>
	  <td style="text-align:right">

	  </td>
	</tr>
  </thead>
</table>
<br />        
      
      <!-- 模块 -->
<div style="background: #fff; border: 1px solid #79B7E7; margin-left:10px; margin-right:10px;">

<div style="margin:10px;">
<span style="font-weight:bold; color:#006600;">创建者</span>：<span runat=server id=Creator style="font-weight:bold;"></span> &nbsp;&nbsp;&nbsp;
<span style="font-weight:bold; color:#006600;">时 &nbsp;&nbsp;&nbsp;间</span>：<span runat=server id=AddTime></span> &nbsp;&nbsp;&nbsp;<br>
<span style="font-weight:bold; color:#006600;">状 &nbsp;&nbsp;&nbsp;态</span>：<span runat=server id=IsValide></span> &nbsp;&nbsp;&nbsp;
<span style="font-weight:bold; color:#006600;">属 &nbsp;&nbsp;&nbsp;性</span>：<span runat=server id=ShowUser></span> &nbsp;&nbsp;&nbsp;<br>
<span style="font-weight:bold; color:#006600;">参与人</span>：<span runat=server id=namelist></span> &nbsp;&nbsp;&nbsp;<br>
<hr />
</div>
<div id="poll_a"></div>
<br>
<div runat=server visible=false id=IsVote1 style="margin:10px;">

<textarea id="replay" name="replay" rows=2 onclick=repayClick() style="overflow:hidden;float:left; padding-left:5px; width:60%;">在这里输入投票评论</textarea>
<input type=button value=' 我要投票 ' id=bt1 name=bt1 style="cursor:pointer;margin-left:3px; height:38px;border:1px #999999 solid;background:#ebf0f4;" onclick='postVote()' />

</div>
<br>
<div style="margin:10px;">
<span style="font-weight:bold; color:#006600;">评 &nbsp;&nbsp;&nbsp;论</span>：
<div runat=server enableviewstate=false id=notes style="min-height:70px;_height:70px;margin:10px 10px 1px 1px; border:1px solid #E3E197; padding:10px 10px 10px 10px; background-color: #FFFFFF;"></div>
</div>

</div>
    <!-- 模块结束 -->


    </div>
  </div>
</div>



    </form>
</body>
</html>
