<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewFlow.aspx.cs" Inherits="WC.WebUI.Mobile.Flows.NewFlow" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head id="Head1" runat="server">
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <title>智能移动办公平台</title>
    <meta name="keywords" content="" />
    <meta name="description" content="" />
    <meta name="format-detection" content="telephone=no" />
    <meta name="format-detection" content="email=no" />
    <meta name="format-detection" content="address=no" />
    <meta name="format-detection" content="date=no" />
    <link href="../css/index.css?201307011200" rel="stylesheet" />
    <script type="text/javascript" src="../js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="http://lvfaoa.haipop.com/KindEditor4/kindeditor.js"></script>
    <script type="text/javascript" src="/js/popup/popup.js"></script>
    <script type="text/javascript">
        var w = window.innerWidth * 0.95;
        function ShowIframe(obj)
        {
            var users = document.getElementById("userlist"+obj);
            var pop=new Popup({ contentType:1,scrollType:'no',isReloadOnClose:false,width:w,height:500});
            pop.setContent("contentUrl","/Manage/Utils/SelectPeople_r.aspx?obj="+obj);
            pop.setContent("title","工作流程 - 审批人员选择");
            pop.build();
            pop.show();
        }      
        function ShowIframe1()
        {
            var users = document.getElementById("userlist");
            var pop=new Popup({ contentType:1,scrollType:'no',isReloadOnClose:false,width:w,height:500});
            pop.setContent("contentUrl","/Manage/Utils/SelectPeople_rt.aspx");
            pop.setContent("title","工作流程 - 抄送人员选择");
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
        function SaveDoc() {
            if (document.myform.Model_Type.value == "-1") {
                alert("您还没有选择分类！");
                document.myform.Model_Type.focus();
                return false;
            } 	 
            if(document.myform.ModelFlowList.value=="")
            {
                alert("您还没有选择流程模型！");
                document.myform.ModelFlowList.focus();
                return false;
            } 	            
            if(document.myform.Flow_Name.value=="")
            {
                alert("流程标题不能为空！");
                document.myform.Flow_Name.focus();
                return false;
            } 	
            if(document.myform.FlowRemark.value=="")
            {
                alert("流程说明不能为空！");
                document.myform.FlowRemark.focus();
                return false;
            }								
            if(confirm("流程发起后不可更改，您确定要正式发起流程吗?")){	
                return true;
            }
            else{
                return false;
            }
        }
    </script>

    <link rel="stylesheet" href="/KindEditor4/themes/default/default.css" />
    <link rel="stylesheet" href="/KindEditor4/plugins/code/prettify.css" />
    <script type="text/javascript" charset="utf-8" src="/KindEditor4/kindeditor.js"></script>
    <script type="text/javascript" charset="utf-8" src="/KindEditor4/lang/zh_CN.js"></script>
    <script type="text/javascript" charset="utf-8" src="/KindEditor4/plugins/code/prettify.js"></script>
    <%--<asp:Literal runat="server" ID="kind_show" Visible="false">--%>
    <script type="text/javascript">
       
        KindEditor.ready(function (K) {
            var editor1 = K.create('#DocBody', {
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
   <%-- </asp:Literal>--%>
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
                <li><a href="FlowMenu.aspx">上级菜单</a></li>
            </ul>
        </div>
        <div class="list">
            <ul>
                <li>
                    <h4>* 流程名称：</h4>
                </li>
                <li>
                    <input runat="server" name="Flow_Name" type="text" id="Flow_Name" placeholder="文档标题 (不能为空)" />
                </li>
                <li>
                    <h4>流程分类：</h4>
                </li>
                <li>
                    <asp:DropDownList runat="server" ID="Model_Type" AutoPostBack="true" OnSelectedIndexChanged="ModelType_btn"></asp:DropDownList>
                </li>
                <li>
                    <h4>* 流程模型：</h4>
                </li>
                <li>
                    <asp:DropDownList runat="server" ID="ModelFlowList" AutoPostBack="true" OnSelectedIndexChanged="Select_btn" dataType="Require" msg="您还没 选择流程模型"></asp:DropDownList>
                </li>
                <li>
                    <label>流程截止日期：</label>
                    <input runat="server" readonly="readonly"
                        id="ValidTime" name="ValidTime" type="text" size="30" />
                </li>
            </ul>
        </div>
        <div class="list">
            <ul>
                <li>
                    <h4>流程说明</h4>
                </li>
            </ul>
            <div class="ina_edit">
                <textarea runat="server" name="FlowRemark" id="FlowRemark" placeholder="内容 (不能为空)" rows="3" style="width: 100%; height: 190px"></textarea>
            </div>
        </div>
        <div class="list">
            <ul>
                <li>
                    <h4>流程说明</h4>
                </li>
                <asp:Repeater runat="server" ID="rpt_steps" OnItemDataBound="OnDataBind">
                    <ItemTemplate>
                        <li>
                            <asp:Label ID='Step_Name' runat="server" Text='<%#Eval("Step_Name") %>' Visible="false"></asp:Label>
                            <asp:Label ID='Step_Orders' runat="server" Text='<%#Eval("Step_Orders") %>' Visible="false"></asp:Label>
                            <asp:Label ID='RightToFinish' runat="server" Text='<%#Eval("RightToFinish") %>' Visible="false"></asp:Label>
                            <asp:Label ID='MailAlert' runat="server" Text='<%#Eval("MailAlert") %>' Visible="false"></asp:Label>
                            <asp:Label ID='IsEnd' runat="server" Text='<%#Eval("IsEnd") %>' Visible="false"></asp:Label>
                            <asp:Label ID='IsHead' runat="server" Text='<%#Eval("IsHead") %>' Visible="false"></asp:Label>
                            <asp:Label ID='IsUserFile' runat="server" Text='<%#Eval("IsUserFile") %>' Visible="false"></asp:Label>

                            <asp:Label ID='isuseredit' runat="server" Text='<%#Eval("IsUserEdit") %>' Visible="false"></asp:Label>
                            <asp:Label ID='stepid' runat="server" Text='<%#Eval("id") %>' Visible="false"></asp:Label>

                            <input type="hidden" name='userlist<%#Eval("id") %>' id='userlist<%#Eval("id") %>' value='<%# GetStepUsers(Eval("userlist"), Eval("namelist"), Eval("userlist_dep"), Eval("step_type")) %>' />
                            &nbsp;&nbsp;第 <%# Container.ItemIndex + 1%> 步 <%# GetStepNotes(Eval("Step_Remark")) %>： <%#Eval("Step_Name")%>
                            <input type="text" size="40" datatype="Require" msg="审批者不能为空" readonly name='namelist<%#Eval("id") %>' id='namelist<%#Eval("id") %>' value='<%# GetStepNames(Eval("userlist"), Eval("namelist"), Eval("userlist_dep"), Eval("step_type")) %>' />
                            <span runat="server" id="isedit" visible="false">
                                <input type="button" value="审核人员" class="checkbutton" onclick='ShowIframe(<%#Eval("id") %>)' />

                            </span>
                        </li>
                    </ItemTemplate>
                </asp:Repeater>

            </ul>
        </div>
        <div class="list">
            <ul>
                <li>
                    <h4>抄送呈报：</h4>
                </li>
                <li>
                    <input runat="server" type="hidden" id="userlist" name="userlist" value="" />
                    <textarea runat="server" type="text" id="namelist" name="namelist" readonly="readonly" placeholder="接收人 (不能为空)" rows="3"></textarea>
                </li>
                <li><a href="javascript:;" onclick='ShowIframe1()' class="people">选择人员</a></li>
            </ul>
        </div>
        <asp:Panel ID="Attachword" runat="server" Visible="false">
            <div class="list">
                <ul>
                    <li>
                        <h4>流程正文</h4>
                    </li>
                    <input type=hidden runat=server id=filepath name=filepath />
                </ul>
                <div class="ina_edit">
                    <textarea runat="server" name="DocBody" id="DocBody" placeholder="内容 (不能为空)" rows="15" style="width: 100%; height: 190px"></textarea>
                </div>
            </div>
            <div class="list">
                <ul>
                    <li id="dvReadAttach"><a onclick="fAddAttach();">添加附件</a>

                    </li>
                </ul>
            </div>
        </asp:Panel>
        <div class="fixed">
            <asp:Button ID="save1" OnClientClick="return SaveDoc()" runat="server" Text="发起流程" OnClick="Save_Btn" />
        </div>
    </form>
    <script type="text/javascript" src="../js/laydate.js"></script>
    <script type="text/javascript">
        if ($(".fixed").length > 0) {
            $(".list").last().css({ paddingBottom: $(".fixed").outerHeight() })
        }
        laydate.render({
            elem: '#ValidTime',
           
        });
    </script>

</body>
</html>
