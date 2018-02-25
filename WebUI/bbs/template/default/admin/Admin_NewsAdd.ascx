﻿<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true"%>
<%@ Register TagPrefix="DXBBS" Namespace="DXBBS.Controls" Assembly="DXBBS.Controls" %>
<div class="BodyBlock PTB5">
    <div class="Block Hidden">
        <div class="Title H22 LH22 TC">
            综合管理-->添加公告
        </div>
        <div class="M1 Middle">
	     <div class="Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;公告位置：
                </div>
                <div class="Left">
                    &nbsp;<asp:DropDownList ID="BoardID" runat="server" /></div>
            </div>
	     <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;公告标题：
                </div>
                <div class="Left">
                    &nbsp;<asp:TextBox ID="Title" runat="server" Width="300px" /><asp:requiredfieldvalidator ID="NeedTitle" runat="server" ControlToValidate="Title" Display="Dynamic" ErrorMessage="请填写标题"></asp:requiredfieldvalidator></div>
            </div>
            <div class="BT Hidden" style="width:100%">
                <div class="Left BR LH25" style="width: 200px">
                    &nbsp;公告内容：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <DXBBS:Editor ID="Content" Height="100px" runat="server" />
                </div>
            </div>
			<div class="Footer BT P5 TC Hidden">
            	<asp:Button CssClass="Button" ID="SubmitButton" Text="确定提交" runat="server" />&nbsp;<input type="button" class="Button" value="公告管理" onclick="window.location.href='Admin_News.aspx'" />&nbsp;<input type="button" class="Button" value="返回" onclick="history.back(-1)" /></div>
		</div>
	</div>
</div>