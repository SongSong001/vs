<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Gov_ModelManage.aspx.cs" Inherits="WC.WebUI.Manage.Gov.Gov_ModelManage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>编辑公文流程模型</title>
<script type="text/javascript" src="/js/validator.js"></script>
<link type="text/css" href="/manage/Style/InterFace.Css" rel="stylesheet" rev="stylesheet" media="all" />
<link type="text/css" href="/manage/style.css" rel="stylesheet" rev="stylesheet" media="all" />
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/manage/include/common.js"></script>

<script type="text/javascript">
function keyDown()
{
var keycode=event.keyCode;
var keyChar=String.fromCharCode(keycode);
if(event.keyCode==13 && event.srcElement.type!='button' && event.srcElement.type!='submit' && event.srcElement.type!='reset' && event.srcElement.type!=''&& event.srcElement.type!='textarea')
{
event.keyCode=9;
}
};
document.onkeydown=keyDown;
</script>

<script type="text/javascript" src="/js/popup/popup.js"></script>
<script type="text/javascript">
	    function ShowIframe()
		{
		    var users = document.getElementById("userlist");
            var pop=new Popup({ contentType:1,scrollType:'no',isReloadOnClose:false,width:468,height:395});
            pop.setContent("contentUrl","/Manage/Utils/SelectPeople.aspx");
            pop.setContent("title","公文模型 - 审批人员选择");
            pop.build();
            pop.show();
        }             
            
        function ShowIframe_dep()
		{
		    var users = document.getElementById("userlist_dep");
            var pop=new Popup({ contentType:1,scrollType:'yes',isReloadOnClose:false,width:468,height:395});
            if(users.value=="")
            {
            pop.setContent("contentUrl","/Manage/Utils/SelectDep.aspx");
            }
            else
            {
                var ids="";
                var objs = users.value.split(',');
                for(var i=0;i<objs.length;i++)
                {
                    if(objs[i].replace(/^\s*(.*?)[\s\n]*$/g, '$1')!="")
                    {
                        ids += objs[i].split('#')[1]+";";
                    }
                }
                
                pop.setContent("contentUrl","/Manage/Utils/SelectDep.aspx?v="+ids);
            }
            pop.setContent("title","公文模型 - 审批职能部门选择");
            pop.build();
            pop.show();
        } 
        
        function ShowIframe_deps()
		{
		    var users = document.getElementById("userlist_deps");
            var pop=new Popup({ contentType:1,scrollType:'yes',isReloadOnClose:false,width:468,height:395});
            if(users.value=="")
            {
            pop.setContent("contentUrl","/Manage/Utils/SelectDeps.aspx");
            }
            else
            {
                var ids="";
                var objs = users.value.split(',');
                for(var i=0;i<objs.length;i++)
                {
                    if(objs[i].replace(/^\s*(.*?)[\s\n]*$/g, '$1')!="")
                    {
                        ids += objs[i].split('#')[1]+";";
                    }
                }
                
                pop.setContent("contentUrl","/Manage/Utils/SelectDeps.aspx?v="+ids);
            }
            pop.setContent("title","公文模型 - 职能部门选择");
            pop.build();
            pop.show();
        }          
        
        function show()
        {
            var obj = '<%=showobj %>';
            
            if(obj == '0')
            {
                document.all.show1.style.display="";
                document.all.show2.style.display="none"
                document.all.step_type0.checked = true;
            }
            if(obj == '1')
            {
                document.all.show1.style.display="none";
                document.all.show2.style.display="";
                document.all.step_type1.checked = true;
            }
        }         
    </script>      
</head>
<body onload=show() onkeypress=keyDown() >
    <form id="form1" runat="server">
<div id="interface_inside">
  <div id="interface_quick">
    <div class="interface_quick_left">您现在的操作 >> 系统管理 >> 公文管理</div>
    <div class="interface_quick_right">
    <a href="javascript:void(0)" onclick="javascript:window.location.replace(window.location.href);"><img style="vertical-align:middle;" src="/manage/images/reload.png" /><strong>刷新</strong></a>
    &nbsp; &nbsp;
    <a href="javascript:history.back();"><img style="vertical-align:middle;" src="/manage/images/ico_up1.gif" /><strong>后退</strong></a>  
    </div>
    <div class="clearboth"></div>
  </div>
  <div id="interface_main">
    <div id="tabs_config" class="tabsbox">
      

      <div class="clearboth"></div>
      
      
      <!-- 模块 -->

        <table width="100%" border="0" cellspacing="0" cellpadding="0" >
          <tr>
            <td>
            
 <div id="config_basic1" class="tabs_wrapper">
