<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HR_View.aspx.cs" EnableViewState="false" Inherits="WC.WebUI.Manage.Sys.HR_View" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title><%=RealName + "(" + DepName + ")" %></title>
<META content="text/html; charset=utf-8" http-equiv=Content-Type>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/>
<STYLE>HTML {
	PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; HEIGHT: 100%; PADDING-TOP: 0px
}
BODY {
	PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; HEIGHT: 100%; PADDING-TOP: 0px
}
TABLE {
	LINE-HEIGHT: 1.6em; COLOR: #333333; FONT-SIZE: 12pt
}
FORM {
	PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; PADDING-TOP: 0px
}
UL {
	PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; PADDING-TOP: 0px
}
LI {
	PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; PADDING-TOP: 0px
}
P {
	PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; PADDING-TOP: 0px
}
H1 {
	PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; PADDING-TOP: 0px
}
H2 {
	PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; PADDING-TOP: 0px
}
H3 {
	PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; PADDING-TOP: 0px
}
H4 {
	PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; PADDING-TOP: 0px
}
H5 {
	PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; PADDING-TOP: 0px
}
H6 {
	PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; PADDING-TOP: 0px
}
IMG {
	BORDER-RIGHT-WIDTH: 0px; BORDER-TOP-WIDTH: 0px; BORDER-BOTTOM-WIDTH: 0px; BORDER-LEFT-WIDTH: 0px
}
UL {
	LIST-STYLE-TYPE: none
}
LI {
	LIST-STYLE-TYPE: none
}
#c_content {
	LINE-HEIGHT: 1.5em; FONT-FAMILY: "Arial"; COLOR: #333333; FONT-SIZE: 12pt
}
.dotline {
	BACKGROUND: url(dotline.gif) repeat-x 50% bottom
}
.height5 {
	HEIGHT: 5px
}
.weight110 {
	WIDTH: 110px
}
.weight180 {
	WIDTH: 180px
}
.weight120 {
	WIDTH: 120px
}
.weight190 {
	WIDTH: 190px
}
.weight220 {
	WIDTH: 220px
}
.padding10 {
	PADDING-RIGHT: 10px
}
.v1 {
	WIDTH: 778px
}
.v1_top {
	TEXT-ALIGN: center; PADDING-BOTTOM: 0px; LINE-HEIGHT: 78px; MARGIN: 0px 0px -3px; PADDING-LEFT: 0px; PADDING-RIGHT: 0px; BACKGROUND: url(v1_top.gif) no-repeat; HEIGHT: 75px; FONT-SIZE: 14pt; FONT-WEIGHT: bold; PADDING-TOP: 3px
}
.v1_middle {
	WIDTH: 778px; BACKGROUND: url(v1_middle.gif) repeat-y; HEIGHT: 1%; OVERFLOW: hidden
}
.v1_t {
	PADDING-BOTTOM: 0px; LINE-HEIGHT: 18px; MARGIN: 0px 0px 10px 1px; PADDING-LEFT: 0px; WIDTH: 728px; PADDING-RIGHT: 0px; FONT-FAMILY: "Arial"; BACKGROUND: url(v1_bar.gif) #eff7fb no-repeat; HEIGHT: 16px; COLOR: #333333; FONT-SIZE: 12pt; FONT-WEIGHT: bold; PADDING-TOP: 2px
}
.v1_t TD {
	LINE-HEIGHT: 18px; FONT-FAMILY: "Arial"; HEIGHT: 16px; COLOR: #333333; FONT-SIZE: 12pt; FONT-WEIGHT: bold
}
.v1_down {
	MARGIN: 0px auto; WIDTH: 778px; BACKGROUND: url(v1_down.gif) no-repeat; HEIGHT: 10px
}
.v_table01 {
	TEXT-ALIGN: left; PADDING-BOTTOM: 0px; LINE-HEIGHT: 22px; MARGIN: 0px 0px 15px 20px; PADDING-LEFT: 0px; WIDTH: 735px; PADDING-RIGHT: 0px; FONT-FAMILY: "Arial"; COLOR: #333333; FONT-SIZE: 12pt; PADDING-TOP: 0px
}
    .style1
    {
        width: 167px;
    }
