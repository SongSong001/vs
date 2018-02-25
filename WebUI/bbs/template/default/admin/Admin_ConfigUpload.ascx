<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true"%>
<div class="BodyBlock PTB5">
    <div class="Block Hidden">
        <div class="Title H22 LH22 TC">
            系统设置-->上传设置
        </div>
        <div class="M1 Middle">
	     <div class="Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;论坛上传功能：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    
                    <asp:RadioButtonList ID="AllowUploadFile" RepeatDirection="horizontal" RepeatLayout="flow" runat="server">
	                    <asp:ListItem Value="1">开启</asp:ListItem>
	                    <asp:ListItem Value="0">关闭</asp:ListItem>
	                </asp:RadioButtonList>
	            </div>
            </div>
	     <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;论坛上传头像：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    
                    <asp:RadioButtonList id="AllowUploadFace" RepeatDirection="horizontal" RepeatLayout="flow" runat="server">
				            <asp:ListItem Value="1">开启</asp:ListItem>
				            <asp:ListItem Value="0">关闭</asp:ListItem>
			            </asp:RadioButtonList>
                </div>
            </div>
	     <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;绝对禁止上传的文件类型：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <asp:TextBox id="ForbiddenUploadType" Enabled="false" width="300px" runat="server" />&nbsp;(修改此项请打开Forum.config文件修改)
                </div>
            </div>
	     <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;允许上传的文件类型：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <asp:TextBox id="UploadType" width="300px" runat="server" /></div>
            </div>
	     <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;上传文件保存文件夹：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <asp:TextBox id="FileUploadPath"  width="150px" runat="server" /></div>
            </div>
	     <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;上传头像保存文件夹：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <asp:TextBox id="FaceUploadPath"  width="150px" runat="server" /></div>
            </div>
	     <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;圈子相册保存文件夹：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <asp:TextBox id="TeamUploadPath"  width="150px" runat="server" /></div>
            </div>
	     <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;圈子相册上传图片允许最大体积：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <asp:TextBox id="TeamUploadSize"  width="150px" runat="server" />&nbsp;K
                </div>
            </div>
	     <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;上传文件名改名规则：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    
                    <asp:RadioButtonList ID="FileNameType" RepeatDirection="horizontal" RepeatLayout="flow" runat="server"><asp:ListItem Value="1" Text="随机数字" /><asp:ListItem Value="2" Text="原文件名+随机数字" /></asp:RadioButtonList>
                </div>
            </div>
	     <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;连接外部头像图片：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    
                    <asp:RadioButtonList ID="OuterFace" RepeatDirection="horizontal" RepeatLayout="flow" runat="server">
	                    <asp:ListItem Value="1">允许</asp:ListItem>
	                    <asp:ListItem Value="0">禁止</asp:ListItem>
	                </asp:RadioButtonList>
                </div>
            </div>  
            <div class="Footer BT P5 TC Hidden">
                <asp:Button CssClass="Button" ID="SubmitButton" Text="确定提交" runat="server" />&nbsp;<input type="button" class="Button" value="取消修改" onclick="window.location='Admin_Right.aspx'" />
            </div>   
        </div>
    </div>
</div>