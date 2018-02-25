<%@ Page Language="C#" AutoEventWireup="true" EnableEventValidation="false" Inherits="Management_AddMemberToGroup" %>

<%@ Register Src="../Script/SubScript.ascx" TagName="SubScript" TagPrefix="uc1" %>
<%@ Register Src="../CommandCtrl.ascx" TagName="CommandCtrl" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title></title>
 <link href="../CurrentVersion/Themes/Default/table.css" rel="stylesheet" type="text/css" />
    <uc1:SubScript ID="SubScript1" runat="server" />
    <style type="text/css">
        body
        {
            margin: 8px;
        }
        .headimg
        {
            width: 20px;
        }
        .name
        {
            width: 100px;
        }
        .nickname
        {
        }
        .email
        {
        }
    </style>
    <script type="text/javascript" language="javascript">
        var Controls = null;
        var Mangement = null;
        var Common = null;

        function init() {
            CurrentWindow.Completed();
            var state = GetState();
            if (state.Action == "RefreshFriendsList") {
                Core.Session.GetGlobal("FriendsInfoCache").Refresh();
            }
            else if (state.Action == "Error") {
                Core.Utility.ShowError(state.Exception.Message);
            }
            else if (state.Action == "Close") {
                CurrentWindow.Close();
            }
        }
        //确定处理
        function AddMemberToGroup() {
            var listRight = document.getElementById("lbRight");
            if (listRight != null) {
                var peer = "";
                for (i = 0; i < listRight.options.length; i++) {
                    var v = listRight.options[i].value;
                    var t = listRight.options[i].text;
                    peer = peer + (peer == "" ? "" : ",") + "{\"Name\":\"" + v + "\"}";
                }
                if (peer != "") {
                    peer = "{\"Peers\":[" + peer + "]}";
                    DoCommand("AddMemberToGroup", peer);
                }
            }
        }
        //关闭窗体
        function CloseForm() {
            CurrentWindow.Close();
        }

        //查询
        function Search() {
            var data = {
                Action: "UsersSerach",
                Name: document.getElementById("txtName").value
            };
            Core.SendCommand(
		        function (ret) {
		            var listLeft = document.getElementById("lbLeft");
		            listLeft.length = 0;
		            if (ret != null && ret.Users != undefined && ret.Users.length > 0) {
		                var listRight = document.getElementById("lbRight");
		                for (var i = 0; i < ret.Users.length; i++) {
		                    if (!jsSelectIsExitItem(listRight, ret.Users[i].Name)) {//右边不存在才添加
		                        listLeft.options[listLeft.options.length] = new Option(ret.Users[i].Nickname + "(" + ret.Users[i].Name + ")", ret.Users[i].Name, true, true);
		                    }
		                }
		            }
		        },
		        function (ex) {
		            alert("查询失败!");
		        },
		        Core.Utility.RenderJson(data), "Core.Web Common_CH", false
	         );
            //DoCommand("Search", document.getElementById("txtName").value);
        }

        //添加项目
        function AddItem() {
            var listLeft = document.getElementById("lbLeft");
            var lstindex = listLeft.selectedIndex;
            if (lstindex < 0)
                return;
            var v = listLeft.options[lstindex].value;
            var t = listLeft.options[lstindex].text;
            var listRight = document.getElementById("lbRight");
            //            if (!jsSelectIsExitItem(listRight, v)) {
            listLeft.options[lstindex].parentNode.removeChild(listLeft.options[lstindex]);
            listRight.options[listRight.options.length] = new Option(t, v, true, true);
            //            }
        }
        //删除项目
        function DelItem() {
            var listRight = window.document.getElementById("lbRight");
            var listLeft = document.getElementById("lbLeft");
            var lstindex = listRight.selectedIndex;
            if (lstindex >= 0) {
                var v = listRight.options[lstindex].value;
                var t = listRight.options[lstindex].text;
                listLeft.options[listLeft.options.length] = new Option(t, v, true, true);
                listRight.options[lstindex].parentNode.removeChild(listRight.options[lstindex]);
            }
        }
        //当前和目标
        function MuiltItem(trigger, target, type) {
            var listLeft = window.document.getElementById(trigger); //触发的listbox
            var listRight = window.document.getElementById(target); //目标
            var k = 0;
            for (var i = 0; i < listLeft.options.length + k; i++) {
                if (listLeft.options[i - k].selected) {
                    var v = listLeft.options[i - k].value;
                    var t = listLeft.options[i - k].text;
                    //                    if (type == "Add") {
                    //                        if (!jsSelectIsExitItem(listRight, v)) {
                    //                            listRight.options[listRight.options.length] = new Option(t, v, true, true);
                    //                        }
                    //                    } else if (type == "Del") {
                    listRight.options[listRight.options.length] = new Option(t, v, true, true);
                    listLeft.options[i - k].parentNode.removeChild(listLeft.options[i - k]);
                    k++;
                    // }
                }
            }
        }

        //判断listbox是否存在该值
        function jsSelectIsExitItem(objSelect, objItemValue) {
            var isExit = false;
            for (var i = 0; i < objSelect.options.length; i++) {
                if (objSelect.options[i].value == objItemValue) {
                    isExit = true;
                    break;
                }
            }
            return isExit;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server" enctype="multipart/form-data">
    <uc1:CommandCtrl ID="CommandCtrl" runat="server" />
    <div style="width: 470px; height: 405px;">
        <table cellpadding="0" cellspacing="0" id="tbFriendList">
            <tr>
                <td style="height: 24px">
                    <table>
                        <tr>
                            <td>
                                <input type="text" id="txtName" maxlength="199" title="输入可以查询联系人" onkeyup="Search()"
                                    style="width: 205px" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                联系人列表:
                            </td>
                        </tr>
                    </table>
                </td>
                <td>
                </td>
                <td style="height: 24px">
                    <table>
                        <tr>
                            <td rowspan="2" valign="bottom">
                                <br />
                                已选联系人:
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:ListBox runat="server" ID="lbLeft" Style="width: 215px; height: 315px;" SelectionMode="Multiple">
                    </asp:ListBox>
                </td>
                <td style="text-align: center">
                    <img src="../CurrentVersion/Themes/Default/Images/Previous.png" alt="添加联系人" id="imgAdd"
                        onclick="MuiltItem('lbLeft','lbRight','Add')" />
                    <%--                    <input type="button"  class="Image22_Previous" title="添加联系人" id="btnRight" onclick="MuiltItem('lbLeft','lbRight','Add')" />--%>
                    <br />
                    <br />
                    <br />
                    <img src="../CurrentVersion/Themes/Default/Images/Next.png" alt="删除联系人" id="imgDelete"
                        onclick="MuiltItem('lbRight','lbLeft','Del')" />
                    <%-- <input type="button" class="Image22_Next" title="删除联系人" id="btnLeft" onclick="MuiltItem('lbRight','lbLeft','Del')" />--%>
                </td>
                <td>
                    <asp:ListBox runat="server" ID="lbRight" SelectionMode="Multiple" Style="width: 215px;
                        height: 315px;"></asp:ListBox>
                </td>
            </tr>
            <tr>
                <td colspan="3" align="right">
                    <br />
                    <input type="button" id="btnOK" value="确    定" onclick="AddMemberToGroup()" class="BtnDefault" />&nbsp;&nbsp;<input
                        type="button" id="btnCancel" value="关    闭" onclick="CloseForm()" class="BtnDefault" />
                </td>
            </tr>
        </table>
    </div>
    <input type="hidden" id="userlist" />
    </form>
</body>
</html>
