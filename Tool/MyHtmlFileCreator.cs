using System;
using System.Web;
using System.Web.UI;
using System.IO;
using System.Text;

namespace WC.Tool
{
    /// <summary>
    /// 将.aspx文件生成html静态页
    /// </summary>
    public class MyHtmlFileCreator
    {
        private string newUrl;
        private StringWriter html;
        private MyHtmlTextWriter htmlWriter;
        // 在 Web 窗体页上写出一系列连续的 HTML 特定字符和文本。此类提供 ASP.NET 服
        //务器控件在将 HTML 内容呈现给客户端时所使用的格式化功能。

        internal class MyHtmlTextWriter : HtmlTextWriter
        {
            internal MyHtmlTextWriter(TextWriter tw) : base(tw) { }
        }
        //写字器属性
        public HtmlTextWriter RenderHere
        {
            get
            {
                return htmlWriter;
            }
        }

        public MyHtmlFileCreator()
        {
            html = new StringWriter();
            htmlWriter = new MyHtmlTextWriter(html);
            newUrl = HttpContext.Current.Request.Url.AbsolutePath.ToString();
            newUrl = newUrl.Replace(".aspx", ".html");
        }

        public void WriteHtmlFile(string virtualFileName)
        {
            StringReader sr = new StringReader(html.ToString());
            StringWriter sw = new StringWriter();

            string htmlLine = sr.ReadLine();
            while (htmlLine != null)
            {
                /*
                if(!((htmlLine.IndexOf("<form")>0) ||
                (htmlLine.IndexOf("_VIEWSTATE")>0 ) ||
                (htmlLine.IndexOf("</form>")>0)))
                {
                sw.WriteLine(htmlLine);
                } 
                */
                if (!(htmlLine.IndexOf("_VIEWSTATE") > 0))
                {
                    sw.WriteLine(htmlLine);
                }

                //sw.WriteLine(htmlLine);
                htmlLine = sr.ReadLine();
            }

            StreamWriter fs = new StreamWriter(virtualFileName, false, Encoding.UTF8);
            fs.Write(sw.ToString());
            fs.Close();
        }

    }


}
