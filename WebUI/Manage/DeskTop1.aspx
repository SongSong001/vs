<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DeskTop1.aspx.cs" Inherits="WC.WebUI.Manage.DeskTop1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
<meta http-equiv="refresh" content="600">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>我的桌面</title>
<LINK rel=stylesheet type=text/css href="Info_aspx_files/css.css">
<script type="text/javascript" src="/js/jquery.js"></script> 
<script type="text/javascript" src="include/common.js"></script>

<script type="text/javascript" src="/js/popup/popup.js"></script>
<script type="text/javascript">
    function changePwd() {
        var pop = new Popup({ contentType: 1, scrollType: 'yes', isReloadOnClose: false, width: 535, height: 300 });
        pop.setContent("contentUrl", "/Manage/Common/User_PwdEdit.aspx");
        pop.setContent("title", "个人密码修改");
        pop.build();
        pop.show();
    }
    function personView() {
        var pop = new Popup({ contentType: 1, scrollType: 'yes', isReloadOnClose: false, width: 585, height: 465 });
        pop.setContent("contentUrl", '/manage/Sys/User_View.aspx?uid=<%=Uid %>');
        pop.setContent("title", "个人资料预览");
        pop.build();
        pop.show();
    }
</script> 
</head>
<body >

<DIV class='divv'>
<TABLE cellSpacing=0 cellPadding=0 width="100%" align=center style="BORDER-BOTTOM: #bbdde5 1px solid;BORDER-LEFT: #bbdde5 1px solid;BORDER-TOP: #bbdde5 1px solid; BORDER-RIGHT: #bbdde5 1px solid; ">
<TBODY>
<TR class=info1>
<TD style="PADDING-LEFT: 8px" height=28 width="58%">您好,<strong><%=UserName+" ("+RealName+")" %></strong><SPAN 
style="PADDING-LEFT: 8px">欢迎您!</SPAN>
<span style="PADDING-LEFT: 8px">
[ <span style="color:#2a7aca; font-weight:bold; cursor:hand;"><a href="#@" onclick="personView()">查看资料</a></span> ] 
[ <span style="color:#2a7aca; font-weight:bold; cursor:hand;"><a href="#@" onclick="changePwd()">修改密码</a></span> ] 
[ <span style="color:#2a7aca; font-weight:bold; cursor:hand;"><a href="#@" onclick="window.parent.addTab('机构导航','Common/DepGuide.aspx','icon-import')" >机构导航</a></span> ] 
</span></TD>
<TD style="width:42%;">
<asp:Panel runat=server ID=TipsState Visible=false>
<SCRIPT type=text/javascript >
var marqueecontent = new Array();
<%=script %>
var marqueeInterval = new Array(); var marqueeId = 0; var marqueeDelay = 3000; var marqueeHeight = 17;
function initMarquee() {var str = marqueecontent[0];
document.write('<div id="marqueeBox" style="float:left;margin: 0px; font-weight:bold; line-height: 140%; text-align:center;overflow:hidden;width:98%;height:' + marqueeHeight + 'px" onmouseover="clearInterval(marqueeInterval[0])" onmouseout="marqueeInterval[0]=setInterval(\'startMarquee()\',marqueeDelay)"><div>' + str + '</div></div>'); marqueeId++;
marqueeInterval[0] = setInterval("startMarquee()", marqueeDelay);}
function startMarquee() {
var str = marqueecontent[marqueeId];marqueeId++;
if (marqueeId >= marqueecontent.length) marqueeId = 0;
if (document.getElementById("marqueeBox").childNodes.length == 1) {
var nextLine = document.createElement('DIV');nextLine.innerHTML = str;
document.getElementById("marqueeBox").appendChild(nextLine);} else {
document.getElementById("marqueeBox").childNodes[0].innerHTML = str;
document.getElementById("marqueeBox").appendChild(document.getElementById("marqueeBox").childNodes[0]);
document.getElementById("marqueeBox").scrollTop = 0;}
clearInterval(marqueeInterval[1]); marqueeInterval[1] = setInterval("scrollMarquee()", 20);}
function scrollMarquee() {document.getElementById("marqueeBox").scrollTop++;
if (document.getElementById("marqueeBox").scrollTop % marqueeHeight == (marqueeHeight - 1)) { clearInterval(marqueeInterval[1]);}} initMarquee(); 
</SCRIPT>
</asp:Panel>
</TD></TR></TBODY></TABLE>

