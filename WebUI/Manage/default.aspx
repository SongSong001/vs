<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="WC.WebUI.Manage._default" %>

<!DOCTYPE html>

<html>
<head id="Head1" runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/>
<title><%=RealName + " (" + DepName + ")" %> - <%=comname %></title>
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="jss/m.js"></script>

<script type="text/javascript">
    $(function () {
        var ie6 = ! -[1, ] && !window.XMLHttpRequest;
        if (ie6) { alert('经典风格不支持IE6,请升级您的浏览器！');location.href = 'default1.aspx'; }
        
    });
    $.include(['themes/default/css/desktop.css', 'themes/default/css/appManager.css', 'jss/jquery-ui-1.8.18.custom.css', 'jss/jquery-smartMenu/css/smartMenu.css', 'jss/jquery-ui-1.8.18.custom.min.js', 'jss/jquery.winResize.js', 'jss/jquery-smartMenu/js/mini/jquery-smartMenu-min.js', 'jss/message/ui.notificationmsg.js', 'jss/message/notificationmsg.css', 'jss/jquery.nicescroll.min.js', 'jss/desktop.js']);

    $(window).load(function () {
        //myLib.progressBar();
        setInterval("writeCurrentDate()", 500);

    <asp:Literal runat=server ID=message_div Visible=true>
    var t = $("#notice_time").val();
    showMessage();
    setInterval(showMessage, t);
    </asp:Literal>

        myLib.stopProgress();

        var lrBarIconData = {
            'app0': {
                'WindowTitle': '工作台',
                'iframSrc': 'DeskTop.aspx',
                'WindowWidth': mw
            },
            'app1': {
                'WindowTitle': '个人设置',
                'iframSrc': 'Common/User_InfoEdit.aspx',
                'WindowWidth': mw
            },
            'app2': {
                'WindowTitle': '在线用户',
                'iframSrc': 'Common/User_OnLine.aspx',
                'WindowWidth': mw
            },
            'app3': {
                'WindowTitle': '即时通讯',
                'iframSrc': '/Lesktop/Default.aspx?auto=true',
                'WindowWidth': mw,'isLinks':true
            }
        };
		   
        var deskIconData = {
            'win1': {
                'WindowTitle': '我的资讯',
                'iframSrc': 'News/News_List.aspx',
                'WindowWidth': mw
            },
            'win2': {
                'WindowTitle': '我的邮件',
                'iframSrc': 'Common/Mail_List.aspx?fid=0',
                'WindowWidth': mw
            },
            'win3': {
                'WindowTitle': '即时通讯',
                'iframSrc': '/Lesktop/Default.aspx?auto=true',
                'WindowWidth': mw,'isLinks':true
            },
            'win4': {
                'WindowTitle': '我的文档',
                'iframSrc': 'doc/Doc_List.aspx?action=mydoc',
                'WindowWidth': mw
            },
            'win5': {
                'WindowTitle': '我的考勤',
                'iframSrc': 'Attend/WorkAttendAdd.aspx?type=1',
                'WindowWidth': mw
            },
            'win6': {
                'WindowTitle': '公文审核',
                'iframSrc': 'gov/Gov_List.aspx?action=verify',
                'WindowWidth': mw
            },
            'win7': {
                'WindowTitle': '我的流程',
                'iframSrc': 'flow/Flow_List.aspx?action=verify',
                'WindowWidth': mw
            },
            'win8': {
                'WindowTitle': '我的公文',
                'iframSrc': 'gov/Gov_Recipient.aspx?action=verify',
                'WindowWidth': mw
            },
            'win9': {
                'WindowTitle': '工作任务',
                'iframSrc': 'Tasks/Task_List.aspx?type=all',
                'WindowWidth': mw
            },
            'win10': {
                'WindowTitle': '工作汇报',
                'iframSrc': 'Common/WorkLog_List.aspx?action=shared',
                'WindowWidth': mw
            },



            'n1': {
                'WindowTitle': '所有资讯',
                'iframSrc': 'News/News_List.aspx',
                'WindowWidth': mw
            },
            <%=news_type %>
            'n6': {
                'WindowTitle': '电子档案',
                'iframSrc': 'Paper/PaperList.aspx',
                'WindowWidth': mw
            },
            'n7': {
                'WindowTitle': '档案分类导航',
                'iframSrc': 'Paper/TypeList_ForView.aspx',
                'WindowWidth': mw
            },
            'n8': {
                'WindowTitle': '发布资讯',
                'iframSrc': 'news/News_Manage.aspx',
                'WindowWidth': mw
            },


            'm1': {
                'WindowTitle': '发送邮件',
                'iframSrc': 'Common/Mail_Manage.aspx',
                'WindowWidth': mw
            },
            'm2': {
                'WindowTitle': '收件箱',
                'iframSrc': 'Common/Mail_List.aspx?fid=0',
                'WindowWidth': mw
            },
            'm3': {
                'WindowTitle': '草稿箱',
                'iframSrc': 'Common/Mail_List.aspx?fid=1',
                'WindowWidth': mw
            },
            'm4': {
                'WindowTitle': '发件箱',
                'iframSrc': 'Common/Mail_List.aspx?fid=2',
                'WindowWidth': mw
            },
            'm5': {
                'WindowTitle': '垃圾箱',
                'iframSrc': 'Common/Mail_List.aspx?fid=3',
                'WindowWidth': mw
            },


            'w1': {
                'WindowTitle': '新建工作任务',
                'iframSrc': 'Tasks/Task_Manage.aspx',
                'WindowWidth': mw
            },
            'w2': {
                'WindowTitle': '任务分类导航',
                'iframSrc': 'Tasks/TypeList_ForView.aspx',
                'WindowWidth': mw
            },
            'w3': {
                'WindowTitle': '所有参与任务',
                'iframSrc': 'Tasks/Task_List.aspx?type=all',
                'WindowWidth': mw
            },
            'w4': {
                'WindowTitle': '我执行的任务',
                'iframSrc': 'Tasks/Task_List.aspx?type=exeute',
                'WindowWidth': mw
            },
            'w5': {
                'WindowTitle': '我管理的任务',
                'iframSrc': 'Tasks/Task_List.aspx?type=manage',
                'WindowWidth': mw
            },
            'w6': {
                'WindowTitle': '我创建的任务',
                'iframSrc': 'Tasks/Task_List.aspx?type=create',
                'WindowWidth': mw
            },


            'f1': {
                'WindowTitle': '新建流程',
                'iframSrc': 'flow/Flow_Manage.aspx',
                'WindowWidth': mw
            },
            'f2': {
                'WindowTitle': '分类导航',
                'iframSrc': 'flow/TypeList_ForView.aspx',
                'WindowWidth': mw
            },
            'f3': {
                'WindowTitle': '我的批阅',
                'iframSrc': 'flow/Flow_List.aspx?action=verify',
                'WindowWidth': mw
            },
            'f4': {
                'WindowTitle': '已经批阅',
                'iframSrc': 'flow/Flow_List.aspx?action=verified',
                'WindowWidth': mw
            },
            'f5': {
                'WindowTitle': '我的申请',
                'iframSrc': 'flow/Flow_List.aspx?action=apply',
                'WindowWidth': mw
            },
            'f6': {
                'WindowTitle': '抄送呈报',
                'iframSrc': 'flow/Flow_List.aspx?action=view',
                'WindowWidth': mw
            },


            'g1': {
                'WindowTitle': '发文拟稿',
                'iframSrc': 'gov/gov_Manage.aspx',
                'WindowWidth': mw
            },
            'g2': {
                'WindowTitle': '分类导航',
                'iframSrc': 'gov/TypeList_ForView.aspx',
                'WindowWidth': mw
            },
            'g3': {
                'WindowTitle': '发文审核',
                'iframSrc': 'gov/Gov_List.aspx?action=verify',
                'WindowWidth': mw
            },
            'g4': {
                'WindowTitle': '已经审核',
                'iframSrc': 'gov/Gov_List.aspx?action=verified',
                'WindowWidth': mw
            },
            'g5': {
                'WindowTitle': '我的发文',
                'iframSrc': 'gov/Gov_List.aspx?action=apply',
                'WindowWidth': mw
            },
            'g6': {
                'WindowTitle': '公文签收',
                'iframSrc': 'gov/Gov_Recipient.aspx?action=verify',
                'WindowWidth': mw
            },
            'g7': {
                'WindowTitle': '已签收',
                'iframSrc': 'gov/Gov_Recipient.aspx?action=verified',
                'WindowWidth': mw
            },
            'g8': {
                'WindowTitle': '已归档',
                'iframSrc': 'gov/Gov_Recipient.aspx?action=archived',
                'WindowWidth': mw
            },


            'c1': {
                'WindowTitle': '我的日程',
                'iframSrc': 'CalendarMemo/CalendarMemo.aspx',
                'WindowWidth': mw
            },
            'c2': {
                'WindowTitle': '我的客户',
                'iframSrc': 'crm/CRM_List.aspx?action=mycrm',
                'WindowWidth': mw
            },
            'c3': {
                'WindowTitle': '供应商管理',
                'iframSrc': 'crm/CRM_Sup_List.aspx',
                'WindowWidth': mw
            },

//            'c4': {
//                'WindowTitle': '车辆管理',
//                'iframSrc': 'ziyuan.html',
//                'WindowWidth': mw
//            },
//            'c5': {
//                'WindowTitle': '物品管理',
//                'iframSrc': 'ziyuan.html',
//                'WindowWidth': mw
//            },
            'c6': {
                'WindowTitle': '发送手机短信',
                'iframSrc': 'sms/SMS_Send.aspx',
                'WindowWidth': mw
            },
            'c7': {
                'WindowTitle': '工作汇报',
                'iframSrc': 'Common/WorkLog_List.aspx?action=shared',
                'WindowWidth': mw
            },


            's1': {
                'WindowTitle': '机构导航',
                'iframSrc': 'Common/DepGuide.aspx',
                'WindowWidth': mw
            },
            's2': {
                'WindowTitle': '在线用户',
                'iframSrc': 'Common/User_OnLine.aspx',
                'WindowWidth': mw
            },
            's3': {
                'WindowTitle': '我的文档',
                'iframSrc': 'doc/Doc_List.aspx?action=mydoc',
                'WindowWidth': mw
            },
            's4': {
                'WindowTitle': '文档分类',
                'iframSrc': 'doc/DocType_List.aspx',
                'WindowWidth': mw
            },
            's5': {
                'WindowTitle': '我的投票',
                'iframSrc': 'Common/Vote_List.aspx',
                'WindowWidth': mw
            },
            's6': {
                'WindowTitle': '我的论坛',
                'iframSrc': '/bbs/index.aspx',
                'WindowWidth': mw
            },
            's7': {
                'WindowTitle': '即时通讯',
                'iframSrc': '/Lesktop/Default.aspx?auto=true',
                'WindowWidth': mw,'isLinks':true
            },


            't1': {
                'WindowTitle': '我的考勤',
                'iframSrc': 'Attend/WorkAttendAdd.aspx?type=1',
                'WindowWidth': mw
            },
            't2': {
                'WindowTitle': '考勤记录',
                'iframSrc': 'Attend/WorkAttendList.aspx?type=1',
                'WindowWidth': mw
            },
            't3': {
                'WindowTitle': '会议管理',
                'iframSrc': 'Common/Meeting_List.aspx',
                'WindowWidth': mw
            },
            't4': {
                'WindowTitle': '记事便笺',
                'iframSrc': 'Common/NoteBook_List.aspx',
                'WindowWidth': mw
            },
            't5': {
                'WindowTitle': '便捷小工具',
                'iframSrc': 'Common/SmallTool.aspx',
                'WindowWidth': mw
            },
            't6': {
                'WindowTitle': '个人资料',
                'iframSrc': 'Common/User_InfoEdit.aspx',
                'WindowWidth': mw
            },
            't7': {
                'WindowTitle': '个人登录记录',
                'iframSrc': 'Common/User_LoginList.aspx',
                'WindowWidth': mw
            },
            't8': {
                'WindowTitle': '公用通讯录',
                'iframSrc': 'Common/PublicAddrBook.aspx',
                'WindowWidth': mw
            },
            't9': {
                'WindowTitle': '个人通讯录',
                'iframSrc': 'Common/PrivateAddrBook.aspx',
                'WindowWidth': mw
            }
        };

        myLib.desktop.desktopPanel();

        <%=wallpaper %>

        myLib.desktop.taskBar.init();

        myLib.desktop.deskIcon.init(deskIconData);

        myLib.desktop.navBar.init();

        myLib.desktop.lrBar.init(lrBarIconData);

        myLib.desktop.appManagerPanel.init();

        <%=power_menu %>

        var data = [
					[{
					    text: "显示桌面",
					    func: function () {
					        $("div.windows").not(".hideWin")
						.each(function () {
						    $(this).find(".winMinimize").trigger("click");
						});
					    }
					}]
					, [{
					    text: "个人设置",
					    func: function () { runWin('个人设置', 'Common/User_InfoEdit.aspx', 'r001'); }
					}, {
					    text: "桌面主题设置",
					    func: function () { runWin('桌面主题设置', 'Common/TopicSet.aspx', 'r002'); }
					}, {
					    text: "切换传统风格",
					    func: function () { tabStyle(); }
					}]
					, [{
					    text: "消息提醒",
					    func: function () { showMsg(); }
					}]
					, [{
					    text: "在线用户",
					    func: function () {
					        runWin('在线用户', 'Common/User_OnLine.aspx', 'r003');
					    }
					}]
					, [{
					    text: "刷新网页",
					    func: function () {
					        location.href="default.aspx";
					    }
					}]
					, [{
					    text: "安全退出",
					    func: function () {
                        logout();
					    }
					}]
					];
        myLib.desktop.contextMenu($(document.body), data, "body", 10);

        runWin('我的工作台', 'DeskTop.aspx', 'winlll');
    });

    var mw = ($(window).width() - 283) / $(window).width();

    function showMessage() {
    var p = $("#stay_time").val();
    $.ajax({
    type:"GET",
    url:"Utils/msg.ashx",
    dataType: 'html',
    data: 'uid='+ $("#uid").val(), 
    success:function(data){
    if(data!="1"){
    myLib.desktop.message.show(data, 20000);
    document.all.music.src="m.wav";
    }
    }});
    }

    function showMsg() {
    var p = $("#stay_time").val();
    $.ajax({
    type:"GET",
    url:"Utils/msg.ashx",
    dataType: 'html',
    data: 'uid='+ $("#uid").val(), 
    success:function(data){
    if(data!="1"){
    myLib.desktop.message.show(data, 20000);
    document.all.music.src="m.wav";
    } else { myLib.desktop.message.show('目前没有新消息提示！', 5000); }
    }});
    }

    function runWin(tit, src, wid) {
        myLib.desktop.win.newWin({ WindowTitle: tit, iframSrc: src, WindowsId: wid, WindowAnimation: 'none', WindowWidth: mw });
    }
    function writeCurrentDate() {
        var today = new Date();
        var day;
        if (today.getDay() == 0) day = "星期日";
        if (today.getDay() == 1) day = "星期一";
        if (today.getDay() == 2) day = "星期二";
        if (today.getDay() == 3) day = "星期三";
        if (today.getDay() == 4) day = "星期四";
        if (today.getDay() == 5) day = "星期五";
        if (today.getDay() == 6) day = "星期六";
        var theDate = (today.getFullYear()) + "年" + (today.getMonth() + 1) + "月" + today.getDate() + "日 " + day + " " + today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
        $("#timebox").html(theDate);
    }
    function logout(){
    if(confirm('确认：您确认要安全注销，退出登录吗？'))
     location.href="LoginOut.aspx";
    }
    function tabStyle(){
    if(confirm('确认：您确认要切换到 传统风格吗？'))
     location.href="default1.aspx";
    }

