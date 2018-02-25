<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true"%>
<div class="BodyBlock PTB5">
    <div class="Block Hidden">
        <div class="Title H22 LH22 TC">
            论坛模板添加/修改
        </div>
        <div class="M1 Middle">
	        <div class="LH25 Hidden" style="width:100%">
	            <div class="Left BR" style="width: 200px">&nbsp;模板名称：</div>
	            <div class="Left">&nbsp;<asp:TextBox ID="TemplateName" runat="server" Width="350px" /><asp:requiredfieldvalidator ID="NeedTemplateName" runat="server" ControlToValidate="TemplateName" Display="Dynamic" ErrorMessage="请填写模板名称"></asp:requiredfieldvalidator></div>
	        </div>
	        <div class="BT LH25 Hidden" style="width:100%">
	            <div class="Left BR" style="width: 200px">&nbsp;模板文件夹：</div>
	            <div class="Left">&nbsp;<asp:TextBox ID="FilePath" runat="server" Width="350px" /><asp:requiredfieldvalidator ID="NeedFilePath" runat="server" ControlToValidate="FilePath" Display="Dynamic" ErrorMessage="请填写模板文件夹"></asp:requiredfieldvalidator></div>
	        </div>
	        <div class="BT Footer P5 TC Hidden">
		        <asp:Button CssClass="Button" ID="SubmitButton" Text="确定提交" runat="server" />&nbsp;<input type="button" class="Button" value="返回" onclick="history.back(-1)" />
	        </div>
	    </div>
	</div>
</div>