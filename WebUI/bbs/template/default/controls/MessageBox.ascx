<%@ Control Language="C#" AutoEventWireup="true"%>
<a href="ControlPanel.aspx?Action=Recieve" target="_blank">新消息 (<span id="MessageNumber">0</span>)</a>
<script language="javascript">
function ShowMessage(result)
{
    if (result != "0")
    {
        document.getElementById("MessageNumber").innerHTML= "<span class='Red'>" + result + "</span><bgsound src='sound/msg.wav'>";
    }
    else
    {
        document.getElementById("MessageNumber").innerHTML= result;
    }
}
if (BeginMessageNumber != 0)
{
    ShowMessage(BeginMessageNumber);
}
</script>