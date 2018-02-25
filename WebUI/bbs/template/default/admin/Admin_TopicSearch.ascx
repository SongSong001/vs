<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true"%>
<%@ Register TagPrefix="DXBBS" Namespace="DXBBS.Controls" Assembly="DXBBS.Controls" %>
<script language="javascript" src="js/calendar.js"></script>
<LINK href="css/calendar.css" rel="stylesheet">
<asp:PlaceHolder ID="ShowTopicList" Visible="false" runat="server">
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
            论坛贴子搜索结果
        </div>
		<ul class="Header TC">
			<li class="Left" style="width:50px">ID</li>
			<li>帖子标题</li>
			<li class="Right">选择</li>
			<li class="Right" style="width:80px">最后更新</li>
			<li class="Right" style="width:80px">发表时间</li>
			<li class="Right" style="width:120px">所属版面</li>
			<li class="Right" style="width:60px">是否审核</li>
			<li class="Right" style="width:80px">回复 / 点击</li>
			<li class="Right" style="width:80px">发表用户</li>
		</ul>
		<asp:Repeater ID="TopicList" runat="server">
		<ItemTemplate>
		<dl class="TC">
			<dd class="Left" style="width:50px"><%# Eval("ID") %></dd>
			<dd class="Right"><input type="checkbox" name="SelectID" value="<%# Eval("ID") %>" /></dd>
			<dd class="Right" style="width:80px"><%# Convert.ToDateTime(Eval("LastReplyTime")).ToString("yyyy/MM/dd") %></dd>
			<dd class="Right" style="width:80px"><%# Convert.ToDateTime(Eval("AddTime")).ToString("yyyy/MM/dd") %></dd>
			<dd class="Right" style="width:120px"><DXBBS:BoardName ID="BoardName1" BoardID='<%# Eval("BoardID") %>' runat="server" /></dd>
			<dd class="Right" style="width:60px"><DXBBS:Confirmed ID="Confirmed1" DataSource='<%# Eval("Confirmed") %>' runat="server" /></dd>
			<dd class="Right" style="width:80px"><span class="Red"><%# Eval("Reply") %></span>&nbsp;/ <%# Eval("Click") %></dd>
			<dd class="Right" style="width:80px"><%# Eval("UserName") %></dd>
			<dd class="TL"><a href='<%# URLConfig.TopicURL.Replace("$BoardID",Eval("BoardID").ToString()).Replace("$TopicID",Eval("ID").ToString()) %>' target="_blank"><%# Eval("Title") %></a></dd>
		</dl>
		</ItemTemplate>
		</asp:Repeater>
		<div class="Footer PTB5 BT TC">
			<asp:Button CssClass="Button" ID="DeleteButton" Text="确定删除" OnClientClick="return CheckSelect()" runat="server" />&nbsp;<input type="checkbox" name="All" onclick="SelectAll(this)" />全选/全不选
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
		    帖子搜索
		</div>
		<div class="M1 Middle">
			<div class="BT Hidden" style="width:100%">
			    <div class="Left BR LH25" style="width: 150px">
			        &nbsp;搜索条件：<br />
			        &nbsp; (可多条件组合查询)
				</div>
			    <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
			        <div class="Hidden H25 LH25">
			            <div class="Left" style="width:100px">
			                &nbsp;<input type="checkbox" value="board" name="Users" />按版面：
			            </div>
			            <div class="Left">
			                 &nbsp;<asp:DropDownList ID="BoardID" runat="server" /></div>
			        </div>
			        <div class="Hidden H25 LH25">
			            <div class="Left" style="width:100px">
			                &nbsp;<input type="checkbox" value="title" checked name="Condition" />按标题：
			            </div>
			            <div class="Left">
			                 &nbsp;<asp:TextBox ID="Title" runat="server" /></div>
			        </div>
			        <div class="Hidden H25 LH25">
			            <div class="Left" style="width:100px">
			                &nbsp;<input type="checkbox" value="name" name="Condition" />按发帖用户名：
			            </div>
			            <div class="Left">
			                 &nbsp;<asp:TextBox ID="UserName" runat="server" /></div>
			        </div>
			        <div class="Hidden H25 LH25">
			            <div class="Left" style="width:100px">
			                &nbsp;<input type="checkbox" value="id" name="Condition" />按发帖用户ID：
			            </div>
			            <div class="Left">
			                 &nbsp;<asp:TextBox ID="UserID" runat="server" /></div>
			        </div>
			        <div class="Hidden H25 LH25">
			            <div class="Left" style="width:100px">
			                &nbsp;<input type="checkbox" value="addtime" name="Condition" />按发帖时间：
			            </div>
			            <div class="Left">
			            	 &nbsp;从 <asp:TextBox ID="StartAddTime" runat="server" /><A onclick="return showCalendar('_ctl0:Main:Admin_TopicSearch1:_ctl0:StartAddTime', 'y-mm-dd');" href="#"><IMG alt="选择日期" src="images/calendar.gif" border="0"></A> 到 <asp:TextBox ID="EndAddTime" runat="server" /> <A onclick="return showCalendar('_ctl0:Main:Admin_TopicSearch1:_ctl0:EndAddTime', 'y-mm-dd');" href="#"><IMG alt="选择日期" src="images/calendar.gif" border="0"></A></div>
			        </div>
			        <div class="Hidden H25 LH25">
			            <div class="Left" style="width:100px">
			                &nbsp;<input type="checkbox" value="click" name="Condition" />按点击率：
			            </div>
			            <div class="Left">
			                &nbsp;从 <asp:TextBox ID="StartClick" runat="server" Width="51px" /> 到 <asp:TextBox ID="EndClick" runat="server" Width="51px" /></div>
			        </div>
			        <div class="Hidden H25 LH25">
			            <div class="Left" style="width:100px">
			                &nbsp;<input type="checkbox" value="reply" name="Condition" />按回复量：
			            </div>
			            <div class="Left">
			                &nbsp;从 <asp:TextBox ID="StartReply" Text="0" runat="server" Width="51px" /> 到 <asp:TextBox ID="EndReply" Text="1" runat="server" Width="51px" /></div>
			        </div>
			    </div>
			</div>
			<div class="Footer BT P5 TC Hidden">
			    <asp:Button CssClass="Button" ID="SubmitButton" Text="确定搜索" runat="server" />
			</div>
		</div>
	</div>
</div>