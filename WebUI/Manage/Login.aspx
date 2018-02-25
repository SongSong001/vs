<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WC.WebUI.Manage.Login" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>用户登录 - <%=comname %></title>
<link href="images/skin.css" rel="stylesheet" type="text/css">     
<link rel=stylesheet type=text/css href="images/style_login.css">  
<script type="text/javascript" src="/js/validator.js"></script> 
<script type="text/javascript">

    function getPX() {
        document.getElementById("px").value = window.screen.width + "?" + window.screen.height;
        var ie6 = ! -[1, ] && !window.XMLHttpRequest;
        if (ie6) {
            document.getElementById("isie6").value = '1'; 
            alert('您的浏览器是IE6，只支持 传统风格! 建议升级到IE8!'); }
    }

    function AddFavorite(sURL, sTitle) {
    try {
        window.external.addFavorite(sURL, sTitle);
    }
    catch (e) {
        try {
            window.sidebar.addPanel(sTitle, sURL, "");
        }
        catch (e) {
            alert("加入收藏失败，请使用Ctrl+D进行手工设置");
        }
    }
}

    function SetHome(obj, url) {
    try {
        obj.style.behavior = 'url(#default#homepage)'; obj.setHomePage(url);
    }
    catch (e) {
        if (window.netscape) {
            try {
                netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");
            }
            catch (e) {
                alert("您的浏览器不支持设为首页，请手工设置");
            }
            var prefs = Components.classes['@mozilla.org/preferences-service;1'].getService(Components.interfaces.nsIPrefBranch);
            prefs.setCharPref('browser.startup.homepage', url);
        }
    }
}
</script>
</head>
<body onload='getPX()'>
<asp:Panel runat=server ID=dxbbs_div Visible=false>
</asp:Panel> 
<form id="form1" runat="server" onsubmit="return Validator.Validate(this.form,1);">
<input type=hidden id=px name=px value="" />
<input type=hidden id=isie6 name=isie6 value="0" />
    <div>
   
<TABLE border=0 cellSpacing=0 cellPadding=0 width="100%" height="100%">
  <TBODY>
  <TR>
    <TD height=69 vAlign=top background=images/index_3.gif>
      <TABLE border=0 cellSpacing=0 cellPadding=0 width="100%">
        <TBODY>
        <TR>
          <TD vAlign=top rowSpan=2 width=289></TD>
          <TD class=cc03 height=2></TD></TR>
        <TR>
          <TD height=67 vAlign=bottom></TD></TR></TBODY></TABLE></TD></TR>
  <TR>
    <TD class=cc01 vAlign=top align=middle>
      <TABLE border=0 cellSpacing=0 cellPadding=0 width=700 align=center 
      height="100%">
        <TBODY>
        <TR>
          <TD height=95>&nbsp;</TD>
          <TD class=cc05 rowSpan=2 width=2></TD>
          <TD height=95>&nbsp;</TD></TR>
        <TR>
          <TD style="BACKGROUND: url(<%=logo %>) no-repeat right top" height=285 vAlign=top width=319></TD>
          <TD vAlign=top style='BORDER-LEFT: dotted thin #cccccc;'>
            <TABLE class=cc06 border=0 cellSpacing=0 cellPadding=0>
              <TBODY>
              <TR>
                <TD height=30 width=53>用户名：</TD>
                <TD colSpan=2>
              <input name="UserName" value='' style="color:#ff0000; font-weight:bold; padding-left:5px; width:125px; height:25px; vertical-align:middle;" type="text" id=UserName dataType="Require" msg="用户名不能为空" maxLength=16 />                    
              <img src="images/ico_user.gif" width="19" height="18"> 
                </TD></TR>
              <TR>
                <TD height=30>密 码：</TD>
                <TD colSpan=2>
              <input type="password" value='' style="color:#ff0000; font-weight:bold; padding-left:5px; width:125px; height:25px; vertical-align:middle;" name=PassWord id=PassWord dataType="Require" msg="密码不能为空" maxLength=16 />
                <img src="images/luck.gif" width="19" height="18"> 
                </TD></TR>
              <asp:Panel runat=server ID=ValidCodeState Visible=false>  
              <TR>
                <TD height=30>验证码：</TD>
                <TD>
                <input type=text style="color:#ff0000; font-weight:bold; padding-left:5px; width:125px; height:25px; vertical-align:middle;" title="看不清楚?点击图片切换" id=GetCode maxLength=4 name=GetCode dataType="Require" msg="验证码不能为空" />
                </TD>
                <TD> &nbsp; <img id="vcodeImg" src="about:blank" onerror="this.onerror=null;this.src='/js/GetCode_Login.aspx?s='+Math.random();"
