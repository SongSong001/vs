<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true"%>
<%@ Register TagPrefix="DXBBS" Namespace="DXBBS.Controls" Assembly="DXBBS.Controls" %>
<script language="javascript">
//全选全不选
function SelectAll(obj,select)
{
    var operator=eval("aspnetForm." + select);
    if (operator != null)
    {
        if (operator.length == null)
        {
            operator.checked=obj.checked;
        }
        else
        {
            for (i=0;i<operator.length;i++)
            {
                if(operator[i].checked!=obj.checked)
                {
                    operator[i].checked=obj.checked;
                }
            }
        }
    }
}
//检查操作
function CheckSelect(select)
{
    var checked=false;
    var operator=eval("aspnetForm." + select);
    if (operator != null)
    {
        if (operator.length == null)
        {
            if (operator.checked == true)
            {
                checked=true;
            }
        }
        else
        {
            for (i=0;i<operator.length;i++)
            {
                if(operator[i].checked == true)
                {
                    checked=true;
                }
            }
        }
    }
    if (checked == false)
    {
        alert("请选择要操作的记录");
        return false;
    }
    else
    {
        if (!confirm("注意：请问确定要操作吗"))
        {
            return false;
        }
    }
    return true;
}
</script>
<div class="Block">
    <div class="Possition">
		<img src="<% = ForumConfig.ReadConfigInfo().SkinPath %>/boardicon.gif" align="absmiddle" /><DXBBS:Possition ID="Possition1" runat="server" />论坛圈子
	</div>
</div>
<asp:PlaceHolder ID="ShowMenu" Visible="false" runat="server">
<div class="Block Hidden">
    <ul class="Middle TC Cursor">
        <li style="width:18%" class=" BR" onmouseover="this.className='Header BR'" onmouseout="this.className='Middle BR'" onclick="location.href='Team.aspx?ID=<% = Requests.GetIntQueryString("ID") %>&Action=Info'">基本资料</li>
        <li style="width:16%" class="BR" onmouseover="this.className='Header BR'" onmouseout="this.className='Middle BR'" onclick="location.href='Team.aspx?ID=<% = Requests.GetIntQueryString("ID") %>&Action=Member'">圈内成员</li>
        <li style="width:16%" class="BR" onmouseover="this.className='Header BR'" onmouseout="this.className='Middle BR'" onclick="location.href='Team.aspx?ID=<% = Requests.GetIntQueryString("ID") %>&Action=News'">圈内公告</li>
        <li style="width:16%" class="BR" onmouseover="this.className='Header BR'" onmouseout="this.className='Middle BR'" onclick="location.href='Team.aspx?ID=<% = Requests.GetIntQueryString("ID") %>&Action=Photo'">圈内相册</li>
        <li style="width:16%" class="BR" onmouseover="this.className='Header BR'" onmouseout="this.className='Middle BR'" onclick="location.href='Team.aspx?ID=<% = Requests.GetIntQueryString("ID") %>&Action=Message'">圈内留言簿</li>
        <li style="width:18%;margin-right:-6px" class="BR" onmouseover="this.className='Header BR'" onmouseout="this.className='Middle BR'" onclick="location.href='Team.aspx'">所有圈子</li>
    </ul>
</div>
</asp:PlaceHolder>

