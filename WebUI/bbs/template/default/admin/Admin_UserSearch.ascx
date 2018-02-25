<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true"%>
<%@ Register TagPrefix="DXBBS" Namespace="DXBBS.Controls" Assembly="DXBBS.Controls" %>
<script language="javascript" src="js/calendar.js"></script>
<LINK href="css/calendar.css" rel="stylesheet">
<asp:PlaceHolder ID="ShowUserList" Visible="false" runat="server">
<script language="javascript">
//全选全不选
function SelectAll(obj)
{
    var aspnetForm=document.getElementById("aspnetForm");
    if (aspnetForm.SelectID != null)
    {
        if (aspnetForm.SelectID.length == null)
        {
            aspnetForm.SelectID.checked=obj.checked;
        }
        else
        {
            for (i=0;i<aspnetForm.SelectID.length;i++)
            {
                if(aspnetForm.SelectID[i].checked!=obj.checked)
                {
                    aspnetForm.SelectID[i].checked=obj.checked;
                }
            }
        }
    }
}
//检查操作
function CheckSelect()
{
    var aspnetForm=document.getElementById("aspnetForm");
    var checked=false;
    if (aspnetForm.SelectID != null)
    {
        if (aspnetForm.SelectID.length == null)
        {
            if (aspnetForm.SelectID.checked == true)
            {
                checked=true;
            }
        }
        else
        {
            for (i=0;i<aspnetForm.SelectID.length;i++)
            {
                if(aspnetForm.SelectID[i].checked == true)
                {
                    checked=true;
                }
            }
        }
    }
    if (checked == false)
    {
        alert("请选择要操作的记录");
        return false;
    }
    else
    {
        if (!confirm("注意：请问确定要操作吗"))
        {
            return false;
        }
    }
    return true;
}
</script>
<div class="BodyBlock PTB5">
    <div class="Block Hidden">
        <div class="Title H22 LH22 TC">
            论坛用户搜索结果
        </div>
		<ul class="Header TC">
			<li style="width:50px">ID</li>
			<li class="Right" style="width:30px">选择</li>
			<li class="Right" style="width:80px">注册时间</li>
			<li class="Right" style="width:50px">用户状态</li>
			<li class="Right" style="width:100px">最后登录IP</li>
			<li class="Right" style="width:80px">最后登录时间</li>
			<li class="Right" style="width:50px">积分</li>
			<li class="Right" style="width:50px">金币</li>
			<li class="Right" style="width:100px">等级</li>
			<li class="Right" style="width:30px">姓别</li>
			<li>用户名</li>
		</ul>
		<asp:Repeater ID="UserList" runat="server">
		<ItemTemplate>
		<ul class="TC">
			<li style="width:50px"><%# Eval("ID") %></li>
			<li class="Right" style="width:30px"><input type="checkbox" name="SelectID" value="<%# Eval("ID") %>" /></li>
			<li class="Right" style="width:80px"><%# Convert.ToDateTime(Eval("RegTime")).ToString("yyyy/MM/dd") %></li>
			<li class="Right" style="width:50px"><DXBBS:UserState DataSource='<%# Eval("State") %>' runat="server" /></li>
			<li class="Right" style="width:100px"><%# Eval("LoginIP") %></li>
			<li class="Right" style="width:80px"><%# Convert.ToDateTime(Eval("LoginTime")).ToString("yyyy/MM/dd") %></li>
			<li class="Right" style="width:50px"><%# Eval("Point") %></li>
			<li class="Right" style="width:50px"><%# Eval("Coin") %></li>
			<li class="Right" style="width:100px"><DXBBS:LevelName ID="LevelName1" DataSource='<%# Eval("LevelID") %>' runat="server" /></li>
			<li class="Right" style="width:30px"><DXBBS:UserSex ID="UserSex1" DataSource='<%# Eval("Sex") %>' runat="server" /></li>
			<li><a href='Admin_UserAdd.aspx?ID=<%# Eval("ID") %>'><%# Eval("UserName") %></a></li>
		</ul>
		</ItemTemplate>
		</asp:Repeater>
		<div class="Footer PTB5 TC">
			<input type="button" class="Button" value="添加用户" onclick="window.location.href='Admin_UserAdd.aspx'" />&nbsp;<asp:Button CssClass="Button" ID="DeleteButton" Text="确定删除" OnClientClick="return CheckSelect()" runat="server" />&nbsp;<asp:Button CssClass="Button" ID="ConfirmButton" Text="审核用户" OnClientClick="return CheckSelect()" runat="server" />&nbsp;<asp:Button CssClass="Button" ID="LockButton" Text="锁定用户" OnClientClick="return CheckSelect()" runat="server" />&nbsp;<asp:Button CssClass="Button" ID="DeleteLockButton" Text="解锁用户" OnClientClick="return CheckSelect()" runat="server" />&nbsp;<input type="checkbox" name="All" onclick="SelectAll(this)" />全选/全不选
		</div>
	</div>
	<div class="BlankBlock Hidden">
        <DXBBS:ForumPager ID="CommonPager" runat="server" />
    </div>
