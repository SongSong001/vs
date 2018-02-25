<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SendMail.aspx.cs" Inherits="WC.WebUI.Mobile.Mails.SendMail" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%--<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>智能移动办公平台</title>
    <meta content="yes" name="apple-mobile-web-app-capable" />
    <meta content="index,follow" name="robots" />
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
    <link href="../Style/Mobile/pics/homescreen.gif" rel="apple-touch-icon" />
    <meta content="minimum-scale=1.0, width=device-width, maximum-scale=0.6667, user-scalable=no"
        name="viewport" />

    <link href="../Style/Mobile/css/Style.css" rel="stylesheet" media="screen" type="text/css" />
    <link href="../Style/Mobile/css/developer-style.css" rel="stylesheet" type="text/css" />

    <link href="../Style/Mobile/pics/startup.png" rel="apple-touch-startup-image" />
    <script type="text/javascript" src="/js/formV/datepicker/WdatePicker.js"></script> 
    <script type="text/javascript" src="/js/popup/popup.js"></script>
    <script type="text/javascript">
        var w = window.innerWidth * 0.95;
        function ShowIframe() {
            var users = document.getElementById("userlist");
            var pop = new Popup({ contentType: 1, scrollType: 'no', isReloadOnClose: false, width: w, height: 500 });
            pop.setContent("contentUrl", "/Mobile/Utils/SelectPeople_r.aspx");
            pop.setContent("title", "工作汇报 - 汇报领导选择");
            pop.build();
            pop.show();
        }

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

    <link rel="stylesheet" href="/KindEditor4/themes/default/default.css" />
	<link rel="stylesheet" href="/KindEditor4/plugins/code/prettify.css" />
	<script type="text/javascript" charset="utf-8" src="/KindEditor4/kindeditor.js"></script>
	<script type="text/javascript" charset="utf-8" src="/KindEditor4/lang/zh_CN.js"></script>
	<script type="text/javascript" charset="utf-8" src="/KindEditor4/plugins/code/prettify.js"></script>
	<script type="text/javascript">
	    KindEditor.ready(function (K) {
	        var editor1 = K.create('#Bodys', {
	            cssPath: '/KindEditor4/plugins/code/prettify.css',
	            resizeType: 1,
	            allowPreviewEmoticons: false,
	            items: [
				'fontsize', 'forecolor', 'bold',
				'justifyleft', 'justifycenter', 'justifyright',
				'emoticons', 'insertunorderedlist']

	        });
	        prettyPrint();
	    });
</script> 

