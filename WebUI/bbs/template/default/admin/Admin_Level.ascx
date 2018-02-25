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
            用户等级管理
        </div>
		<ul class="Header TC">
			<li style="width:50px">ID</li>
			<li class="Right" style="width:30px">选择</li>
			<li class="Right" style="width:150px">等级图片</li>
			<li class="Right" style="width:80px">对应积分</li>
			<li class="Right TL" style="width:100px">等级类型</li>
			<li>等级名称</li>
		</ul>
		<asp:Repeater ID="LevelList" runat="server">
		<ItemTemplate>
		<ul class="TC">
			<li style="width:50px"><%# Eval("ID") %></li>
			<li><a href='Admin_LevelAdd.aspx?ID=<%# Eval("ID") %>'><%# Eval("LevelName") %></a></li>
			<li class="Right" style="width:30px"><input type="checkbox" name="SelectID" value="<%# Eval("ID") %>" /></li>
			<li class="Right" style="width:150px"><DXBBS:LevelPhoto ID="LevelPhoto1" DataSource='<%# Eval("Photo") %>' runat="server" />&nbsp;</li>
			<li class="Right" style="width:80px"><%# Eval("Point") %></li>
			<li class="Right TL" style="width:100px"><DXBBS:LevelTypeName ID="LevelType1" DataSource='<%# Eval("Types") %>' runat="server" /></li>
		</ul>
		</ItemTemplate>
		</asp:Repeater>
		<div class="Footer PTB5 TC">
			<input type="button" class="Button" value="添加等级" onclick="window.location.href='Admin_LevelAdd.aspx'" />&nbsp;<asp:Button CssClass="Button" ID="DeleteButton" Text="确定删除" OnClientClick="return CheckSelect()" runat="server" />&nbsp;<input type="checkbox" name="All" onclick="SelectAll(this)" />全选/全不选
		</div>
	</div>
</div>