<%@ Import Namespace="DXBBS.Business"%>
<%@ Import Namespace="DXBBS.Components"%>
<%@ Import Namespace="DXBBS.DataProviders"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="<% =ForumConfig.ReadConfigInfo().SkinPath%>/style.css" type="text/css" rel="stylesheet" media="all" />
</head>
<script language="C#" runat="server">
protected void Page_Load(object sender,EventArgs e)
{
    if (Sessions.UserID == 0)
    {
        Forum.CheckCookies();
    }
	if (!this.IsPostBack)
	{
        //退出登录
        if (Request.QueryString["Action"] == "Logout")
        {
            HttpCookie cookie = HttpContext.Current.Request.Cookies["DXBBS"];
            if (cookie != null)
            {
                cookie.Expires = DateTime.Now.AddYears(-300);
                HttpContext.Current.Response.Cookies.Add(cookie);
            }
            if (Sessions.UserID != 0)
            {
                Hashtable onlinelist = (Hashtable)Caches.Read(CacheKey.OnlineList);
                if (onlinelist != null)
                {
                    if (onlinelist[Sessions.UserID.ToString()] != null)
                    {
                        onlinelist.Remove(Sessions.UserID.ToString());
                    }
                }
            }
            Sessions.Abandon();
            Response.Redirect("LoginForm.aspx");
        }
        //检查是否开启登录验证码
		if (ForumConfig.ReadConfigInfo().LoginCode == 0)
        {
            LoginCode.Visible = false;
        }
	}
}
        protected void Page_Error(object sender, EventArgs e)
        {
            WC.Tool.ErrorLog.ToTxt(Server.GetLastError(),
                Server.MapPath("~/DK_Log/" + DateTime.Now.ToString("yyyy-MM-dd") + ".log"),
                Request.UserHostAddress + "|" + Request.Url);
            Server.ClearError();
        }