</head>
<body>
    <form id="form1" runat="server" enctype="multipart/form-data">
    <div id="topbar">
        <div id="title">
            发送新邮件</div>
        <div id="leftbutton">
            <a href="../Index.aspx" class="noeffect">主页</a>
        </div>
        <div id="rightnav">
            <a href="../LoginOut.aspx" class="noeffect" onclick="return confirm('您确实要安全退出吗？')">注销</a>
        </div>
    </div>
    <div id="tributton">
        <div class="links">
            <a href="../Menu.aspx">功能菜单</a><a href="../Users/User_OnLine.aspx">在线用户</a><a href="MailMenu.aspx">上级菜单</a></div>
    </div>

    <div id="content">
        <fieldset>
            <span class="graytitle">* 邮件标题：</span>
            <ul class="pageitem">
                <li class="bigfield">
                    <input runat=server name="Subject" type="text" id="Subject" placeholder="汇报标题 (不能为空)" style="width:100%;" />
                </li>
            </ul>
            <span class="graytitle">* 收件人： </span>
            <ul class="pageitem">
                <li class="textbox">
                    <input runat=server type=hidden id=userlist name=userlist value="" />
                    <textarea runat=server type=text id=namelist name=namelist readonly=readonly placeholder="接收人 (不能为空)" rows=3 style="width:100%;"></textarea>
                </li>
                <li class="button" style="text-align: center;">
                <input type=button id=bt8 name=bt8 onclick=ShowIframe() value=' 选择人员 ' /></li>
            </ul>

            <span class="graytitle">* 邮件内容：</span>
            <ul class="pageitem">
                <li class="textbox">
                    <textarea runat="server" name="Bodys" id="Bodys" placeholder="内容 (不能为空)" rows="15" style="width:100%;"></textarea>
                </li>
            </ul>

            <span class="graytitle">添加附件：</span>
            <ul class="pageitem">
                <li class="textbox">
		        <span style="font-weight:bold;"><a href="javascript:fAddAttach();" id="aAddAttach">添加附件</a></span>
                </li>
                <li class="textbox">
                <div runat=server id="dvReadAttach" style="float:left;"></div>
                </li>
            </ul>

            <asp:PlaceHolder ID="Attachwords" runat="server" Visible="false">
            <span class="graytitle">已添加附件：</span>
             <ul class="pageitem">
             
                <li class="textbox">
                <asp:Repeater runat=server ID=rpt><ItemTemplate>
                 <div style="text-align:left; float:left;">
		<input runat=server id=chk type="checkbox" checked=checked value=<%#Eval("Tmp1") %> />
		<%#Eval("Tmp2") %> &nbsp;&nbsp;&nbsp;&nbsp;<a href='/Manage/Utils/Download.aspx?destFileName=<%# Server.UrlEncode(Eval("Tmp3")+"") %>' ><img src='/img/mail_attachment.gif' />下载附件</a>   
        <br></ItemTemplate></asp:Repeater>
                </li>
            </ul>
            </asp:PlaceHolder>

            <span class="graytitle">确定发送：</span>
            <ul class="pageitem">
                <li class="button" style="text-align: center;">
                    <asp:Button ID="bt5" runat="server" OnClientClick='javascript:return confirm("您确定发送吗?")' Text="确定发送" OnClick="Save_Btn" />
                </li>
            </ul>

            <span class="graytitle" style=' display:none'>存为草稿：</span>
            <ul class="pageitem" style=' display:none'>
                <li class="button" style="text-align: center;">
                    <asp:Button ID="Button1" runat="server" OnClientClick='javascript:return confirm("您确定放到草稿箱吗?")' Text="存为草稿" OnClick="Caogao_Btn" />
                </li>
            </ul>

        </fieldset>
    </div>
    </form>
</body>
</html>--%>

<html>
<head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <title>智能移动办公平台-发送新邮件</title>
    <meta name="keywords" content="" />
    <meta name="description" content="" />
    <meta name="format-detection" content="telephone=no" />
    <meta name="format-detection" content="email=no" />
    <meta name="format-detection" content="address=no" />
    <meta name="format-detection" content="date=no" />
    <link href="../css/index.css" rel="stylesheet" />
    <script type="text/javascript" src="../js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="http://lvfaoa.haipop.com/KindEditor4/kindeditor.js"></script>
    <script type="text/javascript" src="/js/popup/popup.js"></script>
    <script type="text/javascript">
        var w = window.innerWidth * 0.95;
        function ShowIframe() {
            var users = document.getElementById("userlist");
            var pop = new Popup({ contentType: 1, scrollType: 'no', isReloadOnClose: false, width: w, height: 500 });
            pop.setContent("contentUrl", "/Mobile/Utils/SelectPeople_r.aspx");
            pop.setContent("title", "工作汇报 - 汇报领导选择");
            pop.build();
            pop.show();
        }

        function fAddAttach() {
           
            var gAttchHTML = '<input placeholder="添加附件" type="file" count="123" name="attachfile" class="file"><input name="Submit" value="删除" onclick="fDeleteAttach(this)" class="delete" type="button">';
    
            var Attach = $("#dvReadAttach");
  
            var spnList = $("[count='123']"); 
            var spn = document.createElement("li");
            spn.innerHTML = gAttchHTML;
            spn.name = "attachfile[]" + spnList.length;
            Attach.after(spn); //增加gAttchHTML
 
            Attach.find("a").html("继续添加附件");
            Attach.style.display = "";
        }

   
        function fDeleteAttach(obj) {
  
            $(obj).parent().remove();
            var spnList = $("[count='123']");
            if (spnList.length == 0) {

                $("#dvReadAttach").find("a").html("添加附件");
            }
            else {
        
                $("#dvReadAttach").find("a").html("继续添加附件");
            }
        }
        
    </script>

    <link rel="stylesheet" href="/KindEditor4/themes/default/default.css" />
    <link rel="stylesheet" href="/KindEditor4/plugins/code/prettify.css" />
    <script type="text/javascript" charset="utf-8" src="/KindEditor4/kindeditor.js"></script>
    <script type="text/javascript" charset="utf-8" src="/KindEditor4/lang/zh_CN.js"></script>
    <script type="text/javascript" charset="utf-8" src="/KindEditor4/plugins/code/prettify.js"></script>
    <script type="text/javascript">
        KindEditor.ready(function (K) {
            var editor1 = K.create('#Bodys', {
                cssPath: '/KindEditor4/plugins/code/prettify.css',
                resizeType: 1,
                allowPreviewEmoticons: false,
                items: [
				'fontsize', 'forecolor', 'bold',
				'justifyleft', 'justifycenter', 'justifyright',
				'emoticons', 'insertunorderedlist']

            });
            prettyPrint();
        });
    </script>
