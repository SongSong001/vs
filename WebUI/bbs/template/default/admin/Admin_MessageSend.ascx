<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true"%>
<%@ Register TagPrefix="DXBBS" Namespace="DXBBS.Controls" Assembly="DXBBS.Controls" %>
<script language="javascript" src="js/calendar.js"></script>
<LINK href="css/calendar.css" rel="stylesheet">
<script language="javascript">
function CheckForm()
{
    if (aspnetForm.UserType[1].checked == true)
    {
	    var checked=false;
        for (i=0;i<aspnetForm.Users.length;i++)
        {
    	    if (aspnetForm.Users[i].checked == true)
    	    {
    		    checked=true;
    	    }
        }
        if (checked == false)
        {
    	    alert("至少应该选择一样条件");
    	    return false;
        }
    }
    return true;
}
</script>
<div class="BodyBlock PTB5">
    <div class="Block Hidden">
        <div class="Title H22 LH22 TC">
            论坛短信息群发接收对象：
        </div>
        <div class="M1 Middle">
	        <div class="Header H22 LH22 TC">
	            <input type="radio" name="UserType" value="1" checked />&nbsp;所有用户<input type="radio" name="UserType" value="2" />按下面条件筛选
	        </div>
	        <div class="BT LH25 Hidden" style="width:100%">
	            <div class="Left BR" style="width: 200px">&nbsp;<input type="checkbox" value="login" name="Users" />按登录时间：</div>
	            <div class="Left BL" style="margin-left:-1px">&nbsp;从&nbsp;<asp:TextBox ID="LoginStartDay" runat="server" Width="112px" />&nbsp;<A onclick="return showCalendar('_ctl0:Main:AdminMessageSend1:_ctl0:LoginStartDay', 'y-mm-dd');" href="#"><IMG alt="选择日期" src="images/calendar.gif" border="0"></A> 到&nbsp;<asp:TextBox ID="LoginEndDay" runat="server" Width="112px" />&nbsp;<A onclick="return showCalendar('_ctl0:Main:AdminMessageSend1:_ctl0:LoginEndDay', 'y-mm-dd');" href="#"><IMG alt="选择日期" src="images/calendar.gif" border="0"></A></div>
	        </div>
	        <div class="BT LH25 Hidden" style="width:100%">
	            <div class="Left BR" style="width: 200px">&nbsp;<input type="checkbox" value="register" name="Users" />按注册时间：</div>
	            <div class="Left BL" style="margin-left:-1px">&nbsp;从&nbsp;<asp:TextBox ID="RegisterStartDay" runat="server" Width="112px" />&nbsp;<A onclick="return showCalendar('_ctl0:Main:AdminMessageSend1:_ctl0:RegisterStartDay', 'y-mm-dd');" href="#"><IMG alt="选择日期" src="images/calendar.gif" border="0"></A> 到&nbsp;<asp:TextBox ID="RegisterEndDay" runat="server" Width="112px" />&nbsp;<A onclick="return showCalendar('_ctl0:Main:AdminMessageSend1:_ctl0:RegisterEndDay', 'y-mm-dd');" href="#"><IMG alt="选择日期" src="images/calendar.gif" border="0"></A></div>
	        </div>
	        <div class="BT LH25 Hidden" style="width:100%">
	            <div class="Left BR" style="width: 200px">&nbsp;<input type="checkbox" value="level" name="Users" />按用户组：</div>
	            <div class="BL" style="margin-left:200px;padding-left:5px"><asp:CheckBoxList ID="Level" RepeatDirection="horizontal" RepeatLayout="flow" runat="server"></asp:CheckBoxList></div>
	        </div>
	        <div class="BT LH25 Hidden" style="width:100%">
	            <div class="Left BR" style="width: 200px">&nbsp;<input type="checkbox" value="level" name="Users" />按圈子组：</div>
	            <div class="BL" style="margin-left:200px;padding-left:5px"><asp:CheckBoxList ID="Team" RepeatDirection="horizontal" RepeatLayout="flow" runat="server"></asp:CheckBoxList></div>
	        </div>
	        <div class="BT LH25 Hidden" style="width:100%">
	            <div class="Left BR" style="width: 200px">&nbsp;<input type="checkbox" value="point" name="Users" />按积分值：</div>
	            <div class="Left BL" style="margin-left:-1px">&nbsp;从&nbsp;<asp:TextBox ID="StartPoint" Text="0" runat="server" Width="50px" />&nbsp;到&nbsp;<asp:TextBox ID="EndPoint" Text="1" runat="server" Width="50px" /></div>
	        </div>
	        <div class="BT H25 LH25 Hidden" style="width:100%">
	            <div class="Left BR" style="width: 200px">&nbsp;<input type="checkbox" value="coin" name="Users" />按金币值：</div>
	            <div class="Left BL" style="margin-left:-1px">&nbsp;从&nbsp;<asp:TextBox ID="StartCoin" Text="0" runat="server" Width="50px" />&nbsp;到&nbsp;<asp:TextBox ID="EndCoin" Text="1" runat="server" Width="50px" /></div>
	        </div>
	        <div class="BT LH25 Hidden" style="width:100%">
	            <div class="Left BR" style="width: 200px">&nbsp;<input type="checkbox" value="topic" name="Users" />按发帖量：</div>
	            <div class="Left BL" style="margin-left:-1px">&nbsp;从&nbsp;<asp:TextBox ID="StartTopic" Text="0" runat="server" Width="50px" />&nbsp;到&nbsp;<asp:TextBox ID="EndTopic" Text="1" runat="server" Width="50px" /></div>
	        </div>
	        <div class="BT LH25 Hidden" style="width:100%">
	            <div class="Left BR" style="width: 200px">&nbsp;<input type="checkbox" value="reply" name="Users" />按回帖量：</div>
	            <div class="Left BL" style="margin-left:-1px">&nbsp;从&nbsp;<asp:TextBox ID="StartReply" Text="0" runat="server" Width="50px" />&nbsp;到&nbsp;<asp:TextBox ID="EndReply" Text="1" runat="server" Width="50px" /></div>
	        </div>
	        <div class="BT LH25 Hidden" style="width:100%">
	            <div class="Left BR" style="width: 200px">&nbsp;<input type="checkbox" value="sex" name="Users" />按性别：</div>
	            <div class="Left BL" style="margin-left:-1px"><asp:RadioButtonList ID="Sex" RepeatDirection="horizontal" runat="server"><asp:ListItem Value="1" Selected="true">男</asp:ListItem><asp:ListItem Value="0">女</asp:ListItem></asp:RadioButtonList></div>
	        </div>
		</div>
	</div>
</div>
<div class="BodyBlock PTB5">
    <div class="Block Hidden">
        <div class="Title H22 LH22 TC">
            论坛短信息群发内容
        </div>
        <div class="M1 Middle">
	        <div class="H25 LH25 Hidden">
	            <div class="Left BR" style="width: 200px">&nbsp;信息标题：</div>
	            <div class="Left">&nbsp;<asp:TextBox ID="Title" runat="server" Width="350px" /><asp:requiredfieldvalidator ID="NeedTitle" runat="server" ControlToValidate="Title" Display="Dynamic" ErrorMessage="请填写标题"></asp:requiredfieldvalidator></div>
	        </div>
	        <div class="BT LH25 Hidden" style="width:100%">
	            <div class="Left BR" style="width: 200px">&nbsp;信息内容：</div>
	            <div class="Left BL" style="margin-left:-1px;padding-left:5px"><DXBBS:Editor ID="Content" Height="100px" runat="server" /></div>
	        </div>
		</div>
		<div class="Footer P5 TC Hidden">
			<asp:Button CssClass="Button" ID="SubmitButton" Text="确定发送" runat="server" />
		</div>
	</div>
</div>