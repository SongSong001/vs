<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true"%>
<div class="BodyBlock PTB5">
    <div class="Block Hidden">
        <div class="Title H22 LH22 TC">
            操作失败
        </div>
        <div class="M1 Middle TC">
        	<asp:TextBox ID="Content" TextMode="multiLine" runat="server" Height="100px" Width="350px" />&nbsp;<input type="button" class="Button" value="返回" onclick="history.back(-2)" />
		</div>
	</div>
</div>
