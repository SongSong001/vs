<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true"%>
<%@ Register TagPrefix="DXBBS" Namespace="DXBBS.Controls" Assembly="DXBBS.Controls" %>
<div class="Block">
    <div class="Possition">
		<img src="<% = ForumConfig.ReadConfigInfo().SkinPath %>/boardicon.gif" align="absmiddle" /><DXBBS:Possition ID="Possition1" runat="server" />[ <a href="ForumTopic.aspx?BoardID=<% = Requests.GetIntQueryString("BoardID") %>&Action=New">最新主题</a> - <a href="ForumTopic.aspx?BoardID=<% = Requests.GetIntQueryString("BoardID") %>&Action=Active">最新回复</a> - <a href="ForumTopic.aspx?BoardID=<% = Requests.GetIntQueryString("BoardID") %>&Action=Hot">热门主题</a> - <a href="ForumTopic.aspx?BoardID=<% = Requests.GetIntQueryString("BoardID") %>&Action=Good">精华主题</a> ]
	</div>
</div>
<div class="Block Hidden">
    <dl class="Title">
        <dd class="Left TC" style="width:50px">状态</dd>
        <dd class="Right" style="width:220px">最后回复</dd>
        <dd class="Right TL" style="width:50px">查看</dd>
        <dd class="Right TR" style="width:50px">回复&nbsp;|&nbsp;</dd>
        <dd class="Right TR" style="width:100px">作者</dd>
        <dd class="TC"> 帖子标题</dd>
    </dl>
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
<div class="BlankBlock">
    <DXBBS:ForumPager ID="CommonPager" runat="server" />
</div>