alt="验证码" title="看不清楚?点击换一张" style="margin-left: 8px; cursor: pointer; width: 85px;
height: 23px;border-width:0px;border:solid 1px #999999; vertical-align:middle;" onclick="src='/js/GetCode_Login.aspx?s='+Math.random();" /></TD></TR>
                </asp:Panel>
              <TR>
                <TD height=30>风 格：</TD>
                <TD colSpan=2>
                <asp:RadioButtonList runat=server RepeatDirection=Horizontal ID=sys_style>
                <asp:ListItem  Text=经典风格 Value=0 style="position: relative;"></asp:ListItem>
                <asp:ListItem Text=传统风格 Value=1 style="position: relative;"></asp:ListItem>
                </asp:RadioButtonList>
                </TD></TR>
              <TR>
                <TD height=60>&nbsp;</TD>
                <TD>
                <asp:Button runat=server class="button" ID=Button1 Text=' 登录 ' OnClick=Login_Btn OnClientClick="return Validator.Validate(this.form,1);" />
                </TD>
                <td> &nbsp; <input id="chkRemember" type="checkbox" name="chkRemember" style="margin-left:8px;vertical-align:middle;" /> <label for="chkRemember" style="vertical-align:middle;">记住本次登录</label>
                </td>
                </TR></TBODY></TABLE></TD></TR>
        <TR>
          <TD vAlign=top colSpan=3 align=middle>
            <TABLE class=cc11 border=0 cellSpacing=0 cellPadding=0 
              width="70%"><TBODY>
              <TR>
                <TD height=20 colSpan=2>&nbsp;</TD></TR>
              <TR>
                <TD width="8%" align=right>
                <img src="images/ico_settings.gif" width="18" height="18">
                </TD>
                <TD class=cc09 width="92%"> &nbsp; &nbsp; <a href="guide.zip" target=_blank class="left_txt3"><span style="font-weight:bold; color:#ff0000">用户使用培训手册(点击下载)</span></a>
                 - (推荐1024*768以上分辨率)
                </TD></TR>
            
              <TR>
                <TD height=1 
        colSpan=2>&nbsp;</TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE></TD></TR>
  <TR>
    <TD height=24 vAlign=top background=images/index_15.gif>
      <TABLE border=0 cellSpacing=0 cellPadding=0 width="100%" align=center>
        <TBODY>
        <TR>
          <TD class=cc02 height=2 vAlign=top></TD></TR>
        <TR>
          <TD class=aa13 height=24 align=middle>
					   Copyright © &nbsp;<span style="font-weight:bold;">&nbsp;<a class="aaa" href='<%=comurl %>' target=_blank><%=comname %></a> &nbsp; </span>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
					   <strong><a class="aaa" href='#@' onclick=AddFavorite('<%=WC.Tool.Utils.GetRequestHostUrl().ToLower().Replace("/manage/", "") %>','<%="协同管理系统_"+comname %>')>>>加入收藏</a>
					    &nbsp;
					   <a class="aaa" href='#@' onclick=SetHome(this,'<%=WC.Tool.Utils.GetRequestHostUrl().ToLower().Replace("/manage/", "") %>')>>>设为首页</a> 
                        &nbsp; <a class="aaa" href='Url_bt.aspx' target=_blank >>>快捷方式</a></strong>
          </TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE>   
    
    </div>
    </form>
</body>
</html>
