<%@ Import Namespace="DXBBS.Components"%>
<%@ Import Namespace="DXBBS.Business"%>
<%@ Control Language="C#" AutoEventWireup="true"%>
<%@ Register TagPrefix="DXBBS" Namespace="DXBBS.Controls" Assembly="DXBBS.Controls" %>
<div class="Block">
    <div class="Possition H22 LH22">
        <div class="Left"><img src="<%= ForumConfig.ReadConfigInfo().SkinPath %>/leadicon.gif" align="absmiddle" /><DXBBS:Possition ID="Possition1" runat="server" />阅读文章</div>
        <div class="Right TR"><DXBBS:MessageBox ID="MessageBox1" runat="server" /></div>
    </div>
</div>

<DXBBS:ForumNews ID="ForumNews1" runat="server" />

<div class="GroupList">
    <DXBBS:GroupList ID="GroupList1" runat="server" />
    <div class="Right" style="padding-bottom:2px"><a href="Post.aspx?BoardID=<%= Requests.GetIntQueryString("BoardID") %>"><img src="<%= ForumConfig.ReadConfigInfo().SkinPath %>/post.gif" border="0" align="absmiddle" /></a>&nbsp;<a href="Post.aspx?BoardID=<%= Requests.GetIntQueryString("BoardID") %>&Action=Vote"><img src="<%= ForumConfig.ReadConfigInfo().SkinPath %>/votenew.gif" border="0" align="absmiddle" /></a>&nbsp;<a href="Reply.aspx?BoardID=<% = Requests.GetIntQueryString("BoardID") %>&TopicID=<% = Requests.GetIntQueryString("TopicID") %>"><img src="<% = ForumConfig.ReadConfigInfo().SkinPath %>/reply.gif" border="0" align="absmiddle" /></a>&nbsp;<a href="AddFavorite.aspx?TopicID=<% = Requests.GetIntQueryString("TopicID") %>"><img src="<% = ForumConfig.ReadConfigInfo().SkinPath %>/favorite.gif" border="0" align="absmiddle" /></a></div>
</div>
<div class="Block Hidden" style="margin-top:0px;">
    <div class="Middle H15 P2">
        <div class="Left"><img src="<%= ForumConfig.ReadConfigInfo().SkinPath %>/dot.gif"  align="absmiddle" /> 版主：<DXBBS:BoardMaster ID="BoardMaster1" Default="暂无版主" runat="server" /></div>
        <div class="Right">你是本帖第 <asp:Label ID="TopicClick" ForeColor="Red" Font-Bold="true" runat="server" /> 阅读者</div>
    </div>
    <div class="Title"><img src="<%= ForumConfig.ReadConfigInfo().SkinPath %>/info.gif"  align="absmiddle" /><asp:Label ID="TopicTitle" runat="server" /></div>
</div>
<asp:Repeater ID="ReplyList" runat="server">
<ItemTemplate>
<div class="Block Hidden">
    <div class="Header M1 Hidden H25">
        <div class="Left P5" style="width:180px"><DXBBS:IsOnline ID="IsOnline1" DataSource='<%# Eval("User") %>' runat="server" /><a href="ControlPanel.aspx?UserID=<%# Eval("UserID") %>" target="_blank"><strong><span style="FILTER: glow(color='#FFFFFF',strength='2'); WIDTH: 120px; cursor:pointer"><span class="Red"><%# Eval("UserName") %></span></span></strong></a></div>
        <div class="Left TL P5 BL"><img src="<%=ForumConfig.ReadConfigInfo().SkinPath %>/userinfo.gif" align="absmiddle" /><a href="ControlPanel.aspx?UserID=<%# Eval("UserID") %>" target="_blank"> 资料 </a><img src="<%=ForumConfig.ReadConfigInfo().SkinPath %>/msg.gif" align="absmiddle" /><a href="SendMessage.aspx?UserID=<%# Eval("UserID") %>" target="_blank"> 发短信 </a><img src="<%=ForumConfig.ReadConfigInfo().SkinPath %>/friend.gif" align="absmiddle" /><a href="AddFriend.aspx?UserID=<%# Eval("UserID") %>" target="_blank"> 加为好友 </a><img src="<%=ForumConfig.ReadConfigInfo().SkinPath %>/mytopic.gif" align="absmiddle" /><a href="ControlPanel.aspx?UserID=<%# Eval("UserID") %>&Action=Topic" target="_blank"> 他发表的主题 </a><img src="<%=ForumConfig.ReadConfigInfo().SkinPath %>/myjoin.gif" align="absmiddle" /><a href="ControlPanel.aspx?UserID=<%# Eval("UserID") %>&Action=Join" target="_blank"> 他参与的主题 </a></div>
        <div class="Right TR P5">
        	第 <span class="Red"><b><%# Eval("Floor") %></b></span> 楼
        </div>
    </div>
    <div class="Middle M1 Hidden">
	    <div class="Middle Div">
	        <div class="TopicLeft"><DXBBS:UserPanel ID="User" DataSource='<%# Eval("User") %>' runat="server"></DXBBS:UserPanel></div>
	        <div class="TopicRight">
		    <div class="P5"><b><%# Eval("Title") %></b></div>
	            <div class="TopicContent">
	            	<DXBBS:ShowVote ID="ShowVote1" VoteID='<%# Eval("VoteID") %>' runat="server" />
		            <DXBBS:ContentShow ID="ContentShow1" DataSource='<%# Eval("MyContent") %>' URL="PostEdit.aspx?BoardID=$BoardID&TopicID=$TopicID&ReplyID=$ReplyID&Action=$Action" runat="server" />
				</div>
				<div class="P5"><DXBBS:Advertisement ID="Advertisement1" runat="server" /></div>
				<DXBBS:UserSign ID="UserSign1" DataSource='<%# Eval("User.Sign") %>' runat="server" />
	            <div class="Footer TR P5">
	            	<div class="Left">
	            		<img src="<%=ForumConfig.ReadConfigInfo().SkinPath %>/dot.gif" align="absmiddle" /> <%# Eval("AddTime") %>/ 用户IP：<DXBBS:IPAddress ID="IPAddress1" DataSource='<%# Eval("IP") %>' runat="server" />
	            	</div>
	            	<DXBBS:PostEditMenu ID="PostEditMenu1" State='<%# Eval("TopicState") %>' IsTopic='<%# Eval("IsTopic") %>' ReplyID='<%# Eval("ID") %>' UserName='<%# Eval("UserName") %>' AddTime='<%# Eval("AddTime") %>' URL="PostEdit.aspx?BoardID=$BoardID&TopicID=$TopicID&ReplyID=$ReplyID&Action=$Action" runat="server" />
	            </div>
	        </div>
		</div>
    </div>
