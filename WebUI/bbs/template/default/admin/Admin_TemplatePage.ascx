<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true"%>
<div class="BodyBlock PTB5">
    <div class="Block Hidden">
        <div class="Title TC P5">当前编辑模板文件：<%= Requests.GetStringQueryString("FileName") %></div>
        <div class="Middle" style="height:500px"><asp:TextBox ID="TemplateContent" TextMode="multiLine" Width="99%" Height="490px" runat="Server" /></div>
        <div class="Footer TC P5"><asp:Button ID="SubmitButton" CssClass="Button" Text="确定修改" runat="server" />&nbsp;<input type="button" class="Button" value="返回上页" onclick="history.back(-1)" /></div>
    </div>
</div>