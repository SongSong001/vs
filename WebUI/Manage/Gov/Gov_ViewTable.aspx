<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Gov_ViewTable.aspx.cs" EnableViewState="false" Inherits="WC.WebUI.Manage.Gov.Gov_ViewTable" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>查看打印</title>
<STYLE type=text/css>BODY {
	BACKGROUND-COLOR: #FFFFFF; MARGIN: 0px
}
A:link {
	FONT-FAMILY: "宋体"; COLOR: #000000; FONT-SIZE: 9pt; TEXT-DECORATION: none
}
A:visited {
	FONT-FAMILY: "宋体"; COLOR: #000000; FONT-SIZE: 9pt; TEXT-DECORATION: none
}
A:hover {
	FONT-FAMILY: "宋体"; COLOR: #ff0000; FONT-SIZE: 9pt; TEXT-DECORATION: none
}
A:active {
	FONT-FAMILY: "宋体"; COLOR: #000000; FONT-SIZE: 9pt; TEXT-DECORATION: none
}
.unnamed181 {
	LINE-HEIGHT: 24pt; FONT-FAMILY: "宋体"; FONT-SIZE: 18px
}
.unnamed24 {
	LINE-HEIGHT: 18pt; FONT-FAMILY: "宋体"; COLOR: #ff0000; FONT-SIZE: 20px; FONT-WEIGHT: bold
}
.unnamed14 {
	FONT-FAMILY: "宋体"; COLOR: #ffffff; FONT-SIZE: 12px; FONT-WEIGHT: bold
}
.unnamed141 {
	BORDER-BOTTOM: #ffffff 1px solid; BORDER-LEFT: #ffffff 1px solid; FONT-FAMILY: "宋体"; COLOR: #ffffff; FONT-SIZE: 12px; BORDER-TOP: #ffffff 1px solid; FONT-WEIGHT: bold; BORDER-RIGHT: #ffffff 1px solid
}
.unnamed142 {
	FONT-FAMILY: "宋体"; COLOR: #000080; FONT-SIZE: 12px; FONT-WEIGHT: bold
}
.unnamed143 {
	FONT-FAMILY: "宋体"; COLOR: #ff0000; FONT-SIZE: 12px; FONT-WEIGHT: bold
}
.unnamed143a {
	FONT-FAMILY: "宋体"; COLOR: #ffffff; FONT-SIZE: 13px; FONT-WEIGHT: bold
}
.unnamed143b {
	LINE-HEIGHT: 18pt; FONT-FAMILY: "宋体"; COLOR: #ff0000; FONT-SIZE: 12px; FONT-WEIGHT: bold
}
.unnamed12 {
	FONT-FAMILY: "宋体"; FONT-SIZE: 12px
}
.unnamed12wu {
	FONT-FAMILY: "宋体"; FONT-SIZE: 12px; TEXT-DECORATION: none
}
.loginBorderB {
	BORDER-BOTTOM: #ffffff 2px solid; FONT-FAMILY: "宋体"; COLOR: #ffffff; FONT-SIZE: 12px; FONT-WEIGHT: bold; TEXT-DECORATION: none
}
.bk {
	BORDER-BOTTOM: #ffffff 1px solid; BORDER-LEFT: #ffffff 1px solid; BORDER-TOP: #ffffff 1px solid; BORDER-RIGHT: #ffffff 1px solid
}
.bk1 {
	BORDER-BOTTOM: #ffffff 1px solid; BORDER-LEFT: #ffffff 1px solid; BORDER-TOP: #ffffff 1px solid; BORDER-RIGHT: #ffffff 1px solid
}
.bk2 {
	BORDER-BOTTOM: #ffffff 1px solid; BORDER-LEFT: #ffffff 1px solid; BACKGROUND-COLOR: #e25050; FONT-FAMILY: "宋体"; COLOR: #ffffff; FONT-SIZE: 12px; BORDER-TOP: #ffffff 1px solid; FONT-WEIGHT: bold; BORDER-RIGHT: #ffffff 1px solid
}
.bk3 {
	BORDER-BOTTOM: #ffffff 1px solid; BORDER-LEFT: #ffffff 1px solid; BACKGROUND-COLOR: #ffffff; FONT-FAMILY: "宋体"; FONT-SIZE: 12px; BORDER-TOP: #ffffff 1px solid; BORDER-RIGHT: #ffffff 1px solid
}
.bk4 {
	BORDER-BOTTOM: #ffffff 1px solid; BORDER-LEFT: #ffffff 1px solid; BACKGROUND-COLOR: #ffffff; FONT-FAMILY: "宋体"; FONT-SIZE: 12px; BORDER-TOP: #ffffff 1px solid; BORDER-RIGHT: #ffffff 1px solid
}
.bk5 {
	BORDER-BOTTOM: #ffffff 1px solid; BORDER-LEFT: #ffffff 1px solid; FONT-FAMILY: "宋体"; COLOR: #ff0000; FONT-SIZE: 12px; BORDER-TOP: #ffffff 1px solid; FONT-WEIGHT: bold; BORDER-RIGHT: #ffffff 1px solid
}
.bottom {
	FONT-FAMILY: "宋体"; COLOR: #edfcfc; FONT-SIZE: 12px; FONT-WEIGHT: bold
}
.bottomcolor:link {
	COLOR: #edfcfc
}
.bottomcolor:visited {
	COLOR: #edfcfc
}
.bottomcolor:hover {
	COLOR: #ff0000
}
.bottomcolor:active {
	COLOR: #edfcfc
}
.addcolor:link {
	COLOR: #edfcfc
}
.addcolor:visited {
	COLOR: #edfcfc
}
.addcolor:hover {
	COLOR: #b00000
}
.addcolor:active {
	COLOR: #edfcfc
}
</STYLE>  
<SCRIPT language=javascript> 
function Print() { 
bdhtml=window.document.body.innerHTML; 
sprnstr= "<!--startprint-->"; 
eprnstr= "<!--endprint-->"; 
prnhtml=bdhtml.substr(bdhtml.indexOf(sprnstr)); 
prnhtml=prnhtml.substring(0,prnhtml.indexOf(eprnstr)); 
window.document.body.innerHTML=prnhtml; 
window.print(); 
} 
</SCRIPT>  
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
<!--startprint-->
<TABLE border=0 cellSpacing=0 cellPadding=0 width=750 bgColor=#ffffff 
align=center>
  <TBODY>
  <TR>
    <TD height=10></TD></TR>
  <TR>
    <TD>
      <TABLE style="BORDER-COLLAPSE: collapse" border=1 cellSpacing=0 
      borderColor=#ff0000 cellPadding=0 width=780 bgColor=#ffffff 
        align=center><TBODY>
        <TR>
          <TD class=unnamed143b height=40 width=760 colSpan=6 
            align=middle><span runat=server id=Flow_Name></span></TD></TR>
        <TR>
          <TD class=unnamed143 width=100 align=middle>拟稿单位</TD>
          <TD class=unnamed142 width=150 align=middle><span runat=server id=CreatorDepName></span></TD>
          <TD class=unnamed143 height=28 width=100 align=middle>拟稿人</TD>
          <TD class=unnamed142 width=140 align=middle><span runat=server id=CreatorRealName></span></TD>
          <TD class=unnamed143 width=100 align=middle>发文日期</TD>
          <TD class=unnamed142 width=140 align=middle><span runat=server id=AddTime></span></TD></TR>
        <TR>
          <TD class=unnamed143 height=28 width=100 align=middle>公文说明</TD>
          <TD width=530 colSpan=5 align=left>
            <TABLE border=0 width=650 align=left>
              <TBODY>
              <TR>
                <TD class=unnamed12 height=70 vAlign=top width=520>
                    <div runat=server id=Remark style="width:98%"></div>
                  </TD></TR>
                  
                  </TBODY></TABLE></TD></TR>
        <TR>
          <TD class=unnamed143 height=28 width=100 align=middle>审核情况</TD>
          <TD width=530 colSpan=5 align=left>
            <TABLE border=0 width=650 align=left>
              <TBODY>
              <TR>
                <TD class=unnamed12 height=130 vAlign=top width=520>
                    <div runat=server id=content style="width:98%"></div>
                  </TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE></TD></TR>
  <TR>
    <TD height=10></TD></TR></TBODY></TABLE>
 <!--endprint-->
 
<TABLE border=0 width="100%">
  <TBODY>
  <TR>
    <TD height=10></TD></TR>
  <TR>
    <TD align=middle><A onclick="Print() " href="#@"><IMG border=0 
      src="../images/Printb.gif"></A></TD></TR>
  <TR>
    <TD height=15></TD></TR></TBODY></TABLE>   
     
    </div>
    </form>
</body>
</html>