</div>
</asp:PlaceHolder>
<div class="BodyBlock PTB5">
    <div class="Block Hidden">
		<div class="Title H22 LH22 TC">
		    用户搜索
		</div>
		<div class="M1 Middle">
			<div class="BT Hidden" style="width:100%">
			    <div class="Left BR LH25" style="width: 150px">
			        &nbsp;搜索条件：<br />
			        &nbsp; (可多条件组合查询)
				</div>
			    <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
		            	<div class="Hidden LH25" style="width:100%">
			            <div class="Left" style="width:100px">
			                &nbsp;<input type="checkbox" value="name" name="Users" />按用户名：
			            </div>
			            <div class="Left">
			                 &nbsp;<asp:TextBox ID="UserName" runat="server" /></div>
			        </div>
		            	<div class="Hidden LH25" style="width:100%">
			            <div class="Left" style="width:100px">
			                &nbsp;<input type="checkbox" value="id" name="Users" />按用户ID：
			            </div>
			            <div class="Left">
			                 &nbsp;<asp:TextBox ID="UserID" runat="server" /></div>
			        </div>
		            	<div class="Hidden LH25" style="width:100%">
			            <div class="Left" style="width:100px">
			                &nbsp;<input type="checkbox" value="level" name="Users" />按用户组：
			            </div>
			            <div class="Left">
			                 &nbsp;<asp:DropDownList ID="level" runat="server" /></div>
			        </div>
		            	<div class="Hidden LH25" style="width:100%">
			            <div class="Left" style="width:100px">
			                &nbsp;<input type="checkbox" value="team" name="Users" />按圈子：
			            </div>
			            <div class="Left">
			                 &nbsp;<asp:DropDownList ID="Team" runat="server" /></div>
			        </div>
		            	<div class="Hidden LH25" style="width:100%">
			            <div class="Left" style="width:100px">
			                &nbsp;<input type="checkbox" value="login" name="Users" />按登录时间：
			            </div>
			            <div class="Left">
			            	&nbsp;从&nbsp;<asp:TextBox ID="LoginStartDay" runat="server" Width="112px" /><A onclick="return showCalendar('_ctl0:Main:Admin_UserSearch1:_ctl0:LoginStartDay', 'y-mm-dd');" href="#"><IMG alt="选择日期" src="images/calendar.gif" border="0"></A> 到&nbsp;<asp:TextBox ID="LoginEndDay" runat="server" Width="112px" /><A onclick="return showCalendar('_ctl0:Main:Admin_UserSearch1:_ctl0:LoginEndDay', 'y-mm-dd');" href="#"><IMG alt="选择日期" src="images/calendar.gif" border="0"></A></div>
			        </div>
		            	<div class="Hidden LH25" style="width:100%">
			            <div class="Left" style="width:100px">
			                &nbsp;<input type="checkbox" value="register" name="Users" />按注册时间：
			            </div>
			            <div class="Left">
			                &nbsp;从&nbsp;<asp:TextBox ID="RegisterStartDay" runat="server" Width="112px" /><A onclick="return showCalendar('_ctl0:Main:Admin_UserSearch1:_ctl0:RegisterStartDay', 'y-mm-dd');" href="#"><IMG alt="选择日期" src="images/calendar.gif" border="0"></A> 到&nbsp;<asp:TextBox ID="RegisterEndDay" runat="server" Width="112px" /><A onclick="return showCalendar('_ctl0:Main:Admin_UserSearch1:_ctl0:RegisterEndDay', 'y-mm-dd');" href="#"><IMG alt="选择日期" src="images/calendar.gif" border="0"></A></div>
			        </div>
		            	<div class="Hidden LH25" style="width:100%">
			            <div class="Left" style="width:100px">
			                &nbsp;<input type="checkbox" value="point" name="Users" />按积分值：
			            </div>
			            <div class="Left">
			                &nbsp;从&nbsp;<asp:TextBox ID="StartPoint" Text="0" runat="server" Width="51px" />&nbsp;到&nbsp;<asp:TextBox ID="EndPoint" Text="1" runat="server" Width="51px" /></div>
			        </div>
		            	<div class="Hidden LH25" style="width:100%">
			            <div class="Left" style="width:100px">
			                &nbsp;<input type="checkbox" value="coin" name="Users" />按金币值：
			            </div>
			            <div class="Left">
			                &nbsp;从&nbsp;<asp:TextBox ID="StartCoin" Text="0" runat="server" Width="52px" />&nbsp;到&nbsp;<asp:TextBox ID="EndCoin" Text="1" runat="server" Width="51px" /></div>
			        </div>
		            	<div class="Hidden LH25" style="width:100%">
			            <div class="Left" style="width:100px">
			                &nbsp;<input type="checkbox" value="topic" name="Users" />按发帖量：
			            </div>
			            <div class="Left">
			                &nbsp;从&nbsp;<asp:TextBox ID="StartTopic" Text="0" runat="server" Width="52px" />&nbsp;到&nbsp;<asp:TextBox ID="EndTopic" Text="1" runat="server" Width="51px" /></div>
			        </div>
		            	<div class="Hidden LH25" style="width:100%">
			            <div class="Left" style="width:100px">
			                &nbsp;<input type="checkbox" value="reply" name="Users" />按回帖量：
			            </div>
			            <div class="Left">
			                &nbsp;从&nbsp;<asp:TextBox ID="StartReply" Text="0" runat="server" Width="52px" />&nbsp;到&nbsp;<asp:TextBox ID="EndReply" Text="1" runat="server" Width="51px" /></div>
			        </div>
		            	<div class="Hidden LH25" style="width:100%">
			            <div class="Left" style="width:100px">
			                &nbsp;<input type="checkbox" value="sex" name="Users" />按性别：
			            </div>
			            <div class="Left">
			                <asp:RadioButtonList ID="Sex" RepeatDirection="horizontal" runat="server"><asp:ListItem Value="1" Selected="true">男</asp:ListItem><asp:ListItem Value="0">女</asp:ListItem></asp:RadioButtonList></div>
			        </div>
		            	<div class="Hidden LH25" style="width:100%">
			            <div class="Left" style="width:100px">
			                &nbsp;<input type="checkbox" value="ip" name="Users" />按IP地址：
			            </div>
			            <div class="Left">
			            	&nbsp;<asp:TextBox ID="IP" runat="server" /></div>
			        </div>
		            	<div class="Hidden LH25" style="width:100%">
			            <div class="Left" style="width:100px">
			                &nbsp;<input type="checkbox" value="ip" name="Users" />用户状态：
			            </div>
			            <div class="Left">
			            	&nbsp;<asp:DropDownList ID="Confirmed" runat="server"><asp:ListItem Value="0" Selected="true">已审核</asp:ListItem><asp:ListItem Value="1">未审核</asp:ListItem><asp:ListItem Value="2">锁定用户</asp:ListItem></asp:DropDownList></div>
			        </div>
			    </div>
			</div>
			<div class="Footer BT P5 TC Hidden">
			    <asp:Button CssClass="Button" ID="SubmitButton" Text="确定提交" runat="server" />
			</div>
		</div>
	</div>
</div>