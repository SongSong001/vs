<%@ Control Language="C#" AutoEventWireup="true" %>
<%@ Import Namespace="DXBBS.Components"%>
<%@ Register TagPrefix="DXBBS" Namespace="DXBBS.Controls" Assembly="DXBBS.Controls" %>
<asp:Repeater ID="VChildBoard" runat="server">
<ItemTemplate>
    <div class="Middle M1 Hidden" onmouseover="this.className='Footer M1 Hidden'" onmouseout="this.className='Middle M1 Hidden'">
    <div style="width:100%">
        <div class="BoardRight">
            <div>标题：<a href="<%# URLConfig.TopicURL.Replace("$BoardID",Eval("ActiveBoardID").ToString()).Replace("$TopicID",Eval("ActiveTopicID").ToString()) %>" title='<%# Eval("FullTopicTitle") %>'><%# Eval("ActiveTopicTitle") %></a></div>
            <div>作者：<a href="ControlPanel.aspx?UserID=<%# Eval("ActiveUserID") %>" target=_blank><%# Eval("ActiveUser") %></a></div>
        </div>
        <div class="Right P5"><DXBBS:BoardPhoto ID="BoardPhoto1" PhotoFile='<%# Eval("Photo") %>' runat="server" /></div>
        <div class="BoardIcon"><img src="<%# Eval("Icon") %>" align="absmiddle" /></div>
        <div class="BoardContent">
            <a href="<%# URLConfig.BoardURL.Replace("$BoardID",Eval("ID").ToString()).Replace("$GroupID","0")  %>" title="点击进入这个版面"><strong><font color="<%# Eval("TitleColor") %>"><%# Eval("BoardName") %></font></strong></a>&nbsp;<span class="Red"><%# (Eval("TodayTopic").ToString() != "0" || Eval("TodayReply").ToString() != "0")?" [ 今日:" + ((int)Eval("TodayTopic")+(int)Eval("TodayReply")) + " ]":"" %></span><br/>
            <%# Eval("Content") %>
        </div>
	</div>
    </div>
</ItemTemplate>
</asp:Repeater>
<DXBBS:SeparatorRepeater ID="HChildBoard" Visible="false" runat="server">
    <HeaderTemplate>
    <div class="Middle M1 Hidden">
    </HeaderTemplate>
	<ItemTemplate>
		<div class="Left Hidden" style="width:<%= Convert.ToDouble(100)/Convert.ToDouble(HChildBoard.PageSize) %>%;border-bottom:1px #FFFFFF solid;background-color:#EFF4F8" title="<%# Eval("Content") %>">
			<div class="BoardIcon_I"><img src="<%# Eval("Icon") %>" align="absmiddle"/></div>
			<div style="text-align:left">
				<div class="BoardRight_I">
					<div><a href="<%# URLConfig.BoardURL.Replace("$BoardID",Eval("ID").ToString()).Replace("$GroupID","0") %>" title="点击进入论版块"><strong><font color="<%# Eval("TitleColor") %>"><%# Eval("BoardName") %></font></strong></a></div>
					<div>今日:<%# (int)Eval("TodayTopic")+(int)Eval("TodayReply") %> 主题:<%# Eval("TotalTopic") %> 贴数:<%# Eval("TotalReply") %></div>
					<div>更新: <%# Convert.ToDateTime(Eval("ActiveTime")).ToString("yyyy/MM/dd tt") %></div>
				</div>
			</div>
		</div>
    </ItemTemplate>
    <FooterTemplate>
    </div>
    </FooterTemplate>
</DXBBS:SeparatorRepeater>
