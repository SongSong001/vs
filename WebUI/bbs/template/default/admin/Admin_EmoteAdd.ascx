<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true"%>
<asp:PlaceHolder ID="Add" runat="server">
<div class="BodyBlock PTB5">
    <div class="Block Hidden">
        <div class="Title H22 LH22 TC">
            添加/修改表情
        </div>
        <div class="M1 Middle">
	        <div class="LH25 Hidden" style="width:100%">
	            <div class="Left BR" style="width: 200px">&nbsp;表情名称：</div>
	            <div class="Left BL" style="margin-left:-1px">&nbsp;<asp:TextBox ID="EmoteName" runat="server" Width="350px" /></div>
	        </div>
	        <div class="BT LH25 Hidden" style="width:100%">
	            <div class="Left BR" style="width: 200px">&nbsp;表情文件：</div>
	            <div class="Left BL" style="margin-left:-1px">&nbsp;<asp:TextBox ID="FileName" runat="server" Width="350px" /><asp:requiredfieldvalidator ID="NeedFileName" runat="server" ControlToValidate="FileName" Display="Dynamic" ErrorMessage="请填写表情文件地址"></asp:requiredfieldvalidator></div>
	        </div>
			<div class="BT Footer P5 TC Hidden">
				<asp:Button CssClass="Button" ID="SubmitButton" Text="确定提交" runat="server" />&nbsp;<input type="button" class="Button" value="返回" onclick="history.back(-1)" />
			</div>
		</div>
	</div>
</div>
</asp:PlaceHolder>
<asp:PlaceHolder ID="MultiAdd" Visible="false" runat="server">
<div class="BodyBlock PTB5">
    <div class="Block Hidden">
        <div class="Title H22 LH22 TC">
            批量添加表情
        </div>
        <div class="M1 Middle">
	        <div class="LH25 Hidden" style="width:100%">
	            <div class="Left BR" style="width: 200px">&nbsp;表情文件夹：</div>
	            <div class="Left BL" style="margin-left:-1px">&nbsp;<asp:TextBox ID="Folder" runat="server" Width="350px" /><asp:requiredfieldvalidator ID="NeedFolder" runat="server" ControlToValidate="Folder" Display="Dynamic" ErrorMessage="请填写表情文件夹"></asp:requiredfieldvalidator></div>
	        </div>
			<div class="BT Footer P5 TC Hidden">
				<asp:Button CssClass="Button" ID="MultiAddButton" Text="确定提交" runat="server" />
			</div>
		</div>
	</div>
</div>
</asp:PlaceHolder>