<asp:PlaceHolder ID="Apply" Visible="false" runat="server">
<div class="Block Hidden">
    <div class="Title H22 LH22 TC">
        申请圈子
    </div>
    <ul>
        <li style="width:30%">&nbsp;圈子名称：</li>
		<li style="width:70%">
			&nbsp;<asp:TextBox ID="ATeamName" runat="server" Width="60%" /><asp:requiredfieldvalidator ID="Requiredfieldvalidator1" runat="server" ControlToValidate="ATeamName" Display="Dynamic" ErrorMessage="请填写圈子名称"></asp:requiredfieldvalidator>
		</li>
	</ul>
    <ul>
        <li style="width:30%">&nbsp;圈子代表图片：</li>
		<li style="width:70%">
			&nbsp;<asp:TextBox ID="APhoto" runat="server" Text="images/team.gif" Width="60%" /></li>
	</ul>
    <ul>
        <li style="width:30%">&nbsp;加入圈子是否需要审核：</li>
		<li style="width:70%">
			&nbsp;<asp:DropDownList ID="ANeedConfirm" runat="server"><asp:ListItem Text="需要" Value="1" /><asp:ListItem Text="不需要" Value="0" /></asp:DropDownList>
		</li>
	</ul>
    <ul>
        <li style="width:30%">&nbsp;圈子资料是对外公开：</li>
		<li style="width:70%">
			&nbsp;<asp:DropDownList ID="AIsPublic" runat="server"><asp:ListItem Text="公开" Value="1" /><asp:ListItem Text="不公开" Value="0" /></asp:DropDownList>
		</li>
	</ul>
    <ul style="height:85px">
        <li style="width:30%">&nbsp;圈子简介：</li>
		<li style="width:70%">
			&nbsp;<asp:TextBox ID="AIntroduce" TextMode="multiLine" runat="server" Width="60%" Height="80" /></li>
	</ul>
	<div class="Footer PTB5 TC">
		<asp:Button CssClass="Button" ID="TeamApplyButton" Text="确定申请" runat="server" />
	</div>
</div>
</asp:PlaceHolder>
<asp:PlaceHolder ID="Info" Visible="false" runat="server">
<div class="Block Hidden">
    <div class="Title H22 LH22 TC">
        基本资料
    </div>
    <ul style="height:105px">
		<li class="TC" style="width:20%">
			<asp:Image ID="SPhoto" runat="server" />
		</li>
		<li style="width:30%;height:105px" class="BL BR">
			&nbsp;圈子名称：<asp:Label ID="STeamName" runat="server" /><br />
			&nbsp;圈内人数：<asp:Label ID="SMembers" runat="server" /><br />
			&nbsp;圈子圈主：<asp:Label ID="SMaster" runat="server" /><br />
			&nbsp;建立时间：<asp:Label ID="SAddTime" runat="server" /><br />
		</li>
		<li style="width:49%">
			&nbsp;圈子简介：<br />
			&nbsp;<asp:Label ID="SIntroduce" runat="server" /><br />
		</li>
	</ul>
</div>
<asp:PlaceHolder ID="InfoManage" Visible="false" runat="server">
<div class="Block Hidden">
    <div class="Title H22 LH22 TC">
        圈子资料修改
    </div>
    <ul>
        <li style="width:30%">&nbsp;圈子名称：</li>
		<li style="width:70%">
			&nbsp;<asp:TextBox ID="MTeamName" runat="server" Width="60%" /><asp:requiredfieldvalidator ID="NeedTeamName" runat="server" ControlToValidate="MTeamName" Display="Dynamic" ErrorMessage="请填写圈子名称"></asp:requiredfieldvalidator>
		</li>
	</ul>
    <ul>
        <li style="width:30%">&nbsp;圈子代表图片：</li>
		<li style="width:70%">
			&nbsp;<asp:TextBox ID="MPhoto" runat="server" Width="60%" /></li>
	</ul>
    <ul>
        <li style="width:30%">&nbsp;加入圈子是否需要审核：</li>
		<li style="width:70%">
			&nbsp;<asp:DropDownList ID="MNeedConfirm" runat="server"><asp:ListItem Text="需要" Value="1" /><asp:ListItem Text="不需要" Value="0" /></asp:DropDownList>
		</li>
	</ul>
    <ul>
        <li style="width:30%">&nbsp;圈子资料是对外公开：</li>
		<li style="width:70%">
			&nbsp;<asp:DropDownList ID="MIsPublic" runat="server"><asp:ListItem Text="公开" Value="1" /><asp:ListItem Text="不公开" Value="0" /></asp:DropDownList>
		</li>
	</ul>
    <ul style="height:85px">
        <li style="width:30%">&nbsp;圈子简介：</li>
		<li style="width:70%">
			&nbsp;<asp:TextBox ID="MIntroduce" TextMode="multiLine" runat="server" Width="60%" Height="80" Wrap="true" /></li>
	</ul>
	<div class="Footer PTB5 TC">
        <asp:Button CssClass="Button" ID="InfoSubmitButton" Text="确定修改" runat="server" />
    </div>
