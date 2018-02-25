namespace Core
{
    using System;
    using System.IO;
    using System.Reflection;
    using System.Threading;
    using System.Web;
    using System.Xml;

    public class SendCommandHandler : IHttpHandler
    {
        void IHttpHandler.ProcessRequest(HttpContext context)
        {
            Exception error = null;
            string data = null;
            try
            {
                Stream inputStream = context.Request.InputStream;
                byte[] buffer = new byte[inputStream.Length];
                inputStream.Read(buffer, 0, (int) inputStream.Length);
                string content = context.Request.ContentEncoding.GetString(buffer);
                XmlDocument doc = new XmlDocument();
                doc.LoadXml(content);
                string[] handlerInfo = doc.DocumentElement.GetAttribute("Handler").Split(new char[] { ' ' });
                string cmdId = doc.DocumentElement.GetAttribute("ID");
                string sessionId = doc.DocumentElement.GetAttribute("SessionID");
                bool isAsyn = bool.Parse(doc.DocumentElement.GetAttribute("IsAsyn"));
                CommandHandler handler = Assembly.Load(handlerInfo[0]).GetType(handlerInfo[1]).GetConstructor(new Type[] { typeof(HttpContext), typeof(string), typeof(string), typeof(string) }).Invoke(new object[] { context, sessionId, cmdId, doc.DocumentElement.InnerXml }) as CommandHandler;
                if (isAsyn)
                {
                    ThreadPool.QueueUserWorkItem(new WaitCallback(handler.Process));
                }
                else
                {
                    data = handler.Process();
                }
            }
            catch (Exception ex)
            {
                error = ex;
            }
            if (error == null)
            {
                context.Response.Write(Utility.RenderHashJson(new object[] { "IsSucceed", true, "Data", new JsonText(data) }));
            }
            else
            {
                context.Response.Write(Utility.RenderHashJson(new object[] { "IsSucceed", false, "Exception", error }));
            }
        }

        bool IHttpHandler.IsReusable
        {
            get
            {
                return true;
            }
        }
    }
}

