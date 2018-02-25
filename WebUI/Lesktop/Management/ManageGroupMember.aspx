<%@ Page Language="C#" AutoEventWireup="true" Inherits="Management_ManageGroupMember" %>
<%@ Register Src="../Script/SubScript.ascx" TagName="SubScript" TagPrefix="uc1" %>
<%@ Register Src="../CommandCtrl.ascx" TagName="CommandCtrl" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title></title>
    <link href="../CurrentVersion/Themes/Default/table.css" rel="stylesheet" type="text/css" />
    <link href="../CurrentVersion/Themes/Default/skin.css" rel="stylesheet" type="text/css" />
	  <uc1:SubScript ID="SubScript1" runat="server" />
    <style type="text/css">
       	body
		{
			margin: 8px;
		}
		.headimg
		{
			width:20px;
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
         }
         //删除用户
         function DeleteMember() {
             var friendList = document.getElementById("tbFriendList");
             if (friendList != null) {
                 var peer = "";
                 //获得DIV内所有的控件
                 var ches = friendList.getElementsByTagName("input");
                 for (i = 0; i < ches.length; i++) {
                     if (ches[i].type == "checkbox") //如果是checkbox
                     {
                         if (ches[i].checked && ches[i].id != "chkSelectAll") {
                             peer = peer + (peer == "" ? "" : ",") + "{\"Name\":" + ches[i].id + "}";
                         }
                     }
                 }
                 if (peer != "") {
                     peer = "{\"Peers\":[" + peer + "]}";
                     DoCommand("DeleteMember", peer);
                 }
             } 
        }
       //添加成员
        function AddMember() {

            var config = {
                Left: 0, Top: 0,
                Width: 500, Height: 440,
                MinWidth: 500, MinHeight: 440,
                Title: {
                    InnerHTML: "添加群成员"
                },
                Resizable: false,
                HasMaxButton: false,
                HasMinButton: true,
                OnClose: function(form) { DoCommand("RefreshMember", ""); form.Close(); },
                AnchorStyle: Core.WindowAnchorStyle.Left | Core.WindowAnchorStyle.Top
            }

            var form = Core.CreateWindow(config);
            form.MoveEx('CENTER', 0, 0, true);
            // form.ShowDialog(CurrentWindow, 'CENTER', 0, 0, true, null);
            form.Show();
            var url = Core.GetPageUrl(String.format("Management/AddMemberToGroup.aspx?random={0}&Name={1}", (new Date()).getTime(), Core.Params["Name"]));
            form.Load(url, null);
        }
        //全选
        function SelectAll(obj) {
            var friendList = document.getElementById("tbFriendList");
            if (friendList != null) {
                //获得DIV内所有的控件
                var ches = friendList.getElementsByTagName("input");
                for (i = 0; i < ches.length; i++) {
                    if (ches[i].type == "checkbox") //如果是checkbox
                    {
                        ches[i].checked = obj.checked; //字节点的状态和父节点的状态相同,即达到全选
                    }
                }
            } 
        }
    </script>

</head>
<body>
    <form id="form1" runat="server" enctype="multipart/form-data">
    <div class="table_blue">
        <div  style="margin:2px"><input type="button" id="Button1" value="删除成员" onclick="DeleteMember()" class="BtnDefault" />&nbsp;&nbsp;<input type="button" id="btnSearch" value="添加成员" onclick="AddMember()" class="BtnDefault" /></div>
        <div style="overflow:auto; width:470px; height:385px;" >
        <table cellpadding="0" cellspacing="0" id="tbFriendList">
            <tr class='header'>
                <td class='headimg'>
                    <input type="checkbox"  id="chkSelectAll" onclick="SelectAll(this)" />
                </td>
              	<td class='name'>用户名</td>
				<td class='nickname'>昵称</td>
				<td class='email'>电子邮件</td>
            </tr>
            <%= RenderFriendList()%>
        </table>
        </div>
    </div>
    <uc1:CommandCtrl ID="CommandCtrl" runat="server" />
    </form>
</body>
</html>

