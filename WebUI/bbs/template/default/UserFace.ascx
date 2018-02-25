<%@ Import Namespace="DXBBS.Components"%>
<%@ Control Language="C#" AutoEventWireup="true" %>
<%@ Register TagPrefix="DXBBS" Namespace="DXBBS.Controls" Assembly="DXBBS.Controls" %>
<script language="javascript">
function Select(obj1)
{
        SetUploadFaceValue(obj1.name,obj1.width,obj1.height);
        window.close();
}
function SetUploadFaceValue(filename,fwidth,fheight)
{
    	var n=ChangeID("_ctl0:Main:ControlPanel1:_ctl0:MPhoto");
    	var obj=oo(n);
    	obj.value=filename;
    
    	n=ChangeID("_ctl0_Main_ControlPanel1__ctl0_MPhotoImage");
    	obj=oo(n);
    	obj.src=filename;
    	obj.value=filename;
    	obj.style.height=fheight;
    	obj.style.width=fwidth;
    
    	n=ChangeID("_ctl0_Main_ControlPanel1__ctl0_MPhotoHeight");
    	obj=oo(n);
    	obj.value=fheight;
    
    	n=ChangeID("_ctl0_Main_ControlPanel1__ctl0_MPhotoWidth");
    	obj=oo(n);
    	obj.value=fwidth;
}
function oo(ID){
	return window.opener.document.getElementById(ID);
}
function ChangeID(ID)
{
	if (oo(ID)==null)
	{
		ID=ID.replace(/(_ctl)/g,"ctl0");
		ID=ID.replace(/(:)/g,"$");
	}
	return ID;
}
</script>
<div style='width: 100%; margin: 5px auto;'>
<table width="100%" cellspacing="1" class="Normal_Table">
    <tr>
        <td width="100%" style="word-break: keep-all">
            <asp:Repeater ID="FaceList" runat="server">
                <ItemTemplate>
                    &nbsp;<img src="<%# Eval("FileName") %>" name="<%# Eval("FileName") %>" title="<%# Eval("FaceName") %>" onclick="Select(this)" style="cursor:pointer" />
                </ItemTemplate>
            </asp:Repeater>
        </td>
    </tr>
</table>
</div>
<div class="BlankBlock">
    <DXBBS:ForumPager ID="CommonPager" runat="server" />
</div>