<TABLE style="MARGIN-TOP: 7px;" cellSpacing=0 cellPadding=0 width="100%" 
align=center>
<TBODY>
<TR>
<TD vAlign=top>
<TABLE cellSpacing=0 cellPadding=0 width="100%" align=center>
<TBODY>
<TR>
<TD vAlign=top width="51%">
<TABLE class=tx border=0 cellSpacing=0 cellPadding=0 width="98%">
<TBODY>
<TR>
<TD height=21 background=Info_aspx_files/link_3.gif width=7 
noWrap>
<DIV style="WIDTH: 7px"></DIV></TD>
<TD background=Info_aspx_files/linkbg2.gif width="100%"><span style="font-weight:bold; color:#ff0000;">&nbsp;我的资讯</span> 
</TD>
<TD height=21 background=Info_aspx_files/link_4.gif width=7 
noWrap>
<DIV style="WIDTH: 7px"></DIV></TD></TR>
<TR>
<TD background=Info_aspx_files/link_3_1.gif></TD>
<TD height=100>
<TABLE style="padding-left:4px;" border=0 cellSpacing=0 
cellPadding=0 width="100%" align=center>
<TBODY>
<%=qyzx %>

<TR>
<TD align="right" class="t2">
<span style="margin-right:15px; "><a href="#@" onclick="window.parent.addTab('所有资讯','News/News_List.aspx','icon-paste')" >更多工作资讯</a></span>
</TD>
</TR>				

</TBODY></TABLE></TD>
<TD background=Info_aspx_files/link_4_1.gif></TD></TR>
<TR>
<TD class=info2 height=1 colSpan=3><IMG 
src="Info_aspx_files/a.gif" width=1 
height=1></TD></TR></TBODY></TABLE></TD>
<TD vAlign=top width="49%">
<TABLE class=tx border=0 cellSpacing=0 cellPadding=0 width="100%">
<TBODY>
<TR>
<TD height=21 background=Info_aspx_files/link_3.gif width=7 
noWrap>
<DIV style="WIDTH: 7px"></DIV></TD>
<TD background=Info_aspx_files/linkbg2.gif width="100%"><span style="font-weight:bold; color:#ff0000;">&nbsp;统计信息 </span>
</TD>
<TD height=21 background=Info_aspx_files/link_4.gif width=7 
noWrap>
<DIV style="WIDTH: 7px"></DIV></TD></TR>
<TR>
<TD background=Info_aspx_files/link_3_1.gif></TD>
<TD height=120>
<TABLE style="padding-left:4px;" border=0 cellSpacing=0 
cellPadding=0 width="100%">
<TBODY>
<TR>
<TD height=24><img src='/img/al.gif' style='border:0px;height:12px;' />
<a href="#@" onclick="window.parent.addTab('所有资讯','News/News_List.aspx','icon-paste')"  title='最近三个月有 <%=news_num %> 条资讯'> 『我的资讯』：(<span style='color:#ff0000'> <%=news_num %> </span>)</a> &nbsp;&nbsp;&nbsp;&nbsp;
<a href="#@" onclick="window.parent.addTab('发布资讯','news/News_Manage.aspx','icon-addnew')" title='点击发布资讯'>发布资讯</a>
</TD></TR>
<TR>
<TD height=24><img src='/img/al.gif' style='border:0px;height:12px;' />
<a href="#@" onclick="window.parent.addTab('收件箱','Common/Mail_List.aspx?fid=0','icon-data3')" title='未读邮件(<%=mails_num1 %>) / 所有收件(<%=mails_num2 %>)'> 
『内部邮件』：( <span style='color:#ff0000'><%=mails_num1 %></span>/<%=mails_num2 %> )</a> &nbsp;&nbsp;&nbsp;&nbsp;<a href="#@" onclick="window.parent.addTab('发送新邮件','Common/Mail_Manage.aspx','icon-addnew')" title='点击撰写新邮件'>撰写新邮件</a>
</TD></TR>
<TR>
<TD height=24><img src='/img/al.gif' style='border:0px;height:12px;' />
<a href="#@" onclick="window.parent.addTab('我的流程','flow/Flow_List.aspx?action=verify','icon-html')" title='待我批阅的流程(<%=flows_num1 %>) / 我申请的流程(<%=flows_num2 %>)'> 
『工作流程』：( <span style='color:#ff0000'><%=flows_num1 %></span>/<%=flows_num2 %> )</a> &nbsp;&nbsp;&nbsp;&nbsp;<a href="#@" onclick="window.parent.addTab('新建工作流程','flow/Flow_Manage.aspx','icon-addnew')" title='点击创建新的工作流程'>新建工作流程</a>
</TD></TR>
<TR>
<TD height=24><img src='/img/al.gif' style='border:0px;height:12px;' />
<a href="#@" onclick="window.parent.addTab('公文审批','gov/Gov_List.aspx?action=verify','icon-password')" title='总计有 <%=shared_num %> 件需要我批阅的公文'> 『公文批阅』：( <span style='color:#ff0000'><%=shared_num %></span> )</a> &nbsp;&nbsp;&nbsp;&nbsp;<a href="#@" onclick="window.parent.addTab('公文签收','gov/Gov_Recipient.aspx?action=verify','icon-et')" title='总计有 <%=shared_num2 %> 件需要我签收的公文'> 
『公文签收』：( <span style='color:#ff0000'><%=shared_num2 %></span> )</a>
</TD></TR>
<TR>
<TD height=24><img src='/img/al.gif' style='border:0px;height:12px;' />
<a href="#@" onclick="window.parent.addTab('所有参与任务','Tasks/Task_List.aspx?type=all','folder')" title='需执行的任务(<%=exe_num %>) / 需管理的任务(<%=man_num %>)'> 
『工作任务』：( <%=exe_num %>/<font color='#ff0000'><%=man_num%></font> )</a> &nbsp;&nbsp;&nbsp;&nbsp;<a href="#@" onclick="window.parent.addTab('新建工作任务','Tasks/Task_Manage.aspx','icon-addnew')" title='点击创建新的工作任务'>新建工作任务</a>
</TD></TR>
            <TR>