</div>
</asp:PlaceHolder>
</asp:PlaceHolder>
<asp:PlaceHolder ID="Member" Visible="false" runat="server">
<div class="Block Hidden">
    <div class="Title H22 LH22 TC">
        圈内成员
    </div>
	<ul class="Header TC Hidden">
	    <li style="width:60px">ID</li>
	    <li>用户名</li>
	    <li class="Right" style="width:30px">选择</li>
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
	<ul class="Middle TC Hidden">
	    <li style="width:60px"><%# Eval("ID") %></li>
	    <li><a href='ControlPanel.aspx?UserID=<%# Eval("ID") %>'><%# Eval("UserName") %></a></li>
	    <li class="Right" style="width:30px"><input type="checkbox" name="SelectID" value='<%# Eval("ID") %>' /></li>
		<li class="Right" style="width:80px"><%# Convert.ToDateTime(Eval("RegTime")).ToString("yyyy/MM/dd") %></li>
		<li class="Right" style="width:80px"><%# Convert.ToDateTime(Eval("LoginTime")).ToString("yyyy/MM/dd") %></li>
		<li class="Right" style="width:60px"><%# Eval("Reply") %></li>
		<li class="Right" style="width:60px"><%# Eval("Topic") %></li>
		<li class="Right" style="width:60px"><%# Eval("Point") %></li>
		<li class="Right" style="width:60px"><%# Eval("Coin") %></li>
		<li class="Right" style="width:120px"><DXBBS:LevelName ID="LevelName1" DataSource='<%# Eval("LevelID") %>' runat="server" /></li>
		<li class="Right" style="width:30px"><DXBBS:UserSex ID="UserSex1" DataSource='<%# Eval("Sex") %>' runat="server" /></li>
	</ul>
	</ItemTemplate>
	</asp:Repeater>	
<asp:PlaceHolder ID="MemberManage" Visible="false" runat="server">
	<div class="Footer PTB5 TC">
		<asp:Button CssClass="Button" ID="RemoveMemberButton" Text="踢出圈子" OnClientClick="return CheckSelect('SelectID')" runat="server" />&nbsp;<input type="checkbox" name="All" onclick="SelectAll(this,'SelectID')" />全选/全不选
	</div>
</asp:PlaceHolder>
</div>
<div class="BlankBlock Hidden">
    <DXBBS:ForumPager ID="UserPager" runat="server" />
