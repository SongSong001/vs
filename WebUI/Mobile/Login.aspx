<%@ Page Language="C#" AutoEventWireup="true" EnableViewState="false" CodeBehind="Login.aspx.cs" Inherits="WC.WebUI.Mobile.Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>智能移动办公平台</title>
<meta content="yes" name="apple-mobile-web-app-capable" />
<meta content="index,follow" name="robots" />
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<meta content="minimum-scale=1.0, width=device-width, maximum-scale=0.6667, user-scalable=no" name="viewport" />
<script type="text/javascript" src="/js/validator.js"></script> 
    <style type="text/css">
        body
        {
   background:url(images/default_bg.png);
   filter:"progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='scale')";
   -moz-background-size:100% 100%;
   background-size:100% 200%;
        }
        .inputsubmit
        {
            width: 120px;
            height: 28px;
            color: #36434E;
            border: 0px;
            cursor: pointer;
            font-size: 16px;
        }
    </style>
</head>
<body onload="javascript:form1.UserName.focus();" >
    <form id="form1" runat="server" onsubmit="return Validator.Validate(this.form,1);">
    <div align="center">
        <table cellspacing="0" cellpadding="0" align="center">
            <tr>
                <td align="center" valign="top" style="padding-top: 60px;" height="430" width="300">
                    <table width="100%">
                        <tr>
                            <td style="text-align: center; font-family: 微软雅黑; font-size: 24px; color: White;"
                                colspan="2">
                                智能移动办公平台
                            </td>
                        </tr>
                        <tr>
                            <td height="20">
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align:center; width: 100px; font-family: 微软雅黑;">
                                <span style="color: White;">账 户:</span>
                            </td>
                            <td>
                                <input name="UserName" dataType="Require" msg="用户名不能为空" type="text" id="UserName" class="inputtext" onfocus="this.select()" onmouseover="this.focus()" style="height:30px;width:200px;" />
                            </td>
                        </tr>
                        <tr>
                            <td height="10">
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align:center; width: 100px; font-family: 微软雅黑;">
                                <span style="color: White;">密 码:</span>
                            </td>
                            <td>
                                <input name="PassWord" type="password" maxlength=16 dataType="Require" msg="密码不能为空" id="PassWord" class="inputtext" onfocus="this.select()" onmouseover="this.focus()" style="height:30px;width:200px;" />
                            </td>
                        </tr>
                        <tr>
                            <td height="7">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 229px">
                            </td>
                            <td>
                                <asp:Button runat=server class="inputsubmit" ID=Button1 Text="登 录" OnClick=Login_Btn OnClientClick="return Validator.Validate(this.form,1);" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>

    </form>
</body>
</html>
