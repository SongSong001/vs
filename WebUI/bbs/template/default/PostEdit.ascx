<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true" %>
<%@ Register TagPrefix="DXBBS" Namespace="DXBBS.Controls" Assembly="DXBBS.Controls" %>
<script src="js/dxbbs.js" type="text/javascript"></script>
<div class="Block">
    <div class="Possition">
		<img src="<% = ForumConfig.ReadConfigInfo().SkinPath %>/boardicon.gif" align="absmiddle" /><DXBBS:Possition ID="Possition1" runat="server" />贴子操作
	</div>
</div>
<asp:PlaceHolder ID="ShowEdit" Visible="false" runat="server">
<div class="Block Hidden">
    <div class="Title TC P5">
		编辑帖子
	</div>
    <div class="Middle M1 Hidden">
        <div class="TopicLeft P5">类型：</div>
		<div class="TopicRight P5"><asp:DropDownList ID="State" AutoPostBack="true" runat="server" /></div>
    </div>
	<asp:PlaceHolder ID="ShowGroup" Visible="false" runat="server">
    <div class="Middle M1 Hidden">
        <div class="TopicLeft P5">专题：</div>
		<div class="TopicRight P5"><asp:DropDownList ID="Group" runat="server" /></div>
    </div>
	</asp:PlaceHolder>
    <div class="Middle M1 Hidden">
        <div class="TopicLeft P5">标题：</div>
        <div class="TopicRight P5"><asp:TextBox ID="Title" runat="server" Width="550px" MaxLength="50" /></div>
	</div>
	<asp:PlaceHolder ID="ShowVote" Visible="false" runat="server">
		<div class="Middle M1 Hidden">
		    <div class="TopicLeft P5">投票选项：</div>
			<div class="TopicRight P5">
		        &nbsp;<asp:RadioButtonList ID="VoteTypeSelect" RepeatLayout="flow" RepeatDirection="horizontal" runat="server"><asp:ListItem Value="1" Text="单选投票" Selected="true" /><asp:ListItem Value="2" Text="多选投票" /></asp:RadioButtonList>,有效期&nbsp;<asp:TextBox ID="Days" Text="0" Width="20" runat="server" />&nbsp;天(0表示无限制)<br />
		        &nbsp;<asp:TextBox ID="Vote" TextMode="multiLine" Width="550px" Height="100px" runat="server" /><asp:RequiredFieldValidator ID="NeedVote" ErrorMessage="请填写投票内容" ControlToValidate="Vote" Display="dynamic" runat="server" /><br />
		        &nbsp;<span class="Red">*不同的投票选项间请用回车换行表示</span>
		    </div>
		</div>
	</asp:PlaceHolder>
    <asp:PlaceHolder ID="ShowRight" Visible="false" runat="server">
    <div class="Middle M1 Hidden">
        <div class="TopicLeft P5">可查看对象：</div>
        <div class="TopicRight P5">
			<div style="padding:5px" class=""><asp:CheckBox ID="OnLevel" runat="server" Checked="true" /> 按等级控制</div>
			<div style="padding:5px" class="BT"><asp:CheckBoxList ID="Level" RepeatLayout="flow" RepeatDirection="horizontal" runat="server" /></div>
			<div style="padding:5px" class="BT"><asp:CheckBox ID="OnTeam" runat="server" /> 按圈子控制</div>
			<div style="padding:5px" class="BT"><asp:CheckBoxList ID="Team" RepeatLayout="flow" RepeatDirection="horizontal" runat="server" /></div>
        </div>
    </div>
    </asp:PlaceHolder>
    <asp:PlaceHolder ID="ShowColor" Visible="false" runat="server">
    <div class="Middle M1 Hidden">
        <div class="TopicLeft P5">选择标题颜色：</div>
        <div class="TopicRight P5"><asp:TextBox ID="Color" Text="#FFFFFF" runat="server" /> <span id="ColorSpan" style="background-color:#000000">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;<IMG style="CURSOR: pointer" onclick="SelectColor('_ctl0:Main:PostEdit1:_ctl0:Color','ColorSpan')" src="images/forecolor.gif"></div>
    </div>
    </asp:PlaceHolder>
    <asp:PlaceHolder ID="ShowCoin" Visible="false" runat="server">
    <div class="Middle M1 Hidden">
        <div class="TopicLeft P5">购买需要金币：</div>
        <div class="TopicRight P5"><asp:TextBox ID="Coin" Text="1" runat="server" />个金币</div>
    </div>
    </asp:PlaceHolder>
    <asp:PlaceHolder ID="ShowAsk" Visible="false" runat="server">
    <div class="Middle M1 Hidden">
        <div class="TopicLeft P5">奖励金币：</div>
        <div class="TopicRight P5"><asp:TextBox ID="AskCoin" Text="1" runat="server" />个金币</div>
    </div>
    </asp:PlaceHolder>
	<div class="Middle M1 Hidden">
	    <div class="TopicLeft P5">上传文件</div>
	    <div class="TopicRight P5"><iframe src="Upload.aspx?BoardID=<% = Requests.GetIntQueryString("BoardID") %>&TopicID=<% = Requests.GetIntQueryString("TopicID") %>&ReplyID=<% = Requests.GetIntQueryString("ReplyID") %>&Types=2" width="100%" height="22px" frameborder="0" allowTransparency="true" scrolling="no"></iframe></div>
	</div>
    <div class="Middle M1 Hidden">
		<div class="TopicLeft">
			<div class="BB P5">发贴表情</div>
			<div style="margin:10px 0px;height:280px;overflow:auto">
			<asp:Repeater ID="Emote" runat="server">
			    <itemTemplate>
			    <img src="<%# Eval("FileName") %>" title="<%# Eval("EmoteName") %>" style="cursor:pointer;padding:2px;height:18px;width:18px" onclick="Emote('<%# Eval("FileName") %>','_ctl0:Main:PostEdit1:_ctl0:Content')" />
			    </itemTemplate>
			</asp:Repeater>
			</div>
		</div>
	    <div class="TopicRight">
			<div class="P5"><DXBBS:Editor ID="Content" Width="550px" Height="350px" runat="server" /></div>
			<div class="P5"><asp:Button CssClass="Button" ID="EditButton" Text="确定修改" runat="server" /></div>
		</div>
	</div>
