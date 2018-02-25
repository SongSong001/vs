<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true"%>
<div class="BodyBlock PTB5">
    <div class="Block Hidden">
        <div class="Title H22 LH22 TC">
            综合管理-->日志查看
        </div>
        <div class="M1 Middle">
            <div class="H25 LH25 Hidden">
                <div class="Left BR" style="width: 200px">
					&nbsp;日志类型：
                </div>
                <div class="Left">
					&nbsp;<asp:Label ID="LogTitle" runat="server" /></div>
            </div>
            <div class="BT H25 LH25 Hidden">
                <div class="Left BR" style="width: 200px">
					&nbsp;文章标题：
                </div>
                <div class="Left">
					&nbsp;<asp:Label ID="Title" runat="server" /></div>
            </div>
            <div class="BT Hidden" style="width:100%">
                <div class="Left BR LH25" style="width: 200px">
                    &nbsp;文章内容：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                     <asp:Label ID="Content" runat="server" />
                </div>
            </div>
            <div class="BT H25 LH25 Hidden">
                <div class="Left BR" style="width: 200px">
					&nbsp;操作原因：
                </div>
                <div class="Left">
					&nbsp;<asp:Label ID="Reason" runat="server" /></div>
            </div>
            <div class="BT H25 LH25 Hidden">
                <div class="Left BR" style="width: 200px">
					&nbsp;操作金币：
                </div>
                <div class="Left">
					&nbsp;<asp:Label ID="Coin" runat="server" /></div>
            </div>
            <div class="BT H25 LH25 Hidden">
                <div class="Left BR" style="width: 200px">
					&nbsp;操作积分：
                </div>
                <div class="Left">
					&nbsp;<asp:Label ID="Point" runat="server" /></div>
            </div>
            <div class="BT H25 LH25 Hidden">
                <div class="Left BR" style="width: 200px">
					&nbsp;操作人：
                </div>
                <div class="Left">
					&nbsp;<asp:Label ID="Operator" runat="server" /></div>
            </div>
            <div class="BT H25 LH25 Hidden">
                <div class="Left BR" style="width: 200px">
					&nbsp;被操作人：
                </div>
                <div class="Left">
					&nbsp;<asp:Label ID="Loger" runat="server" /></div>
            </div>
            <div class="BT H25 LH25 Hidden">
                <div class="Left BR" style="width: 200px">
					&nbsp;记录时间：
                </div>
                <div class="Left">
					&nbsp;<asp:Label ID="AddTime" runat="server" /></div>
            </div>
		</div>
	</div>
</div>