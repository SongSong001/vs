<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true"%>
<script src="js/dxbbs.js" type="text/javascript"></script>
<div class="BodyBlock PTB5">
    <div class="Block Hidden">
        <div class="Title H22 LH22 TC">
            系统设置-->水印图|文字设置
        </div>
        <div class="M1 Middle">
	     <div class="Hidden LH25" style="width:100%">
	            <div class="Left BR" style="width: 200px">&nbsp;水印方式：</div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px"><asp:RadioButtonList ID="WaterType" RepeatDirection="horizontal" AutoPostBack="true" runat="server"><asp:ListItem Value="0" Text="不使用水印" Selected="true" /><asp:ListItem Value="1" Text="文字水印" /><asp:ListItem Value="2" Text="图片水印" /></asp:RadioButtonList></div>
	        </div>
	        <asp:PlaceHolder ID="ShowWater" runat="server">
	     <div class="BT Hidden LH25" style="width:100%">
	            <div class="Left BR" style="width: 200px">&nbsp;水印位置：</div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px"><asp:RadioButtonList ID="WaterPossition" RepeatDirection="horizontal" RepeatLayout="flow" runat="server"><asp:ListItem Value="1" Text="左上" /><asp:ListItem Value="2" Text="左中" /><asp:ListItem Value="3" Text="左下" /><asp:ListItem Value="4" Text="中上" /><asp:ListItem Value="5" Text="居中" /><asp:ListItem Value="6" Text="中下" /><asp:ListItem Value="7" Text="右上" /><asp:ListItem Value="8" Text="右中" /><asp:ListItem Value="9" Text="右下" /></asp:RadioButtonList></div>
	        </div>
	        <asp:PlaceHolder ID="ShowText" runat="server">
	     <div class="BT Hidden LH25" style="width:100%">
	            <div class="Left BR" style="width: 200px">&nbsp;水印文字：</div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px"><asp:TextBox ID="TextContent" Width="150px" runat="server" /></div>
	        </div>
	     <div class="BT Hidden LH25" style="width:100%">
	            <div class="Left BR" style="width: 200px">&nbsp;文字字体：</div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px"><asp:DropDownList ID="TextFont" Width="150px" runat="server" /></div>
	        </div>
	     <div class="BT Hidden LH25" style="width:100%">
	            <div class="Left BR" style="width: 200px">&nbsp;文字大小：</div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px"><asp:TextBox ID="TextSize" Text="3" Width="150px" runat="server" /></div>
	        </div>
	     <div class="BT Hidden LH25" style="width:100%">
	            <div class="Left BR" style="width: 200px">&nbsp;文字颜色：</div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px"><asp:TextBox ID="TextColor" Width="150px" Text="#000000" runat="server" />&nbsp;<span id="ColorSpan" style="background-color:#000000">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;<IMG style="cursor:pointer" onclick="SelectColor('_ctl0:Main:Admin_ConfigPicture1:_ctl0:TextColor','ColorSpan')" src="images/forecolor.gif" border="0"></div>
	        </div>
	        </asp:PlaceHolder>
	        <asp:PlaceHolder ID="ShowPicture" runat="server">
	     <div class="BT Hidden LH25" style="width:100%">
	            <div class="Left BR" style="width: 200px">&nbsp;图片文件：</div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px"><asp:TextBox ID="ImageFile" Width="150px" runat="server" /></div>
	        </div>
	        </asp:PlaceHolder>
	        </asp:PlaceHolder>
	        <div class="Footer BT P5 TC Hidden">
		        <asp:Button CssClass="Button" ID="SubmitButton" Text="确定提交" runat="server" />&nbsp;<input type="button" class="Button" value="取消修改" onclick="window.location='Admin_Right.aspx'" />
	        </div>
        </div>
    </div>
</div>