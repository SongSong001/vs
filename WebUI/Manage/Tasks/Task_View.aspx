<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Task_View.aspx.cs" Inherits="WC.WebUI.Manage.Tasks.Task_View" EnableViewState="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>查看任务</title>
    <script type="text/javascript" src="/js/validator.js"></script>
<link type="text/css" href="/manage/Style/InterFace.Css" rel="stylesheet" rev="stylesheet" media="all" />
<link type="text/css" href="/manage/style.css" rel="stylesheet" rev="stylesheet" media="all" />
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/manage/include/common.js"></script>
    <link rel="stylesheet" href="/KindEditor4/themes/default/default.css" />
	<link rel="stylesheet" href="/KindEditor4/plugins/code/prettify.css" />
	<script type="text/javascript" charset="utf-8" src="/KindEditor4/kindeditor.js"></script>
	<script type="text/javascript" charset="utf-8" src="/KindEditor4/lang/zh_CN.js"></script>
	<script type="text/javascript" charset="utf-8" src="/KindEditor4/plugins/code/prettify.js"></script>

<script type="text/javascript" src="/js/popup/popup.js"></script>
<script type="text/javascript">
    function depView(ud) {
        var pop = new Popup({ contentType: 1, scrollType: 'yes', isReloadOnClose: false, width: 650, height: 485 });
        pop.setContent("contentUrl", '/manage/Tasks/FeedBack_View.aspx?tuid=' + ud);
        pop.setContent("title", "任务执行详情");
        pop.build();
        pop.show();
    }
</script> 
<asp:Panel runat=server ID=display1 Visible=false>     
<script type="text/javascript">
    KindEditor.ready(function (K) {
        var editor1 = K.create('#Bodys', {
            cssPath: '/KindEditor4/plugins/code/prettify.css',
            uploadJson: '/KindEditor4/upload_json.aspx',
            fileManagerJson: '/KindEditor4/file_manager_json.aspx'
        });
        prettyPrint();
    });
</script>
</asp:Panel> 
    <script type="text/javascript">
        function fAddAttach() {
            var gAttchHTML = '<div><input type="file" name="attachfile"><input type="button" name="Submit" value=" 删除 " id="btnDeleteReadAttach" /></div><span></span>';
            var Attach = document.getElementById("dvReadAttach");
            var spnList = Attach.getElementsByTagName("SPAN");
            var spn = document.createElement("DIV");
            spn.innerHTML = gAttchHTML;
            spn.childNodes[0].name = "attachfile[]" + spnList.length;
            Attach.appendChild(spn); //增加gAttchHTML
            fGetObjInputById(spn, "btnDeleteReadAttach").onclick = function () { fDeleteAttach(this); };
            document.getElementById("aAddAttach").innerHTML = "继续添加附件";
            Attach.style.display = "";
        }

        function fGetObjInputById(obj, id) {
            var inputList = obj.getElementsByTagName("INPUT");
            for (var i = 0; i < inputList.length; i++) {
                if (inputList[i].id == id) {
                    return inputList[i];
                }
            }
            return null;
        }

        function fDeleteAttach(obj) {
            obj.parentNode.parentNode.parentNode.removeChild(obj.parentNode.parentNode);
            var Attach = document.getElementById("dvReadAttach");
            var spnList = Attach.getElementsByTagName("SPAN");
            if (spnList.length == 0) {
                document.getElementById("aAddAttach").innerHTML = "添加附件";
                Attach.style.display = "none";
            }
            else {
                document.getElementById("aAddAttach").innerHTML = "继续添加附件";
            }
        }
</script> 
</head>
<body >
    <form id="form1" runat="server" enctype="multipart/form-data">
