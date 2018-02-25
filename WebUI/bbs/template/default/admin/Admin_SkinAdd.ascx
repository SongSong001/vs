<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true"%>
<div class="BodyBlock PTB5">
    <div class="Block Hidden">
        <div class="Title H22 LH22 TC">
            论坛皮肤添加/修改
        </div>
        <div class="M1 Middle">
	        <div class="LH25 Hidden" style="width:100%">
	            <div class="Left BR" style="width: 200px">&nbsp;所属模板：</div>
	            <div class="Left">&nbsp;<asp:DropDownList ID="TemplateID" runat="server" /></div>
	        </div>
	        <div class="BT LH25 Hidden" style="width:100%">
	            <div class="Left BR" style="width: 200px">&nbsp;皮肤名称：</div>
	            <div class="Left">&nbsp;<asp:TextBox ID="SkinName" runat="server" Width="350px" /><asp:requiredfieldvalidator ID="NeedSkinName" runat="server" ControlToValidate="SkinName" Display="Dynamic" ErrorMessage="请填写皮肤名称"></asp:requiredfieldvalidator></div>
	        </div>
	        <div class="BT LH25 Hidden" style="width:100%">
	            <div class="Left BR" style="width: 200px">&nbsp;皮肤文件夹：</div>
	            <div class="Left">&nbsp;<asp:TextBox ID="FilePath" runat="server" Width="350px" /><asp:requiredfieldvalidator ID="NeedFilePath" runat="server" ControlToValidate="FilePath" Display="Dynamic" ErrorMessage="请填写皮肤文件夹"></asp:requiredfieldvalidator></div>
	        </div>
	        <div class="BT Footer P5 TC Hidden">
				<asp:Button CssClass="Button" ID="SubmitButton" Text="确定提交" runat="server" />&nbsp;<input type="button" class="Button" value="返回" onclick="history.back(-1)" />
	        </div>
	    </div>
	</div>
</div>