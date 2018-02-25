<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true"%>
<%@ Register TagPrefix="DXBBS" Namespace="DXBBS.Controls" Assembly="DXBBS.Controls" %>
<div class="Block">
    <div class="Possition">
		<img src="<% = ForumConfig.ReadConfigInfo().SkinPath %>/boardicon.gif" align="absmiddle" /><DXBBS:Possition ID="Possition1" runat="server" />忘记密码
	</div>
</div>
<div class="Block Hidden">
    <div class="Title LH22 TC">
		取回密码填项
    </div>
    <ul>
		<li style="width:35%">&nbsp;用户名：</li>
        <li>&nbsp;<asp:TextBox ID="UserName" Width="150px" runat="server" />&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="UserName" ErrorMessage="请输入用户名" Display="dynamic" runat="server" /></li>
    </ul>
    <ul>
		<li style="width:35%">&nbsp;密码提示问题：</li>
        <li>&nbsp;<asp:TextBox ID="Question" Width="150px" runat="server" />&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="Question" ErrorMessage="请输入提示问题" Display="dynamic" runat="server" /></li>
    </ul>
    <ul>
		<li style="width:35%">&nbsp;问题回答：</li>
        <li>&nbsp;<asp:TextBox ID="Answer" Width="150px" runat="server" />&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="Answer" ErrorMessage="请输入问题回答" Display="dynamic" runat="server" /></li>
    </ul>
    <ul>
		<li style="width:35%">&nbsp;新密码：</li>
        <li>&nbsp;<asp:TextBox ID="NewPassword" Width="150px" TextMode="Password" runat="server" />&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator4" ControlToValidate="NewPassword" ErrorMessage="请输入新密码" Display="dynamic" runat="server" /></li>
    </ul>
    <ul>
		<li style="width:35%">&nbsp;确认新密码：</li>
        <li>&nbsp;<asp:TextBox ID="ConfirmPassword" Width="150px" TextMode="Password" runat="server" /><asp:RequiredFieldValidator ID="RequiredFieldValidator5" ControlToValidate="ConfirmPassword" ErrorMessage="请确认新密码" Display="dynamic" runat="server" /><asp:CompareValidator ID="CheckPassword" ControlToValidate="ConfirmPassword" ControlToCompare="NewPassword" runat="server" Display="Dynamic" ErrorMessage="两次输入密码不一致" /></li>
    </ul>
	<div class="Footer TC PTB5">
        <asp:Button CssClass="Button" ID="SubmitButton" Text="确定提交" runat="server" />
    </div>
</div>