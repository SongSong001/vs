<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true"%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<title>论坛 后台管理</title>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="<%=ForumConfig.ReadConfigInfo().SkinPath %>/style.css" type="text/css" rel="stylesheet" media="all" />
<base target="right">
</head>
<body scroll="auto">
<SCRIPT language=javascript1.2>
function showsubmenu(sid)
{
    whichEl = eval("submenu" + sid);
    if (whichEl.style.display == "none")
    {
        eval("submenu" + sid + ".style.display=\"\";");
    }
    else
    {
        eval("submenu" + sid + ".style.display=\"none\";");
    }
}
</SCRIPT>
<style>
dl
{
	background-color:#EFF4F8;
	margin:0px;
	width:100%;
	padding:0px;
	overflow:hidden
}
dl dd{
	margin:0;padding:0px;
}
</style>
<div class="TC P5" style="border:solid 3px #DADADA;background:#FFFFFF;margin:0px 0px 0px 10px;">

	<asp:PlaceHolder ID="BoardManage" Visible="false" runat="server">
	<div class="Block Hidden">
		<div class="Title PRL5 LH22 Cursor" onclick="showsubmenu(2)">
			&nbsp; 版面管理
		</div>
		<dl class="P5" id="submenu2">
			<dd class="H20"><img src="<% = ForumConfig.ReadConfigInfo().SkinPath %>/bullet.gif">&nbsp; <a href="Admin_BoardAdd.aspx">版面添加</a> | <a href="Admin_Board.aspx">版面管理</a></dd>
			<dd><img src="<% = ForumConfig.ReadConfigInfo().SkinPath %>/bullet.gif">&nbsp; <a href="Admin_GroupAdd.aspx">添加专题</a> | <a href="Admin_Group.aspx">专题管理</a></dd>
		</dl>
	</div>
	</asp:PlaceHolder>
	<asp:PlaceHolder ID="UserManage" Visible="false" runat="server">
	<div class="Block Hidden">
		<div class="Title PRL5 LH22 Cursor" onclick="showsubmenu(3)">
			&nbsp; 用户管理
		</div>
		<dl class="P5" id="submenu3">
			<dd class="H20"><img src="<% = ForumConfig.ReadConfigInfo().SkinPath %>/bullet.gif">&nbsp; <a href="Admin_TeamAdd.aspx">添加圈子</a> | <a href="Admin_Team.aspx">圈子管理</a></dd>
			<dd class="H20"><img src="<% = ForumConfig.ReadConfigInfo().SkinPath %>/bullet.gif">&nbsp; <a href="Admin_UserAdd.aspx">添加用户</a> | <a href="Admin_User.aspx">用户管理</a></dd>
			<dd><img src="<% = ForumConfig.ReadConfigInfo().SkinPath %>/bullet.gif">&nbsp; <a href="Admin_UserRename.aspx">用户改名</a> | <a href="Admin_UserSearch.aspx">用户搜索</a></dd>
		</dl>
	</div>
	</asp:PlaceHolder>
	<asp:PlaceHolder ID="TopicManage" Visible="false" runat="server">
	<div class="Block Hidden">
		<div class="Title PRL5 LH22 Cursor" onclick="showsubmenu(4)">
			&nbsp; 帖子管理
		</div>
		<dl class="P5" id="submenu4">
			<dd class="H20"><img src="<% = ForumConfig.ReadConfigInfo().SkinPath %>/bullet.gif">&nbsp; <a href="Admin_Topic.aspx">帖子列表</a> | <a href="Admin_TopicMove.aspx">批量转移</a></dd>
			<dd class="H20"><img src="<% = ForumConfig.ReadConfigInfo().SkinPath %>/bullet.gif">&nbsp; <a href="Admin_TopicDel.aspx">批量删除</a> | <a href="Admin_TopicSearch.aspx">帖子搜索</a></dd>
			<dd><img src="<% = ForumConfig.ReadConfigInfo().SkinPath %>/bullet.gif">&nbsp; <a href="Admin_TopicConfirm.aspx">批量审核</a></dd>
		</dl>
	</div>
	</asp:PlaceHolder>
	<asp:PlaceHolder ID="MessageManage" Visible="false" runat="server">
	<div class="Block Hidden">
		<div class="Title PRL5 LH22 Cursor" onclick="showsubmenu(6)">
			&nbsp; 短消息管理
		</div>
		<dl class="P5" id="submenu6">
			<dd class="H20"><img src="<% = ForumConfig.ReadConfigInfo().SkinPath %>/bullet.gif">&nbsp; <a href="Admin_MessageSend.aspx">群发消息</a> | <a href="Admin_Message.aspx?Types=1">群发管理</a></dd>
			<dd><img src="<% = ForumConfig.ReadConfigInfo().SkinPath %>/bullet.gif">&nbsp; <a href="Admin_Message.aspx?Types=2">系统消息</a> | <a href="Admin_Message.aspx?Types=3">用户短信</a></dd>
		</dl>
	</div>
	</asp:PlaceHolder>
	<asp:PlaceHolder ID="LinkManage" Visible="false" runat="server">
	<div class="Block Hidden">
		<div class="Title PRL5 LH22 Cursor" onclick="showsubmenu(7)">
			&nbsp; 友情链接管理
		</div>
		<dl class="P5" id="submenu7">
			<dd class="H20"><img src="<% = ForumConfig.ReadConfigInfo().SkinPath %>/bullet.gif">&nbsp; <a href="Admin_Link.aspx?Types=1">图片链接</a> | <a href="Admin_LinkAdd.aspx?Types=1">添加链接</a></dd>
			<dd><img src="<% = ForumConfig.ReadConfigInfo().SkinPath %>/bullet.gif">&nbsp; <a href="Admin_Link.aspx?Types=2">文字链接</a> | <a href="Admin_LinkAdd.aspx?Types=2">添加链接</a></dd>
		</dl>
	</div>
	</asp:PlaceHolder>
	<asp:PlaceHolder ID="FileManage" Visible="false" runat="server">
	<div class="Block Hidden">
		<div class="Title PRL5 LH22 Cursor" onclick="showsubmenu(8)">
			&nbsp; 文件管理
		</div>
		<dl class="P5" id="submenu8">
			<dd class="H20"><img src="<% = ForumConfig.ReadConfigInfo().SkinPath %>/bullet.gif">&nbsp; <a href="Admin_FaceAdd.aspx">添加头像</a> | <a href="Admin_Face.aspx">头像管理</a></dd>
			<dd class="H20"><img src="<% = ForumConfig.ReadConfigInfo().SkinPath %>/bullet.gif">&nbsp; <a href="Admin_FaceAdd.aspx?Action=Multi">批量从文件夹添加头像</a></dd>
			<dd class="H20"><img src="<% = ForumConfig.ReadConfigInfo().SkinPath %>/bullet.gif">&nbsp; <a href="Admin_EmoteAdd.aspx">添加表情</a> | <a href="Admin_Emote.aspx">表情管理</a></dd>
			<dd class="H20"><img src="<% = ForumConfig.ReadConfigInfo().SkinPath %>/bullet.gif">&nbsp; <a href="Admin_EmoteAdd.aspx?Action=Multi">批量从文件夹添加表情</a></dd>
			<dd><img src="<% = ForumConfig.ReadConfigInfo().SkinPath %>/bullet.gif">&nbsp; <a href="Admin_UploadFace.aspx">上传头像</a> | <a href="Admin_UploadFile.aspx">上传文件</a></dd>
		</dl>
	</div>
	</asp:PlaceHolder>
	<asp:PlaceHolder ID="ConfigManage" Visible="false" runat="server">
	<div class="Block Hidden">
		<div class="Title PRL5 LH22 Cursor" onclick="showsubmenu(0)">
			&nbsp; 系统设置
		</div>
		<dl class="P5" id="submenu0">
			<dd class="H20"><img src="<% = ForumConfig.ReadConfigInfo().SkinPath %>/bullet.gif">&nbsp; <a href="Admin_ConfigPoint.aspx">积分金币</a> | <a href="Admin_ConfigUpload.aspx">上传设置</a></dd>
			<dd><img src="<% = ForumConfig.ReadConfigInfo().SkinPath %>/bullet.gif">&nbsp; <a href="Admin_ConfigPicture.aspx">论坛上传图片水印设置</a></dd>
		</dl>
	</div>
	</asp:PlaceHolder>
	<asp:PlaceHolder ID="OtherManage" Visible="false" runat="server">
	<div class="Block Hidden">
		<div class="Title PRL5 LH22 Cursor" onclick="showsubmenu(1)">
			&nbsp; 综合管理
		</div>
		<dl class="P5" id="submenu1">
			<dd class="H20"><img src="<% = ForumConfig.ReadConfigInfo().SkinPath %>/bullet.gif">&nbsp; <a href="Admin_History.aspx">历史状态</a> | <a href="Admin_Log.aspx">日志管理</a></dd>
			<dd class="H20"><img src="<% = ForumConfig.ReadConfigInfo().SkinPath %>/bullet.gif">&nbsp; <a href="Admin_NewsAdd.aspx">添加公告</a> | <a href="Admin_News.aspx">公告管理</a></dd>
			<dd class="H20"><img src="<% = ForumConfig.ReadConfigInfo().SkinPath %>/bullet.gif">&nbsp; <a href="Admin_AdvertisementAdd.aspx">添加广告</a> | <a href="Admin_Advertisement.aspx">广告管理</a></dd>
			<dd class="H20"><img src="<% = ForumConfig.ReadConfigInfo().SkinPath %>/bullet.gif">&nbsp; <a href="Admin_RefreshCache.aspx">数据重计</a> | <a href="Admin_Language.aspx">语言包</a></dd>
			<dd class="H20"><img src="<% = ForumConfig.ReadConfigInfo().SkinPath %>/bullet.gif">&nbsp; <a href="Admin_Replace.aspx">字符转换</a> | <a href="Admin_IP.aspx">IP策略</a></dd>
		</dl>
	</div>
	</asp:PlaceHolder>
	<asp:PlaceHolder ID="RecycleManage" Visible="false" runat="server">
	<div class="Block Hidden">
		<div class="Title PRL5 LH22 Cursor" onclick="showsubmenu(9)">
			&nbsp; 回收站管理
		</div>
		<dl class="P5" id="submenu9">
			<dd class="H20"><img src="<% = ForumConfig.ReadConfigInfo().SkinPath %>/bullet.gif">&nbsp; <a href="Admin_BoardRecycle.aspx">版面回收站</a> | <a href="Admin_UserRecycle.aspx">用户回收站</a></dd>
			<dd><img src="<% = ForumConfig.ReadConfigInfo().SkinPath %>/bullet.gif">&nbsp; <a href="Admin_TopicRecycle.aspx">主题回收站</a> | <a href="Admin_ReplyRecycle.aspx">回复回收站</a></dd>
		</dl>
	</div>
	</asp:PlaceHolder>
	<asp:PlaceHolder ID="TemplateManage" Visible="false" runat="server">

	</asp:PlaceHolder>

</div>
</body>
</html>