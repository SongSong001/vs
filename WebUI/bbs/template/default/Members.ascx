<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true"%>
<%@ Register TagPrefix="DXBBS" Namespace="DXBBS.Controls" Assembly="DXBBS.Controls" %>
<div class="Block">
    <div class="Possition">
		<img src="<% = ForumConfig.ReadConfigInfo().SkinPath %>/boardicon.gif" align="absmiddle" /><DXBBS:Possition ID="Possition1" runat="server" />论坛用户列表 [ <a href="Members.aspx">注册时间</a> - <a href="Members.aspx?Action=Topic">发帖量</a> - <a href="Members.aspx?Action=Reply">回帖量</a> - <a href="Members.aspx?Action=Coin">金币</a> - <a href="Members.aspx?Action=Point">积分</a> - <a href="Members.aspx?Action=Male">男</a> - <a href="Members.aspx?Action=Female">女</a> ]
	</div>
</div>
<div class="Block Hidden">
    <div class="Title H22 LH22 TC">
        论坛会员
    </div>
	<ul class="Header TC Hidden">
	    <li style="width:60px">ID</li>
	    <li>用户名</li>
		<li class="Right" style="width:80px">最后登录时间</li>
		<li class="Right" style="width:80px">注册时间</li>
		<li class="Right" style="width:60px">回复量</li>
		<li class="Right" style="width:60px">发帖量</li>
		<li class="Right" style="width:60px">积分</li>
		<li class="Right" style="width:60px">金币</li>
		<li class="Right" style="width:120px">等级</li>
		<li class="Right" style="width:30px">姓别</li>
	</ul>
	<asp:Repeater ID="UserList" runat="server">
	<ItemTemplate>
	<ul class="TC Hidden">
	    <li style="width:60px"><%# Eval("ID") %></li>
		<li><a href='ControlPanel.aspx?UserID=<%# Eval("ID") %>'><%# Eval("UserName") %></a></li>
		<li class="Right" style="width:80px"><%# Convert.ToDateTime(Eval("LoginTime")).ToString("yyyy/MM/dd") %></li>
		<li class="Right" style="width:80px"><%# Convert.ToDateTime(Eval("RegTime")).ToString("yyyy/MM/dd") %></li>
		<li class="Right" style="width:60px"><%# Eval("Reply") %></li>
		<li class="Right" style="width:60px"><%# Eval("Topic") %></li>
		<li class="Right" style="width:60px"><%# Eval("Point") %></li>
		<li class="Right" style="width:60px"><%# Eval("Coin") %></li>
		<li class="Right" style="width:120px"><DXBBS:LevelName ID="LevelName1" DataSource='<%# Eval("LevelID") %>' runat="server" /></li>
		<li class="Right" style="width:30px"><DXBBS:UserSex ID="UserSex1" DataSource='<%# Eval("Sex") %>' runat="server" /></li>
	</ul>
	</ItemTemplate>
	</asp:Repeater>
</div>
    <div class="BlankBlock Hidden">
	    <DXBBS:ForumPager ID="CommonPager" runat="server" />
    </div>