</div>
</asp:PlaceHolder>
<asp:PlaceHolder ID="ShowDelete" Visible="false" runat="server">
<div class="Block Hidden">
    <div class="Title TC P5">
		删除贴子
	</div>
    <div class="Middle M1 Hidden H25">
        <div class="TopicLeft P5">标题：</div>
		<div class="TopicRight P5"><asp:Label ID="DeleteTopic" ForeColor="red" runat="server" /></div>
    </div>
    <div class="Middle M1 Hidden H25">
        <div class="TopicLeft P5">发帖用户：</div>
		<div class="TopicRight P5"><asp:Label ID="DeleteTopicAddUser" runat="server" /></div>
    </div>
    <div class="Middle M1 Hidden">
        <div class="TopicLeft P5">操作金币：</div>
		<div class="TopicRight P5"><asp:Label ID="DeleteCoin" runat="server"/>&nbsp;<asp:CheckBox ID="DeleteDealCoin" Text="不操作金币" runat="server" /></div>
    </div>
    <div class="Middle M1 Hidden">
        <div class="TopicLeft P5">操作积分：</div>
		<div class="TopicRight P5"><asp:Label ID="DeletePoint" runat="server"/>&nbsp;<asp:CheckBox ID="DeleteDealPoint" Text="不操作积分" runat="server" /></div>
    </div>
    <div class="Middle M1 Hidden">
        <div class="TopicLeft P5">删除原因：</div>
		<div class="TopicRight P5"><asp:TextBox ID="DeleteReason" MaxLength="50" runat="server" />&nbsp;<asp:CheckBox ID="DeleteMessage" Checked="true" runat="server" />短信通知用户</div>
    </div>
    <div class="Footer M1 PTB5 TC">
		<asp:Button CssClass="Button" ID="DeleteButton" Text="确定删除" runat="server" />
    </div>