</div>
<asp:PlaceHolder ID="MemberManage1" Visible="false" runat="server">
<div class="Block Hidden">
    <div class="Title H22 LH22 TC">
        待审核用户
    </div>
	<ul class="Header TC Hidden">
	    <li style="width:60px">ID</li>
	    <li>用户名</li>
	    <li class="Right" style="width:30px">选择</li>
		<li class="Right" style="width:80px">最后登录时间</li>
		<li class="Right" style="width:80px">注册时间</li>
		<li class="Right" style="width:60px">回复量</li>
		<li class="Right" style="width:60px">发帖量</li>
		<li class="Right" style="width:60px">积分</li>
		<li class="Right" style="width:60px">金币</li>
		<li class="Right" style="width:120px">等级</li>
		<li class="Right" style="width:30px">姓别</li>
	</ul>
	<asp:Repeater ID="ManageUserList" runat="server">
	<ItemTemplate>
	<ul class="Middle TC Hidden">
	    <li style="width:60px"><%# Eval("ID") %></li>
	    <li><a href='ControlPanel.aspx?UserID=<%# Eval("ID") %>'><%# Eval("UserName") %></a></li>
	    <li class="Right" style="width:30px"><input type="checkbox" name="SelectID1" value='<%# Eval("ID") %>' /></li>
		<li class="Right" style="width:80px"><%# Convert.ToDateTime(Eval("RegTime")).ToString("yyyy/MM/dd") %></li>
		<li class="Right" style="width:80px"><%# Convert.ToDateTime(Eval("LoginTime")).ToString("yyyy/MM/dd") %></li>
		<li class="Right" style="width:60px"><%# Eval("Reply") %></li>
		<li class="Right" style="width:60px"><%# Eval("Topic") %></li>
		<li class="Right" style="width:60px"><%# Eval("Point") %></li>
		<li class="Right" style="width:60px"><%# Eval("Coin") %></li>
		<li class="Right" style="width:120px"><DXBBS:LevelName ID="LevelName1" DataSource='<%# Eval("LevelID") %>' runat="server" /></li>
		<li class="Right" style="width:30px"><DXBBS:UserSex ID="UserSex1" DataSource='<%# Eval("Sex") %>' runat="server" /></li>
	</ul>
	</ItemTemplate>
	</asp:Repeater>	
	<div class="Footer PTB5 TC">
		<asp:Button CssClass="Button" ID="ConfirmMemberButton" Text="确定审核" OnClientClick="return CheckSelect('SelectID1')" runat="server" />&nbsp;<input type="checkbox" name="All" onclick="SelectAll(this,'SelectID1')" />全选/全不选
	</div>
</div>
<div class="BlankBlock Hidden">
    <DXBBS:ForumPager ID="ManageUserPager" runat="server" />
</div>
</asp:PlaceHolder>
</asp:PlaceHolder>
<asp:PlaceHolder ID="News" Visible="false" runat="server">
<div class="Block Hidden">
    <div class="Title H22 LH22 TC">
        圈内公告
    </div>
	<ul class="Header TC Hidden">
		<li style="width:50px">ID</li>
		<li class="TL">标题</li>
		<li class="Right" style="width:30px">选择</li>
		<li class="Right" style="width:50px">操作</li>
		<li class="Right" style="width:120px">添加时间</li>
    </ul>
	<asp:Repeater ID="NewsList" runat="server">
	<ItemTemplate>
	<ul class="Middle TC Hidden">
		<li style="width:50px"><%# Eval("ID") %></li>
		<li class="TL"><a href='NewsView.aspx?ID=<%# Eval("ID") %>&Action=TeamNews' target="_blank"><%# Eval("Title") %></a></li>
		<li class="Right" style="width:30px"><input type="checkbox" name="SelectID" value="<%# Eval("ID") %>" /></li>
		<li class="Right" style="width:50px"><a href='Team.aspx?Action=News&NewsID=<%# Eval("ID") %>'>修改</a></li>
		<li class="Right" style="width:120px"><%# Eval("AddTime") %></li>
	</ul>
	</ItemTemplate>
	</asp:Repeater>		
<asp:PlaceHolder ID="NewsManage" Visible="false" runat="server">
	<div class="Footer PTB5 TC">
		<asp:Button CssClass="Button" ID="NewsDeleteButton" Text="确定删除" OnClientClick="return CheckSelect('SelectID')" runat="server" />&nbsp;<input type="checkbox" name="All" onclick="SelectAll(this,'SelectID')" />全选/全不选
	</div>
</asp:PlaceHolder>
</div>
<div class="BlankBlock Hidden">
    <DXBBS:ForumPager ID="NewsPager" runat="server" />
