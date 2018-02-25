using Core;
using System;
using System.Web.UI;

public class Script_MainScript : UserControl
{
    private static string ScriptFormat = "<link href=\"{0}/Themes/Default/Desktop/Desktop.css\" rel=\"stylesheet\" type=\"text/css\" />\r\n<script src=\"{0}/Core/Common.js\" type=\"text/javascript\"></script>\r\n<script src=\"{0}/Core/Config.js.aspx\" type=\"text/javascript\"></script>\r\n<script src=\"{0}/Core/Extent.js\" type=\"text/javascript\"></script>\r\n<script src=\"{0}/Core/Main.js\" type=\"text/javascript\"></script>\r\n<script src=\"{0}/Core/Main/Desktop.js\" type=\"text/javascript\"></script>\r\n<script src=\"{0}/Core/Main/Window.js\" type=\"text/javascript\"></script>\r\n";

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
            return string.Format(ScriptFormat, res);
        }
    }
}