</script>

</head>
<body>
<bgsound src="#" id="music" loop="1" autostart="true">
<input type=hidden runat=server id=uid />
<input type=hidden runat=server id=stay_time value='180000' />
<input type=hidden runat=server id=notice_time value='1200000' />

<noscript>
<div style=" position:absolute; z-index:100000; height:2046px;top:0px;left:0px; width:100%; background:white; text-align:center;">
    <img src="images/noscript.gif" alt='抱歉，请开启脚本支持！' />
</div></noscript>

<span id="timebox" class="timebox">&nbsp;</span>
<div id="wallpapers"></div>

<div id="navBar">
<s class="l"></s>
<span>
<a class="currTab" href="#" title="我的快捷导航"><img src="icon/top/001.png" alt=""></a>
<a href="#"><img src="icon/top/002.png" title="我的资讯"></a>
<a href="#"><img src="icon/top/003.gif" title="我的邮件"></a>
<a href="#"><img src="icon/top/004.png" title="我的流程"></a>
<a href="#"><img src="icon/top/005.png" title="我的公文"></a>
<a href="#"><img src="icon/top/006.png" title="工作任务"></a>
<a href="#"><img src="icon/top/007.png" title="计划与资源"></a>
<a href="#"><img src="icon/top/008.png" title="沟通与分享"></a>
<a href="#"><img src="icon/top/009.png" title="我的工具"></a>
<b title="全局视图"></b></span><s class="r"></s>
</div>

