using System;
using System.Web;
using System.Web.UI;
using System.IO;
using System.Text;

namespace WC.Tool
{
    /// <summary>
    /// ��.aspx�ļ�����html��̬ҳ
    /// </summary>
    public class MyHtmlFileCreator
    {
        private string newUrl;
        private StringWriter html;
        private MyHtmlTextWriter htmlWriter;
        // �� Web ����ҳ��д��һϵ�������� HTML �ض��ַ����ı��������ṩ ASP.NET ��
        //�����ؼ��ڽ� HTML ���ݳ��ָ��ͻ���ʱ��ʹ�õĸ�ʽ�����ܡ�

        internal class MyHtmlTextWriter : HtmlTextWriter
        {
            internal MyHtmlTextWriter(TextWriter tw) : base(tw) { }
        }
        //д��������
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
