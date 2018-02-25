<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true"%>
<%@ Register TagPrefix="DXBBS" Namespace="DXBBS.Controls" Assembly="DXBBS.Controls" %>
<script language="javascript" src="js/calendar.js"></script>
<LINK href="css/calendar.css" rel="stylesheet">
<div class="Block">
    <div class="Possition">
		<img src="<% = ForumConfig.ReadConfigInfo().SkinPath %>/boardicon.gif" align="absmiddle" /><DXBBS:Possition ID="Possition1" runat="server" />论坛搜索
	</div>
</div>
<asp:PlaceHolder ID="ShowTopicList" Visible="false" runat="server">
<div class="Block Hidden">
    <div class="Title H22 LH22 TC">
        论坛贴子检索结果
    </div>
	<ul class="Header TC">
		<li class="Left" style="width:50px">ID</li>
		<li>帖子标题</li>
		<li class="Right">选择</li>
		<li class="Right" style="width:80px">最后更新</li>
		<li class="Right" style="width:80px">发表时间</li>
		<li class="Right" style="width:120px">所属版面</li>
		<li class="Right" style="width:60px">是否审核</li>
                <li class="Right TL" style="width:40px">查看</li>
                <li class="Right TR" style="width:40px">回复&nbsp;|&nbsp;</li>
		<li class="Right" style="width:80px">发表用户</li>
	</ul>
	<asp:Repeater ID="TopicList" runat="server">
	<ItemTemplate>
	<dl class="Middle TC">
		<dd class="Left" style="width:50px"><%# Eval("ID") %></dd>
		<dd class="Right"><input type="checkbox" name="SelectID" value="<%# Eval("ID") %>" /></dd>
		<dd class="Right" style="width:80px"><%# Convert.ToDateTime(Eval("LastReplyTime")).ToString("yyyy/MM/dd") %></dd>
		<dd class="Right" style="width:80px"><%# Convert.ToDateTime(Eval("AddTime")).ToString("yyyy/MM/dd") %></dd>
		<dd class="Right" style="width:120px"><DXBBS:BoardName ID="BoardName1" BoardID='<%# Eval("BoardID") %>' runat="server" /></dd>
		<dd class="Right" style="width:60px"><DXBBS:Confirmed ID="Confirmed1" DataSource='<%# Eval("Confirmed") %>' runat="server" /></dd>
        <dd class="Right TL" style="width:40px"><%# Eval("Click") %></dd>
        <dd class="Right TR" style="width:40px"><font color="#ff0099"><b><%# Eval("Reply") %></b></font>&nbsp;|&nbsp;</dd>
		<dd class="Right" style="width:80px"><%# Eval("UserName") %></dd>
		<dd class="TL" style="margin-left:50px"><a href='<%# URLConfig.TopicURL.Replace("$BoardID",Eval("BoardID").ToString()).Replace("$TopicID",Eval("ID").ToString()) %>' target="_blank"><%# Eval("Title") %></a></dd>
	</dl>
	</ItemTemplate>
	</asp:Repeater>
</div>
<div class="BlankBlock Hidden">
	<DXBBS:ForumPager ID="CommonPager" runat="server" />
</div>
</asp:PlaceHolder>
<div class="Block Hidden">
    <div class="Title H22 LH22 TC">
        论坛贴子检索
    </div>
    <dl class="Middle Hidden">
	    <dd class="Left TC" style="width:35%;height:150px">搜索条件：</dd>
	    <dd>
			<input type="checkbox" value="board" checked name="Condition" />按版面：<asp:DropDownList ID="BoardID" runat="server" /><br />
			<input type="checkbox" value="title" checked name="Condition" />按标题：<asp:TextBox ID="Title" runat="server" /><br />
			<input type="checkbox" value="name" name="Condition" />按发帖用户名：<asp:TextBox ID="UserName" runat="server" /><br />
			<input type="checkbox" value="id" name="Condition" />按发帖用户ID：<asp:TextBox ID="UserID" runat="server" /><br />
			<input type="checkbox" value="addtime" name="Condition" />按发帖时间：从<asp:TextBox ID="StartAddTime" runat="server" /><A onclick="return showCalendar('_ctl0:Main:Search1:_ctl0:StartAddTime', 'y-mm-dd');" href="#"><IMG alt="选择日期" src="images/calendar.gif" border="0"></A> 到 <asp:TextBox ID="EndAddTime" runat="server" /> <A onclick="return showCalendar('_ctl0:Main:Search1:_ctl0:EndAddTime', 'y-mm-dd');" href="#"><IMG alt="选择日期" src="images/calendar.gif" border="0"></A> <br />
			<input type="checkbox" value="click" name="Condition" />按点击率：从<asp:TextBox ID="StartClick" runat="server" Width="45px" />到 <asp:TextBox ID="EndClick" runat="server" Width="45px" /><br />
			<input type="checkbox" value="reply" name="Condition" />按回复量：从<asp:TextBox ID="StartReply" runat="server" Width="45px" />到 <asp:TextBox ID="EndReply" runat="server" Width="45px" />
		</dd>
	</dl>
    <div class="Footer PTB5 BT TC">
		<asp:Button CssClass="Button" ID="SubmitButton" Text="确定搜索" runat="server" />
    </div>
</div>