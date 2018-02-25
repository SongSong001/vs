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
            论坛回复回收站管理
        </div>
		<ul class="Header TC">
			<li class="Left" style="width:50px">ID</li>
			<li>回复内容</li>
			<li class="Right">选择</li>
			<li class="Right" style="width:80px">发表时间</li>
			<li class="Right" style="width:300px">所属版面</li>
			<li class="Right" style="width:80px">发表用户</li>
		</ul>
		<asp:Repeater ID="TopicList" runat="server">
		<ItemTemplate>
		<dl class="TC">
			<dd class="Left" style="width:50px"><%# Eval("ID") %></dd>
			<dd class="Right"><input type="checkbox" name="SelectID" value="<%# Eval("ID") %>" /></dd>
			<dd class="Right" style="width:80px"><%# Convert.ToDateTime(Eval("AddTime")).ToString("yyyy/MM/dd") %></dd>
			<dd class="Right" style="width:300px"><DXBBS:BoardName ID="BoardName1" BoardID='<%# Eval("BoardID") %>' runat="server" /></dd>
			<dd class="Right" style="width:80px"><%# Eval("UserName") %></dd>
			<dd class="TL"><%# Filter.Substring(Eval("Content").ToString(),50) %></dd>
		</dl>
		</ItemTemplate>
		</asp:Repeater>
		<ul class="Footer PTB5 TC">
			<asp:Button CssClass="Button" ID="ReturnButton" Text="确定还原" OnClientClick="return CheckSelect()" runat="server" />&nbsp;<asp:Button CssClass="Button" ID="DeleteButton" Text="确定删除" OnClientClick="return CheckSelect()" runat="server" />&nbsp;<input type="checkbox" name="All" onclick="SelectAll(this)" />全选/全不选
		</ul>
	</div>
<div class="BlankBlock Hidden">
    <DXBBS:ForumPager ID="CommonPager" runat="server" />
</div>
</div>