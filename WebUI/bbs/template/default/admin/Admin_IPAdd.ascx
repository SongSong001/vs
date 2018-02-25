<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true"%>
<div class="BodyBlock PTB5">
    <div class="Block Hidden">
        <div class="Title H22 LH22 TC">
            综合管理-->IP策略添加/修改
        </div>
        <div class="M1 Middle">
	     <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
					&nbsp;IP地址：
                </div>
                <div class="Left">
					&nbsp;<asp:TextBox ID="IP" runat="server" Width="300px" /><asp:requiredfieldvalidator ID="NeedIP" runat="server" ControlToValidate="IP" Display="Dynamic" ErrorMessage="请填写IP地址"></asp:requiredfieldvalidator>	
				</div>
            </div>
            <div class="BT Hidden" style="width:100%">
                <div class="Left BR LH25" style="width: 200px">
                    &nbsp;处理原因：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <asp:TextBox ID="Reason" TextMode="multiLine" MaxLength="50" runat="server" Height="100px" Width="550px" />
                </div>
            </div>
			<div class="Footer BT P5 TC Hidden">
				<asp:Button CssClass="Button" ID="SubmitButton" Text="确定提交" runat="server" />&nbsp;<input type="button" class="Button" value="返回" onclick="history.back(-1)" />
			</div>
		</div>
	</div>
</div>
