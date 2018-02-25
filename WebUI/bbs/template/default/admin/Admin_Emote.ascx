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
<div class="BodyBlock PTB5">
	<div class="Block Hidden">
		<div class="Title H22 LH22 TC">
			发帖表情管理
		</div>
	    <ul class="Header TC">
	    	<li style="width:60px">ID</li>
	    	<li style="width:100px">缩略图</li>
		    <li>表情名称</li>
		    <li class="Right" style="width:30px">选择</li>
			<li class="Right" style="width:100px">移动</li>
		</ul>
		<asp:Repeater ID="EmoteList" runat="server">
		<ItemTemplate>
	    <ul class="TC Hidden" style="height:60px">
	    	<li style="width:60px;padding-top:20px"><%# Eval("ID") %></li>
		    <li style="width:100px"><a href='Admin_EmoteAdd.aspx?ID=<%# Eval("ID") %>'><img src="<%# Eval("FileName") %>" width="50" height="50" /></a></li>
		    <li><%# Eval("EmoteName") %></li>
		    <li class="Right" style="width:30px;padding-top:20px"><input type="checkbox" name="SelectID" value="<%# Eval("ID") %>" /></li>
			<li class="Right" style="width:100px;padding-top:20px"><input type="button" class="Button" value="上移" onclick="window.location.href='?Action=Up&ID=<%# Eval("ID") %>&Orders=<%# Eval("Orders") %>'" /><input type="button" class="Button" value="下移" onclick="window.location.href='?Action=Down&ID=<%# Eval("ID") %>&Orders=<%# Eval("Orders") %>'" /></li>
		</ul>
		</ItemTemplate>
		</asp:Repeater>
		<ul class="Footer PTB5 TC">
			<input type="button" class="Button" value="添加表情" onclick="window.location.href='Admin_EmoteAdd.aspx'" />&nbsp;<asp:Button CssClass="Button" ID="DeleteButton" Text="确定删除" OnClientClick="return CheckSelect()" runat="server" />&nbsp;<input type="checkbox" name="All" onclick="SelectAll(this)" />全选/全不选
		</ul>
	</div>
    <div class="BlankBlock Hidden">
        <DXBBS:ForumPager ID="CommonPager" runat="server" />
    </div>
</div>