<div class="tabs_main" align="left">  
<div id="PanelConfig">           

 <table class="table subsubmenu">
  <thead>
	<tr>
	  <td> 
	  <a href="Gov_ModelManage.aspx">新增公文模型</a>
	  </td>
	  <td style="text-align:right">
	  </td>
	</tr>
  </thead>
</table>
<br />

<asp:Panel runat=server ID=ModelName Visible=true>
<table class="table">
<thead>
<tr>
	<td colspan="2"><a href="#" class="helpall">[?]</a></td>
</tr>
</thead>
<tr>
	<th style="width:155px;"><strong>* 公文流程模型名称</strong>&nbsp;<a href="#" class="help">[?]</a></th>
	<td><span class="note">请输入公文流程模型名称 如：发展局秘书办发文通知 </span>
	<input runat=server name="Flow_Name" type="text" dataType="Require" msg="公文流程模型名称不能为空" id="Flow_Name" style="width:504px;" />
	</td>
</tr>
<tr>
	<th style="width:155px; font-weight:bold;">公文模型分类&nbsp;<a href="#" class="help">[?]</a></th>
	<td><span class="note">请选择模型所属的类别 </span>
	<asp:DropDownList runat=server ID=Model_Type style="width:515px;"></asp:DropDownList>
	</td>
</tr>
<tr>
	<th style="width:155px; font-weight:bold;">公文模板表单&nbsp;<a href="#" class="help">[?]</a></th>
	<td><span class="note">发文拟稿时 填写的模板文件表单 </span>
	<asp:DropDownList runat=server ID=ModelFileList style="width:515px;"></asp:DropDownList>
	</td>
</tr>
<tr>
	<th style="width:155px; font-weight:bold;">&nbsp;使用范围：<a href="#" class="help">[?]</a></th>
	<td><span class="note">该公文模型的 使用范围. (发文拟稿人的 所属部门)</span>
    &nbsp; <span style="color:#006600; font-weight:bold;">请在下方选择 该公文模型的使用范围。所有部门公用 请留空不填</span>
	</td>
</tr>
<tr id=tr runat=server >
	<th style="width:155px; font-weight:bold;">&nbsp;使用部门：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请选择 使用部门：点击右侧 [选择部门] 按钮, 所有部门公用请留空.</span>
	<input runat=server type=hidden id=userlist_deps name=userlist_deps value="" />
	<input runat=server size=81 name="namelist_deps" type="text" id="namelist_deps" readonly=readonly  />	
	<input type=button value=选择部门 class="textbutton" onclick=ShowIframe_deps() />
	</td>
</tr>
<tr>
	<th style="width:155px;">备注&nbsp;<a href="#" class="help">[?]</a></th>
	<td><span class="note">备注 补充说明</span>
	<textarea runat=server name=FlowRemark id=FlowRemark rows=3 cols=70></textarea>
	</td>
</tr>
</table>
</asp:Panel>

<asp:Panel runat=server ID=ModelStep Visible=false>
<table class="table">
<thead>
<tr>
	<td colspan="2"><a href="#" class="helpall">[?]</a></td>
</tr>
</thead>
<tr>
	<th style="width:155px;"><strong>公文流程模型名称</strong>&nbsp;</th>
	<td>&nbsp;
    <span runat=server id=StepNo style="font-weight:bold; color:#999999"></span> &nbsp;&nbsp;&nbsp;<asp:Label runat=server ID=This_FolwName></asp:Label>
	</td>
</tr>
<tr>
	<th style="width:155px;">* 步骤名称&nbsp;<a href="#" class="help">[?]</a></th>
	<td><span class="note">请输入步骤名称 </span>
<input runat=server name="Step_Name" dataType="Require" msg="步骤名称不能为空"  type="text" id="Step_Name" style="width:504px;" />
	</td>
</tr>
<tr>
	<th style="width:155px;">审批人员&nbsp;<a href="#" class="help">[?]</a></th>
	<td><span class="note">请选择 审批人员：点击右侧 [审批人]或[审批部门] 按钮 </span>
        <div>
&nbsp;&nbsp;按人员选择：<input type=radio id=step_type0 name='step_type' value=0 checked=true  onclick='javascript:document.all.show2.style.display="none";document.all.show1.style.display=""'' /> &nbsp;&nbsp;
按部门选择：<input type=radio id=step_type1 name='step_type' value=1 onclick='javascript:document.all.show1.style.display="none";document.all.show2.style.display=""'' />
    </div>
	
	<div id=show1 style="margin-top:6px;">
	<input runat=server type=hidden id=userlist name=userlist value="" />
	<input runat=server size=81 name="namelist" type="text" id="namelist" readonly=readonly  />
	<input type=button value=审批人 class="textbutton" onclick=ShowIframe() />
	</div>
	
	<div id=show2 style="display:none; margin-top:6px;">
	<input runat=server type=hidden id=userlist_dep name=userlist_dep value="" />
	<input runat=server size=71 name="namelist_dep" type="text" id="namelist_dep" readonly=readonly  />
	<input type=button value=审批部门 class="textbutton" onclick=ShowIframe_dep() />
	</div>
	</td>
