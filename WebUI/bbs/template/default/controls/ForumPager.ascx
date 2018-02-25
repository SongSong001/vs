<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true"%>
<%@ Register TagPrefix="DXBBS" Namespace="DXBBS.Controls" Assembly="DXBBS.Controls" %>
<div class="Hidden">
    <div class="Pager">
    <DXBBS:Pager ID="CommonPager" SizePerPage="10" runat="server">
    <HeaderTemplate>
            <div class="Pager_Info">共有 <%# Container.Count %> 条</div>
            <div class="Pager_Info">当前 <%# Container.CurrentPage %>/<%# Container.PageCount %> 页</div>
            <div class="Pager_Pointer Cursor" onclick="location.href='<%# Container.URL.Replace("$Page","1") %>'"><img src=<%=ForumConfig.ReadConfigInfo().SkinPath %>/pager_left1.gif /></div>
            <div class="Pager_Pointer Cursor" onclick="location.href='<%# Container.URL.Replace("$Page",Container.PreviousPage.ToString()) %>'"><img src=<%=ForumConfig.ReadConfigInfo().SkinPath %>/pager_left2.gif /></div>
    </HeaderTemplate>
    <ItemTemplate>
            <div class="Pager_Number Cursor" onclick="location.href='<%# Container.URL.Replace("$Page",Container.PageNum.ToString()) %>'"><%# Container.DataItem %></div>
    </ItemTemplate>
    <FooterTemplate>
            <div class="Pager_Pointer Cursor" onclick="location.href='<%# Container.URL.Replace("$Page",Container.NextPage.ToString()) %>'"><img src=<%=ForumConfig.ReadConfigInfo().SkinPath %>/pager_right1.gif /></div>
            <div class="Pager_Pointer Cursor" onclick="location.href='<%# Container.URL.Replace("$Page",Container.PageCount.ToString())%>'"><img src=<%=ForumConfig.ReadConfigInfo().SkinPath %>/pager_right2.gif /></div>
            <div class="Pager_Input">转到 <asp:TextBox ID="GoPage" runat="server" />&nbsp;<asp:Button ID="DoGo" Height="19px" Width="30px" Font-Size="11px" Text="GO" runat="server" /></div>
    </FooterTemplate>
    </DXBBS:Pager>
    </div>
</div>