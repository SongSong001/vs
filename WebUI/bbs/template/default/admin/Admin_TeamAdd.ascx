<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true"%>
<div class="BodyBlock PTB5">
    <div class="Block Hidden">
        <div class="Title H22 LH22 TC">
            圈子添加/修改
        </div>
        <div class="M1 Middle">
	     <div class="Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;圈子名称：
                </div>
                <div class="Left">
                     &nbsp;<asp:TextBox ID="TeamName" runat="server" Width="350px" /><asp:requiredfieldvalidator ID="NeedTeamName" runat="server" ControlToValidate="TeamName" Display="Dynamic" ErrorMessage="请填写圈子名称" /></div>
            </div>
	     <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;圈子代表图片：
                </div>
                <div class="Left">
                     &nbsp;<asp:TextBox ID="Photo" Text="images/team.gif" runat="server" Width="350px" /></div>
            </div>
	     <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;加入圈子是否需要审核：
                </div>
                <div class="Left">
                     &nbsp;<asp:DropDownList ID="NeedConfirm" runat="server"><asp:ListItem Text="需要" Value="1" /><asp:ListItem Text="不需要" Value="0" /></asp:DropDownList></div>
            </div>
	     <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;圈子资料是对外公开：
                </div>
                <div class="Left">
                     &nbsp;<asp:DropDownList ID="IsPublic" runat="server"><asp:ListItem Text="公开" Value="1" /><asp:ListItem Text="不公开" Value="0" /></asp:DropDownList></div>
            </div>
	     <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;圈主：
                </div>
                <div class="Left">
                     &nbsp;<asp:TextBox ID="Master" runat="server" Width="350" /><asp:requiredfieldvalidator ID="NeedMaster" runat="server" ControlToValidate="Master" Display="Dynamic" ErrorMessage="请填写圈主" /></div>
            </div>
            <div class="BT Hidden" style="width:100%">
                <div class="Left BR LH25" style="width: 200px">
                    &nbsp;圈子简介：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                	<asp:TextBox ID="Introduce" TextMode="multiLine" Width="350" Height="100" runat="server" />
                </div>
            </div>
            <div class="Footer BT P5 TC Hidden">
				<asp:Button CssClass="Button" ID="SubmitButton" Text="确定提交" runat="server" />&nbsp;<input type="button" class="Button" value="返回" onclick="history.back(-1)" />
			</div>
		</div>
	</div>
</div>