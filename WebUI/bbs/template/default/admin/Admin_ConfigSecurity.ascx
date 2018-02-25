<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true"%>
<div class="BodyBlock PTB5">
    <div class="Block Hidden">
        <div class="Title H22 LH22 TC">
            系统设置-->安全设置
        </div>
        <div class="M1 Middle">
	     <div class="Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;用户密码加密方式：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <asp:RadioButtonList ID="PasswordType" RepeatDirection="horizontal" RepeatLayout="flow" runat="server"><asp:ListItem Text="明文" Value="0" /><asp:ListItem Text="16位MD5加密" Value="1" /><asp:ListItem Text="32位MD5加密" Value="2" /><asp:ListItem Text="两次MD5加密(更安全)" Value="3" /><asp:ListItem Text="SHA1加密" Value="4" /></asp:RadioButtonList></div>
            </div>
	     <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;论坛COOKIES加密钥匙：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <asp:TextBox id="SecureKey" width="150px" runat="server" /></div>
            </div>
	     <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;注册用户名字符长度限制：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <asp:TextBox id="MinUserNameLength" width="50px" runat="server" />-> <asp:TextBox id="MaxUsernameLength" width="50px" runat="server" /></div>
            </div>
	     <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;注册用户名禁止字符 (用|分隔)：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <asp:TextBox id="ForbiddenName" width="150px" runat="server" /></div>
            </div>
	     <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;验证码方式：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <asp:RadioButtonList ID="CodeType" RepeatDirection="horizontal" RepeatLayout="flow" runat="server"><asp:ListItem Text="纯数字" Value="1" /><asp:ListItem Text="纯字母" Value="2" /><asp:ListItem Text="数字+字母组合" Value="3" /></asp:RadioButtonList>
                </div>
            </div>
	     <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;验证码位数：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    &nbsp;<asp:TextBox id="CodeLength" width="150px" runat="server" /></div>
            </div>
	     <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;验证码杂点数：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <asp:TextBox id="CodeDot" width="150px" runat="server" /></div>
            </div>
	     <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;登录验证码：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <asp:RadioButtonList ID="LoginCode" RepeatDirection="horizontal" RepeatLayout="flow" runat="server">
                    <asp:ListItem Value="1">开启</asp:ListItem>
                    <asp:ListItem Value="0">关闭</asp:ListItem>
                    </asp:RadioButtonList>
                </div>
            </div>
	     <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;注册验证码：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <asp:RadioButtonList ID="RegisterCode" RepeatDirection="horizontal" RepeatLayout="flow" runat="server">
	                    <asp:ListItem Value="1">开启</asp:ListItem>
	                    <asp:ListItem Value="0">关闭</asp:ListItem>
	                </asp:RadioButtonList>
                </div>
            </div>
	     <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;发帖验证码：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <asp:RadioButtonList ID="TopicCode" RepeatDirection="horizontal" RepeatLayout="flow" runat="server">
	                    <asp:ListItem Value="1">开启</asp:ListItem>
	                    <asp:ListItem Value="0">关闭</asp:ListItem>
	                </asp:RadioButtonList>
                </div>
            </div>
	     <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;回复验证码：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <asp:RadioButtonList ID="ReplyCode" RepeatDirection="horizontal" RepeatLayout="flow" runat="server">
	                    <asp:ListItem Value="1">开启</asp:ListItem>
	                    <asp:ListItem Value="0">关闭</asp:ListItem>
	                </asp:RadioButtonList>
                </div>
            </div>
	     <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;发短信息验证码：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <asp:RadioButtonList ID="MessageCode" RepeatDirection="horizontal" RepeatLayout="flow" runat="server">
	                    <asp:ListItem Value="1">开启</asp:ListItem>
	                    <asp:ListItem Value="0">关闭</asp:ListItem>
	                </asp:RadioButtonList>
                </div>
            </div>
	     <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;新用户多少分钟后可发帖：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <asp:TextBox ID="TopicTime" width="150px" runat="server" />&nbsp;分钟
                </div>
            </div>
	     <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;新用户多少分钟后可回复：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <asp:TextBox ID="ReplyTime" width="150px" runat="server" />&nbsp;分钟
                </div>
            </div>
	     <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;多少秒内不能重复发帖：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <asp:TextBox ID="TopicPerTime" width="150px" runat="server" />&nbsp;秒
                </div>
            </div>
	     <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;多少秒内不能重复回帖：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <asp:TextBox ID="ReplyPerTime" width="150px" runat="server" />&nbsp;秒
                </div>
            </div>
	     <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;多少秒内不能重复发短信：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <asp:TextBox ID="MessagePerTime" width="150px" runat="server" />&nbsp;秒
                </div>
            </div>
	     <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;多少秒内不能重复注册：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <asp:TextBox ID="RegisterPerTime" width="150px" runat="server" />&nbsp;秒
                </div>
            </div>
	     <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;多少秒内不能重复尝试登录：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <asp:TextBox ID="LoginPerTime" width="150px" runat="server" />&nbsp;秒
                </div>
            </div>
            <div class="Footer BT P5 TC Hidden">
                <asp:Button CssClass="Button" ID="SubmitButton" Text="确定提交" runat="server" />&nbsp;<input type="button" class="Button" value="取消修改" onclick="window.location='Admin_Right.aspx'" />
            </div>
        </div>
    </div>
</div>