﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="AddFriendForm" %>

<%@ Register src="Script/SubScript.ascx" tagname="SubScript" tagprefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>添加好友</title>
    
	<uc1:SubScript ID="SubScript1" runat="server" />
	
	<script language="javascript" type="text/javascript">
	
	var Controls = null;
	var Mangement = null;
	
	function init()
	{
		CurrentWindow.Waiting("");
		Core.InitUI(
			function()
			{
				Core.LoadModules(
					function()
					{
						CurrentWindow.Completed();
						Controls = new Core.GetModule("Controls.js");
						Management = new Core.GetModule("Management.js");
						
						var config = {
							Left:0,Top:0,Width:Desktop.GetClientWidth(),Height:Desktop.GetClientHeight(),
							Parent:Desktop,
							AnchorStyle:Controls.AnchorStyle.All
						}
						
						var friendForm = new Management.AddFriendForm(config);
					},
					function(ex)
					{
						Core.Utility.ShowError(ex.toString());
					},
					["Management.js"]
				);
			}
		);
	}
	</script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    </div>
    </form>
</body>
</html>
