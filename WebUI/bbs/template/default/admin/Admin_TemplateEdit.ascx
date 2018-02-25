<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true"%>
<div class="BodyBlock Middle">
    <div class="Header TC PTB5 Hidden">当前模板：<asp:Label ID="TemplateName" Font-Bold="true" ForeColor="red" runat="server" /></div>
    <div class="Hidden" style="width:98%;margin:5px auto">
        <div style="width:100%">
            <div class="Title TC PTB5 Hidden">前台文件</div>
            <div class="Hidden">
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=MasterPage.ascx">前台母板<br />&nbsp;MasterPage.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=Header.ascx">论坛顶部<br />&nbsp;Header.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=Footer.ascx">论坛底部<br />&nbsp;Footer.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=Frame.ascx">分栏模式<br />&nbsp;Frame.ascx</a></div>
                <div class="Left BB PTB5" style="width:20%;margin-right:-4px">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=Left.ascx">分栏模式左侧<br />&nbsp;Left.ascx</a></div>
            </div>
            <div class="Hidden">
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=Index.ascx">论坛首页<br />&nbsp;Index.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=Board.ascx">主题列表<br />&nbsp;Board.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=Topic.ascx">帖子内容<br />&nbsp;Topic.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=Register.ascx">用户注册<br />&nbsp;Register.ascx</a></div>
                <div class="Left BB PTB5" style="width:20%;margin-right:-4px">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=Login.ascx">用户登录<br />&nbsp;Login.ascx</a></div>
            </div>
            <div class="Hidden">
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=ControlPanel.ascx">用户中心<br />&nbsp;ControlPanel.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=ForgetPassword.ascx">忘记密码<br />&nbsp;ForgetPassword.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=Members.ascx">用户列表<br />&nbsp;Members.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=UserOnline.ascx">在线列表<br />&nbsp;UserOnline.ascx</a></div>
                <div class="Left BB PTB5" style="width:20%;margin-right:-4px">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=TopicEdit.ascx">版面帖子管理<br />&nbsp;TopicEdit.ascx</a></div>
            </div>
            <div class="Hidden">
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=BoardNews.ascx">版面公告管理<br />&nbsp;BoardNews.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=BoardLog.ascx">版面日志管理<br />&nbsp;BoardLog.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=ForumTopic.ascx">全局主题列表<br />&nbsp;ForumTopic.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=Post.ascx">发表主题<br />&nbsp;Post.ascx</a></div>
                <div class="Left BB PTB5" style="width:20%;margin-right:-4px">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=Reply.ascx">发表回复<br />&nbsp;Reply.ascx</a></div>
            </div>
            <div class="Hidden">
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=PostEdit.ascx">帖子编辑<br />&nbsp;PostEdit.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=VoteView.ascx">查看投票<br />&nbsp;VoteView.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=SendMessage.ascx">发送短信息<br />&nbsp;SendMessage.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=MessageView.ascx">阅读短信息<br />&nbsp;MessageView.ascx</a></div>
                <div class="Left BB PTB5" style="width:20%;margin-right:-4px">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=NewsView.ascx">阅读公告<br />&nbsp;NewsView.ascx</a></div>
            </div>
            <div class="Hidden">
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=Information.ascx">信息提示<br />&nbsp;Information.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=Search.ascx">论坛搜索<br />&nbsp;Search.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=Team.ascx">圈子<br />&nbsp;Team.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=Upload.ascx">上传文件<br />&nbsp;Upload.ascx</a></div>
                <div class="Left BB PTB5" style="width:20%;margin-right:-4px">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=UploadFace.ascx">上传头像<br />&nbsp;UploadFace.ascx</a></div>
            </div>
            <div class="Hidden">
                <div class="Left BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=UserFace.ascx">用户头像选择<br />&nbsp;UserFace.ascx</a></div>
            </div>
        </div>
        <div style="width:100%">
            <div class="Title TC PTB5">前台子控件</div>
            <div class="Hidden">
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=controls/BoardMaster.ascx">版主控件<br />&nbsp;BoardMaster.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=controls/BoardRepeater.ascx">版面列表控件<br />&nbsp;BoardRepeater.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=controls/BoardRule.ascx">版面规则控件<br />&nbsp;BoardRule.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=controls/ForumNews.ascx">论坛公告控件<br />&nbsp;ForumNews.ascx</a></div>
                <div class="Left BB PTB5" style="width:20%;margin-right:-4px">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=controls/ForumOnline.ascx">首页在线列表控件<br />&nbsp;ForumOnline.ascx</a></div>
            </div>
            <div class="Hidden">
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=controls/ForumPager.ascx">分页控件<br />&nbsp;ForumPager.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=controls/GroupList.ascx">专题控件<br />&nbsp;GroupList.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=controls/IsOnline.ascx">在线状态控件<br />&nbsp;IsOnline.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=controls/LoginForm.ascx">首页登录框控件<br />&nbsp;LoginForm.ascx</a></div>
                <div class="Left BB PTB5" style="width:20%;margin-right:-4px">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=controls/MessageBox.ascx">未读信息控件<br />&nbsp;MessageBox.ascx</a></div>
            </div>
            <div class="Hidden">
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=controls/PhotoLink.ascx">图片友情链接控件<br />&nbsp;PhotoLink.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=controls/TextLink.ascx">文件友情链接控件<br />&nbsp;TextLink.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=controls/Possition.ascx">论坛位置控件<br />&nbsp;Possition.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=controls/PostEditMenu.ascx">帖子管理功能按钮控件<br />&nbsp;PostEditMenu.ascx</a></div>
                <div class="Left BB PTB5" style="width:20%;margin-right:-4px">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=controls/ShowVote.ascx">显示投票控件<br />&nbsp;ShowVote.ascx</a></div>
            </div>
            <div class="Hidden">
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=controls/UserPanel.ascx">用户资料控件<br />&nbsp;UserPanel.ascx</a></div>
                <div class="Left BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=controls/UserSign.ascx">用户签名档控件<br />&nbsp;UserSign.ascx</a></div>
            </div>
        </div>
        <div style="width:100%">
            <div class="Title TC PTB5">后台文件</div>
            <div class="Hidden">
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=AdminMasterPage.ascx">后台母板<br />&nbsp;AdminMasterPage.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_Index.ascx">后面首页<br />&nbsp;Admin_Index.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_Left.ascx">后台左侧<br />&nbsp;Admin_Left.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_Right.ascx">后台右侧<br />&nbsp;Admin_Right.ascx</a></div>
                <div class="Left BB PTB5" style="width:20%;margin-right:-4px">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_OK.ascx">成功提示信息<br />&nbsp;Admin_OK.ascx</a></div>
            </div>
            <div class="Hidden">
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_Error.ascx">错误提示信息<br />&nbsp;Admin_Error.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_AdvertisementAdd.ascx">添加广告<br />&nbsp;Admin_AdvertisementAdd.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_Advertisement.ascx">广告管理<br />&nbsp;Admin_Advertisement.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_BoardAdd.ascx">添加版面<br />&nbsp;Admin_BoardAdd.ascx</a></div>
                <div class="Left BB PTB5" style="width:20%;margin-right:-4px">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_Board.ascx">版面管理<br />&nbsp;Admin_Board.ascx</a></div>
            </div>
            <div class="Hidden">
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_BoardRecycle.ascx">版面回收站<br />&nbsp;Admin_BoardRecycle.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_BoardRight.ascx">版面权限<br />&nbsp;Admin_BoardRight.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/admin_BoardRightAdd.ascx">版面权限编辑<br />&nbsp;admin_BoardRightAdd.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_ConfigAll.ascx">参数设置<br />&nbsp;Admin_ConfigAll.ascx</a></div>
                <div class="Left BB PTB5" style="width:20%;margin-right:-4px">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_ConfigPicture.ascx">水印设置<br />&nbsp;Admin_ConfigPicture.ascx</a></div>
            </div>
            <div class="Hidden">
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_ConfigPoint.ascx">积分金币设置<br />&nbsp;Admin_ConfigPoint.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_ConfigSecurity.ascx">安全设置<br />&nbsp;Admin_ConfigSecurity.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_ConfigUpload.ascx">上传设置<br />&nbsp;Admin_ConfigUpload.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_EmoteAdd.ascx">添加表情<br />&nbsp;Admin_EmoteAdd.ascx</a></div>
                <div class="Left BB PTB5" style="width:20%;margin-right:-4px">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_EmoteAdd.ascx">表情管理<br />&nbsp;Admin_EmoteAdd.ascx</a></div>
            </div>
            <div class="Hidden">
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_FaceAdd.ascx">头像添加<br />&nbsp;Admin_FaceAdd.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_Face.ascx">头像管理<br />&nbsp;Admin_Face.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_GroupAdd.ascx">专题添加<br />&nbsp;Admin_GroupAdd.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_Group.ascx">专题管理<br />&nbsp;Admin_Group.ascx</a></div>
                <div class="Left BB PTB5" style="width:20%;margin-right:-4px">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_History.ascx">历史信息<br />&nbsp;Admin_History.ascx</a></div>
            </div>
            <div class="Hidden">
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_IPAdd.ascx">IP策略添加<br />&nbsp;Admin_IPAdd.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_IP.ascx">IP策略管理<br />&nbsp;Admin_IP.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_Language.ascx">语言包管理<br />&nbsp;Admin_Language.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_LevelAdd.ascx">等级添加<br />&nbsp;Admin_LevelAdd.ascx</a></div>
                <div class="Left BB PTB5" style="width:20%;margin-right:-4px">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_Level.ascx">等级管理<br />&nbsp;Admin_Level.ascx</a></div>
            </div>
            <div class="Hidden">
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_LinkAdd.ascx">友情链接添加<br />&nbsp;Admin_LinkAdd.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_Link.ascx">友情链接管理<br />&nbsp;Admin_Link.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_Log.ascx">日志管理<br />&nbsp;Admin_Log.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_LogView.ascx">日志查看<br />&nbsp;Admin_LogView.ascx</a></div>
                <div class="Left BB PTB5" style="width:20%;margin-right:-4px">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_MenuAdd.ascx">导航菜单添加<br />&nbsp;Admin_MenuAdd.ascx</a></div>
            </div>
            <div class="Hidden">
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_Menu.ascx">导航菜单管理<br />&nbsp;Admin_Menu.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_Message.ascx">短信息管理<br />&nbsp;Admin_Message.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_MessageSend.ascx">群发短信息<br />&nbsp;Admin_MessageSend.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_MessageView.ascx">短信息查看<br />&nbsp;Admin_MessageView.ascx</a></div>
                <div class="Left BB PTB5" style="width:20%;margin-right:-4px">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_NewsAdd.ascx">添加公告<br />&nbsp;Admin_NewsAdd.ascx</a></div>
            </div>
            <div class="Hidden">
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_News.ascx">公告管理<br />&nbsp;Admin_News.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_RefreshCache.ascx">参数重计<br />&nbsp;Admin_RefreshCache.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_ReplaceAdd.ascx">替换规则添加<br />&nbsp;Admin_ReplaceAdd.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_Replace.ascx">替换规则管理<br />&nbsp;Admin_Replace.ascx</a></div>
                <div class="Left BB PTB5" style="width:20%;margin-right:-4px">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_SkinAdd.ascx">皮肤添加<br />&nbsp;Admin_SkinAdd.ascx</a></div>
            </div>
            <div class="Hidden">
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_Skin.ascx">皮肤管理<br />&nbsp;Admin_Skin.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_TeamAdd.ascx">圈子添加<br />&nbsp;Admin_TeamAdd.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_Team.ascx">圈子管理<br />&nbsp;Admin_Team.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_Topic.ascx">主题管理<br />&nbsp;Admin_Topic.ascx</a></div>
                <div class="Left BB PTB5" style="width:20%;margin-right:-4px">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_TopicConfirm.ascx">批量审核题<br />&nbsp;Admin_TopicConfirm.ascx</a></div>
            </div>
            <div class="Hidden">
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_TopicDel.ascx">批量删除主题<br />&nbsp;Admin_TopicDel.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_TopicMove.ascx">批量移动主题<br />&nbsp;Admin_TopicMove.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_TopicRecycle.ascx">主题回收站<br />&nbsp;Admin_TopicRecycle.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_TopicSearch.ascx">主题搜索<br />&nbsp;Admin_TopicSearch.ascx</a></div>
                <div class="Left BB PTB5" style="width:20%;margin-right:-4px">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_UploadFace.ascx">上传头像管理<br />&nbsp;Admin_UploadFace.ascx</a></div>
            </div>
            <div class="Hidden">
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_UploadFile.ascx">上传文件管理<br />&nbsp;Admin_UploadFile.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_UserAdd.ascx">用户添加<br />&nbsp;Admin_UserAdd.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_User.ascx">用户管理<br />&nbsp;Admin_User.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_UserRecycle.ascx">用户回收站<br />&nbsp;Admin_UserRecycle.ascx</a></div>
                <div class="Left BB PTB5" style="width:20%;margin-right:-4px">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_UserRename.ascx">用户改名<br />&nbsp;Admin_UserRename.ascx</a></div>
            </div>
            <div class="Hidden">
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_UserSearch.ascx">用户搜索<br />&nbsp;Admin_UserSearch.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_TemplateAdd.ascx">添加模板<br />&nbsp;Admin_TemplateAdd.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_TemplateEdit.ascx">模板编辑<br />&nbsp;Admin_TemplateEdit.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_TemplatePage.ascx">模板细项修改<br />&nbsp;Admin_TemplatePage.ascx</a></div>
                <div class="Left BB PTB5" style="width:20%;margin-right:-4px">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_Template.ascx">模板管理<br />&nbsp;Admin_Template.ascx</a></div>
                <div class="Left BR BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_ReplyRecycle.ascx">回复回收站<br />&nbsp;Admin_ReplyRecycle.ascx</a></div>
            <div class="Hidden">
                <div class="Left BB PTB5" style="width:20%">&nbsp;<a href="Admin_TemplatePage.aspx?ID=<%= Requests.GetIntQueryString("ID") %>&FileName=admin/Admin_CSS.ascx">CSS修改<br />&nbsp;Admin_CSS.ascx</a></div>
            </div>
        </div>
    </div>
</div>