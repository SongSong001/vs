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
			上传文件管理
		</div>
	    <ul class="Header TC">
	    	<li style="width:60px">ID</li>
	    	<li>文件名</li>
		    <li class="Right" style="width:30px">选择</li>
			<li class="Right" style="width:120px">上传时间</li>
			<li class="Right" style="width:50px">文件类型</li>
			<li class="Right" style="width:100px">上传动作</li>
			<li class="Right" style="width:50px">文件大小</li>
			<li class="Right" style="width:120px">上传用户</li>
		</ul>
		<asp:Repeater ID="UploadFileList" runat="server">
		<ItemTemplate>
	    <ul class="TC">
	    	<li style="width:60px"><%# Eval("ID") %></li>
	    	<li><a href='<%# Eval("FileName") %>' target="_blank"><%# Eval("FileName") %></a></li>
		    <li class="Right" style="width:30px"><input type="checkbox" name="SelectID" value="<%# Eval("ID") %>" /></li>
			<li class="Right" style="width:120px"><%# Eval("AddTime") %></li>
			<li class="Right" style="width:50px"><%# Eval("FileType") %></li>
			<li class="Right" style="width:100px"><DXBBS:UploadAction DataSource='<%# Eval("Types") %>' runat="server" /></li>
			<li class="Right" style="width:50px"><%# Eval("FileSize") %></li>
			<li class="Right" style="width:120px"><%# Eval("UserName") %></li>
		</ul>
		</ItemTemplate>
		</asp:Repeater>
		<div class="Footer PTB5 TC">
			<asp:Button CssClass="Button" ID="DeleteButton" Text="确定删除" OnClientClick="return CheckSelect()" runat="server" />&nbsp;<input type="checkbox" name="All" onclick="SelectAll(this)" />全选/全不选
		</div>
	</div>
	<div class="BlankBlock Hidden">
        <DXBBS:ForumPager ID="CommonPager" runat="server" />
    </div>
</div>