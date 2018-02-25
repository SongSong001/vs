<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true"%>
                    <div class="TC"><asp:Image ID="UserPhoto" runat="server" /></div>
                    <div class="TC"><asp:Literal ID="LevelPhoto" runat="server" /></div>
                    <div class="UserInfoList"><img src="<%=ForumConfig.ReadConfigInfo().SkinPath %>/list.gif" align="absmiddle" />等级：<asp:Label ID="Level" ForeColor="blue" Text="访客" runat="server" /></div>
                    <asp:PlaceHolder ID="ShowNickName" Visible="false" runat="server">
                    <div class="UserInfoList"><img src="<%=ForumConfig.ReadConfigInfo().SkinPath %>/list.gif" align="absmiddle" />昵称：<asp:Label ID="NickName" ForeColor="black" Text="--" runat="server" /></div>
                    </asp:PlaceHolder>
                    <div class="UserInfoList"><img src="<%=ForumConfig.ReadConfigInfo().SkinPath %>/list.gif" align="absmiddle" />金币：<asp:Label ID="Coin" ForeColor="black" Text="0" runat="server" /></div>
                    <div class="UserInfoList"><img src="<%=ForumConfig.ReadConfigInfo().SkinPath %>/list.gif" align="absmiddle" />积分：<asp:Label ID="Point" ForeColor="black" Text="0" runat="server" /></div>
                    <div class="UserInfoList"><img src="<%=ForumConfig.ReadConfigInfo().SkinPath %>/list.gif" align="absmiddle" />发帖：<asp:Label ID="Topic" ForeColor="black" Text="0" runat="server" /></div>
                    <div class="UserInfoList"><img src="<%=ForumConfig.ReadConfigInfo().SkinPath %>/list.gif" align="absmiddle" />回帖：<asp:Label ID="Reply" ForeColor="black" Text="0" runat="server" /></div>
                    <div class="UserInfoList"><img src="<%=ForumConfig.ReadConfigInfo().SkinPath %>/list.gif" align="absmiddle" />注册：<asp:Label ID="RegTime" ForeColor="black" Text="--" runat="server" /></div>