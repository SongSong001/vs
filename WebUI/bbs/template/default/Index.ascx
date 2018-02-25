<%@ Import Namespace="DXBBS.Components"%>
<%@ Import Namespace="DXBBS.Business"%>
<%@ Control Language="C#" AutoEventWireup="true" %>
<%@ Register TagPrefix="DXBBS" Namespace="DXBBS.Controls" Assembly="DXBBS.Controls" %>
<DXBBS:ForumNews ID="ForumNews1" runat="server" />
<div class="DottedBlock">
	<div class="P5">
	    <div class="ForumIcon">
	        <div><a href="ControlPanel.aspx"><img src="<%=ForumConfig.ReadConfigInfo().SkinPath %>/controlpanel.gif" align="absmiddle" /><br />个人中心</a></div>
	        <div><a href="Team.aspx"><img src="<%=ForumConfig.ReadConfigInfo().SkinPath %>/team.gif" align="absmiddle" /><br />朋友圈子</a></div>
	        <div><a href="ForumTopic.aspx?Action=Good"><img src="<%=ForumConfig.ReadConfigInfo().SkinPath %>/goodtopics.gif" align="absmiddle" /><br />精华帖子</a></div>
	        <div><a href="ForumTopic.aspx?Action=Hot"><img src="<%=ForumConfig.ReadConfigInfo().SkinPath %>/hottopics.gif" align="absmiddle" /><br />热门帖子</a></div>
	        <div><a href="ForumTopic.aspx?Action=New"><img src="<%=ForumConfig.ReadConfigInfo().SkinPath %>/newtopics.gif" align="absmiddle" /><br />最新帖子</a></div>
	    </div>
	    <div>
	        <div>欢迎你：<span class="Red"><strong><% =Sessions.UserName %></strong></span>&nbsp;现在时间是：<% =Servers.DateTime.ToString() %></div>
	        <div>金币: <% =Sessions.Coin %>  积分: <% =Sessions.Point %>  发帖: <% =Sessions.Topic %>  回复: <% =Sessions.Reply %>  / 等级: <% =Sessions.LevelName %> <DXBBS:MessageBox ID="MessageBox1" runat="server" /></div>
	        <div>共 <b><% =ForumStatus.TotalTopic %></b> 篇主题 | <b><% =ForumStatus.TotalReply %></b> 篇帖子 | 今日 <b><span class="Blue"><% =ForumStatus.TodayPost %></span></b> 篇帖子 | </div>
	    </div>
    </div>
</div>
<DXBBS:LoginForm ID="LoginForm1" Visible="false" runat="server" />
<asp:Repeater id="FatherBoard" runat="server">
<ItemTemplate>
<div class="Block">
    <div class="Title H22">
        <div class="Left"><img src="<%=ForumConfig.ReadConfigInfo().SkinPath %>/boardicon.gif" align="absmiddle" /><a href="<%# URLConfig.BoardURL.Replace("$BoardID",Eval("ID").ToString()).Replace("$GroupID","0")  %>"><%# Eval("BoardName") %></a></div>
        <div class="Right" style="padding:5px;"><a href="#"><img src="<%=ForumConfig.ReadConfigInfo().SkinPath %>/top.gif" border="0" align="absmiddle" /></a></div>
    </div>
    <DXBBS:BoardRepeater ID="BoardRepeater1" FatherID='<%# Eval("ID") %>' runat="server" />
</div>
</ItemTemplate>
</asp:Repeater>


<div class="DottedBlock">
    <div class="Middle M1 ForumInfo">
        <div>目前论坛上总共有 <% = ForumStatus.TotalOnline %> 人在线,其中注册会员 <% = ForumStatus.UserOnline %> 人,访客 <% = ForumStatus.GuestOnline %> 人,[<a href="UserOnline.aspx">查看在线会员</a>]</div>
        <div>您的IP是：<% = Clients.IP %>,操作系统：<% = Clients.OS %>,浏 览 器：<% = Clients.Browser %></div>
        <div>历史最高在线纪录是 <% = ForumStatus.HightestOnline %> 人同时在线,发生时间是：<% = ForumStatus.HightestOnlineTime %></div>
        <div>论坛用户组图例：<img src=<%=ForumConfig.ReadConfigInfo().SkinPath %>/manage_level.gif> 管理组用户&nbsp; <img src=<%=ForumConfig.ReadConfigInfo().SkinPath %>/master_level.gif> 版主组用户&nbsp; <img src=<%=ForumConfig.ReadConfigInfo().SkinPath %>/static_level.gif> 特殊组用户&nbsp; <img src=<%=ForumConfig.ReadConfigInfo().SkinPath %>/register_level.gif> 注册用户&nbsp; <img src=<%=ForumConfig.ReadConfigInfo().SkinPath %>/guest_level.gif> 访客</div>
        <div><DXBBS:ForumOnline ID="ForumOnline2" runat="server" /></div>
    </div> 
</div>

<div class="DottedBlock">
	<div class="Middle M1 BoardState">
        <div><img src="<%=ForumConfig.ReadConfigInfo().SkinPath %>/board_new.gif" align="absmiddle" /> 有新帖子</div>
        <div><img src="<%=ForumConfig.ReadConfigInfo().SkinPath %>/board_normal.gif" align="absmiddle" /> 无新帖子</div>
        <div><img src="<%=ForumConfig.ReadConfigInfo().SkinPath %>/board_lock.gif" align="absmiddle" /> 锁定版面</div>
	</div>
</div>
