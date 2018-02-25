<%@ Page Language="C#" AutoEventWireup="true" Inherits="Management_DeptEdit" %>

<%@ Register Src="../Script/SubScript.ascx" TagName="SubScript" TagPrefix="uc1" %>
<%@ Register Src="../CommandCtrl.ascx" TagName="CommandCtrl" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title></title>
    <link href="../CurrentVersion/Themes/Default/table.css" rel="stylesheet" type="text/css" />
    <uc1:SubScript ID="SubScript1" runat="server" />
    <script type="text/javascript" language="javascript">
        var Controls = null;
        var Mangement = null;
        var Common = null;
        function init() {
            CurrentWindow.Completed();

            var state = GetState();
            if (state.Action == "Close") {
                CurrentWindow.Close();
            }
            else if (state.Action == "Error") {
                Core.Utility.ShowError(state.Exception.Message);
            }
        }

        function UpdateDept() {
            var name = document.getElementById("txtName").value;
            if (name == "") {
                alert("部门名称不能为空！");
                document.getElementById("txtName").focus();
            }
            var did = document.getElementById("txtId").value;
            var pdid = document.getElementById("drpParentDept").value;
            var cindex = document.getElementById("txtCIndex").value;
            if (cindex == "") cindex = "0";
            DoCommand("Update", { Did: did, Name: name, Pdid: pdid, CIndex: cindex });
            return;
        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div class="table_blue">
        <table>
            <tr>
                <td>
                    部门名称
                </td>
                <td>
                    <asp:TextBox runat="server" ID="txtName" Style="width: 192px; height:16px"></asp:TextBox>
                    <asp:TextBox runat="server" ID="txtId" Style="display: none;"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    父级部门
                </td>
                <td>
                    <asp:DropDownList runat="server" ID="drpParentDept" Style="width: 200px; height:20px">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>
                    顺序
                </td>
                <td>
                    <asp:TextBox runat="server" ID="txtCIndex" Style="width: 40px; height:16px" onkeypress="return event.keyCode>=48&&event.keyCode<=57||event.keyCode==46"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: right; margin-right: 5px;">
                    <a href='javascript:UpdateDept();'>更新</a>
                </td>
            </tr>
        </table>
    </div>
    <uc1:CommandCtrl ID="CommandCtrl" runat="server" />
    </form>
</body>
</html>
