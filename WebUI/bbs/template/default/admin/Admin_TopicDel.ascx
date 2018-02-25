<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true"%>
<script language="javascript" src="js/calendar.js"></script>
<LINK href="css/calendar.css" rel="stylesheet">
<div class="BodyBlock PTB5">
    <div class="Block Hidden">
		<div class="Title H22 LH22 TC">
		    帖子批量删除
		</div>
		<div class="M1 Middle">
	        <div class="BT Hidden LH25" style="width:100%">
	            <div class="Left BR" style="width:200px">
	                &nbsp;筛选条件：
	            </div>
	            <div class="Left BL" style="margin-left:-1px">
			        <input type="checkbox" value="board" checked name="Condition" />按版面：<asp:DropDownList ID="BoardID" runat="server" /><br />
			        <input type="checkbox" value="name" name="Condition" />按发帖用户名：<asp:TextBox ID="UserName" runat="server" /><br />
			        <input type="checkbox" value="id" name="Condition" />按发帖用户ID：<asp:TextBox ID="UserID" runat="server" /><br />
			        <input type="checkbox" value="addtime" name="Condition" />按发帖时间：从<asp:TextBox ID="StartAddTime" runat="server" /><A onclick="return showCalendar('_ctl0:Main:Admin_TopicDel1:_ctl0:StartAddTime', 'y-mm-dd');" href="#"><IMG alt="选择日期" src="images/calendar.gif" border="0"></A> 到<asp:TextBox ID="EndAddTime" runat="server" /><A onclick="return showCalendar('_ctl0:Main:Admin_TopicDel1:_ctl0:EndAddTime', 'y-mm-dd');" href="#"><IMG alt="选择日期" src="images/calendar.gif" border="0"></A> <br />
		            <input type="checkbox" value="click" name="Condition" />按点击率：从 <asp:TextBox ID="StartClick" runat="server" Width="45px" /> 到 <asp:TextBox ID="EndClick" runat="server" Width="45px" /><br />
		            <input type="checkbox" value="reply" name="Condition" />按回复量：从 <asp:TextBox ID="StartReply" runat="server" Width="45px" /> 到 <asp:TextBox ID="EndReply" runat="server" Width="45px" /></div>
	        </div>
			<div class="Footer BT P5 TC Hidden">
			    <asp:Button CssClass="Button" ID="SubmitButton" Text="确定提交" runat="server" />
			</div>
		</div>
	</div>
</div>