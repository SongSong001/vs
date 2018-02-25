<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true"%>
<div class="BodyBlock PTB5">
    <div class="Block Hidden">
        <div class="Title H22 LH22 TC">
            用户改名
        </div>
        <div class="M1 Middle">
            <div class="Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;原用户名：
                </div>
                <div class="Left">
                     &nbsp;<asp:TextBox ID="UserName" runat="server" Width="404px" /><asp:requiredfieldvalidator ID="NeedUserName" runat="server" ControlToValidate="UserName" Display="Dynamic" ErrorMessage="请填写原用户名称"></asp:requiredfieldvalidator></div>
            </div>
            <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;新用户名：
                </div>
                <div class="Left">
                     &nbsp;<asp:TextBox ID="NewName" runat="server" Width="404px" /><asp:requiredfieldvalidator ID="NeedNewName" runat="server" ControlToValidate="NewName" Display="Dynamic" ErrorMessage="请填写新用户名称"></asp:requiredfieldvalidator></div>
            </div>
			<div class="Footer BT P5 TC Hidden">
				<asp:Button CssClass="Button" ID="SubmitButton" Text="确定提交" runat="server" />
			</div>
		</div>
	</div>
</div>