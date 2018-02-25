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
		<img src="<% = ForumConfig.ReadConfigInfo().SkinPath %>/boardicon.gif" align="absmiddle" /><DXBBS:Possition ID="Possition1" runat="server" />版块公告管理
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
        公告管理
    </div>
	<ul class="Header TC">
		<li class="Left" style="width:50px">ID</li>
		<li class="Right" style="width:30px">选择</li>
		<li class="Right" style="width:120px">添加时间</li>
		<li class="TC">公告标题</li>
	</ul>
	<asp:Repeater ID="NewsList" runat="server">
	<ItemTemplate>
	<dl class="Middle TC">
		<dd class="Left" style="width:50px"><%# Eval("ID") %></dd>
		<dd class="Right" style="width:30px"><input type="checkbox" name="SelectID" value="<%# Eval("ID") %>" /></dd>
		<dd class="Right" style="width:120px"><%# Eval("AddTime") %></dd>
		<dd class="TL"><a href='BoardNews.aspx?BoardID=<% = Requests.GetIntQueryString("BoardID") %>&Action=Add&ID=<%# Eval("ID") %>'><%# Eval("Title") %></a></dd>
	</dl>
	</ItemTemplate>
	</asp:Repeater>
	<div class="Footer PTB5 BT TC">
		<input type="button" class="Button" value="添加公告" onclick="window.location.href='BoardNews.aspx?BoardID=<% = Requests.GetIntQueryString("BoardID") %>&Action=Add'" />&nbsp;<asp:Button CssClass="Button" ID="DeleteButton" Text="确定删除" OnClientClick="return CheckSelect()" runat="server" />&nbsp;<input type="checkbox" name="All" onclick="SelectAll(this)" />全选/全不选
	</div>
</div>
<div class="BlankBlock Hidden">
    <DXBBS:ForumPager ID="CommonPager" runat="server" />
</div>
<asp:PlaceHolder ID="ShowAdd" Visible="false" runat="server">
<div class="Block Hidden">
    <div class="Title H22 LH22 TC">
        版块公告添加/修改
    </div>
            <div class="BT Middle Hidden" style="width:100%">
                <div class="Left BR LH25" style="width: 200px">
                    &nbsp;公告标题：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <asp:TextBox ID="Title" runat="server" Width="550" /><asp:requiredfieldvalidator ID="NeedTitle" runat="server" ControlToValidate="Title" Display="Dynamic" ErrorMessage="请填写标题"></asp:requiredfieldvalidator>
                </div>
            </div>
            <div class="BT Middle Hidden" style="width:100%">
                <div class="Left BR LH25" style="width: 200px">
                    &nbsp;公告内容：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <DXBBS:Editor id="Content" height="100" AllowScript="true" runat="server" />
                </div>
            </div>
	<div class="Footer PTB5 BT TC">
		<asp:Button CssClass="Button" ID="SubmitButton" Text="确定提交" runat="server" /></div>
</div>
</asp:PlaceHolder>