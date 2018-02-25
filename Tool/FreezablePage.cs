using System;

namespace WC.Tool
{
    public class FreezablePage : System.Web.UI.Page
    {

        private bool freeze = false;
        private string newUrl;

        public string NewUrl
        {
            get
            {
                return newUrl;
            }
            set
            {
                newUrl = value;
            }
        }
        public FreezablePage()
        {
            //
            // TODO: 在此处添加构造函数逻辑
            //
        }

        protected override void Render(System.Web.UI.HtmlTextWriter writer)
        {
            if (freeze)
            {
                MyHtmlFileCreator htmlFile = new MyHtmlFileCreator();
                base.Render(htmlFile.RenderHere);
                htmlFile.WriteHtmlFile(Server.MapPath(newUrl));
                Response.Redirect(newUrl, true);
            }
            else
            {
                base.Render(writer);
            }
        }

        protected void Freeze()
        {
            freeze = true;
        }
        protected void Freeze(string toUrl)
        {
            freeze = true;
            newUrl = toUrl;
        }


    }
}