</div>
</asp:PlaceHolder>
<asp:PlaceHolder ID="ShowGood" Visible="false" runat="server">
<div class="Block Hidden">
    <div class="Title TC P5">
		贴子加精
	</div>
    <div class="Middle M1 Hidden H25">
        <div class="TopicLeft P5">标题：</div>
		<div class="TopicRight P5"><asp:Label ID="GoodTopic" ForeColor="red" runat="server" /></div>
    </div>
    <div class="Middle M1 Hidden H25">
        <div class="TopicLeft P5">发帖用户：</div>
		<div class="TopicRight P5"><asp:Label ID="GoodTopicAddUser" runat="server" /></div>
    </div>
    <div class="Middle M1 Hidden">
        <div class="TopicLeft P5">操作金币：</div>
		<div class="TopicRight P5"><asp:Label ID="GoodCoin" runat="server"/>&nbsp;<asp:CheckBox ID="GoodDealCoin" Text="不操作金币" runat="server" /></div>
    </div>
    <div class="Middle M1 Hidden">
        <div class="TopicLeft P5">操作积分：</div>
		<div class="TopicRight P5"><asp:Label ID="GoodPoint" runat="server"/>&nbsp;<asp:CheckBox ID="GoodDealPoint" Text="不操作积分" runat="server" /></div>
    </div>
    <div class="Middle M1 Hidden">
        <div class="TopicLeft P5">加精原因：</div>
		<div class="TopicRight P5"><asp:TextBox ID="GoodReason" MaxLength="50" runat="server" />&nbsp;<asp:CheckBox ID="GoodMessage" Checked="true" runat="server" />短信通知用户</div>
    </div>
    <div class="Footer M1 PTB5 TC">
    	<asp:Button CssClass="Button" ID="GoodButton" Text="确定加精" runat="server" />
    </div>
</div>
</asp:PlaceHolder>
<asp:PlaceHolder ID="ShowDeleteGood" Visible="false" runat="server">
<div class="Block Hidden">
    <div class="Title TC P5">
		贴子解精
	</div>
    <div class="Middle M1 Hidden H25">
        <div class="TopicLeft P5">标题：</div>
		<div class="TopicRight P5"><asp:Label ID="DeleteGoodTopic" ForeColor="red" runat="server" /></div>
    </div>
    <div class="Middle M1 Hidden H25">
        <div class="TopicLeft P5">发帖用户：</div>
		<div class="TopicRight P5"><asp:Label ID="DeleteGoodTopicAddUser" runat="server" /></div>
    </div>
    <div class="Middle M1 Hidden">
        <div class="TopicLeft P5">解精原因：</div>
		<div class="TopicRight P5"><asp:TextBox ID="DeleteGoodReason" MaxLength="50" runat="server" />&nbsp;<asp:CheckBox ID="DeleteGoodMessage" Checked="true" runat="server" />短信通知用户</div>
    </div>
    <div class="Footer M1 PTB5 TC">
		<asp:Button CssClass="Button" ID="DeleteGoodButton" Text="确定解精" runat="server" />
    </div>
</div>
</asp:PlaceHolder>
<asp:PlaceHolder ID="ShowMove" Visible="false" runat="server">
<div class="Block Hidden">
    <div class="Title TC P5">
		贴子移动
	</div>
    <div class="Middle M1 Hidden H25">
        <div class="TopicLeft P5">标题：</div>
		<div class="TopicRight P5"><asp:Label ID="MoveTopic" ForeColor="red" runat="server" /></div>
    </div>
    <div class="Middle M1 Hidden H25">
        <div class="TopicLeft P5">发帖用户：</div>
		<div class="TopicRight P5"><asp:Label ID="MoveTopicAddUser" runat="server" /></div>
    </div>
    <div class="Middle M1 Hidden">
        <div class="TopicLeft P5">原版面：</div>
		<div class="TopicRight P5"><asp:DropDownList ID="FromBoard" Enabled="false" runat="server" /></div>
    </div>
    <div class="Middle M1 Hidden">
        <div class="TopicLeft P5">移动到版面：</div>
 		<div class="TopicRight P5"><asp:DropDownList ID="ToBoard" runat="server" /></div>
    </div>
    <div class="Middle M1 Hidden">
        <div class="TopicLeft P5">移动原因：</div>
		<div class="TopicRight P5"><asp:TextBox ID="MoveReason" MaxLength="50" runat="server" />&nbsp;<asp:CheckBox ID="MoveMessage" Checked="true" runat="server" />短信通知用户</div>
    </div>
    <div class="Footer M1 PTB5 TC">
		<asp:Button CssClass="Button" ID="MoveButton" Text="确定移动" runat="server" />
    </div>
