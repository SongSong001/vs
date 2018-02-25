<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="WC.WebUI.Index" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>协同管理系统</title>
    <script type="text/javascript">
        function IsPC() {
            var ie6 = ! -[1, ] && !window.XMLHttpRequest;

            if (/AppleWebKit.*mobile/i.test(navigator.userAgent) || (/MIDP|SymbianOS|NOKIA|SAMSUNG|LG|NEC|TCL|Alcatel|BIRD|DBTEL|Dopod|PHILIPS|HAIER|LENOVO|MOT-|Nokia|SonyEricsson|SIE-|Amoi|ZTE/.test(navigator.userAgent))) {
                if (window.location.href.indexOf("?mobile") < 0) {
                    try {
                        if (/Android|webOS|iPhone|iPod|BlackBerry/i.test(navigator.userAgent)) {
                            //window.location.href="手机页面";
                            this.window.location = '/Mobile/Index.aspx';
                        } else if (/iPad/i.test(navigator.userAgent)) {
                            //window.location.href="平板页面";
                            this.window.location = '/Mobile/Index.aspx';
                        }
                        else {
                            //window.location.href="其他移动端页面"
                            this.window.location = '/Mobile/Index.aspx';
                        }
                    } catch (e) { }
                }
            }
            //PC端
            else {
                if (ie6) {
                    this.window.location = '/manage/default1.aspx';
                } else {
                    var t = <%=et %> +'';
                    if(t == '1'){
                    this.window.location = '/manage/default.aspx';}
                    else {
                    this.window.location = '/manage/default1.aspx';}
                }
            }

        }
    </script>

</head>
<body onload=IsPC()>
<noscript>
<div style=" position:absolute; z-index:100000; height:2046px;top:0px;left:0px; width:100%; background:white; text-align:center;">
    <img src="manage/images/noscript.gif" alt='抱歉，请开启脚本支持！' />
</div></noscript>
    <form id="form1" runat="server">
    </form>
</body>
</html>