</STYLE>
<SCRIPT type="text/javascript">
    function Print() {
        bdhtml = window.document.body.innerHTML;
        sprnstr = "<!--startprint-->";
        eprnstr = "<!--endprint-->";
        prnhtml = bdhtml.substr(bdhtml.indexOf(sprnstr));
        prnhtml = prnhtml.substring(0, prnhtml.indexOf(eprnstr));
        window.document.body.innerHTML = prnhtml;
        window.print();
    } 
</SCRIPT>  

</HEAD>
<body topMargin=0 bgColor=#ffffff>
    <form id="form1" runat="server">

<!--startprint-->
<TABLE border=0 cellSpacing=0 cellPadding=0 width=778 align=center>
  <TBODY>
  <TR>
    <TD align=right>&nbsp;</TD></TR>
  <TR>
    <TD align=right></TD></TR></TBODY></TABLE>
<TABLE border=0 cellPadding=0 width=778 align=center>
  <TBODY>
  <TR>
    <TD>
      <DIV class=v1>
      <DIV 
      style="TEXT-ALIGN: center; LINE-HEIGHT: 78px; HEIGHT: 75px; FONT-SIZE: 18pt; FONT-WEIGHT: bold" 
      class=v1_top>员&nbsp;&nbsp;&nbsp;&nbsp;工&nbsp;&nbsp;&nbsp;&nbsp;资&nbsp;&nbsp;&nbsp;&nbsp;料</DIV>
      <DIV class=v1_middle>
      <DIV 
      style="LINE-HEIGHT: 18px; BACKGROUND-COLOR: #eff7fb; WIDTH: 728px; HEIGHT: 16px; FONT-WEIGHT: bold" 
      class=v1_t>
      <TABLE border=0 cellSpacing=0 cellPadding=0 width="100%">
        <TBODY>
        <TR>
          <TD width=35>&nbsp;</TD>
          <TD width=91 align=middle style='text-decoration:underline; font-size:14pt;'>基本信息</TD>
          <TD width=602>&nbsp;</TD></TR></TBODY></TABLE></DIV>
      <TABLE style="LINE-HEIGHT: 22px; WIDTH: 735px" class=v_table01 border=0 
      cellSpacing=0 cellPadding=0>
        <TBODY>
        <TR>
          <TD style="WIDTH: 110px;text-decoration:underline" class=weight110 vAlign=top><FONT 
            color=#000 style="text-decoration:underline">姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名：</FONT></TD>
          <TD style="WIDTH: 190px" class=weight190 vAlign=top><SPAN 
            id=RealName5 runat=server></SPAN></TD>
          <TD style="WIDTH: 110px;text-decoration:underline" class=weight110 vAlign=top><FONT 
            color=#000 style="text-decoration:underline">性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别：</FONT></TD>
          <TD style="WIDTH: 190px" class=weight190 vAlign=top><SPAN 
            id=Sex5  runat=server></SPAN> </TD>
          <TD style="WIDTH: 110px;text-decoration:underline" class=weight110 vAlign=top rowSpan=7>
          <asp:Image runat="server" ImageUrl="~/Manage/images/touxiang.jpg" ID='PerPic' 
                Width='128px' Height='150px' style="border:solid 1px #999999" />
          </TD></TR>
        <TR>
          <TD vAlign=top><FONT 
            color=#000 style="text-decoration:underline">年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;龄：</FONT></TD>
          <TD vAlign=top><SPAN id=Birthday5 runat=server></SPAN></TD>
          <TD vAlign=top><FONT 
