using Core;
using System;
using System.Web.UI;
using System.Web.UI.HtmlControls;

public class ChatForm : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ((HtmlInputHidden) this.FindControl("data")).Value = Utility.RenderHashJson(new object[] { "Peer", AccountImpl.Instance.GetUserInfo(base.Request.Params["peer"]).DetailsJson, "User", AccountImpl.Instance.GetUserInfo(ServerImpl.Instance.GetUserName(this.Context)).DetailsJson });
    }
}