<div id="desktopPanel">
<div id="desktopInnerPanel">
<ul class="deskIcon currDesktop">
  <li class="desktop_icon" id="win1"> <span class="icon"><img src="icon/01/002.png"/></span> <div class="text">我的资讯<s></s></div> </li>
  <li class="desktop_icon" id="win2"> <span class="icon"><img src="icon/02/002.png"/></span> <div class="text">我的邮件<s></s></div> </li>
  <li class="desktop_icon" id="win9"> <span class="icon"><img src="icon/05/001.png"/></span> <div class="text">工作任务<s></s></div> </li>
  <li class="desktop_icon" id="win8"> <span class="icon"><img src="icon/04/001.png"/></span> <div class="text">我的公文<s></s></div> </li>
  <li class="desktop_icon" id="win6"> <span class="icon"><img src="icon/04/004.png"/></span> <div class="text">公文审核<s></s></div> </li>
  <li class="desktop_icon" id="win10"> <span class="icon"><img src="icon/06/007.png"/></span> <div class="text">工作汇报<s></s></div> </li>
  <li class="desktop_icon" id="win7"> <span class="icon"><img src="icon/03/002.png"/></span> <div class="text">我的流程<s></s></div> </li>
  <li class="desktop_icon" id="win3"> <span class="icon"><img src="icon/07/007.png"/></span> <div class="text">即时通讯<s></s></div> </li>
  <li class="desktop_icon" id="win4"> <span class="icon"><img src="icon/07/003.png"/></span> <div class="text">我的文档<s></s></div> </li>    
  <li class="desktop_icon" id="win5"> <span class="icon"><img src="icon/08/001.png"/></span> <div class="text">我的考勤<s></s></div> </li>
