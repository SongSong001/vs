<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true"%>
<%@ Register TagPrefix="DXBBS" Namespace="DXBBS.Controls" Assembly="DXBBS.Controls" %>
<div class="Block">
    <div class="Possition H22 LH22">
        <div class="Left"><img src="<%= ForumConfig.ReadConfigInfo().SkinPath %>/leadicon.gif" align="absmiddle" /><DXBBS:Possition ID="Possition1" runat="server" />帖子列表</div>
        <div class="Right TR"><DXBBS:MessageBox ID="MessageBox1" runat="server" /></div>
    </div>
</div>

<DXBBS:ForumNews ID="ForumNews1" runat="server" />
<asp:PlaceHolder ID="ShowChildBoard" Visible="false" runat="server">
<div class="Block">
    <div class="Title H22">
        <div class="Left"><img src="<%=ForumConfig.ReadConfigInfo().SkinPath %>/boardicon.gif" align="absmiddle" />本版含有子版面</div>
        <div class="Right P5"><img src="<%=ForumConfig.ReadConfigInfo().SkinPath %>/top.gif" align="absmiddle" /></div>
    </div>
    <DXBBS:BoardRepeater ID="BoardRepeater1" FatherID='<%# Eval("ID") %>' runat="server" />
</div>
</asp:PlaceHolder>
<div style="width:100%"><DXBBS:BoardRule ID="BoardRule1" runat="server" /></div>
<asp:PlaceHolder ID="ShowBoardDetail" Visible="true" runat="server">
<div class="GroupList">
    <DXBBS:GroupList ID="GroupList1" runat="server" />
    <div class="Right" style="padding-bottom:2px"><a href="Post.aspx?BoardID=<%= Requests.GetIntQueryString("BoardID") %>"><img src="<%= ForumConfig.ReadConfigInfo().SkinPath %>/post.gif" border="0" align="absmiddle" /></a>&nbsp;<a href="Post.aspx?BoardID=<%= Requests.GetIntQueryString("BoardID") %>&Action=Vote"><img src="<%= ForumConfig.ReadConfigInfo().SkinPath %>/votenew.gif" border="0" align="absmiddle" /></a></div>
</div>
<div class="Block" style="margin-top:0;">
    <ul class="Middle H20 P1 Hidden">
    	<li><img src="<%= ForumConfig.ReadConfigInfo().SkinPath %>/dot.gif"> 主题总数: <asp:Label ID="TotalTopic" runat="server" /> | 回复总数: <asp:Label ID="TotalReply" runat="server" /> | 今日发贴: <asp:Label ID="TodayTopic" runat="server" /> | 今日回复: <asp:Label ID="TodayReply" runat="server" /> | 本版版主：<DXBBS:BoardMaster ID="BoardMaster1" Default="暂无版主" runat="server" /></li>
        <li class="Right"><a href="ForumTopic.aspx?BoardID=<% = Requests.GetIntQueryString("BoardID") %>&Action=New">最新发布</a> | <a href="ForumTopic.aspx?BoardID=<% = Requests.GetIntQueryString("BoardID") %>&Action=Hot">热帖</a> | <a href="ForumTopic.aspx?BoardID=<% = Requests.GetIntQueryString("BoardID") %>&Action=Good"><span class="Red">精华</span></a> | <a href="UserOnline.aspx?BoardID=<% = Requests.GetIntQueryString("BoardID") %>">在线</a> | <a href="TopicEdit.aspx?BoardID=<% = Requests.GetIntQueryString("BoardID") %>">管理</a></li>
    </ul>
    <ul class="Title TC">
        <li style="width:50px">状态</li>
        <li>帖子标题</li>
        <li class="Right" style="width:220px">最后回复</li>
        <li class="Right TL" style="width:50px">查看</li>
        <li class="Right TR" style="width:50px">回复&nbsp;|&nbsp;</li>
        <li class="Right TR" style="width:100px">作者</li>
    </ul>
    <div class="M1 Hidden">
    <asp:Repeater ID="TopTopicList" runat="server">
    <ItemTemplate>
    <dl onmouseover="this.className='Footer'" onmouseout="this.className='Middle'">
        <dd class="Left TC" style="width:50px"><img src="<%# Eval("Photo") %>" align="absmiddle" /></dd>
        <dd class="Right" style="width:220px">
			<div class="Left" style="width:120px;"><%# Eval("LastReplyTime") %></div>
			<div class="Left"><span class="Red">|</span> <a href="ControlPanel.aspx?UserID=<%# Eval("LastReplyUserID") %>" target="_blank"><%# Eval("LastReplyUser") %></a></div>
		</dd>
        <dd class="Right TL" style="width:50px"><%# Eval("Click") %></dd>
        <dd class="Right TR" style="width:50px"><font color="#ff0099"><b><%# Eval("Reply") %></b></font>&nbsp;|&nbsp;</dd>
        <dd class="Right TR" style="width:100px"><a href="ControlPanel.aspx?UserID=<%# Eval("UserID") %>" target="_blank"><%# Eval("UserName") %></a></dd>
        <dd style="margin-left:50px"><DXBBS:GroupName ID="GroupName1" BoardID='<%# Eval("BoardID") %>' GroupID='<%# Eval("GroupID") %>' runat="server" /> <a href="<%# URLConfig.TopicURL.Replace("$BoardID",Eval("BoardID").ToString()).Replace("$TopicID",Eval("ID").ToString()) %>"><font color="<%# Eval("TitleColor") %>"><%# Eval("Title") %></font></a>&nbsp;<DXBBS:FollowPager ID="FollowPager2" Count='<%# Eval("Reply") %>' BoardID='<%# Eval("BoardID") %>' TopicID='<%# Eval("ID") %>' Target="_self" runat="server" /><DXBBS:TopicIcon ID="TopicIcon2" State='<%# Eval("State") %>' IsGood='<%# Eval("IsGood") %>' Reply='<%# Eval("Reply") %>' AddTime='<%# Eval("AddTime") %>' runat="server" /></dd>
    </dl>
    </ItemTemplate>
    </asp:Repeater>
    <asp:Repeater ID="TopicList" runat="server">
    <ItemTemplate>
    <dl onmouseover="this.className='Footer'" onmouseout="this.className='Middle'">
        <dd class="Left TC" style="width:50px"><img src="<%# Eval("Photo") %>" align="absmiddle" /></dd>
        <dd class="Right" style="width:220px">
        	<div class="Left" style="width:120px;"><%# Eval("LastReplyTime") %></div>
        	<div class="Left"><span class="Red">|</span> <a href="ControlPanel.aspx?UserID=<%# Eval("LastReplyUserID") %>" target="_blank"><%# Eval("LastReplyUser") %></a></div>
        </dd>
        <dd class="Right TL" style="width:50px"><%# Eval("Click") %></dd>
        <dd class="Right TR" style="width:50px"><font color="#ff0099"><b><%# Eval("Reply") %></b></font>&nbsp;|&nbsp;</dd>
        <dd class="Right TR" style="width:100px"><a href="ControlPanel.aspx?UserID=<%# Eval("UserID") %>" target="_blank"><%# Eval("UserName") %></a></dd>
        <dd style="margin-left:50px"><DXBBS:GroupName ID="GroupName2" BoardID='<%# Eval("BoardID") %>' GroupID='<%# Eval("GroupID") %>' runat="server" /> <a href="<%# URLConfig.TopicURL.Replace("$BoardID",Eval("BoardID").ToString()).Replace("$TopicID",Eval("ID").ToString()) %>"><font color="<%# Eval("TitleColor") %>"><%# Eval("Title") %></font></a>&nbsp;<DXBBS:FollowPager ID="FollowPager2" Count='<%# Eval("Reply") %>' BoardID='<%# Eval("BoardID") %>' TopicID='<%# Eval("ID") %>' Target="_self" runat="server" /><DXBBS:TopicIcon ID="TopicIcon2" State='<%# Eval("State") %>' IsGood='<%# Eval("IsGood") %>' Reply='<%# Eval("Reply") %>' AddTime='<%# Eval("AddTime") %>' runat="server" /></dd>
    </dl>
    </ItemTemplate>
    </asp:Repeater>
    </div>
