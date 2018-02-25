<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true" %>
<%@ Register TagPrefix="DXBBS" Namespace="DXBBS.Controls" Assembly="DXBBS.Controls" %>
<script src="js/dxbbs.js"></script>
<div class="Block">
    <div class="Possition">
		<img src="<% = ForumConfig.ReadConfigInfo().SkinPath %>/boardicon.gif" align="absmiddle" /><DXBBS:Possition ID="Possition1" runat="server" />回复主题
	</div>
</div>
<div class="Block Hidden">
    <div class="Title TC P5">
		回复主题
	</div>
    <div class="Middle M1 Hidden">
        <div class="TopicLeft P5">类型：</div>
		<div class="TopicRight P5"><asp:DropDownList ID="State" runat="server" AutoPostBack="true" /></div>
    </div>
    <div class="Middle M1 Hidden">
        <div class="TopicLeft P5">标题：</div>
        <div class="TopicRight P5"><asp:TextBox ID="Title" runat="server" Width="550px" MaxLength="50" /><asp:RequiredFieldValidator ID="NeedTitle" ErrorMessage="请输入标题" Display="dynamic" ControlToValidate="Title" runat="server" /></div>
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
        <div class="TopicRight P5"><asp:TextBox ID="Color" Text="#FFFFFF" runat="server" /> <span id="ColorSpan" style="background-color:#000000">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;<IMG style="CURSOR: pointer" onclick="SelectColor('_ctl0:Main:Reply1:_ctl0:Color','ColorSpan')" src="images/forecolor.gif"></div>
    </div>
    </asp:PlaceHolder>
    <asp:PlaceHolder ID="ShowCoin" Visible="false" runat="server">
    <div class="Middle M1 Hidden">
        <div class="TopicLeft P5">购买需要金币：</div>
        <div class="TopicRight P5"><asp:TextBox ID="Coin" Text="1" runat="server" /></div>
    </div>
    </asp:PlaceHolder>
	<div class="Middle M1 Hidden">
	    <div class="TopicLeft P5">上传文件</div>
	    <div class="TopicRight P5">
			<iframe src="Upload.aspx?BoardID=<% = Requests.GetIntQueryString("BoardID") %>&TopicID=<% = Requests.GetIntQueryString("TopicID") %>&ReplyID=<% = Requests.GetIntQueryString("ReplyID") %>&Types=1" width="100%" height="22px" frameborder="0" allowTransparency="true" scrolling="no"></iframe>
		</div>
	</div>
    <div class="Middle M1 Hidden">
		<div class="TopicLeft">
			<div class="BB P5">回复表情</div>
			<div style="margin:10px 0px;height:190px;overflow:auto">
			<asp:Repeater ID="Emote" runat="server">
			    <itemTemplate>
			    <img src="<%# Eval("FileName") %>" title="<%# Eval("EmoteName") %>" style="cursor:pointer;padding:2px;height:18px;width:18px" onclick="Emote('<%# Eval("FileName") %>','_ctl0:Main:Reply1:_ctl0:Content')" />
			    </itemTemplate>
			</asp:Repeater>
			</div>
		</div>
	    <div class="TopicRight">
			<div class="P5"><DXBBS:Editor ID="Content" Width="550px" Height="200px" runat="server" /></div>
		</div>
	</div>
	<asp:PlaceHolder ID="ShowReplyCode" runat="server">
    <div class="Middle M1 Hidden">
        <div class="TopicLeft P5">验证码：</div>
        <div class="TopicRight P5"><asp:TextBox ID="ReplyCode" Width="60px" runat="server" /> <asp:RequiredFieldValidator ID="NeedCode" ErrorMessage="请输入验证码" ControlToValidate="ReplyCode" Display="dynamic" runat="server" /><img src="ShowCode.aspx" align="absmiddle" /></div>
    </div>
	</asp:PlaceHolder>
	<div class="Middle TC"><asp:Button CssClass="Button" ID="PostButton" Text="确定发表" runat="server" /></div>
</div>