<TD height=24><img src='/img/al.gif' style='border:0px;height:12px;' />
<a href="#@" onclick="window.parent.addTab('我的文档','doc/Doc_List.aspx?action=mydoc','icon-folder')"> 
『我的文档』：( <span style='color:#ff0000'><%=mydoc_num %></span> )</a> 
&nbsp;&nbsp;&nbsp;&nbsp;<a href="#@" onclick="window.parent.addTab('电子档案查询','Paper/PaperList.aspx','icon-template')" title='电子档案'>『电子档案』</a>
</TD></TR>
        <TR>
<TD height=24><img src='/img/al.gif' style='border:0px;height:12px;' />
<a href="#@" onclick="window.parent.addTab('我的论坛','/bbs/index.aspx','icon-color')" title='今天总计有 <%=forum_num %>个论坛帖子'> 
『我的论坛』：( <span style='color:#ff0000'><%=forum_num%></span> )</a> &nbsp;&nbsp;&nbsp;
<a href="#@" onclick="window.parent.addTab('工作汇报','Common/WorkLog_List.aspx?action=mydoc','icon-com')"> 
工作汇报</a> &nbsp;
<a href="#@" onclick="window.parent.addTab('他人汇报','Common/WorkLog_List.aspx?action=shared','icon-com')" > 
他人汇报</a> &nbsp;
<a href="#@" onclick="window.parent.addTab('新建汇报','Common/WorkLog_Manage.aspx','icon-com')" > 
新建汇报</a>
</TD></TR>
<TR>
<TD colspan="2" align="right" class="t2">
<span style="margin-right:15px; ">
<a href="#@" onclick="window.parent.addTab('会议管理','Common/Meeting_List.aspx','icon-task')" >会议管理</a>&nbsp;&nbsp; 
<a href="#@" onclick="window.parent.addTab('记事便笺','Common/NoteBook_List.aspx','icon-pen')" >记事便笺</a>&nbsp;&nbsp; 
<a href="#@" onclick="window.parent.addTab('通讯录','Common/PublicAddrBook.aspx','icon-pub')" >通讯录</a>&nbsp;&nbsp; 
<a href="#@" onclick="window.parent.addTab('我的投票','Common/Vote_List.aspx','icon-app')" >我的投票</a>&nbsp;&nbsp;
<a href="#@" onclick="window.parent.addTab('我的考勤','Attend/WorkAttendAdd.aspx?type=1','icon-new2')" >我的考勤</a>&nbsp;&nbsp;	  
</span>
</TD>
</TR>	
</TBODY></TABLE></TD>
<TD background=Info_aspx_files/link_4_1.gif></TD></TR>
<TR>
<TD class=info2 height=1 colSpan=3><IMG 
src="Info_aspx_files/a.gif" width=1 
height=1></TD></TR></TBODY></TABLE></TD></TR>
<TR>
<TD height=8 colSpan=2></TD></TR>
<TR>
<TD vAlign=top width="51%">
<TABLE class=tx border=0 cellSpacing=0 cellPadding=0 width="98%">
<TBODY>
<TR>
<TD height=21 background=Info_aspx_files/link_3.gif width=7 
noWrap>
<DIV style="WIDTH: 7px"></DIV></TD>
<TD background=Info_aspx_files/linkbg2.gif width="100%"><span style="font-weight:bold; color:#ff0000;">&nbsp;我的邮件</span> 
</TD>
<TD height=21 background=Info_aspx_files/link_4.gif width=7 
noWrap>
<DIV style="WIDTH: 7px"></DIV></TD></TR>
<TR>
<TD background=Info_aspx_files/link_3_1.gif>
<DIV style="HEIGHT: 1px"></DIV></TD>
<TD vAlign=top>
<TABLE style="padding-left:4px;" border=0 cellSpacing=0 
cellPadding=0 width="100%" align=center>
<TBODY>
<%=wdyj %>

