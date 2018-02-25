using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Collections;

/// <summary>
/// 命令控制
/// </summary>
public partial class CommandCtrl : System.Web.UI.UserControl
{
    /// <summary>
    /// 命令委托
    /// </summary>
    /// <param name="cmd">命令类型</param>
    /// <param name="data">数据</param>
    public delegate void OnCommandDelegate(string cmd, object data);

    public event OnCommandDelegate OnCommand;

    private Hashtable _state = new Hashtable();

    /// <summary>
    /// 状态集合
    /// </summary>
    public Hashtable State
    {
        get { return _state; }
    }

    protected void Page_Init(object sender, EventArgs e)
    {
        OnCommand += new OnCommandDelegate(CommandCtrl_OnCommand);
        //初始化把页面控件的json信息转换成状态集合
        if (!String.IsNullOrEmpty(Request.Params[ClientID + "_state_json"]))
        {
            _state = Core.Utility.ParseJson(Request.Params[ClientID + "_state_json"]) as Hashtable;
        }
    }

    private void CommandCtrl_OnCommand(string command, object data)
    {

    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!String.IsNullOrEmpty(Request.Params[ClientID + "_command"]))
        {
            OnCommand(
                Request.Params[ClientID + "_command"],
                Core.Utility.ParseJson(Request.Params[ClientID + "_data"])
            );
        }
    }

    /// <summary>
    /// 状态Json数据
    /// </summary>
    protected String StateJson
    {
        get { return Core.Utility.RenderJson(_state).Replace("\"", "&quot;").Replace("<", "&lt;"); }
    }

    /// <summary>
    /// 状态变量名称
    /// </summary>
    protected String StateVarName
    {
        get { return "__" + ClientID + "_state"; }
    }
}