</div>
</ItemTemplate>
</asp:Repeater>
<div class="BlankBlock">
	<DXBBS:ForumPager ID="CommonPager" URL='<%# URLConfig.TopicPagerURL.Replace("$BoardID",Requests.GetIntQueryString("BoardID").ToString()).Replace("$TopicID",Requests.GetIntQueryString("TopicID").ToString()) %>' runat="server" />
</div>
<asp:PlaceHolder ID="ReplyForm" Visible="false" runat="server">
<div class="DottedBlock Hidden" <% if (Sessions.UserID == 0) { %> style='display:none;' <%}%> >
    <div class="Header M1 TC PTB5">快速回复框</div>
    <div class="Middle M1 Hidden">
        <div class="TopicLeft">回复内容：</div>
        <div class="TopicRight"><DXBBS:Editor ID="Content" Width="550px" Height="100px" runat="server" /></div>
    </div>
	<asp:PlaceHolder ID="ShowReplyCode" Visible="false" runat="server">
	<div class="Middle M1 Hidden">
        <div class="TopicLeft">验证码：</div>
        <div class="TopicRight"><asp:TextBox ID="ReplyCode" Width="80px" runat="server" /> <asp:RequiredFieldValidator ID="NeedCode" ErrorMessage="请输入验证码" ControlToValidate="ReplyCode" Display="dynamic" runat="server" /><img src="ShowCode.aspx" align="absmiddle" /></div>
    </div>
    </asp:PlaceHolder>
    <div class="Footer M1 TC P2">
		<asp:Button CssClass="Button" ID="ReplyButton" Text="确定回复" runat="server" />&nbsp;<input type="button" class="Button" onclick="window.location.href='Reply.aspx?BoardID=<% = Requests.GetIntQueryString("BoardID") %>&TopicID=<% = Requests.GetIntQueryString("TopicID") %>'" value="高级回复" />
    </div>
</div>
</asp:PlaceHolder>
<div class="DottedBlock TR">管理选项：<a href="PostEdit.aspx?BoardID=<% = Requests.GetIntQueryString("BoardID") %>&TopicID=<% = Requests.GetIntQueryString("TopicID") %>&Action=MainTop">总固顶</a> | <a href="PostEdit.aspx?BoardID=<% = Requests.GetIntQueryString("BoardID") %>&TopicID=<% = Requests.GetIntQueryString("TopicID") %>&Action=AreaTop">区固顶</a> | <a href="PostEdit.aspx?BoardID=<% = Requests.GetIntQueryString("BoardID") %>&TopicID=<% = Requests.GetIntQueryString("TopicID") %>&Action=Top">固顶</a> | <a href="PostEdit.aspx?BoardID=<% = Requests.GetIntQueryString("BoardID") %>&TopicID=<% = Requests.GetIntQueryString("TopicID") %>&Action=DeleteTop">解固</a> | <a href="PostEdit.aspx?BoardID=<% = Requests.GetIntQueryString("BoardID") %>&TopicID=<% = Requests.GetIntQueryString("TopicID") %>&Action=Good">加精</a> | <a href="PostEdit.aspx?BoardID=<% = Requests.GetIntQueryString("BoardID") %>&TopicID=<% = Requests.GetIntQueryString("TopicID") %>&Action=DeleteGood">解精</a> | <a href="PostEdit.aspx?BoardID=<% = Requests.GetIntQueryString("BoardID") %>&TopicID=<% = Requests.GetIntQueryString("TopicID") %>&Action=Move">移动</a> | <a href="PostEdit.aspx?BoardID=<% = Requests.GetIntQueryString("BoardID") %>&TopicID=<% = Requests.GetIntQueryString("TopicID") %>&Action=Lock">锁定</a> | <a href="PostEdit.aspx?BoardID=<% = Requests.GetIntQueryString("BoardID") %>&TopicID=<% = Requests.GetIntQueryString("TopicID") %>&Action=DeleteLock">解锁</a>&nbsp;</div>