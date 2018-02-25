using Core;
using System;
using System.Web.UI;

public class Script_SubScript : UserControl
{
    private static string ScriptFormat = "<script src=\"{0}/Core/Common.js\" type=\"text/javascript\"></script>\r\n<script src=\"{0}/Core/Config.js.aspx\" type=\"text/javascript\"></script>\r\n<script src=\"{0}/Core/Extent.js\" type=\"text/javascript\"></script>\r\n<script src=\"{0}/Core/UI.js\" type=\"text/javascript\"></script>\r\n<script src=\"{0}/Core/Sub.js\" type=\"text/javascript\"></script>\r\n";
    private static string SkinCssFormat = "<link href=\"{0}/Themes/Default/skin.css\" rel=\"stylesheet\" type=\"text/css\" />\r\n";

    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected string CommonScript
    {
        get
        {
            string res = ServerImpl.Instance.ServiceUrl;
            if (!res.EndsWith("/"))
            {
                res = res + "/";
            }
            res = res + ServerImpl.Instance.ResPath;
            return string.Format("\r\n" + SkinCssFormat + ScriptFormat, res);
        }
    }
}