<TR>
<TD align="right" class="t2">
<span style="margin-right:15px; ">
<a href="#@" onclick="window.parent.addTab('收件箱','/manage/Common/Mail_List.aspx?fid=0','icon-data3')" >收件箱</a>&nbsp;&nbsp; 
<a href="#@" onclick="window.parent.addTab('草稿箱','/manage/Common/Mail_List.aspx?fid=1','icon-guestbook')" >草稿箱</a>&nbsp;&nbsp; 
<a href="#@" onclick="window.parent.addTab('发件箱','/manage/Common/Mail_List.aspx?fid=2','icon-data1')" >发件箱</a>&nbsp;&nbsp; 
<a href="#@" onclick="window.parent.addTab('发送新邮件','/manage/Common/Mail_Manage.aspx','icon-addnew')" >发送新邮件</a>&nbsp;&nbsp; 					  
</span>
</TD>
</TR>						  

</TBODY></TABLE></TD>
<TD background=Info_aspx_files/link_4_1.gif></TD></TR>
<TR>
<TD class=info2 height=1 colSpan=3><IMG 
src="Info_aspx_files/a.gif" width=1 
height=1></TD></TR></TBODY></TABLE></TD>
<TD vAlign=top width="49%">
<TABLE class=tx border=0 cellSpacing=0 cellPadding=0 width="100%">
<TBODY>
<TR>
<TD height=21 background=Info_aspx_files/link_3.gif width=7 
noWrap>
<DIV style="WIDTH: 7px"></DIV></TD>
<TD background=Info_aspx_files/linkbg2.gif width="100%"><span style="font-weight:bold; color:#ff0000;">&nbsp;工作流程</span> 
</TD>
<TD height=21 background=Info_aspx_files/link_4.gif width=7 
noWrap>
<DIV style="WIDTH: 7px"></DIV></TD></TR>
<TR>
<TD background=Info_aspx_files/link_3_1.gif></TD>
<TD vAlign=top>
<TABLE style="padding-left:4px;" border=0 cellSpacing=0 
cellPadding=0 width="100%" align=center>
<TBODY>
<%=wdsp %>

<TR>
<TD align="right" class="t2">
<span style="margin-right:15px; ">
<a href="#@" onclick="window.parent.addTab('我的批阅','flow/Flow_List.aspx?action=verify','icon-html')" >我的批阅</a>&nbsp;&nbsp; 
<a href="#@" onclick="window.parent.addTab('已经批阅','flow/Flow_List.aspx?action=verified','icon-filesave')" >已经批阅</a>&nbsp;&nbsp; 
<a href="#@" onclick="window.parent.addTab('我的申请','flow/Flow_List.aspx?action=apply','icon-all')" >我的申请</a>&nbsp;&nbsp; 
<a href="#@" onclick="window.parent.addTab('抄送呈报','flow/Flow_List.aspx?action=view','icon-template')" >抄送呈报</a>					  
</span>
</TD>
</TR>						  

</TBODY></TABLE></TD>
<TD background=Info_aspx_files/link_4_1.gif></TD></TR>
<TR>
<TD class=info2 height=1 colSpan=3><IMG 
src="Info_aspx_files/a.gif" width=1 
height=1></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE></TD>

</TR></TBODY></TABLE></div>

</body>
</html>

