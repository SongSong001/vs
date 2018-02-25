<%@ Import Namespace="DXBBS.Components" %>
<%@ Control Language="C#" AutoEventWireup="true" %>
<%@ Register TagPrefix="DXBBS" Namespace="DXBBS.Controls" Assembly="DXBBS.Controls" %>
<div class="BodyBlock PTB5">
    <div class="Block Hidden">
        <div class="Title H22 LH22 TC">
            系统设置-->参数设置
        </div>
        <div class="M1 Middle">
	     <div class="Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;论坛名称：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <asp:textbox id="ForumName" width="550"  runat="server" /></div>
            </div>
            <div class="BT Hidden" style="width:100%">
                <div class="Left BR LH25" style="width: 200px">
                    &nbsp;论坛Keyword关键字
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <asp:textbox id="Keyword" textmode="multiLine" height="60" width="550" runat="server" />
                </div>
            </div>
            <div class="BT Hidden" style="width:100%">
                <div class="Left BR LH25" style="width: 200px">
                    &nbsp;论坛Description描述：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <asp:textbox id="Description" textmode="multiLine" height="60" width="550"
                        runat="server" /></div>
            </div>
	     <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;模板皮肤：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <asp:dropdownlist id="Template" autopostback="true" runat="server" />&nbsp;<asp:dropdownlist id="Skin" runat="server" /></div>
            </div>
	     <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;论坛状态：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <asp:RadioButtonList RepeatDirection="horizontal" RepeatLayout="flow" id="ForumState" runat="server">
				            <asp:ListItem Value="1">开启</asp:ListItem>
				            <asp:ListItem Value="0">关闭</asp:ListItem>
			            </asp:RadioButtonList>
                </div>
            </div>
	     <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;允许注册用户：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <asp:RadioButtonList RepeatDirection="horizontal" RepeatLayout="flow" id="AllowRegister" runat="server">
				            <asp:ListItem Value="1">允许</asp:ListItem>
				            <asp:ListItem Value="0">禁止</asp:ListItem>
			            </asp:RadioButtonList>
                </div>
            </div>
	     <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;新注册用户需要审核：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <asp:RadioButtonList RepeatDirection="horizontal" RepeatLayout="flow" id="UserConfirm" runat="server">
				            <asp:ListItem Value="1">需要</asp:ListItem>
				            <asp:ListItem Value="0">不需要</asp:ListItem>
			            </asp:RadioButtonList>
                </div>
            </div>
	     <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;首页显示在线列表：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <asp:RadioButtonList RepeatDirection="horizontal" RepeatLayout="flow" id="ShowOnline" runat="server">
				            <asp:ListItem Value="1">开启</asp:ListItem>
				            <asp:ListItem Value="0">关闭</asp:ListItem>
			            </asp:RadioButtonList>
                </div>
            </div>
	     <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;是否显示版面下拉菜单：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <asp:RadioButtonList RepeatDirection="horizontal" RepeatLayout="flow" id="ShowMenu" runat="server">
				            <asp:ListItem Value="1">显示</asp:ListItem>
				            <asp:ListItem Value="0">不显示</asp:ListItem>
			            </asp:RadioButtonList>
                </div>
            </div>
            <div class="BT Hidden" style="width:100%">
                <div class="Left BR LH25" style="width: 200px">
                    &nbsp;论坛LOGO图片：<br />
                    &nbsp; (支持HTML代码)
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <dxbbs:editor id="Logo" height="100" AllowScript="true" runat="server" />
                </div>
            </div>
            <div class="BT Hidden" style="width:100%">
                <div class="Left BR LH25" style="width: 200px">
                    &nbsp;论坛BANNER图片：<br />
                    &nbsp; (支持HTML代码)
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <dxbbs:editor id="Banner" height="100" AllowScript="true" runat="server" />
                </div>
            </div>
            <div class="BT H25 LH25 Hidden">
                <div class="Left BR" style="width: 200px">
                    &nbsp;在线用户刷新时间：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <asp:textbox id="RefreshTime" width="150px" runat="server" />&nbsp;分钟
                </div>
            </div>
            <div class="BT H25 LH25 Hidden">
                <div class="Left BR" style="width: 200px">
                    &nbsp;版面活动主题显示字数：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <asp:textbox id="ActiveTitleLength" width="150px" runat="server" /></div>
            </div>
            <div class="BT H25 LH25 Hidden">
                <div class="Left BR" style="width: 200px">
                    &nbsp;单Reply表最大数据量：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <asp:textbox id="MaxTableCount" width="150px" runat="server" /></div>
            </div>
            <div class="BT H25 LH25 Hidden">
                <div class="Left BR" style="width: 200px">
                    &nbsp;数据表前缀：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <asp:textbox id="TablePrefix" width="150px" Enabled="false" runat="server" />&nbsp;(该项请不要随意修改.如有需要请打开Forum.config文件修改)</div>
            </div>
            <div class="BT H25 LH25 Hidden">
                <div class="Left BR" style="width: 200px">
                    &nbsp;默认男用户头像：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <asp:textbox id="MalePhoto" width="150px" runat="server" /></div>
            </div>
            <div class="BT H25 LH25 Hidden">
                <div class="Left BR" style="width: 200px">
                    &nbsp;默认女用户头像：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <asp:textbox id="FemalePhoto" width="150px" runat="server" /></div>
            </div>
            <div class="BT H25 LH25 Hidden">
                <div class="Left BR" style="width: 200px">
                    &nbsp;默认头像宽度：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <asp:textbox id="PhotoWidth" width="150px" runat="server" />&nbsp;px
                </div>
            </div>
            <div class="BT H25 LH25 Hidden">
                <div class="Left BR" style="width: 200px">
                    &nbsp;默认头像高度：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <asp:textbox id="PhotoHeight" width="150px" runat="server" />&nbsp;px
                </div>
            </div>
            <div class="BT H25 LH25 Hidden">
                <div class="Left BR" style="width: 200px">
                    &nbsp;允许最大头像宽度：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <asp:textbox id="MaxPhotoWidth" width="150px" runat="server" />&nbsp;px &nbsp;(建议不要超过250px)
                </div>
            </div>
            <div class="BT H25 LH25 Hidden">
                <div class="Left BR" style="width: 200px">
                    &nbsp;允许最大头像高度：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <asp:textbox id="MaxPhotoHeight" width="150px" runat="server" />&nbsp;px &nbsp;(建议不要超过250px)
                </div>
            </div>
            <div class="BT H25 LH25 Hidden">
                <div class="Left BR" style="width: 200px">
                    &nbsp;允许昵称最大字符数：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <asp:textbox id="NickNameLength" width="150px" runat="server" />&nbsp;字符 &nbsp;(建议10字符以内
                </div>
            </div>
            <div class="BT H25 LH25 Hidden">
                <div class="Left BR" style="width: 200px">
                    &nbsp;允许签名最大档字符数：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <asp:textbox id="SignLength" width="150px" runat="server" />&nbsp;字符 &nbsp;(250字符以内)
                </div>
            </div>
	     <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;发帖允许HTML代码：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <asp:RadioButtonList id="AllowHTML" RepeatDirection="horizontal" RepeatLayout="flow" runat="server">
				            <asp:ListItem Value="1">允许</asp:ListItem>
				            <asp:ListItem Value="0">不允许</asp:ListItem>
			            </asp:RadioButtonList>
                </div>
            </div>
	     <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;发帖允许UBB代码：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <asp:RadioButtonList id="AllowUBB" RepeatDirection="horizontal" RepeatLayout="flow" runat="server">
				            <asp:ListItem Value="1">允许</asp:ListItem>
				            <asp:ListItem Value="0">不允许</asp:ListItem>
			            </asp:RadioButtonList>
                </div>
            </div>
	     <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;签名档允许HTML代码：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <asp:RadioButtonList id="AllowSignHTML" RepeatDirection="horizontal" RepeatLayout="flow" runat="server">
				            <asp:ListItem Value="1">允许</asp:ListItem>
				            <asp:ListItem Value="0">不允许</asp:ListItem>
			            </asp:RadioButtonList>
                </div>
            </div>
	     <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;签名档允许UBB代码：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <asp:RadioButtonList id="AllowSignUBB" RepeatDirection="horizontal" RepeatLayout="flow" runat="server">
				            <asp:ListItem Value="1">允许</asp:ListItem>
				            <asp:ListItem Value="0">不允许</asp:ListItem>
			            </asp:RadioButtonList>
                </div>
            </div>
            <div class="BT H25 LH25 Hidden">
                <div class="Left BR" style="width: 200px">
                    网页文件扩展名：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    &nbsp;<asp:textbox id="Extension" runat="server" /></div>
            </div>
	     <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;注册欢迎短信息：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <asp:RadioButtonList id="Welcome" RepeatDirection="horizontal" RepeatLayout="flow" runat="server">
				            <asp:ListItem Value="1">开启</asp:ListItem>
				            <asp:ListItem Value="0">关闭</asp:ListItem>
			            </asp:RadioButtonList>
                </div>
            </div>
	     <div class="BT Hidden LH25" style="width:100%">
                <div class="Left BR" style="width: 200px">
                    &nbsp;注册欢迎短信息标题：
                </div>
                <div class="Left" style="padding-left: 5px">
                    <asp:textbox id="WelcomeTitle" runat="server" />
                </div>
            </div>
            <div class="BT Hidden" style="width:100%">
                <div class="Left BR LH25" style="width: 200px">
                    &nbsp;注册欢迎短信息内容：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <dxbbs:editor id="WelcomeContent" height="100px" runat="server" />
                </div>
            </div>
            <div class="BT H25 LH25 Hidden">
                <div class="Left BR" style="width: 200px">
                    &nbsp;单个圈子允许最大公告条数：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <asp:textbox id="TeamNewsNumber" width="150px" runat="server" />&nbsp;条
                </div>
            </div>
            <div class="BT H25 LH25 Hidden">
                <div class="Left BR" style="width: 200px">
                    &nbsp;单个圈子允许最大图片张数：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <asp:textbox id="TeamPhotoNumber" width="150px" runat="server" />&nbsp;张
                </div>
            </div>
            <div class="BT H25 LH25 Hidden">
                <div class="Left BR" style="width: 200px">
                    &nbsp;单个圈子允许最大留言条数：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <asp:textbox id="TeamMessageNumber" width="150px" runat="server" />&nbsp;条
                </div>
            </div>
            <div class="BT H25 LH25 Hidden">
                <div class="Left BR" style="width: 200px">
                    &nbsp;当地时间与服务器时间差值：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <asp:textbox id="TimeZone" width="150px" runat="server" />分钟(前为正值，后为负值)
                </div>
            </div>
            <div class="BT H25 LH25 Hidden">
                <div class="Left BR" style="width: 200px">
                    &nbsp;当前服务器时间：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
                    <%= System.DateTime.Now.ToString() %>
                </div>
            </div>
            <div class="Footer BT P5 TC Hidden">
                <asp:Button CssClass="Button" id="SubmitButton" text="确定提交" runat="server" />
                &nbsp;<input type="button" class="Button" value="取消修改" onclick="window.location='Admin_Right.aspx'" />
            </div>
        </div>
    </div>
</div>
