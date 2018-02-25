<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true"%>
<div class="BodyBlock PTB5">
    <div class="Block Hidden">
        <div class="Title H22 LH22 TC">
            用户添加/修改
        </div>
        <div class="M1 Middle">
            <div class="Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;用户名称：
                </div>
                <div class="Left">
                     &nbsp;<asp:TextBox ID="UserName" runat="server" Width="150px" /><asp:requiredfieldvalidator ID="NeedUserName" runat="server" ControlToValidate="UserName" Display="Dynamic" ErrorMessage="请填写用户名称"></asp:requiredfieldvalidator></div>
            </div>
            <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;用户密码：
                </div>
                <div class="Left">
                     &nbsp;<asp:TextBox ID="Password" TextMode="password" runat="server" Width="150px" /><asp:requiredfieldvalidator ID="NeedPassword" runat="server" ControlToValidate="Password" Display="Dynamic" ErrorMessage="请填写用户密码"></asp:requiredfieldvalidator>
                </div>
            </div>
            <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;确认用户密码：
                </div>
                <div class="Left">
                     &nbsp;<asp:TextBox ID="Password1" TextMode="password" runat="server" Width="150px" /><asp:requiredfieldvalidator ID="NeedPassword1" runat="server" ControlToValidate="Password1" Display="Dynamic" ErrorMessage="请确认用户密码" /><asp:CompareValidator ID="ComparePassword" ControlToValidate="Password" ControlToCompare="Password1" Display="dynamic" ErrorMessage="两次输入的密码不一致" runat="server" /></div>
            </div>
            <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;Email地址：
                </div>
                <div class="Left">
                     &nbsp;<asp:TextBox ID="Email" runat="server" Width="150px" /><asp:requiredfieldvalidator ID="NeedEmail" runat="server" ControlToValidate="Email" Display="Dynamic" ErrorMessage="请填写Email地址" /><asp:RegularExpressionValidator ID="CheckMail" ControlToValidate="Email" runat="server" Display="Dynamic" ErrorMessage="Email地址不正确" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" /></div>
            </div>
            <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;性别：
                </div>
                <div class="Left">
                     <asp:RadioButtonList ID="Sex" RepeatDirection="horizontal" runat="server"><asp:ListItem Text="男" Value="1" Selected="true" /><asp:ListItem Text="女" Value="0" /></asp:RadioButtonList>
                </div>
            </div>
			<asp:PlaceHolder ID="UserOther" Visible="false" runat="server">
            <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;密码提示问题：
                </div>
                <div class="Left">
                     &nbsp;<asp:TextBox ID="Question" runat="server" Width="150px" /></div>
            </div>
            <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;提示问题回答：
                </div>
                <div class="Left">
                     &nbsp;<asp:TextBox ID="Answer" runat="server" Width="150px" /></div>
            </div>
            <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;用户头像：
                </div>
                <div class="Left">
                     &nbsp;<asp:TextBox ID="Photo" runat="server" Width="150px" /></div>
            </div>
            <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;头像宽度：
                </div>
                <div class="Left">
                     &nbsp;<asp:TextBox ID="PhotoWidth" runat="server" Width="150px" /></div>
            </div>
            <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;头像高度：
                </div>
                <div class="Left">
                     &nbsp;<asp:TextBox ID="PhotoHeight" runat="server" Width="150px" /></div>
            </div>
            <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;用户等级：
                </div>
                <div class="Left">
                     &nbsp;<asp:DropDownList ID="Level" runat="server" /></div>
            </div>
            <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;用户圈子：
                </div>
                <div class="Left">
                     &nbsp;<asp:DropDownList ID="Team" runat="server" /></div>
            </div>
            <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;用户昵称：
                </div>
                <div class="Left">
                     &nbsp;<asp:TextBox ID="NickName" runat="server" Width="150px" /></div>
            </div>
            <div class="BT Hidden" style="width:100%">
                <div class="Left BR LH25" style="width: 200px">
                    &nbsp;签名档：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                	<asp:TextBox ID="Sign" TextMode="multiLine" Width="350" Height="100" runat="server" />
                </div>
            </div>
              <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;金币：
                </div>
                <div class="Left">
                     &nbsp;<asp:TextBox ID="Coin" runat="server" Width="150px" /></div>
            </div>
            <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;积分：
                </div>
                <div class="Left">
                     &nbsp;<asp:TextBox ID="Point" runat="server" Width="150px" /></div>
            </div>
            <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;发帖量：
                </div>
                <div class="Left">
                     &nbsp;<asp:TextBox ID="Topic" runat="server" Width="150px" /></div>
            </div>
            <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;回复量：
                </div>
                <div class="Left">
                     &nbsp;<asp:TextBox ID="Reply" runat="server" Width="150px" /></div>
            </div>
            <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;被删主题：
                </div>
                <div class="Left">
                     &nbsp;<asp:TextBox ID="TopicDel" runat="server" Width="150px" /></div>
            </div>
            <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;被删回复：
                </div>
                <div class="Left">
                     &nbsp;<asp:TextBox ID="ReplyDel" runat="server" Width="150px" /></div>
            </div>
            <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;精华帖数：
                </div>
                <div class="Left">
                     &nbsp;<asp:TextBox ID="GoodTopic" runat="server" Width="150px" /></div>
            </div>
             <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;用户状态：
                </div>
                <div class="Left">
                     &nbsp;<asp:DropDownList ID="State" runat="server"><asp:ListItem Value="0" Text="正常" /><asp:ListItem Value="1" Text="未审核" /><asp:ListItem Value="2" Text="锁定" /></asp:DropDownList></div>
            </div>
            <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;注册IP：
                </div>
                <div class="Left">
                     &nbsp;<asp:TextBox ID="IP" runat="server" Width="150px" /></div>
            </div>
            <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;最后登录IP：
                </div>
                <div class="Left">
                     &nbsp;<asp:TextBox ID="LoginIP" runat="server" Width="150px" /></div>
            </div>
            <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;注册时间：
                </div>
                <div class="Left">
                     &nbsp;<asp:TextBox ID="RegTime" runat="server" Width="150px" /></div>
            </div>
             <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;最后登录时间：
                </div>
                <div class="Left">
                     &nbsp;<asp:TextBox ID="LoginTime" runat="server" Width="150px" /></div>
            </div>
			</asp:PlaceHolder>
			<div class="Footer BT P5 TC Hidden">
				<asp:Button CssClass="Button" ID="SubmitButton" Text="确定提交" runat="server" />&nbsp;<input type="button" class="Button" value="返回" onclick="history.back(-1)" />
			</div>
		</div>
	</div>
</div>