<div id="interface_inside">
  <div id="interface_quick">
    <div class="interface_quick_left">您现在的操作 >> 查看任务</div>
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
	  <a href="Task_List.aspx?type=all"> 所有参与任务( <span id=t_all runat=server style="font-weight:bold;">0</span> ) </a>
	  <a href="Task_List.aspx?type=exeute"> 我执行的任务( <span id=t_exeute runat=server style="font-weight:bold;color:#ff0000; ">0</span> ) </a>
	  <a href="Task_List.aspx?type=manage"> 我管理的任务( <span id=t_manage runat=server style="font-weight:bold;color:#ff0000; ">0</span> ) </a>
	  <a href="Task_List.aspx?type=create"> 我创建的任务( <span id=t_create runat=server style="font-weight:bold;">0</span> ) </a>
	  <a href="Task_Manage.aspx">新建工作任务</a>
	  </td>
	  <td style="text-align:right">

	  </td>
	</tr>
  </thead>
</table>
<br /> 
 
<table class="table">
	<thead>
	<tr>
		<td style="width:10px;"></td>
		<td><span style="color:#ff0000;font-size:12pt; font-weight:bolder;" id=Subject runat=server></span></td>
	</tr>
	</thead>
	<tr>
		<th style="width:10px;"></th>
		<td style="color:#000">
		<span style="color:#006600; font-weight:bold;">任务状态：</span>&nbsp;<span style="color:#000; font-weight:bold;" runat=server id=status></span> &nbsp;&nbsp; &nbsp;&nbsp;
		<span style="color:#006600; font-weight:bold;">创建人员：</span>&nbsp;<span style="color:#000; " runat=server id=Creator></span> &nbsp;&nbsp; &nbsp;&nbsp;
		<span style="color:#006600; font-weight:bold;">任务分类：</span>&nbsp;<span style="color:#000; " runat=server id=TypeName></span> &nbsp;&nbsp; &nbsp;&nbsp;
		<span style="color:#006600; font-weight:bold;">流水编号：</span>&nbsp;<span style="color:#000; " runat=server id=TaskNO></span><br>
        <span style="color:#006600; font-weight:bold;">更新时间：</span>&nbsp;<span style="color:#000; " runat=server id=UpdateTime></span> &nbsp;&nbsp; &nbsp;&nbsp;
        <span style="color:#006600; font-weight:bold;">创建时间：</span>&nbsp;<span style="color:#000; " runat=server id=AddTime></span> &nbsp;&nbsp; &nbsp;&nbsp;
		<span style="color:#006600; font-weight:bold;">期待完成时间：</span>&nbsp;<span style="color:#000; " runat=server id=ExpectTime></span><br>
		<span style="color:#006600; font-weight:bold;">任务级别：</span>&nbsp;<span style="color:#000; font-weight:bold;" runat=server id=Important></span> &nbsp;&nbsp; &nbsp;&nbsp;
		<span style="color:#006600; font-weight:bold;">管理人员：</span>&nbsp;<span style="color:#000; " runat=server id=ManageNameList></span>
		</td>
	</tr>
	
	<tr>
		<th style="width:10px;"></th>
		<td><span style="font-weight:bold; color:#006600;">任务内容</span>：
        <div runat=server id=bodys1 style="min-height:100px;_height:100px;margin:8px 8px 8px 1px; border:1px solid #E3E197; padding:10px 10px 10px 10px; background-color: #FFFFDD;"></div>
				<%=this.fjs %>
		</td>
	</tr>	
	

<tr>
	<td style="width:10px;"></td>
	<td colspan="2" class="manage">
    <a href='Task_Records.aspx?tid=<%=Request.QueryString["tid"] %>' target=_blank>任务操作日志</a> 
    <a href='Task_PrintView.aspx?tid=<%=Request.QueryString["tid"] %>' target=_blank>打印工作任务</a>
    </td>
</tr>
</table>   
<div id=feedbacks>
<table class="table1">
<thead>
	<tr>
		
		<td width="70"><span style="margin-left:25px;">序</span></td>
			<td>执行情况标题</td>
			<td width="175">执行人</td>	
            <td width="125">操作时间</td>	
            <td width="90">执行状态</td>	
		  <td width="90">操作</td>	
	</tr>