</ul>
<ul class="deskIcon">
  <li class="desktop_icon" id="n1"> <span class="icon"><img src="icon/01/002.png"/></span> <div class="text">所有资讯<s></s></div> </li>
  <%=news_type1 %>
  <li class="desktop_icon" id="n6"> <span class="icon"><img src="icon/01/006.png"/></span> <div class="text">电子档案<s></s></div> </li>
  <li class="desktop_icon" id="n7"> <span class="icon"><img src="icon/01/007.png"/></span> <div class="text">档案分类导航<s></s></div> </li>
  <li class="desktop_icon" id="n8"> <span class="icon"><img src="icon/03/001.png"/></span> <div class="text">发布资讯<s></s></div> </li>
</ul>
<ul class="deskIcon">
  <li class="desktop_icon" id="m1"> <span class="icon"><img src="icon/02/001.png"/></span> <div class="text">发送邮件<s></s></div> </li>
  <li class="desktop_icon" id="m2"> <span class="icon"><img src="icon/02/002.png"/></span> <div class="text">收件箱<s></s></div> </li>
  <li class="desktop_icon" id="m3"> <span class="icon"><img src="icon/02/003.png"/></span> <div class="text">草稿箱<s></s></div> </li>
  <li class="desktop_icon" id="m4"> <span class="icon"><img src="icon/02/004.png"/></span> <div class="text">发件箱<s></s></div> </li>
  <li class="desktop_icon" id="m5"> <span class="icon"><img src="icon/02/005.png"/></span> <div class="text">垃圾箱<s></s></div> </li>
