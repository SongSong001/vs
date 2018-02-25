using System;
using System.Configuration;
using System.Web.UI;

public class FloatForm : Page
{
    public string floatWindowShowTime;

    protected void Page_Load(object sender, EventArgs e)
    {
        this.floatWindowShowTime = ConfigurationManager.AppSettings["FloatWindowShowTime"];
    }
}

