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
			权限设置
		</div>
        <div class="M1 Middle">
	        <div class="Hidden LH25" style="width:100%">
	            <div class="Left BR" style="width: 200px">
	                &nbsp;版面名称：
	            </div>
	            <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
	                <asp:Label ID="BoardName" runat="server" />
	            </div>
	        </div>
	        <div class="BT Hidden LH25" style="width:100%">
	            <div class="Left BR" style="width: 200px">
	                &nbsp;设置对象：
	            </div>
	            <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
	                <asp:Label ID="ItemName" runat="server" />
	            </div>
	        </div>
	        <asp:PlaceHolder ID="ShowTypes" runat="server">
	        <div class="BT Hidden LH25" style="width:100%">
	            <div class="Left BR" style="width: 200px">
	                &nbsp;权限类型：
	            </div>
	            <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
	                <asp:RadioButtonList ID="Types" RepeatDirection="horizontal" RepeatLayout="flow" runat="server"><asp:ListItem Value="0" Text="采用默认设置" /><asp:ListItem Value="1" Text="采用自定义设置" /></asp:RadioButtonList>
	            </div>
	        </div>
			</asp:PlaceHolder>
	        <div class="BT Hidden LH25" style="width:100%">
	            <div class="Left BR" style="width: 200px">
	                &nbsp;基本权限：
	            </div>
	            <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
		            <input name="Rights" type="checkbox" value="4" />查看贴子列表&nbsp;
		            <input name="Rights" type="checkbox" value="5" />查看贴子内容 
		            <input name="Rights" type="checkbox" value="10" />允许查看屏蔽贴
		            <input name="Rights" type="checkbox" value="11" />直接查看金币贴<br />
		            <input name="Rights" type="checkbox" value="12" />直接查看权限贴<input name="Rights" type="checkbox" value="13" />直接查看回复可见贴
		        </div>
	        </div>
	        <div class="BT Hidden LH25" style="width:100%">
	            <div class="Left BR" style="width: 200px">
	                &nbsp;发帖/回复权限：
	            </div>
	            <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
		            <input name="Rights" type="checkbox" value="16" />发表普通帖
		            <input name="Rights" type="checkbox" value="17" />发表投票帖
		            <input name="Rights" type="checkbox" value="18" />发表权限贴
		            <input name="Rights" type="checkbox" value="19" />发表颜色标题贴<br />
		            <input name="Rights" type="checkbox" value="20" />发表回复可见贴
		            <input name="Rights" type="checkbox"value="21" />发表金币购买帖
		            <input name="Rights" type="checkbox"value="22" />发表HTML标题贴
		            <input name="Rights" type="checkbox"value="23" />发表问答帖<br />
		            <input name="Rights" type="checkbox" value="24" />回复普通帖
		            <input name="Rights" type="checkbox" value="25" />回复投票帖
		            <input name="Rights" type="checkbox" value="26" />回复权限帖
		            <input name="Rights" type="checkbox" value="27" />回复颜色标题帖<br />
		            <input name="Rights" type="checkbox" value="28" />回复金币购买帖
		            <input name="Rights" type="checkbox" value="29" />回复HTML标题帖&nbsp;<br />
		            <input name="Rights" type="checkbox" value="30"/>在锁定版面发贴
		            <input name="Rights" type="checkbox" value="31" />在锁定版面回复
		            <input name="Rights" type="checkbox" value="32" />在锁定主题回复<br />
		            <input name="Rights" type="checkbox" value="33"/>可编辑自己发表的主题,<asp:TextBox ID="EditSelfTopicDay" Text="10" runat="server" Width="36px" />天内可操作<br />
		            <input name="Rights" type="checkbox" value="34"/>可删除自己发表的主题,<asp:TextBox ID="DeleteSelfTopicDay" Text="10" runat="server" Width="36px" />天内可操作<br />
		            <input name="Rights" type="checkbox" value="35"/>可编辑自己发表的回复,<asp:TextBox ID="EditSelfReplyDay" Text="10" runat="server" Width="36px" />天内可操作<br />
		            <input name="Rights" type="checkbox" value="36"/>可删除自己发表的回复,<asp:TextBox ID="DeleteSelfReplyDay" Text="10" runat="server" Width="36px" />天内可操作
		        </div>
	        </div>
	        <div class="BT Hidden LH25" style="width:100%">
	            <div class="Left BR" style="width: 200px">
	                &nbsp;上传/下载权限：
	            </div>
	            <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
		            <input name="Rights" type="checkbox" value="37" />允许下载附件<br />
			        <input name="Rights" type="checkbox" value="38" />允许上传头像，最大体积
		            <asp:TextBox ID="UploadFaceSize" Text="300" runat="server" Width="36px" />KB.<br />
		            <input name="Rights" type="checkbox" value="39" />允许上传附件，最大体积&nbsp;<asp:TextBox ID="UploadSize" Text="300" runat="server" Width="36px" />KB. 每天最多&nbsp;<asp:TextBox ID="UploadNum" Text="10" runat="server" Width="36px" />个
		        </div>
	        </div>
	        <div class="BT Hidden LH25" style="width:100%">
	            <div class="Left BR" style="width: 200px">
	                &nbsp; 前台管理权限：<br />(版主类型等级只对所管理的版面有效,其他等级对所有帖子有效)
	            </div>
	            <div class="Left BL" style="padding-left: 5px;margin-left:-1px">
			        <input name="Rights" type="checkbox" value="40" />编辑主题
		            <input name="Rights" type="checkbox" value="41" />删除主题
		            <input name="Rights" type="checkbox" value="42" />编辑回复
		            <input name="Rights" type="checkbox" value="43" />删除回复<br />
		            <input name="Rights" type="checkbox" value="44" />移动主题
		            <input name="Rights" type="checkbox" value="45" />加精主题
		            <input name="Rights" type="checkbox" value="46" />解精主题
		            <input name="Rights" type="checkbox" value="47" />锁定主题<br />
		            <input name="Rights" type="checkbox" value="48" />解锁主题
		            <input name="Rights" type="checkbox" value="49" />屏蔽主题
		            <input name="Rights" type="checkbox" value="50" />解屏主题
		            <input name="Rights" type="checkbox" value="51" />屏蔽回复<br />
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
		            <input name="Rights" type="checkbox" value="63" />批量屏蔽<br />
		            <input name="Rights" type="checkbox" value="64" />批量解屏
		            <input name="Rights" type="checkbox" value="65" />批量移动
		            <input name="Rights" type="checkbox" value="66" />批量删除
		            <input name="Rights" type="checkbox" value="67" />设置问题帖最佳答案
		        </div>
	        </div>
            <div class="Footer BT P5 TC Hidden">
                <asp:Button CssClass="Button" ID="SubmitButton" Text="确定提交" runat="server" /> <input name="All" type="checkbox" onclick="SelectAll(this)" />全选/全不选
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