</div>
</asp:PlaceHolder>
<asp:PlaceHolder ID="ShowHide" Visible="false" runat="server">
<div class="Block Hidden">
    <div class="Title TC P5">
		屏蔽帖子
	</div>
    <div class="Middle M1 Hidden H25">
        <div class="TopicLeft P5">标题：</div>
		<div class="TopicRight P5"><asp:Label ID="HideTopic" ForeColor="red" runat="server" /></div>
    </div>
    <div class="Middle M1 Hidden H25">
        <div class="TopicLeft P5">发帖用户：</div>
		<div class="TopicRight P5"><asp:Label ID="HideTopicAddUser" runat="server" /></div>
    </div>
    <div class="Middle M1 Hidden">
        <div class="TopicLeft P5">屏蔽原因：</div>
		<div class="TopicRight P5"><asp:TextBox ID="HideReason" MaxLength="50" runat="server" />&nbsp;<asp:CheckBox ID="HideMessage" Checked="true" runat="server" />短信通知用户</div>
    </div>
    <div class="Footer M1 PTB5 TC">
		<asp:Button CssClass="Button" ID="HideButton" Text="确定屏蔽" runat="server" />
    </div>
</div>
</asp:PlaceHolder>
<asp:PlaceHolder ID="ShowDeleteHide" Visible="false" runat="server">
<div class="Block Hidden">
    <div class="Title TC P5">
		解屏帖子
	</div>
    <div class="Middle M1 Hidden H25">
        <div class="TopicLeft P5">标题：</div>
		<div class="TopicRight P5"><asp:Label ID="DeleteHideTopic" ForeColor="red" runat="server" /></div>
    </div>
    <div class="Middle M1 Hidden H25">
        <div class="TopicLeft P5">发帖用户：</div>
		<div class="TopicRight P5"><asp:Label ID="DeleteHideTopicAddUser" runat="server" /></div>
    </div>
    <div class="Middle M1 Hidden">
        <div class="TopicLeft P5">解屏原因：</div>
		<div class="TopicRight P5"><asp:TextBox ID="DeleteHideReason" MaxLength="50" runat="server" />&nbsp;<asp:CheckBox ID="DeleteHideMessage" Checked="true" runat="server" />短信通知用户</div>
    </div>
    <div class="Footer M1 PTB5 TC">
		<asp:Button CssClass="Button" ID="DeleteHideButton" Text="确定解屏" runat="server" />
    </div>
</div>
</asp:PlaceHolder>
<asp:PlaceHolder ID="ShowLock" Visible="false" runat="server">
<div class="Block Hidden">
    <div class="Title TC P5">
		锁定帖子
	</div>
    <div class="Middle M1 Hidden H25">
        <div class="TopicLeft P5">标题：</div>
		<div class="TopicRight P5"><asp:Label ID="LockTopic" ForeColor="red" runat="server" /></div>
    </div>
    <div class="Middle M1 Hidden H25">
        <div class="TopicLeft P5">发帖用户：</div>
		<div class="TopicRight P5"><asp:Label ID="LockTopicAddUser" runat="server" /></div>
    </div>
    <div class="Middle M1 Hidden">
        <div class="TopicLeft P5">锁定原因：</div>
		<div class="TopicRight P5"><asp:TextBox ID="LockReason" MaxLength="50" runat="server" />&nbsp;<asp:CheckBox ID="LockMessage" Checked="true" runat="server" />短信通知用户</div>
    </div>
    <div class="Footer M1 PTB5 TC">
		<asp:Button CssClass="Button" ID="LockButton" Text="确定锁定" runat="server" />
    </div>
</div>
</asp:PlaceHolder>
<asp:PlaceHolder ID="ShowDeleteLock" Visible="false" runat="server">
<div class="Block Hidden">
    <div class="Title TC P5">
		解锁帖子
	</div>
    <div class="Middle M1 Hidden H25">
        <div class="TopicLeft P5">标题：</div>
		<div class="TopicRight P5"><asp:Label ID="DeleteLockTopic" ForeColor="red" runat="server" /></div>
    </div>
    <div class="Middle M1 Hidden H25">
        <div class="TopicLeft P5">发帖用户：</div>
		<div class="TopicRight P5"><asp:Label ID="DeleteLockTopicAddUser" runat="server" /></div>
    </div>
    <div class="Middle M1 Hidden">
        <div class="TopicLeft P5">解锁原因：</div>
		<div class="TopicRight P5"><asp:TextBox ID="DeleteLockReason" MaxLength="50" runat="server" />&nbsp;<asp:CheckBox ID="DeleteLockMessage" Checked="true" runat="server" />短信通知用户</div>
    </div>
    <div class="Footer M1 PTB5 TC">
		<asp:Button CssClass="Button" ID="DeleteLockButton" Text="确定解锁" runat="server" />
    </div>
</div>
</asp:PlaceHolder>