color=#000 style="text-decoration:underline">民&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;族：</FONT></TD>
          <TD vAlign=top><SPAN id=MinZu5 runat=server></SPAN> </TD></TR>
        <TR>
          <TD vAlign=top><FONT color=#000 style="text-decoration:underline">职能部门：</FONT></TD>
          <TD vAlign=top><SPAN id=UDepName5 runat=server></SPAN> </TD>
          <TD vAlign=top><FONT 
            color=#000 style="text-decoration:underline">职务名称：</FONT></TD>
          <TD vAlign=top><SPAN id=PositionName5 runat=server></SPAN></TD></TR>
        <TR>
          <TD vAlign=top><FONT color=#000 style="text-decoration:underline">移动电话：</FONT></TD>
          <TD vAlign=top><SPAN id=Phone5 runat=server></SPAN> </TD>
          <TD vAlign=top><FONT 
            color=#000 style="text-decoration:underline">固定电话：</FONT></TD>
          <TD vAlign=top><SPAN id=Tel5 runat=server></SPAN></TD></TR>
        <TR>
          <TD vAlign=top><FONT color=#000 style="text-decoration:underline">电子邮件：</FONT></TD>
          <TD vAlign=top><SPAN id=Email5 runat=server></SPAN> </TD>
          <TD vAlign=top><FONT 
            color=#000 style="text-decoration:underline">腾讯 &nbsp;QQ：</FONT></TD>
          <TD vAlign=top><SPAN id=QQ5 runat=server></SPAN></TD></TR>
        <TR>
          <TD vAlign=top><FONT color=#000 style="text-decoration:underline">居住地址：</FONT></TD>
          <TD vAlign=top colSpan=4><SPAN id=HomeAddress5 runat=server></SPAN> 
</TD></TR>
        <TR>
          <TD vAlign=top><FONT color=#000 style="text-decoration:underline">档案文件：</FONT></TD>
          <TD vAlign=top colSpan=4><div id=Q12Q runat=server>
          <%=fjs %>
          </div> 
        </TD></TR>
        
        </TBODY></TABLE>

      <DIV 
      style="LINE-HEIGHT: 18px; BACKGROUND-COLOR: #eff7fb; WIDTH: 728px; HEIGHT: 16px; FONT-WEIGHT: bold" 
      class=v1_t>
      <TABLE border=0 cellSpacing=0 cellPadding=0 width="100%">
        <TBODY>
        <TR>
          <TD width=35>&nbsp;</TD>
          <TD width=91 align=middle style='text-decoration:underline; font-size:14pt;'>人事信息</TD>
          <TD width=602>&nbsp;</TD></TR></TBODY></TABLE></DIV>
      <TABLE style="LINE-HEIGHT: 22px; WIDTH: 735px" class=v_table01 border=0 
      cellSpacing=0 cellPadding=0>
        <TBODY>

        <TR>
          <TD vAlign=top class="style1"><FONT color=#000 style="text-decoration:underline">身份证号：</FONT></TD>
          <TD vAlign=top colSpan=3><SPAN id=SFZNO runat=server></SPAN></TD></TR>

        <TR>
          <TD style="text-decoration:underline" class=style1 vAlign=top><FONT 
            color=#000 style="text-decoration:underline">户口性质：</FONT></TD>
          <TD style="WIDTH: 210px" class=weight190 vAlign=top ><SPAN 
            id=HuKouXZ runat=server></SPAN></TD>
          <TD style="WIDTH: 160px;text-decoration:underline" class=weight110 vAlign=top><FONT 
            color=#000 style="text-decoration:underline">户口所在地：</FONT></TD>
          <TD style="WIDTH: 250px" class=weight190 vAlign=top><SPAN 
            id=HuKouSZD runat=server></SPAN> </TD>
          <TD style="WIDTH: 170px;text-decoration:underline" class=weight110 vAlign=top rowSpan=7>
          </TD></TR>

        <TR>
          <TD vAlign=top class="style1"><FONT color=#000 style="text-decoration:underline">毕业院校：</FONT></TD>
          <TD vAlign=top colSpan=3><SPAN id=BiYeYX runat=server></SPAN></TD></TR>

        <TR>
          <TD vAlign=top class="style1"><FONT 
            color=#000 style="text-decoration:underline">入学时间：</FONT></TD>
          <TD vAlign=top><SPAN id=SchoolTime runat=server></SPAN></TD>
          <TD vAlign=top><FONT 
