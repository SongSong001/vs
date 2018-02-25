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
function CheckConfirm()
{
    if (!confirm("注意：确定要清空所有系统消息吗"))
    {
        return false;
    }
}
</script>
<div class="BodyBlock PTB5">
	<div class="Block Hidden">
		<div class="Title H22 LH22 TC">
			论坛短消息管理
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
		<asp:Repeater ID="MessageList" runat="server">
		<ItemTemplate>
	    <ul class="TC">
	    	<li style="width:60px"><%# Eval("ID") %></li>
		    <li><a href='Admin_MessageView.aspx?ID=<%# Eval("ID") %>'><%# Eval("Title") %></a></li>
		    <li class="Right" style="width:30px"><input type="checkbox" name="SelectID" value="<%# Eval("ID") %>" /></li>
			<li class="Right" style="width:120px"><%# Eval("AddTime") %></li>
			<li class="Right" style="width:100px"><%# Eval("ToName") %></li>
			<li class="Right" style="width:100px"><%# Eval("FromName") %></li>
			<li class="Right" style="width:80px"><DXBBS:MessageRead ID="MesageIsRead1" DataSource='<%# Eval("IsRead") %>' runat="server" /></li>
		</ul>
		</ItemTemplate>
		</asp:Repeater>
		<div class="Footer PTB5 TC">
			<input type="button" class="Button" value="群发消息" onclick="window.location.href='Admin_MessageSend.aspx'" />&nbsp;<asp:Button CssClass="Button" ID="DeleteButton" Text="确定删除" OnClientClick="return CheckSelect()" runat="server" />&nbsp;<asp:Button CssClass="Button" ID="ClearButton" Text="清空系统消息" OnClientClick="return CheckConfirm()" runat="server" />&nbsp;<input type="checkbox" name="All" onclick="SelectAll(this)" />全选/全不选
		</div>
	</div>
	<div class="BlankBlock Hidden">
        <DXBBS:ForumPager ID="CommonPager" runat="server" />
    </div>
</div>