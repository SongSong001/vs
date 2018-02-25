<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MakerCS.aspx.cs" Inherits="WC.WebUI.CS_Maker.MakerCS" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>无标题页</title>
</head>
<body>
    <form id="form1" runat="server">
    <div style="margin-left:200px; margin-top:50px;">
    <input type=text name=tablename /><br/>
    <asp:Button Text=生成文件 runat=server OnClick=btn_Onclick />
    </div>
    </form>
</body>
</html>
