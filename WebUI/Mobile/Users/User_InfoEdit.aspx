<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="User_InfoEdit.aspx.cs" Inherits="WC.WebUI.Mobile.Users.User_InfoEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <title>智能移动办公平台-个人资料编辑</title>
    <meta name="keywords" content="" />
    <meta name="description" content="" />
    <meta name="format-detection" content="telephone=no" />
    <meta name="format-detection" content="email=no" />
    <meta name="format-detection" content="address=no" />
    <meta name="format-detection" content="date=no" />
    <link href="../css/index.css" rel="stylesheet" />
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
            <li><a href="../Users/User_PwdEditNew.aspx">修改密码</a></li>
        </ul>
    </div>
    <div class="list_edit">
        <ul>
            <li>
                <label>职务名称：</label>
                <input runat="server" size="30" maxlength="26"
                    name="PositionName1" type="text" id="PositionName1" />
            </li>
            <li>
                <label>性别：</label>
                <%--<select>
                    <option>男</option>
                    <option>女</option>
                </select>--%>
                <asp:DropDownList runat="server" ID="Sex">
                    <asp:ListItem Text='男' Value="0"></asp:ListItem>
                    <asp:ListItem Text='女' Value="1"></asp:ListItem>
                </asp:DropDownList>
            </li>
            <li>
                <label>出生日期：</label>
                <input runat="server" readonly="readonly"
                    id="Birthday" name="Birthday" type="text" size="30" />
            </li>
        </ul>
    </div>
    <div class="list_edit">
        <ul>
            <li>
                <label>腾讯QQ：</label>
                <input runat="server"
                    id="QQ" name="QQ" type="text" size="30" />
            </li>
            <li>
                <label>电子邮件：</label>
                <input runat="server"
                    id="Email" name="Email" type="text" size="30" />
            </li>
            <li>
                <label>移动电话：</label>
                <input runat="server"
                    id="Phone" name="Phone" type="text" size="30" />
            </li>
            <li>
                <label>固定电话：</label>
                <input runat="server"
                    id="Tel" name="Tel" type="text" size="30" />
            </li>
            <li>
                <label>居住地址：</label>
                <input runat="server" size="30" maxlength="60"
                    name="HomeAddress" type="text" id="HomeAddress" />
            </li>
            <li>
                <label>入职日期：</label>
                <input runat="server" readonly="readonly"
                    id="JoinTime" name="JoinTime" size="30" type="text" />
            </li>
            <li>
                <label>上传照片：</label>
               <%-- <a href="javascript:;">选择文件 --%>
                    <asp:FileUpload ID="Fup" runat="server" style="margin-top:9px;" /><%--</a>--%>
               <%-- <input type="file" ID="Fup" runat="server" style="margin-top:4px;" />--%>
            </li>
            <li>
                <label>员工备注：</label>
                <input type="text" id="Notes" name="Notes" size="30" maxlength="60" runat="server" />

                <%--  <textarea runat="server" name="Notes" id="Notes" rows="3" style='width: 100%;'></textarea>--%>
            </li>
        </ul>
    </div>
    <div class="fixed"><a runat="server" onserverclick="Save_Btn" id="bt5">确定保存</a></div>
           <%--  <asp:Button ID="bt5" runat="server" OnClientClick='javascript:return confirm("您确定吗?")' Text="确定保存" OnClick="Save_Btn" />--%>
    <script type="text/javascript" src="../js/jquery-1.7.2.min.js"></script>

    <script type="text/javascript" src="../js/laydate.js"></script>
    <script type="text/javascript">
        if ($(".fixed").length > 0) {
            $(".fixed").prev().css({ paddingBottom: $(".fixed").outerHeight() })
        }
        laydate.render({
            elem: '#Birthday',
            range: false,
            format: 'yyyy-MM-dd',
            max: 0
        });
        laydate.render({
            elem: '#JoinTime',
            range: false,
            format: 'yyyy-MM-dd',
            max: 0
        });
    </script>
         </form>
</body>
</html>