</thead>

<asp:Repeater runat=server ID=rpt OnItemDataBound=RowDataBind><ItemTemplate>
<tr>
<td><span style="margin-left:25px;"><%# Container.ItemIndex+1 %></span></td>
<td>
<asp:Panel runat=server ID=pa1 Visible=false>
<%# "<strong>" + Eval("WorkTitle") + "</strong>"%>
</asp:Panel><asp:Label runat=server ID=lab1 Visible=false></asp:Label>
</td>
<td><strong style='color:#006600'><%# Eval("RealName") + "(" + Eval("DepName") + ")"%></strong></td>
<td>
<%#Eval("AddTime")%>
</td>
<td><%# GetWorkTag(Eval("WorkTag"))%></td>
<td class="manage">
<asp:LinkButton runat=server ID=lb CommandArgument=<%# Eval("WorkTag") + "," + Eval("UserID")%> Visible=false class="show">测试</asp:LinkButton>
<asp:Panel runat=server ID=pa Visible=false>
<a href='#@' onclick='depView(<%#Eval("id") %>)' class="show">查看详情</a>
</asp:Panel>
</tr>
</ItemTemplate></asp:Repeater>

</table>
</div>
<br /><br />

<asp:Panel runat=server ID=display Visible=false>
<table class="table1" runat=server visible=false id=exetable>
<tr>
	<th style="width:10px;"></th>
	<td>
	<span style="color:#000; font-weight:bold;">*任务执行标题：</span><br>
<input runat=server style='width:74%;' dataType="Require" msg="任务执行标题不能为空!" maxlength=120 name="WorkTitle" type="text" id="WorkTitle" />
	</td>
</tr>
<tr>
	<th style="width:10px;"></th>
	<td>
	<span style="color:#000; font-weight:bold;">任务执行详情：</span><br>
	<textarea id="Bodys" name="Bodys" style="width:80%;height:200px;visibility:hidden;" runat="server" enableviewstate=false></textarea>
	</td>
</tr>
<tr>
	<th style="width:10px;"></th>
	<td><span style="color:#000; font-weight:bold;">我要添加附件：</span>
	&nbsp;&nbsp;<span style="font-weight:bold;"><a href="javascript:fAddAttach();" id="aAddAttach">点击添加附件</a></span>
	<br />
	<div runat=server id="dvReadAttach" style="float:left;"></div>	  
    <br />      
	</td>
</tr>
</table>
    
  <br />
<div style="text-align:center;">
    <asp:Button runat=server id=s1 OnClick=Submit_Btn CssClass="textbutton" Text=' 提交执行情况 ' OnClientClick="return Validator.Validate(this.form,1)" Visible=false /> &nbsp;&nbsp;
    <asp:Button runat=server id=s2 OnClick=Accept_Btn CssClass="textbutton" Text=' 我要接收任务 ' OnClientClick="return confirm('您确定要接收该任务吗？')" Visible=false /> &nbsp;&nbsp; 
	<asp:Button runat=server id=b1 OnClick=ReStart_Btn CssClass="textbutton" Text=' 启动任务 ' OnClientClick="return confirm('您确实要将任务状态启动码？')" Visible=false /> &nbsp;&nbsp; 
	<asp:Button runat=server ID=b2 OnClick=Stop_Btn CssClass="textbutton" Text=' 停止任务 ' OnClientClick="return confirm('您确实要停止任务吗？')" Visible=false /> &nbsp;&nbsp;
	<asp:Button runat=server ID=b3 OnClick=Complete_Btn CssClass="textbutton" Text=' 完成任务 ' OnClientClick="return confirm('您确实要完成任务吗？')" Visible=false /> &nbsp;&nbsp;  
	&nbsp;&nbsp; 
</div>   
</asp:Panel>    
<br />
              </div></div></div>
              
            </td>
          </tr>



        </table>

      <!-- 模块 -->

    </div>
  </div>
</div>
    </form>
</body>
</html>
