<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true"%>
<%@ Register TagPrefix="DXBBS" Namespace="DXBBS.Controls" Assembly="DXBBS.Controls" %>
<script src="js/dxbbs.js"></script>
<script language="javascript">
//全选全不选
function SelectAll(obj)
{
    var aspnetForm=document.getElementById("aspnetForm");
    if (aspnetForm.SelectID != null)
    {
        if (aspnetForm.SelectID.length == null)
        {
            aspnetForm.SelectID.checked=obj.checked;
        }
        else
        {
            for (i=0;i<aspnetForm.SelectID.length;i++)
            {
                if(aspnetForm.SelectID[i].checked!=obj.checked)
                {
                    aspnetForm.SelectID[i].checked=obj.checked;
                }
            }
        }
    }
}
//检查操作
function CheckSelect()
{
    var aspnetForm=document.getElementById("aspnetForm");
    var checked=false;
    if (aspnetForm.SelectID != null)
    {
        if (aspnetForm.SelectID.length == null)
        {
            if (aspnetForm.SelectID.checked == true)
            {
                checked=true;
            }
        }
        else
        {
            for (i=0;i<aspnetForm.SelectID.length;i++)
            {
                if(aspnetForm.SelectID[i].checked == true)
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
		<img src="<% = ForumConfig.ReadConfigInfo().SkinPath %>/boardicon.gif" align="absmiddle" /><DXBBS:Possition ID="Possition1" runat="server" />用户中心
	</div>
</div>
<asp:PlaceHolder ID="ShowMenu" Visible="false" runat="server">
<div class="Block Hidden">
    <ul class="Middle TC Cursor">
        <li style="width:9%" class="TC BR" onmouseover="this.className='Footer TC BR'" onmouseout="this.className='Middle TC BR'" onclick="location.href='ControlPanel.aspx'">个人资料</li>
        <li style="width:10%" class="TC BR" onmouseover="this.className='Footer TC BR'" onmouseout="this.className='Middle TC BR'" onclick="location.href='ControlPanel.aspx?Action=Modify'">编辑资料</li>
        <li style="width:10%" class="TC BR" onmouseover="this.className='Footer TC BR'" onmouseout="this.className='Middle TC BR'" onclick="location.href='ControlPanel.aspx?Action=Password'">修改密码</li>
        <li style="width:10%" class="TC BR" onmouseover="this.className='Footer TC BR'" onmouseout="this.className='Middle TC BR'" onclick="location.href='ControlPanel.aspx?Action=Topic'">发表的主题</li>
        <li style="width:10%" class="TC BR" onmouseover="this.className='Footer TC BR'" onmouseout="this.className='Middle TC BR'" onclick="location.href='ControlPanel.aspx?Action=Join'">参与的主题</li>
        <li style="width:10%" class="TC BR" onmouseover="this.className='Footer TC BR'" onmouseout="this.className='Middle TC BR'" onclick="location.href='ControlPanel.aspx?Action=Favorite'">我的收藏</li>
        <li style="width:10%" class="TC BR" onmouseover="this.className='Footer TC BR'" onmouseout="this.className='Middle TC BR'" onclick="location.href='ControlPanel.aspx?Action=Friend'">我的好友</li>
        <li style="width:10%" class="TC BR" onmouseover="this.className='Footer TC BR'" onmouseout="this.className='Middle TC BR'" onclick="location.href='ControlPanel.aspx?Action=Recieve'">收件箱</li>
        <li style="width:10%" class="TC BR" onmouseover="this.className='Footer TC BR'" onmouseout="this.className='Middle TC BR'" onclick="location.href='ControlPanel.aspx?Action=Upload'">我的文件</li>
        <li style="width:10%;margin-right:-5px" class="TC" onmouseover="this.className='Footer TC'" onmouseout="this.className='Middle TC'" onclick="location.href='ControlPanel.aspx?Action=Right'">我的权限</li>
    </ul>
</div>
</asp:PlaceHolder>
<asp:PlaceHolder ID="ShowInfo" Visible="false" runat="server">
<div class="Block Hidden">
    <div class="Title H22 LH22 TC">
        查看用户资料
    </div>
    <div class="Middle M1 Hidden">
	    <div class="Middle" style="width:100%">
		    <div class="Left BR" style="width:300px">
	    		<div class="TC PTB5">
	    			<asp:Image ID="SPhotoImage" runat="server" />
	    		</div>
	    		<div class="TC">
		    		<img src="<%=ForumConfig.ReadConfigInfo().SkinPath %>/msg.gif" align="absmiddle"> <a href="SendMessage.aspx?UserID=<% = Requests.GetIntQueryString("UserID") %>" title="给他(她)发个讯息">发送讯息</a> &nbsp; 
		    		<img src="<%=ForumConfig.ReadConfigInfo().SkinPath %>/friend.gif" align="absmiddle"> <a href="AddFriend.aspx?UserID=<% = Requests.GetIntQueryString("UserID") %>" title="将他(她)加入好友">加为好友</a> &nbsp; 
		    		<img src="<%=ForumConfig.ReadConfigInfo().SkinPath %>/mytopic.gif" align="absmiddle"> <a href='ControlPanel.aspx?UserID=<% = Requests.GetIntQueryString("UserID") %>&Action=Topic' title="查看我所发表的主题">我的主题</a>
	    		</div>
	    		<div style="width:75%;margin:0px auto" class="PTB5 LH20">
	    			用户名称： <asp:Label ID="SUserName" runat="server" />&nbsp;(<DXBBS:UserSex ID="SSex" runat="server" />)<br/>
	    			用户昵称： <asp:Label ID="SNickName" runat="server" /><br/>
	    			朋友圈子： <asp:Label ID="STeam" runat="server" /><br/>
	    			用户等级： <DXBBS:LevelName ID="SLevel" runat="server" /><br/>
	    			用户金币： <asp:Label ID="SCoin" runat="server" /><br/>
	    			用户积分： <asp:Label ID="SPoint" runat="server" /><br/>
	    			主题贴数： <asp:Label ID="STopic" runat="server" /><br/>
	    			回复贴数： <asp:Label ID="SReply" runat="server" /><br/>
	    			精华帖数： <asp:Label ID="SGoodTopic" runat="server" /><br/>
	    			被删主题： <asp:Label ID="STopicDel" runat="server" /><br/>
	    			被删回复： <asp:Label ID="SReplyDel" runat="server" /><br/>
	    			注册时间： <asp:Label ID="SRegTime" runat="server" /><br/>
	    			注册ＩＰ： <asp:Label ID="SIP" runat="server" /><br/>
	    			上次登录时间： <asp:Label ID="SLoginTime" runat="server" /><br/>
	    			上次登录ＩＰ： <asp:Label ID="SLoginIP" runat="server" /><br/>
	    		</div>
		    </div>
			<div class="P5 BL" style="margin-left:300px">
				<div class="Header P5 B">
	    			 论坛个性签名
	    		</div>
	    		<div class="P5 LH20"><asp:Label ID="SSign" runat="server" /></div>
	    		<div class="Header P5 B">
	    			联系资料
	    		</div>
	    		<div class="P5 LH20">
	    			Q Q： <asp:Label ID="SQQ" runat="server" /><br/>
	    			ICQ： <asp:Label ID="SICQ" runat="server" /><br/>
	    			MSN： <asp:Label ID="SMSN" runat="server" /><br/>
	    			EMAIL： <asp:Label ID="SEmail" runat="server" /><br/>
	    			联系电话： <asp:Label ID="SPhone" runat="server" /><br/>
	    			联系手机： <asp:Label ID="SMobile" runat="server" /><br/>
	    			联系地址： <asp:Label ID="SAddress" runat="server" /><br/>
	    		</div>
				<div class="Header P5 B">
	    			详细资料
	    		</div>
	    		<div class="P5 LH20">
	    			姓名： <asp:Label ID="SRealName" runat="server" /><br/>
	    			生日： <asp:Label ID="SBirthday" runat="server" /><br/>
	    			婚否： <asp:Label ID="SMarry" runat="server" /><br/>
	    			星座： <asp:Label ID="SStar" runat="server" /><br/>
	    			血型： <asp:Label ID="SBlood" runat="server" /><br/>
	    			学历： <asp:Label ID="SStudy" runat="server" /><br/>
	    			毕业院校： <asp:Label ID="SSchool" runat="server" />
	    		</div>
				<div class="Header P5 B">
	    			个人简介
	    		</div>
	    		<div class="TC">
	    			<div class="LH20" style="width:98%"><asp:Label ID="SIntroduce" runat="server" /></div>
	    		</div>
		    </div>
		</div>
    </div>
</div>
</asp:PlaceHolder>
<asp:PlaceHolder ID="ShowModify" Visible="false" runat="server">
<script language="javascript">
function ChangePhotoSize()
{
    var obj=document.getElementById(ChangeID("_ctl0_Main_ControlPanel1__ctl0_MPhotoImage"));
    var width=document.getElementById(ChangeID("_ctl0_Main_ControlPanel1__ctl0_MPhotoWidth")).value;
    var height=document.getElementById(ChangeID("_ctl0_Main_ControlPanel1__ctl0_MPhotoHeight")).value;
    obj.style.width=width;
    obj.style.height=height;
}
function OpenWindow(url, width, height)
{
    var Win = window.open(url,"openScript",'width=' + width + ',height=' + height + ',resizable=1,scrollbars=yes,menubar=no,status=no' );
}
</script>
<div class="Block Hidden">
    <div class="Title H22 LH22 TC">
        修改资料
    </div>
    <div class="Middle M1 Hidden">
	    <div class="Middle" style="width:100%">
		    <div class="Left P5 BR" style="width:290px">
	    		<div class="TC PTB5">
	    			<asp:Image ID="MPhotoImage" runat="server" />
	    		</div>
	    		<div class="Header P5 B">
	    			论坛头像设置
	    		</div>
	    		<div class="PTB5 LH25">
	    			<input type="button" class="Button" value="选择头像" onclick="OpenWindow('UserFace.aspx',600,400)"><br/>
	    			头像文件：<asp:TextBox ID="MPhoto" Width="180" runat="server" /><br />
	    			头像高度：<asp:TextBox ID="MPhotoHeight" Width="180" runat="server" /><br />
					头像宽度：<asp:TextBox ID="MPhotoWidth"  Width="180" runat="server" /><br />
				</div>
				<div class="Header P5 B">
					上传头像
				</div>
				<div class="PTB5 LH25">
					<iframe src="UploadFace.aspx" width="100%" height="50" frameborder="0" scrolling="no"></iframe>
	    		</div>
	    		<div class="Header P5 B">
	    			基本资料设置
	    		</div>
	    		<div class="PTB5 LH25">
	    			用户名称： <asp:Label ID="MUserName" runat="server" /><br/>
	    			<asp:PlaceHolder ID="ShowNickName" runat="server">
	    			用户昵称： <asp:TextBox ID="MNickName" runat="server" /><br />
	    			</asp:PlaceHolder>
	    			朋友圈子： <a href="Team.aspx" target="_blank">点击前往操作</a><br/> 
	    			<asp:RadioButtonList ID="MSex" RepeatDirection="horizontal" runat="server">
		    			<asp:ListItem Value="1" Text="男" Selected="true"/>
		    			<asp:ListItem Value="0" Text="女" />
	    			</asp:RadioButtonList>
	    		</div>
	    		<asp:PlaceHolder ID="ShowSign" runat="server">
	    		<div class="Header P5 B">
	    			 论坛个性签名
	    		</div>
	    		<div class="P5 LH20">
	    			<div><asp:TextBox ID="MSign" TextMode="MultiLine" Height="65" Width="98%" runat="server" /></div>
	    		</div>
	    		</asp:PlaceHolder>
		    </div>
			<div class="P5 BL" style="margin-left:300px">
	    		<div class="Header P5 B">
	    			联系资料
	    		</div>
	    		<div class="P5 LH25">
	    			Q Q： <asp:TextBox ID="MQQ" runat="server" /><br/>
	    			ICQ： <asp:TextBox ID="MICQ" runat="server" /><br/>
	    			MSN： <asp:TextBox ID="MMSN" runat="server" /><br/>
	    			EMAIL： <asp:TextBox ID="MEmail" runat="server" /><br/>
	    			联系电话： <asp:TextBox ID="MPhone" runat="server" /><br/>
	    			联系手机： <asp:TextBox ID="MMobile" runat="server" /><br/>
	    			联系地址： <asp:TextBox ID="MAddress" runat="server" /><br/>
	    		</div>
				<div class="Header P5 B">
	    			详细资料
	    		</div>
	    		<div class="P5 LH25">
	    			姓名： <asp:TextBox ID="MRealName" runat="server" /><br/>
	    			生日： <asp:TextBox ID="MBirthday" runat="server" /><br/>
	    			婚否： <asp:TextBox ID="MMarry" runat="server" /><br/>
	    			星座： <asp:TextBox ID="MStar" runat="server" /><br/>
	    			血型： <asp:TextBox ID="MBlood" runat="server" /><br/>
	    			学历： <asp:TextBox ID="MStudy" runat="server" /><br/>
	    			毕业院校： <asp:TextBox ID="MSchool" runat="server" />
	    		</div>
				<div class="Header P5 B">
	    			个人简介
	    		</div>
	    		<div class="P5 LH20">
	    			<div>
	    				<asp:TextBox ID="MIntroduce" TextMode="multiLine" Height="125" Width="95%" runat="server" />
	    			</div>
	    		</div>
		    </div>
		</div>
    </div>
    <div class="Footer PTB5 TC">
		<asp:Button CssClass="Button" ID="ModifyButton" Text="确认提交更新" runat="server" />
    </div>
</div>
</asp:PlaceHolder>
<asp:PlaceHolder ID="ShowPassword" Visible="false" runat="server">
<div class="Block Hidden">
    <div class="Title H22 LH22 TC">
        修改密码
    </div>
    <ul>
		<li style="width:35%">&nbsp;旧密码：</li>
        <li>&nbsp;<asp:TextBox ID="OldPassword" TextMode="Password" Width="150px" runat="server" /><asp:RequiredFieldValidator ID="NeedOldPassword" ControlToValidate="OldPassword" ErrorMessage="请输入旧密码" Display="dynamic" runat="server" /></li>
    </ul>
    <ul>
		<li style="width:35%">&nbsp;新密码：</li>
        <li>&nbsp;<asp:TextBox ID="NewPassword" TextMode="Password" Width="150px" runat="server" /></li>
    </ul>
    <ul>
		<li style="width:35%">&nbsp;确认新密码：</li>
        <li>&nbsp;<asp:TextBox ID="ConfirmPassword" TextMode="Password" Width="150px" runat="server" /><asp:CompareValidator ID="ComparePassword" ControlToValidate="NewPassword" ControlToCompare="ConfirmPassword" ErrorMessage="两次输入新密码不一致" Display="dynamic" runat="server" /></li>
    </ul>
    <ul>
		<li style="width:35%">&nbsp;密码提示问题：</li>
        <li>&nbsp;<asp:TextBox ID="Question" Width="150px" runat="server" /><asp:RequiredFieldValidator ID="NeedQuestion" ControlToValidate="Question" ErrorMessage="请输入密码提示问题" Display="dynamic" runat="server" /></li>
    </ul>
    <ul>
		<li style="width:35%">&nbsp;问题回答：</li>
        <li>&nbsp;<asp:TextBox ID="Answer" Width="150px" runat="server" /></li>
    </ul>
    <div class="Footer PTB5 TC">
        <asp:Button CssClass="Button" ID="PasswordButton" Text="确定修改" runat="server" />
    </div>
</div>
</asp:PlaceHolder>
<asp:PlaceHolder ID="ShowTopic" Visible="false" runat="server">
<div class="Block Hidden">
    <div class="Title H22 LH22 TC">
        发表的主题
    </div>
    <ul class="Header">
        <li class="Left TC" style="width:50px">状态</li>
        <li class="Right TC" style="width:220px">最后回复</li>
        <li class="Right TL" style="width:50px">查看</li>
        <li class="Right TR" style="width:50px">回复&nbsp;|&nbsp;</li>
        <li class="Right TR" style="width:100px">作者</li>
        <li>帖子标题</li>
    </ul>
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
<div class="BlankBlock Hidden">
    <DXBBS:ForumPager ID="CommonPager" runat="server" />
</div>
</asp:PlaceHolder>
<asp:PlaceHolder ID="ShowJoin" Visible="false" runat="server">
<div class="Block Hidden">
    <div class="Title H22 LH22 TC">
        参与的主题
    </div>
    <ul class="Header">
        <li class="Left TC" style="width:50px">状态</li>
        <li class="Right TC" style="width:220px">最后回复</li>
        <li class="Right TL" style="width:50px">查看</li>
        <li class="Right TR" style="width:50px">回复&nbsp;|&nbsp;</li>
        <li class="Right TR" style="width:100px">作者</li>
        <li>帖子标题</li>
    </ul>
	<asp:Repeater ID="JoinTopicList" runat="server">
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
	<div class="Middle TC P5"><asp:Repeater ID="TableList" runat="server"><HeaderTemplate>选择数据表：</HeaderTemplate><ItemTemplate>[ <a href="ControlPanel.aspx?Action=Join&TID=<%# Eval("Orders") %>"><b><%# Eval("Orders") %></b></a> ]&nbsp;</ItemTemplate></asp:Repeater></div>
</div>
<div class="BlankBlock Hidden">
    <DXBBS:ForumPager ID="JoinPager" runat="server" />
</div>
</asp:PlaceHolder>
<asp:PlaceHolder ID="ShowFavorite" Visible="false" runat="server">
<div class="Block Hidden">
    <div class="Title H22 LH22 TC">
        我收藏的主题
    </div>
    <ul class="Header">
        <li class="Left TC" style="width:50px">状态</li>
        <li class="Right" style="width:30px">选择</li>
        <li class="Right TC" style="width:220px">最后回复</li>
        <li class="Right TL" style="width:50px">查看</li>
        <li class="Right TR" style="width:50px">回复&nbsp;|&nbsp;</li>
        <li class="Right TR" style="width:100px">作者</li>
        <li>帖子标题</li>
    </ul>
	<asp:Repeater ID="FavoriteTopicList" runat="server">
	<ItemTemplate>
	<dl onmouseover="this.className='Footer'" onmouseout="this.className='Middle'">
        <dd class="Left TC" style="width:50px"><img src="<%# Eval("Photo") %>" align="absmiddle" /></dd>
        <dd class="Right TC" style="width:30px"><input type="checkbox" name="SelectID" value="<%# Eval("ID") %>" /></dd>
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
    <div class="Footer PTB5 BT TC">
    	<asp:Button CssClass="Button" ID="DeleteFavoriteButton" Text="确定删除" OnClientClick="return CheckSelect()" runat="server" />&nbsp;<input type="checkbox" name="All" onclick="SelectAll(this)" />全选/全不选
	</div>
</div>
<div class="BlankBlock Hidden">
    <DXBBS:ForumPager ID="FavoritePager" runat="server" />
</div>
</asp:PlaceHolder>
<asp:PlaceHolder ID="ShowFriend" Visible="false" runat="server">
<div class="Block Hidden">
    <div class="Title H22 LH22 TC">
        我的好友
    </div>
    <ul class="Header TC">
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
	<ul class="TC Hidden">
	    <li style="width:60px"><%# Eval("ID") %></li>
	    <li class="Right" style="width:30px"><input type="checkbox" name="SelectID" value="<%# Eval("ID") %>" /></li>
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
    <div class="Footer PTB5 TC">
		<asp:Button CssClass="Button" ID="DeleteFriendButton" Text="确定删除" OnClientClick="return CheckSelect()" runat="server" />&nbsp;<input type="checkbox" name="All" onclick="SelectAll(this)" />全选/全不选
	</div>
</div>
<div class="BlankBlock Hidden">
    <DXBBS:ForumPager ID="UserPager" runat="server" />
</div>
</asp:PlaceHolder>

<asp:PlaceHolder ID="ShowRecieve" Visible="false" runat="server">
<div class="Block Hidden">
    <div class="Title H22 LH22 TC">
        我的收信箱
    </div>
    <ul class="Header TC">
    	<li style="width:60px">ID</li>
	    <li>标题</li>
	    <li class="Right" style="width:30px">选择</li>
		<li class="Right" style="width:120px">发送时间</li>
		<li class="Right" style="width:100px">接收用户</li>
		<li class="Right" style="width:100px">发送用户</li>
		<li class="Right" style="width:80px">是否已读</li>
	</ul>
	<asp:Repeater ID="RecieveList" runat="server">
	<ItemTemplate>
	<ul class="Middle TC">
    	<li style="width:60px"><%# Eval("ID") %></li>
	    <li><a href='MessageView.aspx?ID=<%# Eval("ID") %>' target="_blank"><%# Eval("Title") %></a></li>
	    <li class="Right" style="width:30px"><input type="checkbox" name="SelectID" value='<%# Eval("ID") %>' /></li>
		<li class="Right" style="width:120px"><%# Eval("AddTime") %></li>
		<li class="Right" style="width:100px"><%# Eval("ToName") %></li>
		<li class="Right" style="width:100px"><%# Eval("FromName") %></li>
		<li class="Right" style="width:80px"><DXBBS:MessageRead ID="MesageIsRead1" DataSource='<%# Eval("IsRead") %>' runat="server" /></li>
	</ul>
	</ItemTemplate>
	</asp:Repeater>
    <div class="Footer PTB5 TC">
		<input type="button" class="Button" value="写新信息" onclick="window.location.href='SendMessage.aspx'" />&nbsp;<input type="button" class="Button" value="发件箱" onclick="location.href='ControlPanel.aspx?Action=Send'" />&nbsp;<asp:Button CssClass="Button" ID="DeleteRecieveButton" Text="确定删除" OnClientClick="return CheckSelect()" runat="server" />&nbsp;<input type="checkbox" name="All" onclick="SelectAll(this)" />全选/全不选
	</div>
</div>
<div class="BlankBlock Hidden">
    <DXBBS:ForumPager ID="RecievePager" runat="server" />
</div>
</asp:PlaceHolder>

<asp:PlaceHolder ID="ShowSend" Visible="false" runat="server">
<div class="Block Hidden">
    <div class="Title H22 LH22 TC">
        我的发信箱
    </div>
    <ul class="Header TC">
    	<li style="width:60px">ID</li>
	    <li>标题</li>
	    <li class="Right" style="width:30px">选择</li>
		<li class="Right" style="width:120px">发送时间</li>
		<li class="Right" style="width:100px">接收用户</li>
		<li class="Right" style="width:100px">发送用户</li>
		<li class="Right" style="width:80px">是否已读</li>
	</ul>
	<asp:Repeater ID="SendList" runat="server">
	<ItemTemplate>
	<ul class="Middle TC">
    	<li style="width:60px"><%# Eval("ID") %></li>
	    <li><a href='MessageView.aspx?ID=<%# Eval("ID") %>' target="_blank"><%# Eval("Title") %></a></li>
	    <li class="Right" style="width:30px"><input type="checkbox" name="SelectID" value='<%# Eval("ID") %>' /></li>
		<li class="Right" style="width:120px"><%# Eval("AddTime") %></li>
		<li class="Right" style="width:100px"><%# Eval("ToName") %></li>
		<li class="Right" style="width:100px"><%# Eval("FromName") %></li>
		<li class="Right" style="width:80px"><DXBBS:MessageRead ID="MesageIsRead1" DataSource='<%# Eval("IsRead") %>' runat="server" /></li>
	</ul>
    </ItemTemplate>
	</asp:Repeater>
    <div class="Footer PTB5 TC">
		<input type="button" class="Button" value="写新信息" onclick="window.location.href='SendMessage.aspx'" />&nbsp;<input type="button" class="Button" value="收件箱" onclick="location.href='ControlPanel.aspx?Action=Recieve'" />&nbsp;<asp:Button CssClass="Button" ID="DeleteSendButton" Text="确定删除" OnClientClick="return CheckSelect()" runat="server" />&nbsp;<input type="checkbox" name="All" onclick="SelectAll(this)" />全选/全不选
	</div>
</div>
<div class="BlankBlock Hidden">
    <DXBBS:ForumPager ID="SendPager" runat="server" />
</div>
</asp:PlaceHolder>

<asp:PlaceHolder ID="ShowUpload" Visible="false" runat="server">
<div class="Block Hidden">
    <div class="Title H22 LH22 TC">
        我的文件集
    </div>
    <ul class="Header TC">
    	<li style="width:60px">ID</li>
	    <li>文件名(体积)</li>
	    <li class="Right" style="width:30px">选择</li>
	    <li class="Right" style="width:120px">上传用户</li>
		<li class="Right" style="width:120px">上传时间</li>
		<li class="Right" style="width:100px">上传动作</li>
		<li class="Right" style="width:100px">文件类型</li>
	</ul>
	<asp:Repeater ID="UploadFileList" runat="server">
	<ItemTemplate>
    <ul class="Middle TC">
    	<li style="width:60px"><%# Eval("ID") %></li>
	    <li><a href='<%# Eval("FileName") %>' target="_blank"><%# Eval("FileName") %>&nbsp;(<%# Eval("FileSize") %>)</a></li>
	    <li class="Right" style="width:30px"><input type="checkbox" name="SelectID" value="<%# Eval("ID") %>" /></li>
	    <li class="Right" style="width:120px"><%# Eval("UserName") %></li>
		<li class="Right" style="width:120px"><%# Eval("AddTime") %></li>
		<li class="Right" style="width:100px"><DXBBS:UploadAction DataSource='<%# Eval("Types") %>' runat="server" /></li>
		<li class="Right" style="width:100px"><%# Eval("FileType") %></li>
	</ul>
	</ItemTemplate>
	</asp:Repeater>
    <div class="Footer PTB5 TC">
        <asp:Button CssClass="Button" ID="DeleteUploadButton" Text="确定删除" OnClientClick="return CheckSelect()" runat="server" />&nbsp;<input type="checkbox" name="All" onclick="SelectAll(this)" />全选/全不选
    </div>
</div>
<div class="BlankBlock Hidden">
    <DXBBS:ForumPager ID="UploadPager" runat="server" />
</div>
</asp:PlaceHolder>

<asp:PlaceHolder ID="ShowRight" Visible="false" runat="server">
<div class="Block Hidden">
    <div class="Title H22 LH22 TC">
        我的权限
    </div>
   	<div class="Middle TC P5">
        <div class="Header P5 B">&nbsp; 基本权限</div>
		<div style="width:98%">
            <input name="Rights" type="checkbox" value="1" checked="CHECKED" />允许隐身 
            <input name="Rights" type="checkbox" value="2" checked="CHECKED" />允许使用搜索 
            <input name="Rights" type="checkbox" value="3" checked="CHECKED" />允许使用昵称 
            <input name="Rights" type="checkbox" value="4" checked="CHECKED" />查看贴子列表 
            <input name="Rights" type="checkbox" value="5" checked="CHECKED" />查看贴子内容 
            <input name="Rights" type="checkbox" value="6" checked="CHECKED" />查看用户资料 
            <input name="Rights" type="checkbox" value="7" checked="CHECKED" />查看在线用户 
            <input name="Rights" type="checkbox" value="8" />查看用户IP 
            <input name="Rights" type="checkbox" value="9" checked="CHECKED" />允许使用签名档 
            <input name="Rights" type="checkbox" value="10" />允许查看屏蔽贴 
            <input name="Rights" type="checkbox" value="11" />直接查看金币贴 
            <input name="Rights" type="checkbox" value="12" />直接查看权限贴 
            <input name="Rights" type="checkbox" value="13" />直接查看回复可见贴 
            <input name="Rights" type="checkbox" value="14" checked="CHECKED" />允许加入圈子 
            <input name="Rights" type="checkbox" value="15" />允许申请圈子
		</div>
	</div>
   	<div class="Middle TC P5">
        <div class="Header P5 B">&nbsp; 发贴/回复权限</div>
		<div style="width:98%">
            <input name="Rights" type="checkbox" value="16" checked="CHECKED" />发表普通帖 
            <input name="Rights" type="checkbox" value="17" checked="CHECKED" />发表投票帖 
            <input name="Rights" type="checkbox" value="18" checked="CHECKED" />发表权限贴 
            <input name="Rights" type="checkbox" value="19" checked="CHECKED" />发表颜色标题贴 
            <input name="Rights" type="checkbox" value="20" checked="CHECKED" />发表回复可见贴 
            <input name="Rights" type="checkbox"value="21" checked="CHECKED" />发表金币购买帖 
            <input name="Rights" type="checkbox"value="22" checked="CHECKED" />发表HTML标题贴 
            <input name="Rights" type="checkbox"value="23" checked="CHECKED" />发表问答帖 
            <input name="Rights" type="checkbox" value="24" checked="CHECKED" />回复普通帖 
            <input name="Rights" type="checkbox" value="25" checked="CHECKED" />回复投票帖 
            <input name="Rights" type="checkbox" value="26" checked="CHECKED" />回复权限帖 
            <input name="Rights" type="checkbox" value="27" checked="CHECKED" />回复颜色标题帖 
            <input name="Rights" type="checkbox" value="28" checked="CHECKED" />回复金币购买帖 
            <input name="Rights" type="checkbox" value="29" checked="CHECKED" />回复HTML标题帖 
            <input name="Rights" type="checkbox" value="30"/>在锁定版面发贴 
            <input name="Rights" type="checkbox" value="31" />在锁定版面回复 
            <input name="Rights" type="checkbox" value="32" />在锁定主题回复 
            <input name="Rights" type="checkbox" value="33" checked="CHECKED"/>可编辑自己发表的主题,&nbsp;<asp:Label ID="EditSelfTopicDay" Text="0" Width="36px" Font-Bold="true" runat="server" />&nbsp;天内可操作 
            <input name="Rights" type="checkbox" value="34" checked="CHECKED"/>可删除自己发表的主题,&nbsp;<asp:Label ID="DeleteSelfTopicDay" Text="0" Width="36px" Font-Bold="true" runat="server" />&nbsp;天内可操作 
            <input name="Rights" type="checkbox" value="35" checked="CHECKED"/>可编辑自己发表的回复,&nbsp;<asp:Label ID="EditSelfReplyDay" Text="0" Width="36px" Font-Bold="true" runat="server" />&nbsp;天内可操作 
            <input name="Rights" type="checkbox" value="36" checked="CHECKED"/>可删除自己发表的回复,&nbsp;<asp:Label ID="DeleteSelfReplyDay" Text="0" Width="36px" Font-Bold="true" runat="server" />&nbsp;天内可操作 
		</div>
	</div>
   	<div class="Middle TC P5">
        <div class="Header P5 B">&nbsp; 下载/上传权限</div>
		<div style="width:98%">
            <input name="Rights" type="checkbox" value="37" checked="CHECKED" />允许下载附件 
	        <input name="Rights" type="checkbox" value="38" checked="CHECKED" />允许上传头像，最大体积&nbsp; <asp:Label ID="UploadFaceSize" Text="0" Width="36px" Font-Bold="true" runat="server" />&nbsp;KB. 
            <input name="Rights" type="checkbox" value="39" checked="CHECKED" />允许上传附件，最大体积&nbsp; <asp:Label ID="UploadSize" Text="0" Width="36px" Font-Bold="true" runat="server" />&nbsp;KB. 每天最多&nbsp;<asp:Label ID="UploadNum" Text="0" Font-Bold="true" runat="server" Width="36px" />&nbsp;个 
		</div>
	</div>
   	<div class="Middle TC P5">
        <div class="Header P5 B">&nbsp; 前台管理权限</div>
			<div style="width:98%">
	        <input name="Rights" type="checkbox" value="40" />编辑主题 
            <input name="Rights" type="checkbox" value="41" />删除主题 
            <input name="Rights" type="checkbox" value="42" />编辑回复 
            <input name="Rights" type="checkbox" value="43" />删除回复 
            <input name="Rights" type="checkbox" value="44" />移动主题
            <input name="Rights" type="checkbox" value="45" />加精主题 
            <input name="Rights" type="checkbox" value="46" />解精主题 
            <input name="Rights" type="checkbox" value="47" />锁定主题 
            <input name="Rights" type="checkbox" value="48" />解锁主题 
            <input name="Rights" type="checkbox" value="49" />屏蔽主题 
            <input name="Rights" type="checkbox" value="50" />解屏主题 
            <input name="Rights" type="checkbox" value="52" />解屏回复 
            <input name="Rights" type="checkbox" value="53" />发表公告 
            <input name="Rights" type="checkbox" value="54" />编辑公告 
            <input name="Rights" type="checkbox" value="55" />删除公告 
            <input name="Rights" type="checkbox" value="56" />版面固顶主题 
            <input name="Rights" type="checkbox" value="57" />区固顶主题 
            <input name="Rights" type="checkbox" value="58" />总固顶主题 
            <input name="Rights" type="checkbox" value="59" />解除固顶 
            <input name="Rights" type="checkbox" value="60" />批量审核主题 
            <input name="Rights" type="checkbox" value="61" />批量锁定 
            <input name="Rights" type="checkbox" value="62" />批量解锁 
            <input name="Rights" type="checkbox" value="63" />批量屏蔽 
            <input name="Rights" type="checkbox" value="64" />批量解屏 
            <input name="Rights" type="checkbox" value="65" />批量移动 
            <input name="Rights" type="checkbox" value="66" />批量删除 
            <input name="Rights" type="checkbox" value="67" />设置问题帖最佳答案 
		</div>
	</div>
   	<div class="Middle TC P5">
        <div class="Header P5 B">&nbsp; 后台管理权限</div>
			<div style="width:98%">
	        <input name="Rights" type="checkbox" value="68" />系统设置 
	        <input name="Rights" type="checkbox" value="69" />综合管理 
	        <input name="Rights" type="checkbox" value="70" />版面管理 
	        <input name="Rights" type="checkbox" value="71" />用户管理 
            <input name="Rights" type="checkbox" value="72" />帖子管理 
            <input name="Rights" type="checkbox" value="73" />模板皮肤管理 
            <input name="Rights" type="checkbox" value="74" />短消息管理 
            <input name="Rights" type="checkbox" value="75" />友情链接管理 
            <input name="Rights" type="checkbox" value="76" />文件管理
            <input name="Rights" type="checkbox" value="77" />回收站管理
		</div>
	</div>
</div>
<script language="JavaScript">
var aspnetForm=document.getElementById("aspnetForm");
var Right="<%=Currents.LevelPower%>";
if (Right != "")
{
	temp=Right.split(",");
	for (i=0;i<aspnetForm.Rights.length ;i++ )
	{
		var ischecked=false;
		for (j=0;j<temp.length ;j++ )
		{
			if(temp[j]==aspnetForm.Rights[i].value)
			{
				ischecked=true;
			}
		}
		if (ischecked == true)
		{
			aspnetForm.Rights[i].checked=true;
		}
		else
		{
			aspnetForm.Rights[i].checked=false;
		}
	}
}
</script>
</asp:PlaceHolder>