</head>
<body>
    <form id="form1" runat="server" enctype="multipart/form-data">
        <div class="head">
            <a href="../Index.aspx" class="prev"><i class="icon"></i></a>
            <div class="head_bt">智能移动办公平台</div>
            <a href="../LoginOut.aspx" onclick="return confirm('您确实要安全退出吗？')" class="close"><i class="icon"></i></a>
        </div>
        <div class="daohang">
            <ul>
                <li><a href="../Menu.aspx">功能菜单</a></li>
                <li><a href="../Users/User_OnLine.aspx">在线用户</a></li>
                <li><a href="MailList.aspx">上级菜单</a></li>
            </ul>
        </div>
        <div class="list">
            <ul>
                <li>
                    <h4>邮件标题</h4>
                </li>
                <li>
                    <input runat="server" name="Subject" type="text" id="Subject" placeholder="汇报标题 (不能为空)" />
                </li>
                <li>
                    <h4>收件人</h4>
                </li>
                <li>
                    <input runat="server" type="hidden" id="userlist" name="userlist" value="" />
                    <textarea runat="server" type="text" id="namelist" name="namelist" readonly="readonly" placeholder="接收人 (不能为空)" rows="3"></textarea>
                </li>
                <li><a href="javascript:;" id='bt8' name='bt8' onclick='ShowIframe()' class="people">选择人员</a></li>
            </ul>
        </div>
        <div class="list">
            <ul>
                <li>
                    <h4>邮件内容</h4>
                </li>
            </ul>
            <div class="ina_edit">
                <textarea runat="server" name="Bodys" id="Bodys" placeholder="内容 (不能为空)" rows="15" style="width: 100%; height: 190px"></textarea>
            </div>
        </div>
        <div class="list">
            <ul>
                <li id="dvReadAttach" ><a onclick="fAddAttach();">添加附件</a> 
                 
                </li>

                <asp:PlaceHolder ID="Attachwords" runat="server" Visible="false">
                    <span class="graytitle">已添加附件：</span>
                    <ul class="pageitem">

                        <li class="textbox">
                            <asp:Repeater runat="server" ID="rpt">
                                <ItemTemplate>
                                    <div style="text-align: left; float: left;">
                                        <input runat="server" id="chk" type="checkbox" checked="checked" value='<%#Eval("Tmp1") %>' />
                                        <%#Eval("Tmp2") %> &nbsp;&nbsp;&nbsp;&nbsp;<a href='/Manage/Utils/Download.aspx?destFileName=<%# Server.UrlEncode(Eval("Tmp3")+"") %>'><img src='/img/mail_attachment.gif' />下载附件</a>
                                        <br>
                                </ItemTemplate>
                            </asp:Repeater>
                        </li>
                    </ul>
                </asp:PlaceHolder>
       
            </ul>
        </div>
        <div class="fixed">  <asp:Button ID="bt5" OnClientClick='javascript:return confirm("您确定吗?")' runat="server" Text="确定发送" OnClick="Save_Btn" /></div>
    </form>

    <script type="text/javascript">
        if ($(".fixed").length > 0) {
            $(".list").last().css({ paddingBottom: $(".fixed").outerHeight() })
        }
    </script>
</body>
</html>
