<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true"%>
<%@ Register TagPrefix="DXBBS" Namespace="DXBBS.Controls" Assembly="DXBBS.Controls" %>
<div class="BodyBlock PTB5">
	<div class="Block Hidden">
		<div class="Title H22 LH22 TC">
			综合管理-->论坛历史记录查看
		</div>
		<ul class="Header TC">
			<li style="width:5%">ID</li>
			<li style="width:15%">当天发帖</li>
			<li style="width:15%">当天回复</li>
			<li style="width:15%">当天注册用户</li>
			<li style="width:15%">当天最高在线</li>
			<li style="width:15%">用户总登录次数</li>
			<li style="width:19%">日期时间</li>
		</ul>
		<asp:Repeater ID="HistoryList" runat="server">
		<ItemTemplate>
			<ul class="TC">
				<li style="width:5%"><%# Eval("ID") %></li>
				<li style="width:15%"><%# Eval("TodayTopic") %></li>
				<li style="width:15%"><%# Eval("TodayReply") %></li>
				<li style="width:15%"><%# Eval("TodayRegister") %></li>
				<li style="width:15%"><%# Eval("TodayOnline") %></li>
				<li style="width:15%"><%# Eval("TodayLogin") %></li>
				<li style="width:19%"><%# Convert.ToDateTime(Eval("AddTime")).ToShortDateString() %></li>
			</ul>
		</ItemTemplate>
		</asp:Repeater>
	</div>
	<div class="BlankBlock Hidden">
        <DXBBS:ForumPager ID="CommonPager" runat="server" />
    </div>
</div>