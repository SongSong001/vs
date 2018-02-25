<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true"%>
<%@ Register TagPrefix="DXBBS" Namespace="DXBBS.Controls" Assembly="DXBBS.Controls" %>
<script src="js/dxbbs.js" type="text/javascript"></script>
<div class="BodyBlock PTB5">
    <div class="Block Hidden">
        <div class="Title H22 LH22 TC">
           版面可访问用户设置
        </div>
        <div>
			<div class="Header P5"><asp:CheckBox ID="OnLevel" runat="server" Checked="true" /> 按等级控制</div>
			<div class="Middle BT P5"><asp:CheckBoxList ID="Level" RepeatLayout="flow" RepeatDirection="horizontal" runat="server" /></div>
			<div class="Header BT P5"><asp:CheckBox ID="OnTeam" runat="server" /> 按圈子控制</div>
			<div class="Middle BT P5"><asp:CheckBoxList ID="Team" RepeatLayout="flow" RepeatDirection="horizontal" runat="server" /></div>
		</div>
	</div>
</div>
<div class="BodyBlock PTB5">
    <div class="Block Hidden">
        <div class="Title H22 LH22 TC">
           版面添加/修改
        </div>
        <div class="M1 Middle">
	     <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;所属版面：
                </div>
                <div class="Left">
                    &nbsp;<asp:DropDownList ID="FatherBoard" runat="server" /></div>
            </div>
	     <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;版面名称：
                </div>
                <div class="Left">
                    &nbsp;<asp:TextBox ID="BoardName" Width="150px" runat="server"/><asp:requiredfieldvalidator ID="NeedBoardName" runat="server" ControlToValidate="BoardName" Display="Dynamic" ErrorMessage="请填写版面名称"></asp:requiredfieldvalidator></div>
            </div>
	     <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;作为分类版面：
                </div>
                <div class="Left">
                    <asp:RadioButtonList ID="AllowTopic" RepeatDirection="horizontal" RepeatLayout="flow" runat="server"><asp:ListItem Value="0" Text="是" /><asp:ListItem Value="1" Text="否" Selected="true" /></asp:RadioButtonList></div>
            </div>
	     <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;版名颜色：
                </div>
                <div class="Left">
                    &nbsp;<asp:TextBox ID="TitleColor" runat="server" Text="#000000" Width="80px" />&nbsp;<span id="ColorSpan" style="background-color:#000000">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;<IMG style="CURSOR: pointer" onclick="SelectColor('_ctl0:Main:Admin_BoardAdd1:_ctl0:TitleColor','ColorSpan')" src="images/forecolor.gif"></div>
            </div>
	     <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;可查看用户：
                </div>
                <div class="Left">
                    <asp:RadioButtonList ID="ShowType" RepeatDirection="horizontal" RepeatLayout="flow" runat="server"><asp:ListItem Value="0" Text="所有用户" Selected="true" /><asp:ListItem Value="1" Text="有权限用户" /></asp:RadioButtonList></div>
            </div>
	     <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;子版面排序方式：
                </div>
                <div class="Left">
                    <asp:RadioButtonList ID="ChildOrderType" RepeatDirection="horizontal" RepeatLayout="flow" runat="server"><asp:ListItem Value="0" Text="竖排" Selected="true" /><asp:ListItem Value="1" Text="横排" /></asp:RadioButtonList>(每行排列<asp:TextBox ID="ChildLineNum" Text="5" runat="server" Width="40px" />个版面)
                </div>
            </div>
	     <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;帖子需要审核：
                </div>
                <div class="Left">
                    <asp:RadioButtonList ID="NeedConfirm" RepeatDirection="horizontal" RepeatLayout="flow" runat="server"><asp:ListItem Value="1" Text="需要" /><asp:ListItem Value="0" Text="不需要" Selected="true" /></asp:RadioButtonList>
                </div>
            </div>
	     <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;是否锁定：
                </div>
                <div class="Left">
                    <asp:RadioButtonList ID="Locked" RepeatDirection="horizontal" RepeatLayout="flow" runat="server"><asp:ListItem Value="1" Text="是" /><asp:ListItem Value="0" Text="否" Selected="true" /></asp:RadioButtonList>
                </div>
            </div>
	     <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;主题列表排序方式：
                </div>
                <div class="Left">
                    <asp:RadioButtonList ID="TopicOrderType" RepeatDirection="horizontal" RepeatLayout="flow" runat="server"><asp:ListItem Value="0" Text="按最后回复时间倒序" Selected="true" /><asp:ListItem Value="1" Text="按发表时间顺序" /><asp:ListItem Value="2" Text="按发表时间倒序" /></asp:RadioButtonList>
                </div>
            </div>
	     <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;每页显示主题数：
                </div>
                <div class="Left">
                    &nbsp;<asp:TextBox ID="TopicPerPage" Text="20" Width="150px" runat="server"/>&nbsp;条</div>
            </div>
	     <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;每页显示回复数：
                </div>
                <div class="Left">
                    &nbsp;<asp:TextBox ID="ReplyPerPage" Text="10" Width="150px" runat="server" />&nbsp;条</div>
            </div>

	     <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;版面代表图片：
                </div>
                <div class="Left">
                    &nbsp;<asp:TextBox ID="Photo" Width="300px" runat="server" /></div>
            </div>
            <div class="BT Hidden" style="width:100%">
                <div class="Left BR LH25" style="width: 200px; height: 105px">
					&nbsp;该版版主：<br/>
					&nbsp;多版主添加请用回车换行进行分隔<br/>
					&nbsp;<span class="Red">注意：只能填写属于版主类型用户组的用户</span>
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <asp:TextBox ID="Master" TextMode="multiLine" Width="550px" Height="100" runat="server" />
                </div>
            </div>
            <div class="BT Hidden" style="width:100%">
                <div class="Left BR LH25" style="width: 200px">
                    &nbsp;版面简介：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                     <DXBBS:Editor ID="Content" Height="100" runat="server" />
                </div>
            </div>
            <div class="BT Hidden" style="width:100%">
                <div class="Left BR LH25" style="width: 200px">
                    &nbsp;版面规则：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                     <DXBBS:Editor ID="Rule" Height="100" runat="server" />
                </div>
            </div>
            <div class="BT Hidden" style="width:100%">
                <div class="Left BR LH25" style="width: 200px">
                    &nbsp;本版顶部右边BANNER图片：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                     <DXBBS:Editor ID="Logo" Height="100" AllowScript="true" runat="server" />
                </div>
            </div>  
            <div class="Footer BT P5 TC Hidden">
            	<asp:Button CssClass="Button" ID="SubmitButton" Text="确定提交" runat="server" />&nbsp;<input type="button" class="Button" value="返回" onclick="history.back(-1)" />
            </div>
		</div>
	</div>
</div>