</ul>
<ul class="deskIcon">
  <li class="desktop_icon" id="f1"> <span class="icon"><img src="icon/03/001.png"/></span> <div class="text">新建流程<s></s></div> </li>
  <li class="desktop_icon" id="f2"> <span class="icon"><img src="icon/01/007.png"/></span> <div class="text">分类导航<s></s></div> </li>
  <li class="desktop_icon" id="f3"> <span class="icon"><img src="icon/03/002.png"/></span> <div class="text">我的批阅<s></s></div> </li>
  <li class="desktop_icon" id="f4"> <span class="icon"><img src="icon/03/003.png"/></span> <div class="text">已经批阅<s></s></div> </li>
  <li class="desktop_icon" id="f5"> <span class="icon"><img src="icon/03/004.png"/></span> <div class="text">我的申请<s></s></div> </li>
  <li class="desktop_icon" id="f6"> <span class="icon"><img src="icon/03/005.png"/></span> <div class="text">抄送呈报<s></s></div> </li>
</ul>
<ul class="deskIcon">
  <li class="desktop_icon" id="g1"> <span class="icon"><img src="icon/03/001.png"/></span> <div class="text">发文拟稿<s></s></div> </li>
  <li class="desktop_icon" id="g2"> <span class="icon"><img src="icon/01/007.png"/></span> <div class="text">分类导航<s></s></div> </li>
  <li class="desktop_icon" id="g3"> <span class="icon"><img src="icon/04/004.png"/></span> <div class="text">发文审核<s></s></div> </li>
  <li class="desktop_icon" id="g4"> <span class="icon"><img src="icon/04/002.png"/></span> <div class="text">已经审核<s></s></div> </li>
  <li class="desktop_icon" id="g5"> <span class="icon"><img src="icon/04/003.png"/></span> <div class="text">我的发文<s></s></div> </li>
  <li class="desktop_icon" id="g6"> <span class="icon"><img src="icon/04/001.png"/></span> <div class="text">公文签收<s></s></div> </li>
  <li class="desktop_icon" id="g7"> <span class="icon"><img src="icon/04/005.png"/></span> <div class="text">已签收<s></s></div> </li>
  <li class="desktop_icon" id="g8"> <span class="icon"><img src="icon/04/006.png"/></span> <div class="text">已归档<s></s></div> </li>