</div>
<asp:PlaceHolder ID="NewsManage1" Visible="false" runat="server">
<div class="Block Hidden">
    <div class="Title H22 LH22 TC">
        添加/修改圈内公告
    </div>
	<ul>
        <li style="width:30%">&nbsp;公告标题：</li>
		<li style="width:70%">
			&nbsp;<asp:TextBox ID="NewsTitle" Width="60%" runat="server" /><asp:requiredfieldvalidator ID="NeedNewsTitle" runat="server" ControlToValidate="NewsTitle" Display="Dynamic" ErrorMessage="请填写标题"></asp:requiredfieldvalidator>
		</li style="width:70%">
	</ul>
	<ul style="height:85px">
        <li style="width:30%">&nbsp;公告内容：</li>
		<li style="width:70%">
			&nbsp;<asp:TextBox ID="NewsContent" TextMode="multiLine" Height="80" Width="60%" runat="server" /><asp:requiredfieldvalidator ID="NeedNewsContent" runat="server" ControlToValidate="NewsContent" Display="Dynamic" ErrorMessage="请填写内容"></asp:requiredfieldvalidator>
		</li>
	</ul>
	<div class="Footer PTB5 TC">
        <asp:Button CssClass="Button" ID="NewsAddButton" Text="确定提交" runat="server" />
    </div>
</div>
</asp:PlaceHolder>
</asp:PlaceHolder>
<asp:PlaceHolder ID="Photo" Visible="false" runat="server">
<div class="Block Hidden">
    <div class="Title H22 LH22 TC">
        圈内相册
    </div>
    <dl>
	    <DXBBS:SeparatorRepeater ID="PhotoList" PageSize="5" runat="server">
	    <ItemTemplate>
		    <dd style="width:<%= Convert.ToDouble(100)/Convert.ToDouble(PhotoList.PageSize) %>%;margin-right:-1px" class="Left TC BB PTB5">
		    	<a href='<%# Eval("Photo") %>' title='<%# Eval("Content") %>' target="_blank"><img src='<%# Eval("Photo") %>' width="98" height="98" border="0" /></a><br />
			    	名称：<%# Eval("Title") %><br />
			    上传用户：<a href='ControlPanel.aspx?UserID=<%# Eval("UserID") %>' target="_blank"><%# Eval("UserName") %></a>&nbsp;<input type="checkbox" name="SelectID" value="<%# Eval("ID") %>" />&nbsp;<a href='?ID=<% = Requests.GetIntQueryString("ID") %>&Action=<% = Requests.GetStringQueryString("Action") %>&PhotoID=<%# Eval("ID") %>'>编辑</a><br />
			    上传时间：<%# Eval("AddTime") %>
		    </dd>
	    </ItemTemplate>
	    </DXBBS:SeparatorRepeater>
	</dl>
<asp:PlaceHolder ID="ShowPhotoManage" Visible="false" runat="server">
	<div class="Footer BT PTB5 TC">
		<asp:Button CssClass="Button" ID="PhotoDeleteButton" Text="确定删除" OnClientClick="return CheckSelect('SelectID')" runat="server" />&nbsp;<input type="checkbox" name="All" onclick="SelectAll(this,'SelectID')" />全选/全不选
	</div>
</asp:PlaceHolder>
</div>
<div class="BlankBlock Hidden">
    <DXBBS:ForumPager ID="PhotoPager" runat="server" />
</div>
<asp:PlaceHolder ID="ShowPhotoAdd" Visible="false" runat="server">
<div class="Block Hidden">
    <div class="Title H22 LH22 TC">
        上传/修改相册
    </div>
    <ul>
        <li style="width:30%">&nbsp;图片名称：</li>
        <li style="width:70%">&nbsp;<asp:TextBox ID="PhotoTitle" Width="60%" MaxLength="50" runat="server" /><asp:RequiredFieldValidator ID="NeedPhotoTitle" ControlToValidate="PhotoTitle" ErrorMessage="请输入名称" Display="dynamic" runat="server" /></li>
	</ul>
    <ul>
        <li style="width:30%">&nbsp;图片文件：</li>
        <li style="width:70%">&nbsp;<asp:FileUpload ID="PhotoUpload" runat="server" /></li>
    </ul>
    <ul style="height:65px">
        <li style="width:30%">&nbsp;图片简介：</li>
        <li style="width:70%">&nbsp;<asp:TextBox ID="PhotoContent" TextMode="multiLine" Width="60%" Height="60" runat="server" /></li>
    </ul>
	<div class="Footer PTB5 TC">
		<asp:Button CssClass="Button" ID="PhotoUploadButton" Text="确定上传" runat="server" />
	</div>
