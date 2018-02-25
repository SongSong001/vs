<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true"%>
<%@ Register TagPrefix="DXBBS" Namespace="DXBBS.Controls" Assembly="DXBBS.Controls" %>
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
		<img src="<% = ForumConfig.ReadConfigInfo().SkinPath %>/boardicon.gif" align="absmiddle" /><DXBBS:Possition ID="Possition1" runat="server" />帖子操作
	</div>
</div>
<div class="Block Hidden">
    <ul class="Middle TC Cursor">
        <li style="width:25%" class="TC BR" onmouseover="this.className='Footer TC BR'" onmouseout="this.className='Middle TC BR'" onclick="location.href='BoardNews.aspx?BoardID=<% = Requests.GetIntQueryString("BoardID") %>'">版块公告管理</li>
        <li style="width:25%" class="TC BR" onmouseover="this.className='Footer TC BR'" onmouseout="this.className='Middle TC BR'" onclick="location.href='TopicEdit.aspx?BoardID=<% = Requests.GetIntQueryString("BoardID") %>'">版块帖子管理</li>
        <li style="width:25%" class="TC BR" onmouseover="this.className='Footer TC BR'" onmouseout="this.className='Middle TC BR'" onclick="location.href='TopicEdit.aspx?BoardID=<% = Requests.GetIntQueryString("BoardID") %>&Types=1'">版块帖子审核</li>
        <li style="width:25%;margin-right:-5px" class="TC" onmouseover="this.className='Footer TC'" onmouseout="this.className='Middle TC'" onclick="location.href='BoardLog.aspx?BoardID=<% = Requests.GetIntQueryString("BoardID") %>'">版块日志管理</li>
    </ul>
</div>
<div class="Block Hidden">
    <div class="Title H22 LH22 TC">
        论坛版块贴子管理
    </div>
	<ul class="Header TC">
		<li class="Left" style="width:50px">ID</li>
		<li class="Right" style="width:30px">选择</li>
		<li class="Right" style="width:80px">最后更新</li>
		<li class="Right" style="width:80px">发表时间</li>
		<li class="Right" style="width:150px">所属版面</li>
		<li class="Right" style="width:60px">是否审核</li>
        	<li class="Right TL" style="width:50px">查看</li>
        	<li class="Right TR" style="width:50px">回复&nbsp;|&nbsp;</li>
		<li class="Right TR" style="width:100px">发表用户</li>
		<li>帖子标题</li>
	</ul>
	<asp:Repeater ID="TopicList" runat="server">
	<ItemTemplate>
	<dl class="Middle TC">
		<dd class="Left" style="width:50px"><%# Eval("ID") %></dd>
		<dd class="Right" style="width:30px"><input type="checkbox" name="SelectID" value="<%# Eval("ID") %>" /></dd>
		<dd class="Right" style="width:80px"><%# Convert.ToDateTime(Eval("LastReplyTime")).ToString("yyyy/MM/dd") %></dd>
		<dd class="Right" style="width:80px"><%# Convert.ToDateTime(Eval("AddTime")).ToString("yyyy/MM/dd") %></dd>
		<dd class="Right" style="width:150px"><DXBBS:BoardName ID="BoardName1" BoardID='<%# Eval("BoardID") %>' runat="server" /></dd>
		<dd class="Right" style="width:60px"><DXBBS:Confirmed ID="Confirmed1" DataSource='<%# Eval("Confirmed") %>' runat="server" /></dd>
        	<dd class="Right TL" style="width:50px"><%# Eval("Click") %></dd>
        	<dd class="Right TR" style="width:50px"><font color="#ff0099"><b><%# Eval("Reply") %></b></font>&nbsp;|&nbsp;</dd>
		<dd class="Right TR" style="width:100px"><%# Eval("UserName") %></dd>
		<dd class="TL" style="margin-left:50px"><a href='<%# URLConfig.TopicURL.Replace("$BoardID",Eval("BoardID").ToString()).Replace("$TopicID",Eval("ID").ToString()) %>' target="_blank"><%# Eval("Title") %></a></dd>
	</dl>
	</ItemTemplate>
	</asp:Repeater>
	<div class="Footer PTB5 BT TC">
		<asp:Button CssClass="Button" ID="LockButton" Text="批量锁定" OnClientClick="return CheckSelect()" runat="server" />&nbsp;<asp:Button CssClass="Button" ID="DeleteLockButton" Text="批量解锁" OnClientClick="return CheckSelect()" runat="server" />&nbsp;<asp:Button CssClass="Button" ID="HideButton" Text="批量屏蔽" OnClientClick="return CheckSelect()" runat="server" />&nbsp;<asp:Button CssClass="Button" ID="DeleteHideButton" Text="批量解屏" OnClientClick="return CheckSelect()" runat="server" />&nbsp;<asp:Button CssClass="Button" ID="ConfirmButton" Text="批量审核" OnClientClick="return CheckSelect()" runat="server" />&nbsp;<asp:Button CssClass="Button" ID="DeleteButton" Text="批量删除" OnClientClick="return CheckSelect()" runat="server" />&nbsp;移动到：<asp:DropDownList ID="ToBoard" runat="server" />&nbsp;<asp:Button CssClass="Button" ID="MoveButton" Text="批量移动" OnClientClick="return CheckSelect()" runat="server" />&nbsp;<input type="checkbox" name="All" onclick="SelectAll(this)" />全选/全不选
	</div>
</div>
<div class="BlankBlock Hidden">
    <DXBBS:ForumPager ID="CommonPager" runat="server" />
</div>