</ul>
<ul class="deskIcon">
  <li class="desktop_icon" id="w1"> <span class="icon"><img src="icon/03/001.png"/></span> <div class="text">新建工作任务<s></s></div> </li>
  <li class="desktop_icon" id="w2"> <span class="icon"><img src="icon/01/007.png"/></span> <div class="text">任务分类导航<s></s></div> </li>
  <li class="desktop_icon" id="w3"> <span class="icon"><img src="icon/05/001.png"/></span> <div class="text">所有参与任务<s></s></div> </li>
  <li class="desktop_icon" id="w4"> <span class="icon"><img src="icon/05/002.png"/></span> <div class="text">我执行的任务<s></s></div> </li>
  <li class="desktop_icon" id="w5"> <span class="icon"><img src="icon/05/003.png"/></span> <div class="text">我管理的任务<s></s></div> </li>
  <li class="desktop_icon" id="w6"> <span class="icon"><img src="icon/05/004.png"/></span> <div class="text">我创建的任务<s></s></div> </li>
</ul>
<ul class="deskIcon">
  <li class="desktop_icon" id="c1"> <span class="icon"><img src="icon/06/001.png"/></span> <div class="text">我的日程<s></s></div> </li>
<%--  <li class="desktop_icon" id="c4"> <span class="icon"><img src="icon/06/002.png"/></span> <div class="text">车辆管理<s></s></div> </li>
  <li class="desktop_icon" id="c5"> <span class="icon"><img src="icon/06/003.png"/></span> <div class="text">物品管理<s></s></div> </li>--%>
  <li class="desktop_icon" id="c6"> <span class="icon"><img src="icon/06/006.png"/></span> <div class="text">手机短信<s></s></div> </li>
  <li class="desktop_icon" id="c2"> <span class="icon"><img src="icon/06/004.png"/></span> <div class="text">我的客户<s></s></div> </li>
  <li class="desktop_icon" id="c3"> <span class="icon"><img src="icon/06/005.png"/></span> <div class="text">供应商管理<s></s></div> </li>
  <li class="desktop_icon" id="c7"> <span class="icon"><img src="icon/06/007.png"/></span> <div class="text">工作汇报<s></s></div> </li>
