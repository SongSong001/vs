<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true"%>
<div class="BodyBlock PTB5">
    <div class="Block Hidden">
        <div class="Title H22 LH22 TC">
            系统设置-->积分金币设置
        </div>
        <div class="M1 Middle">
	     <div class="Hidden LH25" style="width:100%">
	            <div class="Left BR" style="width: 200px">&nbsp;上传一次头像金币操作：</div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px"><asp:TextBox ID="FaceUploadCoin" width="150px" runat="server" /></div>
	        </div>
	     <div class="BT Hidden LH25" style="width:100%">
	            <div class="Left BR" style="width: 200px">&nbsp;上传一次头像积分操作：</div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px"><asp:TextBox ID="FaceUploadPoint" width="150px" runat="server" /></div>
	        </div>
	     <div class="BT Hidden LH25" style="width:100%">
	            <div class="Left BR" style="width: 200px">&nbsp;上传一次文件金币操作：</div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px"><asp:TextBox ID="FileUploadCoin" width="150px" runat="server" /></div>
	        </div>
	     <div class="BT Hidden LH25" style="width:100%">
	            <div class="Left BR" style="width: 200px">&nbsp;上传一次文件积分操作：</div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px"><asp:TextBox ID="FileUploadPoint" width="150px" runat="server" /></div>
	        </div>
	     <div class="BT Hidden LH25" style="width:100%">
	            <div class="Left BR" style="width: 200px">&nbsp;用户下载一次附件金币操作：</div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px"><asp:TextBox ID="DownloadCoin" width="150px" runat="server" /></div>
	        </div>
	     <div class="BT Hidden LH25" style="width:100%">
	            <div class="Left BR" style="width: 200px">&nbsp;用户下载一次附件积分操作：</div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px"><asp:TextBox ID="DownloadPoint" width="150px" runat="server" /></div>
	        </div>
	     <div class="BT Hidden LH25" style="width:100%">
	            <div class="Left BR" style="width: 200px">&nbsp;注册新用户金币操作：</div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px"><asp:TextBox ID="RegisterCoin" width="150px" runat="server" /></div>
	        </div>
	     <div class="BT Hidden LH25" style="width:100%">
	            <div class="Left BR" style="width: 200px">&nbsp;注册新用户积分操作：</div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px"><asp:TextBox ID="RegisterPoint" width="150px" runat="server" /></div>
	        </div>
	     <div class="BT Hidden LH25" style="width:100%">
	            <div class="Left BR" style="width: 200px">&nbsp;用户登录一次金币操作：</div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px"><asp:TextBox ID="LoginCoin" width="150px" runat="server" /></div>
	        </div>
	     <div class="BT Hidden LH25" style="width:100%">
	            <div class="Left BR" style="width: 200px">&nbsp;用户登录一次积分操作：</div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px"><asp:TextBox ID="LoginPoint" width="150px" runat="server" /></div>
	        </div>
	     <div class="BT Hidden LH25" style="width:100%">
	            <div class="Left BR" style="width: 200px">&nbsp;用户发表一个主题金币操作：</div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px"><asp:TextBox ID="TopicCoin" width="150px" runat="server" /></div>
	        </div>
	     <div class="BT Hidden LH25" style="width:100%">
	            <div class="Left BR" style="width: 200px">&nbsp;用户发表一个主题积分操作：</div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px"><asp:TextBox ID="TopicPoint" width="150px" runat="server" /></div>
	        </div>
	     <div class="BT Hidden LH25" style="width:100%">
	            <div class="Left BR" style="width: 200px">&nbsp;用户回复帖子一次金币操作：</div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px"><asp:TextBox ID="ReplyCoin" width="150px" runat="server" /></div>
	        </div>
	     <div class="BT Hidden LH25" style="width:100%">
	            <div class="Left BR" style="width: 200px">&nbsp;用户回复帖子一次积分操作：</div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px"><asp:TextBox ID="ReplyPoint" width="150px" runat="server" /></div>
	        </div>
	     <div class="BT Hidden LH25" style="width:100%">
	            <div class="Left BR" style="width: 200px">&nbsp;用户文章被加精一次金币操作：</div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px"><asp:TextBox ID="GoodCoin" width="150px" runat="server" /></div>
	        </div>
	     <div class="BT Hidden LH25" style="width:100%">
	            <div class="Left BR" style="width: 200px">&nbsp;用户文章被加精一次积分操作：</div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px"><asp:TextBox ID="GoodPoint" width="150px" runat="server" /></div>
	        </div>
	     <div class="BT Hidden LH25" style="width:100%">
	            <div class="Left BR" style="width: 200px">&nbsp;用户主题被删除金币操作：</div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px"><asp:TextBox ID="TopicDelCoin" width="150px" runat="server" /></div>
	        </div>
	     <div class="BT Hidden LH25" style="width:100%">
	            <div class="Left BR" style="width: 200px">&nbsp;用户主题被删除积分操作：</div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px"><asp:TextBox ID="TopicDelPoint" width="150px" runat="server" /></div>
	        </div>
	     <div class="BT Hidden LH25" style="width:100%">
	            <div class="Left BR" style="width: 200px">&nbsp;用户回复被删除金币操作：</div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px"><asp:TextBox ID="ReplyDelCoin" width="150px" runat="server" /></div>
	        </div>
	     <div class="BT Hidden LH25" style="width:100%">
	            <div class="Left BR" style="width: 200px">&nbsp;用户回复被删除积分操作：</div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px"><asp:TextBox ID="ReplyDelPoint" width="150px" runat="server" /></div>
	        </div>
	     <div class="BT Hidden LH25" style="width:100%">
	            <div class="Left BR" style="width: 200px">&nbsp;用户发送一条站内信息金币操作：</div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px"><asp:TextBox ID="MessageCoin" width="150px" runat="server" /></div>
	        </div>
	     <div class="BT Hidden LH25" style="width:100%">
	            <div class="Left BR" style="width: 200px">&nbsp;用户发送一条站内信息积分操作：</div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px"><asp:TextBox ID="MessagePoint" width="150px" runat="server" /></div>
	        </div>
            <div class="Footer BT P5 TC Hidden">
	            <asp:Button CssClass="Button" ID="SubmitButton" Text="确定提交" runat="server" />&nbsp;<input type="button" class="Button" value="取消修改" onclick="window.location='Admin_Right.aspx'" />
	        </div>
        </div>
    </div>
</div>