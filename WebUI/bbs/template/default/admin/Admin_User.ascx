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
    if (!confirm("注意：确定要操作吗"))
    {
        return false;
    }
}
</script>
<div class="BodyBlock PTB5">
    <div class="Block Hidden">
        <div class="Title H22 LH22 TC">
            论坛用户管理
        </div>
		<ul class="Header TC">
			<li style="width:50px">ID</li>
			<li class="Right" style="width:30px">选择</li>
			<li class="Right" style="width:80px">注册时间</li>
			<li class="Right" style="width:50px">用户状态</li>
			<li class="Right" style="width:100px">最后登录IP</li>
			<li class="Right" style="width:80px">最后登录时间</li>
			<li class="Right" style="width:50px">积分</li>
			<li class="Right" style="width:50px">金币</li>
			<li class="Right" style="width:100px">等级</li>
			<li class="Right" style="width:30px">姓别</li>
			<li>用户名</li>
		</ul>
		<asp:Repeater ID="UserList" runat="server">
		<ItemTemplate>
		<ul class="TC">
			<li style="width:50px"><%# Eval("ID") %></li>
			<li class="Right" style="width:30px"><input type="checkbox" name="SelectID" value="<%# Eval("ID") %>" /></li>
			<li class="Right" style="width:80px"><%# Convert.ToDateTime(Eval("RegTime")).ToString("yyyy/MM/dd") %></li>
			<li class="Right" style="width:50px"><DXBBS:UserState DataSource='<%# Eval("State") %>' runat="server" /></li>
			<li class="Right" style="width:100px"><%# Eval("LoginIP") %></li>
			<li class="Right" style="width:80px"><%# Convert.ToDateTime(Eval("LoginTime")).ToString("yyyy/MM/dd") %></li>
			<li class="Right" style="width:50px"><%# Eval("Point") %></li>
			<li class="Right" style="width:50px"><%# Eval("Coin") %></li>
			<li class="Right" style="width:100px"><DXBBS:LevelName ID="LevelName1" DataSource='<%# Eval("LevelID") %>' runat="server" /></li>
			<li class="Right" style="width:30px"><DXBBS:UserSex ID="UserSex1" DataSource='<%# Eval("Sex") %>' runat="server" /></li>
			<li><a href='Admin_UserAdd.aspx?ID=<%# Eval("ID") %>'><%# Eval("UserName") %></a></li>
		</ul>
		</ItemTemplate>
		</asp:Repeater>
		<div class="Footer PTB5 TC">
			<input type="button" class="Button" value="添加用户" onclick="window.location.href='Admin_UserAdd.aspx'" />&nbsp;<asp:Button CssClass="Button" ID="DeleteButton" Text="确定删除" OnClientClick="return CheckSelect()" runat="server" />&nbsp;<asp:Button CssClass="Button" ID="ConfirmButton" Text="审核用户" OnClientClick="return CheckConfirm()" runat="server" />&nbsp;<asp:Button CssClass="Button" ID="LockButton" Text="锁定用户" OnClientClick="return CheckSelect()" runat="server" />&nbsp;<asp:Button CssClass="Button" ID="DeleteLockButton" Text="解锁用户" OnClientClick="return CheckSelect()" runat="server" />&nbsp;<input type="checkbox" name="All" onclick="SelectAll(this)" />全选/全不选
		</div>
	</div>
	<div class="BlankBlock Hidden">
        <DXBBS:ForumPager ID="CommonPager" runat="server" />
    </div>
</div>