</div>
<div class="BlankBlock">
	<DXBBS:ForumPager ID="CommonPager" URL='<%# URLConfig.BoardPagerURL.Replace("$BoardID",Requests.GetIntQueryString("BoardID").ToString()).Replace("$GroupID",Requests.GetIntQueryString("GroupID").ToString()) %>' runat="server" />
</div>
<div class="DottedBlock Hidden">
    <div class="Middle M1 TC Hidden P5" style="height:15px">
        <div class="Left" style="width:6%"><img src="<%= ForumConfig.ReadConfigInfo().SkinPath %>/topic_normal.gif" align="absmiddle" /> 开放</div>
        <div class="Left" style="width:6%"><img src="<%= ForumConfig.ReadConfigInfo().SkinPath %>/topic_hot.gif" align="absmiddle" /> 热门</div>
        <div class="Left" style="width:6%"><img src="<%= ForumConfig.ReadConfigInfo().SkinPath %>/topic_lock.gif" align="absmiddle" /> 锁定</div>
        <div class="Left" style="width:6%"><img src="<%= ForumConfig.ReadConfigInfo().SkinPath %>/topic_top.gif" align="absmiddle" /> 固顶</div>
        <div class="Left" style="width:8%"><img src="<%= ForumConfig.ReadConfigInfo().SkinPath %>/topic_areatop.gif" align="absmiddle" /> 区固顶</div>
        <div class="Left" style="width:8%"><img src="<%= ForumConfig.ReadConfigInfo().SkinPath %>/topic_maintop.gif" align="absmiddle" /> 总固顶</div>
        <div class="Left" style="width:6%"><img src="<%= ForumConfig.ReadConfigInfo().SkinPath %>/topic_vote.gif" align="absmiddle" /> 投票</div>
        <div class="Left" style="width:6%"><img src="<%= ForumConfig.ReadConfigInfo().SkinPath %>/topic_ask.gif" align="absmiddle" /> 问答</div>
        <div class="Left" style="width:9%"><img src="<%= ForumConfig.ReadConfigInfo().SkinPath %>/topic_html.gif" align="absmiddle" /> HTML标题</div>
        <div class="Left" style="width:9%"><img src="<%= ForumConfig.ReadConfigInfo().SkinPath %>/topic_color.gif" align="absmiddle" /> 颜色标题</div>
        <div class="Left" style="width:9%"><img src="<%= ForumConfig.ReadConfigInfo().SkinPath %>/topic_reply.gif" align="absmiddle" /> 回复可见</div>
        <div class="Left" style="width:6%"><img src="<%= ForumConfig.ReadConfigInfo().SkinPath %>/topic_right.gif" align="absmiddle" /> 权限</div>
        <div class="Left" style="width:9%"><img src="<%= ForumConfig.ReadConfigInfo().SkinPath %>/topic_coin.gif" align="absmiddle" /> 金币购买</div>
        <div class="Left" style="width:6%"><img src="<%= ForumConfig.ReadConfigInfo().SkinPath %>/topic_good.gif" align="absmiddle" /> 精华</div>
    </div>
</div>
</asp:PlaceHolder>