<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SmallTool.aspx.cs" Inherits="WC.WebUI.Manage.Common.SmallTool" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/><title>企业通讯录</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link type="text/css" href="/manage/Style/InterFace.Css" rel="stylesheet" rev="stylesheet" media="all" />
<link type="text/css" href="/manage/style.css" rel="stylesheet" rev="stylesheet" media="all" />
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/manage/include/common.js"></script>
<script type="text/javascript" src="/js/validator.js"></script>    
<script type="text/javascript" src="/js/popup/popup.js"></script>
<script type="text/javascript">
function WZ()
{
	var pop = new Popup({ contentType: 1, scrollType: 'yes', isReloadOnClose: false, width: 800, height: 460 });
	pop.setContent("contentUrl", '/DK_Css/WZ/index.htm');
	pop.setContent("title", "网址大全");
	pop.build();
	pop.show();
}
function JSQ()
{
	var pop = new Popup({ contentType: 1, scrollType: 'yes', isReloadOnClose: false, width: 800, height: 460 });
	pop.setContent("contentUrl", '/manage/utils/calar/jsq.htm');
	pop.setContent("title", "计算器");
	pop.build();
	pop.show();
}
function WNL()
{
	var pop = new Popup({ contentType: 1, scrollType: 'yes', isReloadOnClose: false, width: 800, height: 460 });
	pop.setContent("contentUrl", '/manage/utils/calar/Calendar.htm');
	pop.setContent("title", "多功能万年历");
	pop.build();
	pop.show();
}
function LSJT()
{
	var pop = new Popup({ contentType: 1, scrollType: 'yes', isReloadOnClose: false, width: 800, height: 460 });
	pop.setContent("contentUrl", '/dk_css/history/history.aspx');
	pop.setContent("title", "历史上的今天");
	pop.build();
	pop.show();
}
function HWSX()
{
	var pop = new Popup({ contentType: 1, scrollType: 'yes', isReloadOnClose: false, width: 880, height: 465 });
	pop.setContent("contentUrl", '/dk_css/search/index.htm');
	pop.setContent("title", "快捷网络搜索");
	pop.build();
	pop.show();
}
</script>
</head>
<body >
    <form id="form1" runat="server">
<div id="interface_inside">
  <div id="interface_quick">
    <div class="interface_quick_left">您现在的操作 >> 我的工具 >> 小工具</div>
    <div class="interface_quick_right">

    </div>
    <div class="clearboth"></div>
  </div>
  <div id="interface_main">
    <div id="tabs_config" class="tabsbox">
      

      <div class="clearboth"></div>
      
      
      <!-- 模块 -->
      <div id="config_basic" class="tabs_wrapper"><div class="tabs_main" align='center'>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" >
          <tr>
            <td><div id="Div1" class="tabsbox">
              <ul class="idTabs">
                <li><a href='#@' onclick='JSQ()'>科学计算器</a></li>
                <li><a href="#@" onclick='WNL()'>多功能万年历</a></li>
                <li><a href='#@' onclick='WZ()'>网址大全</a></li>
                <li><a href="#@" onclick='LSJT()'>历史上的今天</a></li>
                <li><a href='#@' onclick='HWSX()'>网络搜索</a></li>
              </ul>
              <div id="config_basic1" class="tabs_wrapper"><div class="tabs_main" align="left">      
    
<div id="PanelConfig">

</div>

              </div></div>
            </div></td>
          </tr>
        </table>
      </div></div>
      <!-- 模块 -->

    </div>
  </div>
</div>
    </form>
</body>
</html>
