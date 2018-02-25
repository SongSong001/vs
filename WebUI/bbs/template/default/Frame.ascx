<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true"%>
<style type="text/css">
body {
	margin: 0px;padding:0px;overflow:hidden
}
#SwitchTable
{
    position: absolute; 
    left: 200px; 
    background-repeat: repeat-y; 
    background-position: -192px
}
#SwitchButton
{
    background: url('images/switchbutton.gif') no-repeat 0;
    cursor: pointer;
}
</style>
<script type="text/javascript">
function DoSwitch()
{
    var obj = document.getElementById('LeftFrame');
    var obj1 = document.getElementById('SwitchTable');
    var obj2 = document.getElementById('SwitchButton');
    if(obj.style.display == 'none')
    {
        obj.style.display = '';
        obj1.style.left = '200px';
        obj2.style.backgroundPosition = '0';
    }
    else
    {
        obj.style.display = 'none';
        obj1.style.left = '0px';
        obj2.style.backgroundPosition = '-11';
    }
}
</script>
<table border="0" width="100%" cellspacing="0" cellpadding="0" height="100%">
	<tr>
		<td width="195" id="LeftFrame" valign="top" height="100%" style="padding-left:5px" class="Middle">
			<iframe src="Left.aspx" frameborder="0" scrolling="yes" allowTransparency="true" width="100%" height="100%"></iframe>
		</td>
		<td height="100%" class="Middle">
            <table id="SwitchTable" border="0" cellPadding="0" cellSpacing="0" width="11" height="100%">
                <tr>
                    <td><img id="SwitchButton" src="images/blank.gif" alt="" border="0" width="11" height="49" onclick="DoSwitch()"/></td>
                </tr>
            </table>
			<iframe name="right" id="right" src="Index.aspx" frameborder="0" scrolling="auto" width="100%" height="100%"></iframe>
		</td>
	</tr>
</table>
<script type="text/javascript">
var URL=location.search;
if (URL != "")
{
    URL=URL.replace("?URL=","");
    var obj=document.getElementById("right");
    obj.src=URL;
}
</script>