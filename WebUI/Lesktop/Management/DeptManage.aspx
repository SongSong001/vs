<%@ Page Language="C#" AutoEventWireup="true" Inherits="Management_DeptManage" %>

<%@ Register Src="../CommandCtrl.ascx" TagName="CommandCtrl" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title></title>
    <link href="../CurrentVersion/Themes/Default/table.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        body
        {
            margin: 8px;
        }
        .name
        {
        }
        .nickname
        {
            width: 200px;
        }
        .index
        {
            width: 40px;
        }
        .name input, .nickname input
        {
            width: 90%;
            border: solid 1px #D0D0D0;
            font-family: SimSun;
            font-size: 12px;
            padding: 3px;
        }
        .operation
        {
            width: 120px;
            text-align: center;
        }
    </style>
    <script type="text/javascript" language="javascript">
        var CurrentWindow = parent.CurrentWindow;

        window.onload = function () {
            CurrentWindow.Completed();

            var state = GetState();
            if (state.Action == "RefreshFriendsList") {
                parent.Core.Session.GetGlobal("FriendsInfoCache").Refresh();
            }
            else if (state.Action == "Error") {
                parent.Core.Utility.ShowError(state.Exception.Message);
            }
        }
        //更新
        function Update(did) {
            var config = {
                Left: 0, Top: 0,
                Width: 370, Height: 173,
                MinWidth: 370, MinHeight: 173,
                Title: {
                    InnerHTML: "修改部门资料"
                },
                Resizable: false,
                HasMaxButton: false,
                HasMinButton: true,
                AnchorStyle: parent.Core.WindowAnchorStyle.Left | parent.Core.WindowAnchorStyle.Top
            }

            var form = parent.Core.CreateWindow(config);
            form.MoveEx('CENTER', 0, 0, true);
            form.ShowDialog(CurrentWindow, 'CENTER', 0, 0, true, null);
            var url = parent.Core.GetPageUrl(String.format("Management/DeptEdit.aspx?random={0}&did={1}", (new Date()).getTime(), did));
            form.Load(url, null);
        }
        //by fj  2011-4-11  增加管理群成员
        function ManageDeptMember(did) {
            var config = {
                Left: 0, Top: 0,
                Width: 500, Height: 440,
                MinWidth: 500, MinHeight: 440,
                Title: {
                    InnerHTML: "管理部门成员"
                },
                Resizable: false,
                HasMaxButton: false,
                HasMinButton: true,
                AnchorStyle: parent.Core.WindowAnchorStyle.Left | parent.Core.WindowAnchorStyle.Top
            }

            var form = parent.Core.CreateWindow(config);
            form.MoveEx('CENTER', 0, 0, true);
            form.ShowDialog(CurrentWindow, 'CENTER', 0, 0, true, null);
            var url = parent.Core.GetPageUrl(String.format("Management/DeptEmpManage.aspx?random={0}&did={1}", (new Date()).getTime(), did));
            form.Load(url, null);
        }
        //删除用户
        function Delete(did, name) {
            if (confirm(String.format("您确定要删除该部门\"{0}\"", name))) {
                CurrentWindow.Waiting("正在删除该部门...");
                DoCommand("Delete", did);
            }
        }
        //新增部门
        function NewDept() {
            var name = document.getElementById("txtName").value;
            if (name == "") {
                alert("部门名称不能为空！");
                document.getElementById("txtName").focus();
                return;
            }
            var cindex = document.getElementById("txtIndex").value;
            if (cindex == "") {
                alert("顺序不能为空！");
                document.getElementById("txtIndex").focus();
                return;
            }
            var pdid = document.getElementById("drpParentDept").value;
            DoCommand("NewDept", { Name: name, Pdid: pdid, CIndex: cindex });
            return;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div class="table_blue">
        <div style="color: Red">
            友情提示：新建部门时,如果不指定上级部门,默认为顶级部门!</div>
        <br />
        <table cellpadding="0" cellspacing="0">
            <tr class='header'>
                <td class='name'>
                    部门名称
                </td>
                <td class='nickname'>
                    上级部门
                </td>
                <td class='index'>
                    顺序
                </td>
                <td class='operation'>
                    操作
                </td>
            </tr>
            <tr>
                <td class='name'>
                    <input type="text" id="txtName" name="txtName" />
                </td>
                <td class='nickname'>
                    <asp:DropDownList runat="server" ID="drpParentDept" Style="width: 200px">
                    </asp:DropDownList>
                </td>
                <td class='index'>
                    <input type="text" id="txtIndex" name="txtIndex" style="ime-mode: Disabled; width: 40px;"
                        onkeypress="return event.keyCode>=48&&event.keyCode<=57||event.keyCode==46" onpaste="return !clipboardData.getData('text').match(/\D/)"
                        ondragenter="return false" />
                </td>
                <td class='operation'>
                    <a href='javascript:NewDept();'>新建部门</a>
                </td>
            </tr>
            <%= RenderDeptList()%>
        </table>
    </div>
    <uc1:CommandCtrl ID="CommandCtrl" runat="server" />
    </form>
</body>
</html>
