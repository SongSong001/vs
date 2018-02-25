<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true" EnableViewState="true"%>
<%@ Register TagPrefix="DXBBS" Namespace="DXBBS.Controls" Assembly="DXBBS.Controls" %>
<style type="text/css">
Body{
	scrollbar-3dlight-color:C9C9C9;
	scrollbar-arrow-color:999999;
	scrollbar-base-color:D2D2D2;
	scrollbar-face-color:#DADADA;
	scrollbar-highlight-color:f0f0f0;
	scrollbar-shadow-color:C9C9C9;
	scrollbar-darkshadow-color:f0f0f0;
}
hr { height:0px; border-top:1px solid #CAD9E7;}
.left_menu_top
{
    white-space: nowrap;
    height:90px; 
    width:172px; 
    margin:0px auto 1px; 
    padding:10px 0px 0px;  
    text-align:left; 
    clear:both; 
    vertical-align:top;
    text-align:center; 
    line-height:20px;
    background:url("<%=ForumConfig.ReadConfigInfo().SkinPath %>/left_top.gif") no-repeat;
}
.left_menu_top img 
{
    float:none; 
    vertical-align:top;
    border:none;
    margin:0px;
}
</style>
<div style='width: 100%; margin: 5px auto;'>
<div class="TC M5"><b><%=ForumConfig.ReadConfigInfo().ForumName %></b></div>
<div class="left_menu_top">
<a href="ForumTopic.aspx?Action=New" target="right"><img src="<%=ForumConfig.ReadConfigInfo().SkinPath %>/left_newtopic.gif" alt="最新主题" /></a><a href="ForumTopic.aspx?Action=Hot" target="right"><img src="<%=ForumConfig.ReadConfigInfo().SkinPath %>/left_hottopic.gif" alt="热门主题" /></a><a href="ForumTopic.aspx?Action=Good" target="right"><img src="<%=ForumConfig.ReadConfigInfo().SkinPath %>/left_goodtopic.gif" alt="精华主题" /></a><a href="Team.aspx" target="right"><img src="<%=ForumConfig.ReadConfigInfo().SkinPath %>/left_team.gif" alt="朋友圈子" /></a><a href="ControlPanel.aspx" target="right"><img src="<%=ForumConfig.ReadConfigInfo().SkinPath %>/left_user.gif" alt="用户中心" /></a>
<hr style="width:80%;" />
<a href="Register.aspx" target="right">用户注册</a> <a href="Login.aspx" target="right">用户登录</a> <a href="ForgetPassword.aspx" target="right">忘记密码</a>
</div>
<div class="TC P5"><hr style="width:100%;border:dashed 1px  #CAD9E7" /></div>
<div>
<DXBBS:MenuTree ID="MenuTree1" runat="server" />
</div>
</div>