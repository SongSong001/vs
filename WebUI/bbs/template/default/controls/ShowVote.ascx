<%@ Import Namespace="System.Web.UI" %>
<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true"%>
<asp:PlaceHolder ID="VotePanel" Visible="false" runat="server">
<script language="javascript">
    function OnCallback(result,context)
    {
        if (result.substring(0,1)=="*")
        {
            alert(result);
            window.location.reload();
        }
        else
        {
            alert(result);
        }
    }
    function getvotevalue(itemnum)
    {
        var selectvalue='';
        var MyOption=eval("aspnetForm.VoteOption" + itemnum);
        if (MyOption != null)
        {
            if (MyOption.length == null)
            {
                if (MyOption.checked == true)
                {
                    selectvalue=MyOption.value;
                }
            }
            else
            {
                for (i=0;i<MyOption.length;i++)
                {
                    if(MyOption[i].checked == true)
                    {
                        if (selectvalue=='')
                        {
                            selectvalue=MyOption[i].value;
                        }
                        else
                        {
                            selectvalue += "," + MyOption[i].value;
                        }
                    }
                }
            }
        }
        selectvalue=itemnum + "|" + selectvalue;
        return selectvalue;
    }
</script>
<div class="Block Hidden">
    <div class="Header TC P2">
        投票选项
    </div>
<asp:Repeater ID="CheckBoxVoteList" runat="server">
<itemtemplate>
<div class="M1" style="background:#F5FAFE;">
	<div class="VoteList">
		<div class="VoteLeft">
			<div>
				<input type="checkbox" name="VoteOption<%# Eval("ID") %>" value="<%# Eval("ValueID") %>" /><%# Eval("Content")%>
			</div>
		</div>
		<div class="VoteRight">
			<div class="Left" style="width:80%">&nbsp;<img src="<% = ForumConfig.ReadConfigInfo().SkinPath %>/votebar.gif" height="10" width="<%# Eval("PhotoRank") %>%"></div>
			<div class="Right"><%# Eval("Result")%>票 / <%# Eval("Rank")%>%</div>
		</div>
	</div>
</div>
</itemtemplate>
</asp:Repeater>
<asp:Repeater ID="RadioVoteList" runat="server">
<itemtemplate>
<div class="M1" style="background:#F5FAFE;">
	<div class="VoteList Hidden">
		<div class="VoteLeft">
				<input type="radio" name="VoteOption<%# Eval("ID") %>" value="<%# Eval("ValueID") %>" /><%# Eval("Content")%>
		</div>
		<div class="VoteRight">
			<div class="Left" style="width:80%">&nbsp;<img src="<% = ForumConfig.ReadConfigInfo().SkinPath %>/votebar.gif" height="10" width="<%# Eval("PhotoRank") %>%"></div>
			<div class="Right"><%# Eval("Result")%>票 / <%# Eval("Rank")%>%</div>
		</div>
	</div>
</div>
</itemtemplate>
</asp:Repeater>
<div class="M1" style="background:#F5FAFE;">
	<div class="VoteList">
	    <div class="VoteLeft">有效期至：</div>
	    <div class="VoteRight"><asp:Label ID="VoteExpired" ForeColor="red" runat="server" /></div>
	</div>
</div>
<div class="Footer Hidden TC P2">
	<asp:Button CssClass="Button" ID="VoteButton" Text="投上一票" runat="server"/>&nbsp;<asp:Button CssClass="Button" ID="ViewButton" Text="查看结果" runat="server" /></div>
</div>
</asp:PlaceHolder>