</ul>
<ul class="deskIcon">
  <li class="desktop_icon" id="s1"> <span class="icon"><img src="icon/07/001.png"/></span> <div class="text">机构导航<s></s></div> </li>
  <li class="desktop_icon" id="s2"> <span class="icon"><img src="icon/07/002.png"/></span> <div class="text">在线用户<s></s></div> </li>
  <li class="desktop_icon" id="s3"> <span class="icon"><img src="icon/07/003.png"/></span> <div class="text">我的文档<s></s></div> </li>
  <li class="desktop_icon" id="s4"> <span class="icon"><img src="icon/07/004.png"/></span> <div class="text">文档分类<s></s></div> </li>
  <li class="desktop_icon" id="s5"> <span class="icon"><img src="icon/07/005.png"/></span> <div class="text">我的投票<s></s></div> </li>
  <li class="desktop_icon" id="s6"> <span class="icon"><img src="icon/07/006.png"/></span> <div class="text">我的论坛<s></s></div> </li>
  <li class="desktop_icon" id="s7"> <span class="icon"><img src="icon/07/007.png"/></span> <div class="text">即时通讯<s></s></div> </li>
</ul>
<ul class="deskIcon">
  <li class="desktop_icon" id="t1"> <span class="icon"><img src="icon/08/001.png"/></span> <div class="text">我的考勤<s></s></div> </li>
  <li class="desktop_icon" id="t2"> <span class="icon"><img src="icon/08/002.png"/></span> <div class="text">考勤记录<s></s></div> </li>
  <li class="desktop_icon" id="t3"> <span class="icon"><img src="icon/08/003.png"/></span> <div class="text">会议管理<s></s></div> </li>
  <li class="desktop_icon" id="t4"> <span class="icon"><img src="icon/08/004.png"/></span> <div class="text">记事便笺<s></s></div> </li>
  <li class="desktop_icon" id="t5"> <span class="icon"><img src="icon/08/005.png"/></span> <div class="text">便捷小工具<s></s></div> </li>
  <li class="desktop_icon" id="t6"> <span class="icon"><img src="icon/left/002.png"/></span> <div class="text">个人资料<s></s></div> </li>
  <li class="desktop_icon" id="t7"> <span class="icon"><img src="icon/08/006.png"/></span> <div class="text">个人登录记录<s></s></div> </li>
  <li class="desktop_icon" id="t8"> <span class="icon"><img src="icon/08/007.png"/></span> <div class="text">公用通讯录<s></s></div> </li>
  <li class="desktop_icon" id="t9"> <span class="icon"><img src="icon/08/008.png"/></span> <div class="text">个人通讯录<s></s></div> </li>