</tr>
<tr>
	<th style="width:155px;">步骤选项&nbsp;<a href="#" class="help">[?]</a></th>
	<td><span class="note">步骤选项</span>
	&nbsp;&nbsp;自行选择人员 <input runat=server id="IsUserEdit" type="checkbox" checked=checked name="IsUserEdit" /> &nbsp;
	(说明：该流程的<strong> 发起人/创建者 </strong> 是否可以 自行选择 <strong> 该步骤的审批者 </strong> ) <br>	
	
	<asp:Panel runat=server ID=display1 Visible=false>
    &nbsp;&nbsp;是否编辑附件 <input runat=server id="IsUserFile" type="checkbox" name="IsUserFile" /> &nbsp;
	(说明：<strong>该步骤的审批者 </strong>是否可以 编辑(包括删除/上传)审核附件) <br></asp:Panel>
	
	&nbsp;&nbsp;是否强制签发 <input runat=server id="RightToFinish" type="checkbox" name="RightToFinish" /> &nbsp;
	(说明：<strong>该步骤的审批者 </strong>是否可以 强行签发公文) 
	<asp:Panel runat=server ID=display2 Visible=false>
	<br>
	&nbsp;&nbsp;邮件催办提醒 <input runat=server id="MailAlert" type="checkbox" name="MailAlert" /> &nbsp;
	(说明：<strong>该步骤的审批者 </strong>是否收到 邮件通知 催办完成 ) </asp:Panel>
	</td>
</tr>
<tr>
	<th style="width:155px;">步骤说明&nbsp;<a href="#" class="help">[?]</a></th>
	<td><span class="note">备注 补充说明</span>
	<textarea runat=server name=StepRemark id=StepRemark rows=3 cols=70></textarea>
	</td>
</tr>
</table>
</asp:Panel>
<br />

<table class="table">
<tr>
	<th style="width:155px;">已添加步骤&nbsp;(点击步骤编辑)</th>
	<td>
	<asp:Repeater runat=server ID=rpt>
	<ItemTemplate>&nbsp;&nbsp;
	<asp:Label runat=server ID=lab Text=<%# Eval("Tmp3") %> Visible=false></asp:Label>
	<asp:Label runat=server ID=labid Text=<%# Eval("Tmp4") %> Visible=false></asp:Label>
	<asp:Label runat=server ID=showdiv Text=<%# Eval("Tmp5") %> Visible=false></asp:Label>
	 <asp:LinkButton runat=server CommandArgument=<%# Eval("Tmp2") %> OnClick=Rpt_Edit ID=lb1><%# Eval("Tmp1") %></asp:LinkButton>&nbsp;&nbsp;
	 <asp:ImageButton runat=server CommandArgument=<%# Eval("Tmp2") %> OnClick=Rpt_Drop ID=img1 ImageUrl="~/img/delete.gif" OnClientClick="javascript:return confirm('确实要删除该步骤吗？')" />
	 <br />
	</ItemTemplate>
	</asp:Repeater>
	</td>
</tr>
</table>

<br />
<div style="text-align:center;">
	<asp:Button runat=server id=save1 OnClick=SaveStep_Btn OnClientClick="return Validator.Validate(this.form,3);" CssClass="buttoms" Text=' 确定保存 ' />&nbsp;&nbsp; 
	<asp:Button runat=server ID=add1 OnClick=AddStep_Btn CssClass="buttoms" Text=' 新建步骤 ' Enabled=false />&nbsp;&nbsp;
	<asp:Button runat=server id=finish1 OnClick=Finish_Btn CssClass="buttoms" Text=' 完成设计 ' OnClientClick="javascript:return confirm('确实要完成整个公文流程模型设计吗？')" />&nbsp;&nbsp; 
	<asp:Button runat=server id=cancer1 OnClick=Cancer_Btn CssClass="buttoms" Text=' 取消设计 ' OnClientClick="javascript:return confirm('取消设计将删除整个公文流程模型,确定吗？')" />&nbsp;&nbsp; 
</div>    
     
              </div></div>
            </div></td>
          </tr>
        </table>

      <!-- 模块 -->

    </div>
  </div>
</div>
    </form>
</body>
</html>
