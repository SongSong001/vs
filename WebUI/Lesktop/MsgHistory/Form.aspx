<%@ Page Language="C#" AutoEventWireup="true" Inherits="MsgHistory_Form" %>

<%@ Register Src="../Script/SubScript.ascx" TagName="SubScript" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title></title>
    <uc1:SubScript ID="SubScript1" runat="server" />
    <script type="text/javascript" src="../CurrentVersion/Module/date_ctrl.js"></script>
    <script language="javascript" type="text/javascript">
        function init() {
            CurrentWindow.Waiting("");
            Core.InitUI(
			function () {
			    Core.LoadModules(
					function () {
					    CurrentWindow.Completed();

					    var Controls = Core.GetModule("Controls.js");

					    var config = {
					        Left: 0, Top: 0, Width: Desktop.GetClientWidth(), Height: Desktop.GetClientHeight(),
					        Parent: Desktop,
					        AnchorStyle: Controls.AnchorStyle.All
					    }

					    var MsgHistroyPanel = new Core.GetModule("WebIM.js").MsgHistroyPanel(config);
					},
					function (ex) {
					    Core.Utility.ShowError(ex.toString());
					},
					["WebIM.js", "Common.js"]
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