</ul>
</div>
</div>

<div id="taskBarWrap">
<div id="taskBar">
  <div id="leftBtn"><a href="#" class="upBtn"></a></div>
  <div id="rightBtn"><a href="#" class="downBtn"></a> </div>
  <div id="task_lb_wrap"><div id="task_lb"></div></div>
</div>
</div>

<div id="lr_bar">
  <ul id="default_app">
   <li id="app0" class="desktop_icon"><span><img src="icon/left/001.png" title="我的工作台"/></span><div class="text">我的工作台<s></s></div></li>
   <li id="app1" class="desktop_icon"><span><img src="icon/left/002.png" title="个人设置"/></span><div class="text">个人设置<s></s></div></li>
   <li id="app2" class="desktop_icon"><span><img src="icon/07/002.png" title="在线用户"/></span><div class="text">在线用户<s></s></div></li>
   <li id="app3" class="desktop_icon"><span><img src="icon/07/007.png" title="即时通讯"/></span><div class="text">即时通讯<s></s></div></li>
  </ul>
  <div id="default_tools"> 
  <span id="showZm_btn" title="切换传统风格" onclick=tabStyle()></span>
  <span id="shizhong_btn" title="消息提示" onclick=showMsg()></span> 
  <span id="weather_btn" title="机构导航" onclick=runWin('组织机构导航','Common/DepGuide.aspx','left002')></span>
  <span id="them_btn" title="安全退出" onclick='logout()'></span>
  </div>
  <div id="start_block">
<a title="开始" id="start_btn"></a>
<div id="start_item">
      <ul class="item admin">
        <li onclick=runWin('桌面主题设置','Common/TopicSet.aspx','cdan02')><span class="adminImg"></span>桌面主题设置</li>
      </ul> 
     
    </div>
</div>
</div>


<div id="msg1">
            <div id="modal">
                <div class="modaltop">
                    <div class="modaltitle">小秘书消息提示</div>
                    <span id="closebutton" style="cursor:pointer">
	                    <img alt="Hide Popup" src="jss/message/img/close_vista.gif" border="0" />
	                </span>
	            </div>
                <div class="modalbody" id="modalbody">
                </div>
            </div>
</div>

<div id="appManagerPanel" class="appManagerPanel">
<a class="aMg_close" href="javascript:void(0);"></a>

<div class="aMg_dock_container"></div>
<div class="aMg_line_x"></div>

<div class="aMg_folder_container">
<div class="aMg_folder_innercontainer"></div>
</div>
<a href="javascript:void(0);" id="aMg_prev"></a>
<a href="javascript:void(0);" id="aMg_next"></a> 
</div>  
<asp:Panel runat=server ID=dxbbs_div Visible=false>
<iframe src='/bbs/LoginForm.aspx?u=<%=Uid %>' frameborder="0" scrolling="no" width="0" height="0"></iframe>
</asp:Panel>
</body>
</html>