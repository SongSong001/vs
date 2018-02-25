<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DbBackup.aspx.cs" Inherits="WC.WebUI.Manage.Sys.DbBackup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>数据库备份操作</title>
<link type="text/css" href="../Style/Backup_Style.css" rel="stylesheet" rev="stylesheet" media="all" />

</head>
<body>
    <form id="form1" runat="server">
    <div>
    <ul id='mt'>
    <div  align="center" style=" margin-top:18px;"><strong>在线备份数据库：(此功能仅限 主机服务器与数据库服务器在同一台计算机上)</strong></div></ul> 
    
    <table border="0" align="center" width="100%" cellpadding="0" cellspacing="0">
    <tr align="center"><td><br /><asp:Label ID="l1" runat="server" Visible="false"></asp:Label><br /><br /></td></tr>
    <tr align="center"><td><asp:Button ID="Sub" runat="server" OnClick="Submit" CssClass="button" Text="系统数据库备份" />
    <span style="color: red"> 成功后能立即下载 备份文件！<br /><br /></span>
    <span style="color: red;"> 注意：基于计算机安全策略,
下载后备份文件 扩展名为 .rar (并非真正的压缩文件),
请重命名为 .bak
<br /><br /></span>
    <span style="color: red;"> 如果：您的主机服务器,
与数据库服务器不是一台计算机,
请联系您的服务器系统管理人员！
<br /><br /></span>
    </td></tr>
    <tr align="center"><td><br /><br /><br /><br /><asp:Button ID="Button1" runat="server" OnClick="ClearIMData" OnClientClick="javascript:return confirm('确实要清理IM系统的所有聊天记录吗？')" CssClass="button" Text="IM数据清理" />
    <span style="color: red"> 此功能将清理数据库中3个月以前的即时通讯聊天记录!<br /><br /></span>
    <span style="color: red"> 如果IM即时通讯 明显反应加载变慢(抛开网速因素)，可考虑使用，一般无须使用!<br /><br /></span>
    </td></tr>
    </table>       
    </div>
    </form>
</body>
</html>