color=#000 style="text-decoration:underline">参加工作时间：</FONT></TD>
          <TD vAlign=top><SPAN id=WorkTime runat=server></SPAN> </TD></TR>

        <TR>
          <TD vAlign=top class="style1"><FONT color=#000 style="text-decoration:underline">学&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;历：</FONT></TD>
          <TD vAlign=top><SPAN id=XueLi runat=server></SPAN> </TD>
          <TD vAlign=top><FONT 
            color=#000 style="text-decoration:underline">专&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;业：</FONT></TD>
          <TD vAlign=top><SPAN id=ZhuanYe runat=server></SPAN></TD></TR>


        <TR>
          <TD vAlign=top class="style1"><FONT color=#000 style="text-decoration:underline">入职时间：</FONT></TD>
          <TD vAlign=top colSpan=3><SPAN id=JoinTime5 runat=server></SPAN></TD></TR>
        

        <TR>
          <TD vAlign=top class="style1"><FONT 
            color=#000 style="text-decoration:underline">试&nbsp;&nbsp;用&nbsp;&nbsp;期：</FONT></TD>
          <TD vAlign=top><SPAN id=SYQMonth runat=server></SPAN> &nbsp;  个月</TD>
          <TD vAlign=top><FONT 
color=#000 style="text-decoration:underline">转正时间：</FONT></TD>
          <TD vAlign=top><SPAN id=ZhuanZhengRQ runat=server></SPAN> </TD></TR>
          
        <TR>
          <TD vAlign=top class="style1"><FONT 
            color=#000 style="text-decoration:underline">劳动合同年限：</FONT></TD>
          <TD vAlign=top><SPAN id=HTNX runat=server></SPAN> &nbsp;  年</TD>
          <TD vAlign=top><FONT 
color=#000 style="text-decoration:underline">合同签订日期：</FONT></TD>
          <TD vAlign=top><SPAN id=HTRQ runat=server></SPAN> </TD></TR>  
        
        <TR>
          <TD vAlign=top class="style1"><FONT color=#000 style="text-decoration:underline">证件扫描件：</FONT></TD>
          <TD vAlign=top colSpan=4><div id=Div1 runat=server>
          <%=fjs1 %>
          </div> 
        </TD></TR>        

        </TBODY></TABLE>

      <DIV 
      style="LINE-HEIGHT: 18px; BACKGROUND-COLOR: #eff7fb; WIDTH: 728px; HEIGHT: 16px; FONT-WEIGHT: bold" 
      class=v1_t>
      <TABLE border=0 cellSpacing=0 cellPadding=0 width="100%">
        <TBODY>
        <TR>
          <TD width=31>&nbsp;</TD>
          <TD width=131 align=middle style='text-decoration:underline; font-size:14pt;'>公司获奖情况</TD>
          <TD width=572>&nbsp;</TD></TR></TBODY></TABLE></DIV>

     <TABLE class=v_table01 style="WIDTH: 735px; LINE-HEIGHT: 22px" 
      cellSpacing=0 cellPadding=0 border=0>
        <TBODY>
        <TR>
          <TD id=TD1 style="WIDTH: 735px" vAlign=top>
		  <div id=HuoJiang runat=server>
          
          </div>
		  </TD></TR></TBODY></TABLE>


      <DIV 
      style="LINE-HEIGHT: 18px; BACKGROUND-COLOR: #eff7fb; WIDTH: 728px; HEIGHT: 16px; FONT-WEIGHT: bold" 
      class=v1_t>
      <TABLE border=0 cellSpacing=0 cellPadding=0 width="100%">
        <TBODY>
        <TR>
          <TD width=31>&nbsp;</TD>
          <TD width=131 align=middle style='text-decoration:underline; font-size:14pt;'>公司处罚情况</TD>
          <TD width=572>&nbsp;</TD></TR></TBODY></TABLE></DIV>

     <TABLE class=v_table01 style="WIDTH: 735px; LINE-HEIGHT: 22px" 
      cellSpacing=0 cellPadding=0 border=0>
        <TBODY>
        <TR>
          <TD id=Cur_Val style="WIDTH: 735px" vAlign=top>
		  <div id=ChuFa runat=server>
          
          </div>
		  </TD></TR></TBODY></TABLE>


        
        </DIV></DIV></TD></TR>
  <TR>
    <TD colSpan=2><FONT color=white></FONT></TD></TR></TBODY></TABLE>

 <!--endprint-->

<DIV style=' text-align:center'>

<A onclick="Print() " href="#@"><IMG border=0 
      src="../images/Printb.gif"></A>
      
</DIV>
<br><br>

<DIV class=v1_down></DIV>


    </form>
</body>
</html>
