<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true"%>
<div class="BodyBlock PTB5">
	<div class="Block Hidden">
		<div class="Title H22 LH22 TC">
			综合管理-->系统当前使用的语言包内容修改
		</div>
		<div class="M1">
			<div class="Middle BT Hidden">
				<asp:TextBox TextMode="multiLine" ID="Content" runat="server" Height="500px" Width="100%" />
			</div>
			<div class="Footer BT P5 TC Hidden">
				<asp:Button CssClass="Button" ID="SubmitButton" Text="确定提交" runat="server" />
			</div>
		</div>
	</div>
</div>