</div>
</asp:PlaceHolder>
</asp:PlaceHolder>
<asp:PlaceHolder ID="Message" Visible="false" runat="server">
<div class="Block Hidden">
    <div class="Title H22 LH22 TC">
        圈内留言簿
    </div>
    <asp:Repeater ID="MessageList" runat="server">
	<ItemTemplate>
    <div class="Header M1 H22 LH22">
       &nbsp;发表用户：<a href='ControlPanel.aspx?UserID=<%# Eval("UserID") %>' target="_blank"><%# Eval("UserName") %></a> 发表时间：<%# Eval("AddTime") %>&nbsp;<input type="checkbox" name="SelectID" value="<%# Eval("ID") %>" />
	</div>
	<div class="Middle M1 PTB5">
	&nbsp;<%# Eval("Content") %>
	</div>
	</ItemTemplate>
	</asp:Repeater>
<asp:PlaceHolder ID="ShowMessageManage" Visible="false" runat="server">
	<div class="Footer PTB5 TC">
		<asp:Button CssClass="Button" ID="MessageDeleteButton" Text="确定删除" OnClientClick="return CheckSelect('SelectID')" runat="server" />&nbsp;<input type="checkbox" name="All" onclick="SelectAll(this,'SelectID')" />全选/全不选
	</div>
</asp:PlaceHolder>
</div>
<div class="BlankBlock Hidden">
    <DXBBS:ForumPager ID="MessagePager" runat="server" />
</div>
<asp:PlaceHolder ID="ShowMessageAdd" Visible="false" runat="server">
<div class="Block Hidden">
    <div class="Title H22 LH22 TC">
        发表留言
    </div>
	<div class="Middle TC" style="height:85px">
    	<asp:TextBox ID="MessageContent" TextMode="multiLine" Width="60%" Height="80" runat="server" /><asp:RequiredFieldValidator ID="NeedMessageContent" ControlToValidate="MessageContent" ErrorMessage="请输入内容" Display="dynamic" runat="server" />
	</div>
	<div class="Footer PTB5 BT TC">
		<asp:Button CssClass="Button" ID="MessageAddButton" Text="确定留言" runat="server" />
	</div>
</div>
</asp:PlaceHolder>
</asp:PlaceHolder>
<asp:PlaceHolder ID="AllTeam" Visible="false" runat="server">
<div class="Block Hidden">
    <div class="Title H22 LH22 TC">
        圈子列表
    </div>
    <dl>
    	<div class="Hidden" style="width:100%">
	    <DXBBS:SeparatorRepeater ID="TeamList" PageSize="5" runat="server">
	    <ItemTemplate>
		<dd style="width:<%= Convert.ToDouble(100)/Convert.ToDouble(TeamList.PageSize) %>%;margin-right:-1px" class="Left TC BB PTB5">
	    	<a href='Team.aspx?ID=<%# Eval("ID") %>&Action=Info'><img src='<%# Eval("Photo") %>' width="98" height="98" border="0" /></a><br />
	    	名称：<%# Eval("TeamName") %><br />
	    	人数：<%# Eval("Members") %>&nbsp;圈主：<a href='ControlPanel.aspx?UserID=<%# Eval("MasterID") %>' target="_blank"><%# Eval("Master") %></a><br />
	    	<a href="Team.aspx?ID=<%# Eval("ID") %>&Action=Join">申请加入(<DXBBS:NeedOrNot ID="NeedOrNot1" DataSource='<%# Eval("NeedConfirm") %>' runat="server" />审核)</a>
	    </dd>
	    </ItemTemplate>
		</DXBBS:SeparatorRepeater>
		</div>
	</dl>
	<div class="Footer PTB5 BT TC">
		<input type="button" class="Button" value="申请圈子" onclick="window.location.href='Team.aspx?Action=Apply'" />
	</div>
</div>
</asp:PlaceHolder>