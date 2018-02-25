<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true"%>
<%@ Register TagPrefix="DXBBS" Namespace="DXBBS.Controls" Assembly="DXBBS.Controls" %>
<div class="BodyBlock PTB5">
    <div class="Block Hidden">
        <div class="Title H22 LH22 TC">
            综合管理-->添加导航链接
        </div>
        <div class="Middle M1">
	     <div class="Hidden LH25" style="width:100%">
	            <div class="Left BR" style="width: 200px">
	            	&nbsp;菜单模式：
	            </div>
				<div class="Left">
					&nbsp;<asp:RadioButtonList ID="Types" RepeatDirection="horizontal" RepeatLayout="flow" AutoPostBack="true" runat="server"><asp:ListItem Value="1" Text="设置模式" Selected="true" /><asp:ListItem Value="2" Text="HTML代码模式" /></asp:RadioButtonList>
				</div>
			</div>
	     <div class="BT Hidden LH25" style="width:100%">
	            <div class="Left BR" style="width: 200px">
	            	&nbsp;名称：
	            </div>
				<div class="Left">
					&nbsp;<asp:TextBox ID="Title" runat="server" Width="300px" /><asp:requiredfieldvalidator ID="Requiredfieldvalidator1" runat="server" ControlToValidate="Title" Display="Dynamic" ErrorMessage="请填写名称"></asp:requiredfieldvalidator>
				</div>
			</div>
			<asp:PlaceHolder ID="ConfigMode" runat="server">
			<div class="BT H25 LH25 Hidden">
	            <div class="Left BR" style="width: 200px">
	            	&nbsp;链接地址：
	            </div>
				<div class="Left">
					&nbsp;<asp:TextBox ID="URL" runat="server" Width="300px" /><asp:requiredfieldvalidator ID="NeedTitle" runat="server" ControlToValidate="URL" Display="Dynamic" ErrorMessage="请填写连接地址"></asp:requiredfieldvalidator>
				</div>
			</div>
	     <div class="BT Hidden LH25" style="width:100%">
	            <div class="Left BR" style="width: 200px">
	            	&nbsp;目标窗口：
	            </div>
				<div class="Left">
					&nbsp;<asp:DropDownList ID="Target" runat="server"><asp:ListItem Value="_self" Text="当前窗口" /><asp:ListItem Value="_parent" Text="父窗口" /><asp:ListItem Value="_top" Text="整页窗口" /><asp:ListItem Value="_blank" Text="新建窗口" /></asp:DropDownList>
				</div>
			</div>
	     <div class="BT Hidden LH25" style="width:100%">
	            <div class="Left BR" style="width: 200px">
	            	&nbsp;链接颜色：
	            </div>
				<div class="Left">
					&nbsp;<asp:TextBox ID="Color" Text="#000000" Width="150px" runat="server" /></div>
			</div>
	     <div class="BT Hidden LH25" style="width:100%">
	            <div class="Left BR" style="width: 200px">
	            	&nbsp;字体加粗：
	            </div>
				<div class="Left">
					&nbsp;<asp:DropDownList ID="Strong" runat="server"><asp:ListItem Value="0" Text="否" /><asp:ListItem Value="1" Text="是" /></asp:DropDownList>
				</div>
			</div>
			</asp:PlaceHolder>
			<asp:PlaceHolder ID="HTMLMode" Visible="false" runat="server">
            <div class="BT Hidden" style="width:100%">
                <div class="Left BR LH25" style="width: 200px">
                    &nbsp;显示内容：<br/>支持Html,Javascript等代码
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <DXBBS:Editor ID="Content" Height="100px" Mode="textarea" runat="server" />
                </div>
            </div>
			</asp:PlaceHolder>
	     <div class="BT Hidden LH25" style="width:100%">
	            <div class="Left BR" style="width: 200px">
	            	&nbsp;需要登录后显示：
	            </div>
				<div class="Left">
					&nbsp;<asp:DropDownList ID="Login" runat="server"><asp:ListItem Value="0" Text="否" /><asp:ListItem Value="1" Text="是" /></asp:DropDownList>
				</div>
			</div>
	     <div class="BT Hidden LH25" style="width:100%">
	            <div class="Left BR" style="width: 200px">
	            	&nbsp;登录后隐藏：
	            </div>
				<div class="Left">
					&nbsp;<asp:DropDownList ID="Disappear" runat="server"><asp:ListItem Value="0" Text="否" /><asp:ListItem Value="1" Text="是" /></asp:DropDownList>
				</div>
			</div>
			<div class="Footer BT P5 TC Hidden">
				<asp:Button CssClass="Button" ID="SubmitButton" Text="确定提交" runat="server" />&nbsp;<input type="button" class="Button" value="返回" onclick="history.back(-1)" />
			</div>
		</div>
	</div>
</div>