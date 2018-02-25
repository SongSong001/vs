<%@ Control Language="C#" AutoEventWireup="true"%>
<%@ Import Namespace="DXBBS.Components"%>
<asp:PlaceHolder ID="ShowGroupList" Visible="false" runat="server">
<div class="GroupItem"><div class="<%= (Requests.GetIntQueryString("GroupID")==0)?"GroupInside-On":"GroupInside" %>" onmouseover="this.className='GroupInside-On'" onmouseout="this.className='<%= (Requests.GetIntQueryString("GroupID")==0)?"GroupInside-On":"GroupInside" %>'"><a href="<%= URLConfig.BoardURL.Replace("$BoardID",Requests.GetIntQueryString("BoardID").ToString()).Replace("$GroupID","0")  %>">全部主题</a></div></div>
<asp:Repeater ID="GroupList" runat="server"><itemTemplate>
<div class="GroupItem"><div class="<%# (Eval("ID").ToString() == Requests.GetStringQueryString("GroupID"))?"GroupInside-On":"GroupInside" %>" onmouseover="this.className='GroupInside-On'" onmouseout="this.className='<%# (Eval("ID").ToString() == Requests.GetStringQueryString("GroupID"))?"GroupInside-On":"GroupInside" %>'"><a href="<%# URLConfig.BoardURL.Replace("$BoardID",Eval("BoardID").ToString()).Replace("$GroupID",Eval("ID").ToString())  %>"><%# Eval("GroupName") %></a></div></div>
</itemTemplate></asp:Repeater>
</asp:PlaceHolder>