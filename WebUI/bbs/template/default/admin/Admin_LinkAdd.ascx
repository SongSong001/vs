<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true"%>
<div class="BodyBlock PTB5">
    <div class="Block Hidden">
        <div class="Title H22 LH22 TC">
            添加/修改友情链接
        </div>
        <div class="M1 Middle">
	        <div class="BT LH25 Hidden" style="width:100%">
	            <div class="Left BR" style="width: 200px">&nbsp;网站名称：</div>
	            <div class="Left BL" style="margin-left:-1px">&nbsp;<asp:TextBox ID="Title" runat="server" Width="350px" /><asp:requiredfieldvalidator ID="Requiredfieldvalidator1" runat="server" ControlToValidate="Title" Display="Dynamic" ErrorMessage="请填写标题"></asp:requiredfieldvalidator></div>
	        </div>
	        <div class="BT LH25 Hidden" style="width:100%">
	            <div class="Left BR" style="width: 200px">&nbsp;链接地址：</div>
	            <div class="Left BL" style="margin-left:-1px">&nbsp;<asp:TextBox ID="URL" runat="server" Width="350px" /><asp:requiredfieldvalidator ID="NeedTitle" runat="server" ControlToValidate="URL" Display="Dynamic" ErrorMessage="请填写连接地址"></asp:requiredfieldvalidator></div>
	        </div>
	        <asp:PlaceHolder ID="ShowPhoto" Visible="false" runat="server">
	        <div class="BT LH25 Hidden" style="width:100%">
	            <div class="Left BR" style="width: 200px">&nbsp;链接图片：</div>
	            <div class="Left BL" style="margin-left:-1px">&nbsp;<asp:TextBox ID="Photo" runat="server" Width="350px" /><asp:requiredfieldvalidator ID="NeedContent" runat="server" ControlToValidate="Photo" Display="Dynamic" ErrorMessage="请填写链接图片"></asp:requiredfieldvalidator></div>
	        </div>
	        </asp:PlaceHolder>
	        <div class="BT LH25 Hidden" style="width:100%">
	            <div class="Left BR" style="width: 200px">&nbsp;站点说明：</div>
	            <div class="Left BL" style="margin-left:-1px">&nbsp;<asp:TextBox ID="Introduce" TextMode="multiLine" runat="server" Height="100px" Width="350px" /></div>
	        </div>
			<div class="BT Footer P5 TC Hidden">
				<asp:Button CssClass="Button" ID="SubmitButton" Text="确定提交" runat="server" />&nbsp;<input type="button" class="Button" value="返回" onclick="history.back(-1)" />
			</div>
		</div>
	</div>
</div>