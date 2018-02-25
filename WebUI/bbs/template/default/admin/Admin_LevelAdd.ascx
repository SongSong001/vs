<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true"%>
<script language="javascript">
//全选全不选
function SelectAll(obj)
{
    var aspnetForm=document.getElementById("aspnetForm");
    if (aspnetForm.Rights != null)
    {
        if (aspnetForm.Rights.length == null)
        {
            aspnetForm.Rights.checked=obj.checked;
        }
        else
        {
            for (i=0;i<aspnetForm.Rights.length;i++)
            {
                if(aspnetForm.Rights[i].checked!=obj.checked)
                {
                    aspnetForm.Rights[i].checked=obj.checked;
                }
            }
        }
    }
}
</script>
<div class="BodyBlock PTB5">
    <div class="Block Hidden">
        <div class="Title H22 LH22 TC">
            添加/修改用户等级
        </div>
        <div class="M1 Middle">
            <div class="Hidden H25 LH25">
                <div class="Left BR" style="width: 200px">
                    &nbsp;等级名称：
                </div>
                <div class="Left">
                     &nbsp;<asp:TextBox ID="LevelName" runat="server" Width="173px" /><asp:requiredfieldvalidator ID="Requiredfieldvalidator1" runat="server" ControlToValidate="LevelName" Display="Dynamic" ErrorMessage="请填写名称"></asp:requiredfieldvalidator>
                </div>
            </div>
            <div class="BT Hidden H25 LH25">
                <div class="Left BR" style="width: 200px">
                    &nbsp;等级类型：
                </div>
                <div class="Left">
                     &nbsp;<asp:DropDownList ID="Types" AutoPostBack="true" runat="server"><asp:ListItem Value="5" Text="普通升级" /><asp:ListItem Value="3" Text="固定不定" /><asp:ListItem Value="4" Text="访客类型" /><asp:ListItem Value="2" Text="版主类型" /><asp:ListItem Value="1" Text="系统管理" /></asp:DropDownList>
                </div>
            </div>
            <div class="BT Hidden H25 LH25">
                <div class="Left BR" style="width: 200px">
                    &nbsp;等级图片：
                </div>
                <div class="Left">
                     &nbsp;<asp:TextBox ID="Sun" Text="0" Width="30px" runat="server" />&nbsp;太阳&nbsp;<asp:TextBox ID="Moon" Text="0" Width="30px" runat="server" />&nbsp;月亮&nbsp;<asp:TextBox ID="Star" Text="1" Width="30px" runat="server" />&nbsp;星星&nbsp;
                </div>
            </div>
			<asp:PlaceHolder ID="ShowPoint" runat="server">
            <div class="BT Hidden H25 LH25">
                <div class="Left BR" style="width: 200px">
                    &nbsp;最高积分：<br />(超过此积分的用户将升级)
                </div>
                <div class="Left">
                     &nbsp;<asp:TextBox ID="Point" runat="server" Width="173px"></asp:TextBox>&nbsp;<asp:requiredfieldvalidator ID="Requiredfieldvalidator2" runat="server" ControlToValidate="Point" Display="Dynamic" ErrorMessage="请填写积分"></asp:requiredfieldvalidator>
                </div>
            </div>
            </asp:PlaceHolder>
            <asp:PlaceHolder ID="ShowAddToPermision" runat="server">
            <div class="BT Hidden H25 LH25">
                <div class="Left BR" style="width: 200px">
                    &nbsp;加入到所有版面的可访问用户组：
                </div>
                <div class="Left">
                     &nbsp;<asp:DropDownList ID="AddToPermision" runat="server"><asp:ListItem Value="1" Text="是" /><asp:ListItem Value="0" Text="否" /></asp:DropDownList>
                </div>
            </div>
            </asp:PlaceHolder>
            <div class="BT Hidden" style="width:100%">
                <div class="Left BR LH25" style="width: 200px">
                    &nbsp;基本权限：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
		            <input name="Rights" type="checkbox" value="1" checked="CHECKED" />允许隐身 
		            <input name="Rights" type="checkbox" value="2" checked="CHECKED" />允许使用搜索 
		            <input name="Rights" type="checkbox" value="3" checked="CHECKED" />允许使用昵称 
		            <input name="Rights" type="checkbox" value="4" checked="CHECKED" />查看贴子列表<br />
		            <input name="Rights" type="checkbox" value="5" checked="CHECKED" />查看贴子内容  
		            <input name="Rights" type="checkbox" value="6" checked="CHECKED" />查看用户资料 
		            <input name="Rights" type="checkbox" value="7" checked="CHECKED" />查看在线用户 
		            <input name="Rights" type="checkbox" value="8" />查看用户IP<br />
		            <input name="Rights" type="checkbox" value="9" checked="CHECKED" />允许使用签名档 
		            <input name="Rights" type="checkbox" value="10" />允许查看屏蔽贴 
		            <input name="Rights" type="checkbox" value="11" />直接查看金币贴 
		            <input name="Rights" type="checkbox" value="12" />直接查看权限贴<br />
		            <input name="Rights" type="checkbox" value="13" />直接查看回复可见贴 
		            <input name="Rights" type="checkbox" value="14" checked="CHECKED" />允许加入圈子 
		            <input name="Rights" type="checkbox" value="15" />允许申请圈子
                </div>
            </div>
            <div class="BT Hidden" style="width:100%">
                <div class="Left BR LH25" style="width: 200px">
                    &nbsp;发帖/回复权限：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
		            <input name="Rights" type="checkbox" value="16" checked="CHECKED" />发表普通帖
		            <input name="Rights" type="checkbox" value="17" checked="CHECKED" />发表投票帖
		            <input name="Rights" type="checkbox" value="18" checked="CHECKED" />发表权限贴
		            <input name="Rights" type="checkbox" value="19" checked="CHECKED" />发表颜色标题贴<br />
		            <input name="Rights" type="checkbox" value="20" checked="CHECKED" />发表回复可见贴
		            <input name="Rights" type="checkbox"value="21" checked="CHECKED" />发表金币购买帖
		            <input name="Rights" type="checkbox"value="22" checked="CHECKED" />发表HTML标题贴
		            <input name="Rights" type="checkbox"value="23" checked="CHECKED" />发表问答帖<br />
		            <input name="Rights" type="checkbox" value="24" checked="CHECKED" />回复普通帖
		            <input name="Rights" type="checkbox" value="25" checked="CHECKED" />回复投票帖
		            <input name="Rights" type="checkbox" value="26" checked="CHECKED" />回复权限帖
		            <input name="Rights" type="checkbox" value="27" checked="CHECKED" />回复颜色标题帖<br />
		            <input name="Rights" type="checkbox" value="28" checked="CHECKED" />回复金币购买帖
		            <input name="Rights" type="checkbox" value="29" checked="CHECKED" />回复HTML标题帖&nbsp;<br />
		            <input name="Rights" type="checkbox" value="30"/>在锁定版面发贴
		            <input name="Rights" type="checkbox" value="31" />在锁定版面回复
		            <input name="Rights" type="checkbox" value="32" />在锁定主题回复<br />
		            <input name="Rights" type="checkbox" value="33" checked="CHECKED"/>可编辑自己发表的主题,<asp:TextBox ID="EditSelfTopicDay" Text="2" runat="server" Width="36px" />天内可操作<br />
		            <input name="Rights" type="checkbox" value="34" checked="CHECKED"/>可删除自己发表的主题,<asp:TextBox ID="DeleteSelfTopicDay" Text="1" runat="server" Width="36px" />天内可操作<br />
		            <input name="Rights" type="checkbox" value="35" checked="CHECKED"/>可编辑自己发表的回复,<asp:TextBox ID="EditSelfReplyDay" Text="2" runat="server" Width="36px" />天内可操作<br />
		            <input name="Rights" type="checkbox" value="36" checked="CHECKED"/>可删除自己发表的回复,<asp:TextBox ID="DeleteSelfReplyDay" Text="1" runat="server" Width="36px" />天内可操作
                </div>
            </div>
            <div class="BT Hidden" style="width:100%">
                <div class="Left BR LH25" style="width: 200px">
                    &nbsp;上传/下载权限：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
		            <input name="Rights" type="checkbox" value="37" checked="CHECKED" />允许下载附件<br />
			        <input name="Rights" type="checkbox" value="38" checked="CHECKED" />允许上传头像，最大体积
		            <asp:TextBox ID="UploadFaceSize" Text="300" runat="server" Width="36px" /> KB.<br />
		            <input name="Rights" type="checkbox" value="39" checked="CHECKED" />允许上传附件，最大体积&nbsp;<asp:TextBox ID="UploadSize" Text="300" runat="server" Width="36px" />KB. 每天最多&nbsp;<asp:TextBox ID="UploadNum" Text="10" runat="server" Width="36px" />个
                </div>
            </div>
            <div class="BT Hidden" style="width:100%">
                <div class="Left BR LH25" style="width: 200px">
                    &nbsp;前台管理权限：<br />(版主类型等级只对所管理的版面有效,其他等级对所有帖子有效)：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
			        <input name="Rights" type="checkbox" value="40" />编辑主题
		            <input name="Rights" type="checkbox" value="41" />删除主题
		            <input name="Rights" type="checkbox" value="42" />编辑回复
		            <input name="Rights" type="checkbox" value="43" />删除回复<br />
		            <input name="Rights" type="checkbox" value="44" />移动主题
		            <input name="Rights" type="checkbox" value="45" />加精主题
		            <input name="Rights" type="checkbox" value="46" />解精主题
		            <input name="Rights" type="checkbox" value="47" />锁定主题
		            <br />
		            <input name="Rights" type="checkbox" value="48" />解锁主题
		            <input name="Rights" type="checkbox" value="49" />屏蔽主题
		            <input name="Rights" type="checkbox" value="50" />解屏主题
		            <input name="Rights" type="checkbox" value="51" />屏蔽回复
		            <br />
		            <input name="Rights" type="checkbox" value="52" />解屏回复
		            <input name="Rights" type="checkbox" value="53" />发表公告
		            <input name="Rights" type="checkbox" value="54" />编辑公告
		            <input name="Rights" type="checkbox" value="55" />删除公告<br />
		            <input name="Rights" type="checkbox" value="56" />版面固顶主题
		            <input name="Rights" type="checkbox" value="57" />区固顶主题
		            <input name="Rights" type="checkbox" value="58" />总固顶主题
		            <input name="Rights" type="checkbox" value="59" />解除固顶<br />
		            <input name="Rights" type="checkbox" value="60" />批量审核主题
		            <input name="Rights" type="checkbox" value="61" />批量锁定
		            <input name="Rights" type="checkbox" value="62" />批量解锁
		            <input name="Rights" type="checkbox" value="63" />批量屏蔽
		            <br />
		            <input name="Rights" type="checkbox" value="64" />批量解屏
		            <input name="Rights" type="checkbox" value="65" />批量移动
		            <input name="Rights" type="checkbox" value="66" />批量删除
		            <input name="Rights" type="checkbox" value="67" />设置问题帖最佳答案
                </div>
            </div>
            <div class="BT Hidden" style="width:100%">
                <div class="Left BR LH25" style="width: 200px">
                    &nbsp;后台管理权限：
                </div>
                <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
			        <input name="Rights" type="checkbox" value="68" />系统设置
			        <input name="Rights" type="checkbox" value="69" />综合管理
			        <input name="Rights" type="checkbox" value="70" />版面管理
			        <input name="Rights" type="checkbox" value="71" />用户管理<br />
		            <input name="Rights" type="checkbox" value="72" />帖子管理
		            <input name="Rights" type="checkbox" value="73" />模板皮肤管理
		            <input name="Rights" type="checkbox" value="74" />短消息管理<br />
		            <input name="Rights" type="checkbox" value="75" />友情链接管理
		            <input name="Rights" type="checkbox" value="76" />文件管理
		            <input name="Rights" type="checkbox" value="77" />回收站管理
                </div>
            </div>
            <div class="Footer BT P5 TC Hidden">
				<asp:Button CssClass="Button" ID="SubmitButton" Text="确定提交" runat="server" />&nbsp;<input type="button" class="Button" value="返回" onclick="history.back(-1)" />&nbsp;<input name="All" type="checkbox" onclick="SelectAll(this)" />全选/全不选
			</div>
		</div>
	</div>
</div>
<script language="JavaScript">
var aspnetForm=document.getElementById("aspnetForm");
var Right="<%=Currents.LevelPower%>";
if (Right != "")
{
	temp=Right.split(",");
	for (i=0;i<aspnetForm.Rights.length ;i++ )
	{
		var ischecked=false;
		for (j=0;j<temp.length ;j++ )
		{
			if(temp[j]==aspnetForm.Rights[i].value)
			{
				ischecked=true;
			}
		}
		if (ischecked == true)
		{
			aspnetForm.Rights[i].checked=true;
		}
		else
		{
			aspnetForm.Rights[i].checked=false;
		}
	}
}
</script>