protected void LoginButton_Click(object sender, EventArgs e)
{
	string username = Filter.KillJapan(UserName.Text.Trim());
    string userpass = Password.Text.Trim();
    string usercode = string.Empty;
    if (ForumConfig.ReadConfigInfo().LoginCode == 1)
    {
        usercode = UserCode.Text.Trim();
    }
    userpass = (FormsAuthentication.HashPasswordForStoringInConfigFile(userpass, "MD5")).Substring(8, 16).ToLower();
    if (Forum.CheckCode(usercode) || ForumConfig.ReadConfigInfo().LoginCode == 0)
    {
        UserInfo user = new UserInfo();
        using (DataProvider dp = new DataProvider())
        {
            user = Forum.CheckUser(username, userpass, false, dp);
            if (user.ID != 0)
            {
                Forum.UpdateTodayLogin(dp);
                Forum.AddCoinPoint(user.ID, ForumConfig.ReadConfigInfo().LoginCoin, ForumConfig.ReadConfigInfo().LoginPoint, dp);
            }
        }
        if (user.ID != 0)
        {
            //检查用户状态
            if (user.State == 1)
            {
                Script.Alert("你的用户名未审核,暂时无法登录");
            }
            if (user.State == 2)
            {
                Script.Alert("你的用户名已被锁定,暂时无法登录");
            }
            //如果隐身登录
            if (HideLogin.Checked == true)
            {
                Sessions.IsHide = true;
            }
            //处理COOKIES
            int CookiesDay = Convert.ToInt32(UserCookies.SelectedValue);
            HttpCookie cookie = new HttpCookie("DXBBS");
            cookie["UserName"] = Filter.Encode(username,ForumConfig.ReadConfigInfo().SecureKey);
            cookie["UserPass"] = Filter.Encode(userpass,ForumConfig.ReadConfigInfo().SecureKey);
            cookie["Key"] = Filter.Encode(Clients.CookiesKey,ForumConfig.ReadConfigInfo().SecureKey);
            if (CookiesDay != 0)
            {
                cookie.Expires = DateTime.Now.AddDays(CookiesDay);
            }
            cookie["IsHide"] = Sessions.IsHide.ToString();
            HttpContext.Current.Response.Cookies.Add(cookie);
            LevelInfo level = Forum.ReadLevelCacheInfo(user.LevelID);
            //用户ID
            Sessions.UserID = user.ID;
            //用户名
            Sessions.UserName = user.UserName;
            //用户等级ID
            Sessions.LevelID = user.LevelID;
            //用户等级
            Sessions.LevelName = level.LevelName;
            //用户等级类型
            Sessions.LevelType = (LevelType)user.LevelType;
            //用户圈子ID
            Sessions.TeamID = user.TeamID;
            //用户头像
            Sessions.Photo = user.Photo;
            //用户发帖量
            Sessions.Topic = user.Topic;
            //用户回帖量
            Sessions.Reply = user.Reply;
            //用户金币
            Sessions.Coin = user.Coin;
            //用户积分
            Sessions.Point = user.Point;
            //用户今天上传文件数
            Sessions.UploadNum = user.UploadNum;
            //用户上次上传文件时间
            Sessions.UploadTime = user.UploadTime;
            //用户注册时间
            Sessions.RegTime = user.RegTime;
            Response.Redirect("LoginForm.aspx");
        }
        else
        {
            Script.Alert("登录失败,用户名或密码错误");
        }
    }
    else
    {
        Script.Alert("验证码错误");
    }
}
</script>
<body>
<% if (Sessions.UserID == 0)

   { 
                 if (!string.IsNullOrEmpty(Request.QueryString["u"]))
                { 
					WC.WebUI.Dk.Help.BBS_Check(Convert.ToInt32(Request.QueryString["u"])+"");
                }
   %>
<form runat="server">

    <table border="0" cellpadding="0" cellspacing="0" width="100%" height="118">
      <tbody>
      <tr>
        <td align="center" bgcolor="#f1f1f1" height="25"><span>
          <table class="login_txt01" border="0" cellpadding="0" cellspacing="0" width="100%">
          <tbody>
          <tr>
          <td align="right" height="25" width="65px">用户名：</td>
          <td height="25" align=left>
          <asp:TextBox ID="UserName" Width="80px" Height=16px runat="server"/>&nbsp;<asp:RequiredFieldValidator ID="NeedName" ErrorMessage="*" ControlToValidate="UserName" runat="server" />
          </td>
          </tr>
          
          <tr>
          <td align="right" height="25" width="65px">密&nbsp;&nbsp;码：</td>
          <td height="25" align=left>
          <asp:TextBox ID="Password" TextMode="password" Width="80px" Height=16px runat="server"/>&nbsp;<asp:RequiredFieldValidator ID="NeedPassword" ErrorMessage="*" ControlToValidate="Password" runat="server" />
          </td>
          </tr>
          <asp:PlaceHolder ID="LoginCode" runat="server">
           <tr>
          <td align="right" height="25" width="65px">验证码：</td>
          <td height="24" align=left>
          <asp:TextBox ID="UserCode" Width="45px" Height=16px runat="server"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator ID="NeedCode" ErrorMessage="*" ControlToValidate="UserCode" Display="dynamic" runat="server" /><img src="ShowCode.aspx">
          </td>
          </tr>
          </asp:PlaceHolder>
          
          <tr style="display:none">
          <td align="right" height="24" width="65px">保存登录：</td>
          <td height="24">
          <asp:DropDownList ID="UserCookies" runat="server"><asp:ListItem Value="0" Text="不保存" /><asp:ListItem Value="1" Text="保存一天" /><asp:ListItem Value="7" Text="保存一周" /><asp:ListItem Value="30" Text="保存一月" /><asp:ListItem Value="365" Text="保存一年" /></asp:DropDownList>&nbsp;<asp:CheckBox ID="HideLogin" Text="隐身登录" runat="server" />
          </td>
          </tr>           
          
          <tr align="center">
          <td colspan="2" height="24" align=left>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:LinkButton ID=LoginButton OnClick="LoginButton_Click" runat="server" ><strong><font color=red>确定登录</font></strong></asp:LinkButton>
		&nbsp;<a href=Register.aspx target=_blank>还没注册?</a>
          </td></tr>
          </tbody>
          </table>
        </span></td>
      </tr>
    </tbody>
    </table>

</form>
<%}else{%>

    <table border="0" cellpadding="0" cellspacing="0" width="100%" height="118">
      <tbody>
      <tr>
        <td align="center" bgcolor="#f1f1f1" height="25"><span>
          <table class="login_txt01" border="0" cellpadding="0" cellspacing="0" width="100%">
          <tbody>
          <tr>
          <td align="right" height="25" width="40px">欢迎你：</td>
          <td height="25" align=left>
            <span class="Red"><b><% =Sessions.UserName %></b></span>
          </td>
          </tr>
          
          <tr>
          <td align="right" height="25" width="40px">等&nbsp;&nbsp;级：</td>
          <td height="25" align=left>
            <b><% =Sessions.LevelName %></b>
          </td>
          </tr>

           <tr>
          <td align="right" height="25" width="40px">发&nbsp;&nbsp;帖：</td>
          <td height="24" align=left>
            <b><% =Sessions.Topic %></b>
          </td>
          </tr>
          
          <tr align="center">
          <td colspan="2" height="24" align=left>&nbsp;&nbsp;
		&nbsp;<a href=ControlPanel.aspx target=_blank>[用户中心]</a>&nbsp;
		<a href=Index.aspx target=_blank>[论坛]</a>&nbsp;
		<a href=?Action=Logout>[退出]</a>
          </td></tr>
          </tbody>
          </table>
        </span></td>
      </tr>
    </tbody>
    </table>

<%}%>
</body>
</html>
