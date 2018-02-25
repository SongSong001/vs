﻿<%@ Import Namespace="DXBBS.Components"%>
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
			论坛皮肤管理
		</div>
		<ul class="Header TC">
			<li class="Left" style="width:50px">ID</li>
			<li class="Right" style="width:30px">选择</li>
			<li class="Right" style="width:120px">编辑CSS文件</li>
			<li class="Right" style="width:120px">添加时间</li>
			<li class="Right" style="width:250px">皮肤文件地址</li>
			<li>皮肤名称</li>
		</ul>
		<asp:Repeater ID="TemplateList" runat="server">
		<ItemTemplate>
		<ul class="Middle TC">
		    <li>╋&nbsp;<%# Eval("TemplateName") %></li>
		</ul>
	    <DXBBS:SkinRepeater ID="SkinRepeater1" TemplateID='<%# Eval("ID") %>' runat="server">
	    <ItemTemplate>
		<ul class="Middle TC">
			<li class="Left" style="width:50px"><%# Eval("ID") %></li>
			<li class="Right" style="width:30px"><input type="checkbox" name="SelectID" value="<%# Eval("ID") %>" /></li>
			<li class="Right" style="width:120px"><a href='Admin_CSS.aspx?ID=<%# Eval("TemplateID") %>&FileName=<%# Eval("FilePath") %>/style.css'><span class="Blue"><b>编辑该皮肤CSS</b></span></a></li>
			<li class="Right" style="width:120px"><%# Eval("AddTime") %></li>
			<li class="Right" style="width:250px"><%# Eval("FilePath") %></li>
			<li><a href='Admin_SkinAdd.aspx?ID=<%# Eval("ID") %>'><%# Eval("SkinName") %></a>&nbsp;<DXBBS:TemplateUsing ID="TemplateUsing1" DataSource='<%# Eval("ID") %>' Types="skin" runat="server" /></li>
		</ul>
	    </ItemTemplate>
	    </DXBBS:SkinRepeater>
		</ItemTemplate>
		</asp:Repeater>
		<div class="Footer PTB5 TC">
			<input type="button" class="Button" value="添加皮肤" onclick="window.location.href='Admin_SkinAdd.aspx'" />&nbsp;<asp:Button CssClass="Button" ID="DeleteButton" Text="确定删除" OnClientClick="return CheckSelect()" runat="server" />&nbsp;<input type="checkbox" name="All" onclick="SelectAll(this)" />全选/全不选
		</div>
	</div>
</div>