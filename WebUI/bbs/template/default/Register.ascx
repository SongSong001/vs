<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true" %>
<%@ Register TagPrefix="DXBBS" Namespace="DXBBS.Controls" Assembly="DXBBS.Controls" %>
<script language="javascript">
    function OnCallback(result,context)
    {
        var obj=document.getElementById("msg");
        if (result=="0")
        {
            obj.innerHTML="<img src=images/reg_ok.gif>&nbsp;<font color=blue><b>可用,未被注册</b></font>";
        }
        else
        {
            if (result=="-1")
            {
                obj.innerHTML="<img src=images/reg_error.gif>&nbsp;<font color=red><b>用户名含有非法字符</b></font>";
            }
            else if (result=="-2")
            {
                obj.innerHTML="<img src=images/reg_error.gif>&nbsp;<font color=red><b>用户名长度不正确</b></font>";
            }
            else
            {
                obj.innerHTML="<img src=images/reg_error.gif>&nbsp;<font color=red><b>该用户名已经被注册,请重新填写</b></font>";
            }
        }
    }
</script>
<div class="Block">
    <div class="Possition">
		<img src="<% = ForumConfig.ReadConfigInfo().SkinPath %>/boardicon.gif" align="absmiddle" /><DXBBS:Possition ID="Possition1" runat="server" />新用户注册
	</div>
</div>
<div class="Block Hidden" style="float:left; width:100%; overflow:hidden;">
    <div class="Title LH22 TC">
        全部项目必须填写
    </div>
    <ul>
		<li style="width:350px"><b>&nbsp;用户名</b>：(长度限制为<%=ForumConfig.ReadConfigInfo().MinUsernameLength %>－<%=ForumConfig.ReadConfigInfo().MaxUsernameLength %>字符)</li>
		<li>&nbsp;<asp:TextBox ID="UserName" Width="150px" runat="server"/><span id="msg"></span>&nbsp;<asp:RequiredFieldValidator ID="NeedName" ControlToValidate="UserName" runat="server" Display="Dynamic" ErrorMessage="请填写用户名" /></li>
    </ul>
    <ul>
		<li style="width:350px"><b>&nbsp;密码(至少3位)</b>：(请输入密码,区分大小写)</li>
		<li>&nbsp;<asp:TextBox ID="Password" Width="150px" TextMode="password" runat="server" />&nbsp;<asp:RequiredFieldValidator ID="NeedPassword" ControlToValidate="Password" runat="server" Display="Dynamic" ErrorMessage="请填写密码" /></li>
    </ul>
    <ul>
		<li style="width:350px"><b>&nbsp;确认密码(至少3位)</b>：(请再输一遍确认)</li>
		<li>&nbsp;<asp:TextBox ID="Password1" Width="150px" TextMode="password" runat="server" />&nbsp;<asp:RequiredFieldValidator ID="NeedPassword1" ControlToValidate="Password1" runat="server" Display="Dynamic" ErrorMessage="请确认密码" /><asp:CompareValidator ID="ComparePassword" ControlToValidate="Password1" ControlToCompare="Password" Display="dynamic" ErrorMessage="两次输入密码不一致" runat="server" /></li>
    </ul>
    <ul>
		<li style="width:350px"><b>&nbsp;Email地址</b>：(请输入有效的邮件地址)</li>
		<li>&nbsp;<asp:TextBox ID="Email" Width="150px" runat="server" />&nbsp;<asp:RequiredFieldValidator ID="NeedMail" ControlToValidate="Email" runat="server" Display="Dynamic" ErrorMessage="请填写Email" /><asp:RegularExpressionValidator ID="CheckMail" ControlToValidate="Email" runat="server" Display="Dynamic" ErrorMessage="Email地址不正确" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" /></li>
    </ul>
    <ul>
		<li style="width:350px"><b>&nbsp;密码提示问题</b></li>
		<li>&nbsp;<asp:TextBox ID="Question" Width="150px" MaxLength="50" runat="server"/>&nbsp;<span id="Span1"></span><asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="Question" runat="server" Display="Dynamic" ErrorMessage="请填写密码提示问题" /></li>
    </ul>
    <ul>
		<li style="width:350px"><b>&nbsp;问题回答</b></li>
		<li>&nbsp;<asp:TextBox ID="Answer" Width="150px" MaxLength="50" runat="server"/>&nbsp;<span id="Span2"></span><asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="Answer" runat="server" Display="Dynamic" ErrorMessage="请填写问题回答" /></li>
    </ul>
    <ul>
		<li style="width:350px"><b>&nbsp;性别</b></li>
		<li>&nbsp;<asp:RadioButtonList ID="Sex" RepeatDirection="horizontal" RepeatLayout="flow" runat="server"><asp:ListItem Text="男" Value="1" Selected="true" /><asp:ListItem Text="女" Value="0" /></asp:RadioButtonList></li>
    </ul>
	<asp:PlaceHolder ID="ShowRegisterCode" runat="server">
    <ul>
		<li style="width:350px"><b>&nbsp;验证码</b></li>
		<li>&nbsp;<asp:TextBox ID="RegisterCode" Width="100px" runat="server" />&nbsp;<img src="ShowCode.aspx" align="absmiddle"> <asp:RequiredFieldValidator ID="NeedRegisterCode" ControlToValidate="RegisterCode" runat="server" Display="Dynamic" ErrorMessage="请确认验证码" /></li>
    </ul>
	</asp:PlaceHolder>
	<div class="Footer TC PTB5">
        <asp:Button CssClass="Button" ID="RegisterButton" Text="确定注册" runat="server" />&nbsp;&nbsp;<input type="reset" value=' 重填 ' class="Button"/>
    </div>
</div>