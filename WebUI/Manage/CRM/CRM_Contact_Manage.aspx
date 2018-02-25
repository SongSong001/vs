<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CRM_Contact_Manage.aspx.cs" Inherits="WC.WebUI.Manage.CRM.CRM_Contact_Manage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>客户编辑</title>
<script type="text/javascript" src="/js/validator.js"></script>
<link type="text/css" href="/manage/Style/InterFace.Css" rel="stylesheet" rev="stylesheet" media="all" />
<link type="text/css" href="/manage/style.css" rel="stylesheet" rev="stylesheet" media="all" />
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/manage/include/common.js"></script>

<script type="text/javascript" src="/js/formV/datepicker/WdatePicker.js"></script>

</head>
<body >
    <form id="form1" runat="server" onsubmit="return Validator.Validate(this.form,1);" enctype="multipart/form-data">
<div id="interface_inside">
  <div id="interface_quick">
    <div class="interface_quick_left">您现在的操作 >> 我的客户 >> 客户接触编辑</div>
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
<a href="/Manage/crm/CRM_List.aspx?action=mycrm">我的客户列表</a>
<a href='/Manage/crm/CRM_View.aspx?cid=<%=c %>' >客户资料</a>
<a href="/Manage/crm/CRM_Contact_List.aspx?cid=<%=c %>">接触列表</a>
<a href="/Manage/crm/CRM_Contact_Manage.aspx?cid=<%=c %>">添加接触</a>
	  </td>
	  <td style="text-align:right">

	  </td>
	</tr>
  </thead>
</table>
<br />  

<table class="table1">
<thead>
<tr>
	<td><a href="#" class="helpall">[?]</a></td>
	<td>
		<asp:Button runat=server class="button" ID=Button1 Text='保存' OnClick=Save_Btn OnClientClick="return Validator.Validate(this.form,1);" />
	&nbsp;&nbsp;<input type="reset" class="button" value='重置' />
	</td>
</tr>
</thead>
<tr>
	<th style="width:145px; font-weight:bold;">&nbsp;客户名称：<a href="#" class="help">[?]</a></th>
	<td><span class="note">客户名称.</span> &nbsp;
	<span id=CRM_Name1 runat=server style="font-weight:bold; color:Red"></span>
	</td>
</tr>
<tr>
	<th style="width:145px; font-weight:bold;">&nbsp;* 接触主题：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请输入 接触主题.</span>
	<input runat=server name="ContactAim" dataType="Require" msg="接触主题不能为空" type="text" value="" id="ContactAim" maxlength=90 size=97 /></td>
</tr>

<tr>
	<th style="width:145px; font-weight:bold;">&nbsp;参与人员：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请 输入 我方参与人员.</span>
	<input runat=server name="ContactPeople" type="text" id="ContactPeople" size=45 />
	</td>
</tr>

<tr>
	<th style="width:145px; font-weight:bold;">&nbsp;接触时间：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请点击在选择框中选取 接触的时间.</span>
	<input runat=server name="AddTime" type="text" id="AddTime" size=45 class="Wdate"   readonly onClick="WdatePicker()" />
	</td>
</tr>

<tr>
	<th style="width:145px; font-weight:bold;">&nbsp;发生费用：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请输入 发生费用(人民币 数字).</span>
	<input runat=server name="ContactCharge" type="text" value="" id="ContactCharge" size=45 /> 元
	</td>
</tr>

<tr>
	<th style="width:145px; font-weight:bold;">&nbsp;费用用途：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请选择 发生费用的用途.</span>
        <asp:CheckBoxList ID="ContactChargeType" runat="server" RepeatDirection=Horizontal>
        <asp:ListItem Text='差旅' Value='差旅;'></asp:ListItem>
        <asp:ListItem Text='餐饮' Value='餐饮;'></asp:ListItem>
        <asp:ListItem Text='礼品' Value='礼品;'></asp:ListItem>
        <asp:ListItem Text='公关' Value='公关;'></asp:ListItem>
        <asp:ListItem Text='其他用途' Value='其他用途;'></asp:ListItem>
        </asp:CheckBoxList>
	
	</td>
</tr>

<tr>
	<th style="width:145px; font-weight:bold;">&nbsp;接触方式：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请选择 接触方式.</span>
        <asp:CheckBoxList ID="ContactType" runat="server" RepeatDirection=Horizontal>
        <asp:ListItem Text='走访' Value='走访;'></asp:ListItem>
        <asp:ListItem Text='来访' Value='来访;'></asp:ListItem>
        <asp:ListItem Text='电话' Value='电话;'></asp:ListItem>
        <asp:ListItem Text='传真' Value='传真;'></asp:ListItem>
        <asp:ListItem Text='邮件' Value='邮件;'></asp:ListItem>
        <asp:ListItem Text='信函' Value='信函;'></asp:ListItem>
        <asp:ListItem Text='会议' Value='会议;'></asp:ListItem>
        <asp:ListItem Text='网络' Value='网络;'></asp:ListItem>
        <asp:ListItem Text='其他活动' Value='其他活动;'></asp:ListItem>
        </asp:CheckBoxList>
	</td>
</tr>


<tr>
	<th style="width:145px; font-weight:bold;">&nbsp;* 接触状态：<a href="#" class="help">[?]</a></th>
	<td><span class="note">请选择 该次客户接触的状态.</span>
    <asp:DropDownList runat=server ID=ContactState>
    <asp:ListItem Text='客户关系维护' Value='客户关系维护'></asp:ListItem>
    <asp:ListItem Text='跟踪' Value='跟踪'></asp:ListItem>
    <asp:ListItem Text='产品推荐' Value='产品推荐'></asp:ListItem>
    <asp:ListItem Text='启动' Value='启动'></asp:ListItem>
    <asp:ListItem Text='需求定义' Value='需求定义'></asp:ListItem>
    <asp:ListItem Text='方案提交' Value='方案提交'></asp:ListItem>
    <asp:ListItem Text='商务谈判' Value='商务谈判'></asp:ListItem>
    <asp:ListItem Text='项目实施' Value='项目实施'></asp:ListItem>
    <asp:ListItem Text='跟进服务' Value='跟进服务'></asp:ListItem>
    <asp:ListItem Text='收尾款' Value='收尾款'></asp:ListItem>
    <asp:ListItem Text='售后服务' Value='售后服务'></asp:ListItem>
    <asp:ListItem Text='其他' Value='其他'></asp:ListItem>
    </asp:DropDownList>
	</td>
</tr>

<tr>
	<th style="width:145px; font-weight:bold;">接触内容&nbsp;<a href="#" class="help">[?]</a></th>
	<td>
	<span class="note">请输入 该次接触内容详情. </span>
	<textarea runat=server style="BACKGROUND-IMAGE: url(/img/line.gif); LINE-HEIGHT: 22px; padding-left:3px; background-repeat:repeat;" name=ContactDetail id=ContactDetail rows=4 cols=83></textarea>
	</td>
</tr>


<tr>
	<th>&nbsp;</th>
	<td>
	<asp:Button runat=server class="button" ID=save_bt Text='保存' OnClick=Save_Btn OnClientClick="return Validator.Validate(this.form,1);" />
	&nbsp;&nbsp;<input type="reset" class="button" value='重置' />
</td>
</tr>

</table>

    
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