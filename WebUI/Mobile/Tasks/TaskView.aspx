<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TaskView.aspx.cs" Inherits="WC.WebUI.Mobile.Tasks.TaskView" %>

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

    function check() {
        if (document.form1.Bodys.value == "") {
            alert("任务执行情况为空！");
            document.form1.Bodys.focus();
            return false;
        }
    }
    </script> 
</head>
<body>
    <form id="form1" runat="server" enctype="multipart/form-data">
    <div id="topbar">
        <div id="title">
            工作任务详情</div>
        <div id="leftbutton">
            <a href="../Index.aspx" class="noeffect">主页</a>
        </div>
        <div id="rightnav">
            <a href="../LoginOut.aspx" class="noeffect" onclick="return confirm('您确实要安全退出吗？')">注销</a>
        </div>
    </div>

    <div id="tributton">
        <div class="links">
            <a href="../Menu.aspx">功能菜单</a><a href="../Users/User_OnLine.aspx">在线用户</a><a href="TaskMenu.aspx">上级菜单</a></div>
    </div>

    <div id="content">
        <span class="graytitle">
            <span id="Label1">
            标题： 
            <span style='color:#ff0000' runat=server ID=Subject></span>
            </span>
        </span>

        <ul class="pageitem">
            <li class="textbox">
            <span class="header">任务状态：<span runat=server ID=status style=' color:#009900;'></span></span>
            <span class="header">创建人员：<span runat=server ID=Creator style=' color:#000'></span></span>
            <span class="header">创建时间：<span runat=server ID=AddTime style=' color:#000;'></span></span>
            <span class="header">更新时间：<span runat=server ID=UpdateTime style=' color:#000'></span></span>
            <span class="header">管理人员：<span runat=server ID=ManageNameList style=' color:#000;'></span></span>
            </li>
        </ul>   

        <ul class="pageitem">
            <li class="textbox">
            <span class="header">任务内容：</span>
                    <p><div runat=server ID=bodys1 style='overflow: auto; overflow-y:hidden;font-size:13pt'></div></p>
                    <div style="font-weight:bold;"><%=fjs %></div>
            </li>
        </ul> 

        <ul>
            <asp:Repeater runat=server ID=rpt><ItemTemplate>
            <li>
                    <asp:LinkButton runat=server ID=lb CommandArgument=<%# Eval("WorkTag") + "," + Eval("UserID")%> Visible=false class="show">.</asp:LinkButton>

                    <span><%#Eval("RealName")%> (<%# GetWorkTag(Eval("WorkTag"))%>)</span> 
                <span>
                    <asp:Panel runat=server ID=pa Visible=false>
                            <asp:Panel runat=server ID=pa1 Visible=false>
                            </asp:Panel>
                    </asp:Panel>
                    <asp:Label runat=server ID=lab1 Visible=false></asp:Label>
                </span> <br>
                <span>
                    <%#Eval("AddTime")%>
                    <a class="effect" href='FeedBack_View.aspx?tuid=<%#Eval("id") %>'>查看详情</a>
                </span>
            </li>
            </ItemTemplate>
            </asp:Repeater>

        </ul>

        <ul class="pageitem">
            <li class="textbox">
            <span class="header">任务分类：<span runat=server ID=TypeName style=' color:#000;'></span></span>
            <span class="header">任务级别：<span runat=server ID=Important style=' color:#000;'></span></span>
            <span class="header">期待完成时间：<span runat=server ID=ExpectTime style=' color:#000;'></span></span>
            </li>
        </ul>  

        <asp:PlaceHolder runat=server ID=displays Visible=false>
        <asp:PlaceHolder runat=server ID=exetables Visible=false>
        <span class="graytitle">反馈执行情况：</span>
            <ul class="pageitem">
                <li class="textbox">
                    <textarea runat="server" name="Bodys" id="Bodys" placeholder="任务执行情况" rows="3" style="width:100%;"></textarea>
                </li>
            </ul>
            <ul class="pageitem">
                <li class="textbox">
		        <span style="font-weight:bold;"><a href="javascript:fAddAttach();" id="aAddAttach">添加附件</a></span>
                </li>
                <li class="textbox">
                <div runat=server id="dvReadAttach" style="float:left;"></div>
                </li>
            </ul>
        </asp:PlaceHolder>

        <ul class="pageitem">
            <li class="button" style="text-align: center;">
            <asp:Button ID="s1" runat="server" OnClientClick='javascript:return check()' Text="提交执行情况" OnClick="Submit_Btn" Visible=false />
            </li>
        </ul> 

        <ul class="pageitem">
            <li class="button" style="text-align: center;">
            <asp:Button ID="s2" runat="server" OnClientClick='javascript:return confirm("确定接受任务吗")' Text="我要接收任务" OnClick="Accept_Btn" Visible=false />
            </li>
        </ul>

        <ul class="pageitem">
            <li class="button" style="text-align: center;">
            <asp:Button ID="b3" runat="server" OnClientClick='javascript:return confirm("确实完成整个任务吗")' Text="完成任务" OnClick="Complete_Btn" Visible=false />
            </li>
        </ul> 
        </asp:PlaceHolder>
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
        function check() {
            if (document.form1.Bodys.value == "") {
                alert("任务执行情况为空！");
                document.form1.Bodys.focus();
                return false;
            }
        }
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
                <li><a href="TaskMenu.aspx">上级菜单</a></li>
            </ul>
        </div>
        <div class="list">
            <ul>
                <li>
                    <h4 runat='server' id='Subject'></h4>
                </li>
                <li>
                    <span>任务状态：<b runat='server' id='status'></b></span>
                    <span>创建人员：<b runat='server' id='Creator'></b></span>
                    <span>创建时间：<b runat='server' id='AddTime'></b></span>
                    <span>更新时间：<b runat="server" id="UpdateTime"></b></span>
                    <span>管理人员：<b runat="server" id="ManageNameList"></b></span>
                </li>
            </ul>
        </div>
        <div class="list">
            <ul>
                <li><span>任务内容：</span>


                    <div runat="server" id="bodys1" class="textarea"></div>
                    <%--  <textarea runat="server"  id="DocBody" placeholder="" ></textarea>--%>
                </li>
                <li>
                    <span>任务附件：<b><%=fjs %></b></span>
                </li>
            </ul>
        </div>
        <div class="list">
            <ul>
                <asp:Repeater runat="server" ID="rpt">
                    <ItemTemplate>
                        <li>
                            <asp:LinkButton runat="server" ID="lb" CommandArgument='<%# Eval("WorkTag") + "," + Eval("UserID")%>' Visible="false" class="show">.</asp:LinkButton>

                            <span><%#Eval("RealName")%> (<%# GetWorkTag(Eval("WorkTag"))%>)</span>
                            <span>
                                <asp:Panel runat="server" ID="pa" Visible="false">
                                    <asp:Panel runat="server" ID="pa1" Visible="false">
                                    </asp:Panel>
                                </asp:Panel>
                                <asp:Label runat="server" ID="lab1" Visible="false"></asp:Label>
                            </span>
                            <br>
                            <span>
                                <%#Eval("AddTime")%>
                                <a class="effect" href='FeedBack_View.aspx?tuid=<%#Eval("id") %>'>查看详情</a>
                            </span>
                        </li>
                    </ItemTemplate>
                </asp:Repeater>
                <li>
                    <span>任务分类：<b runat="server" id="TypeName"></b></span>
                    <span>任务级别：<b runat="server" id="Important"></b></span>
                    <span>期待完成时间：<b runat="server" id="ExpectTime"></b></span>

                </li>
            </ul>
        </div>
        <asp:PlaceHolder runat="server" ID="displays" Visible="false">
            <asp:PlaceHolder runat="server" ID="exetables" Visible="false">
                <div class="list">

                    <ul>
                        <li>
                            <h4>反馈完成情况</h4>
                        </li>
                        <li>
                            <textarea runat="server" name="Bodys" id="Bodys" placeholder="任务执行情况" rows="3"></textarea>
                        </li>
                        <li id="dvReadAttach"><a onclick="fAddAttach();">添加附件</a>

                        </li>

                    </ul>

                </div>
            </asp:PlaceHolder>
            <div class="fixed">

                <asp:Button ID="s1" runat="server" OnClientClick='javascript:return check()' Text="提交执行情况" OnClick="Submit_Btn" Visible="false" />
                <asp:Button ID="s2" runat="server" OnClientClick='javascript:return confirm("确定接受任务吗")' Text="我要接收任务" OnClick="Accept_Btn" Visible="false" />
                <asp:Button ID="b3" runat="server" OnClientClick='javascript:return confirm("确实完成整个任务吗")' Text="完成任务" OnClick="Complete_Btn" Visible="false" />

            </div>
        </asp:PlaceHolder>

    </form>

    <script type="text/javascript">
        if ($(".fixed").length > 0) {
            $(".list").last().css({ paddingBottom: $(".fixed").outerHeight() })
        }
    </script>
</body>
</html>
