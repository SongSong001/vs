namespace Core.Web
{
    using Core;
    using System;
    using System.IO;
    using System.Web;

    public class DownloadJsHandler : IHttpHandler
    {
        private static string EmbedJsFormat = "var Core = {{}}\r\nCore.Config = {{\r\n\tVersion: \"{0}\",\r\n\tServiceUrl: \"{1}\",\r\n\tResPath: \"{3}\"\r\n}};\r\n\r\ndocument.write('<link href=\"{2}/Themes/Default/Desktop/Desktop.css\" rel=\"stylesheet\" type=\"text/css\" />');\r\ndocument.write('<script src=\"{2}/Core/Common.js\" type=\"text/javascript\"><'+'/script>');\r\ndocument.write('<script src=\"{2}/Core/Extent.js\" type=\"text/javascript\"><'+'/script>');\r\ndocument.write('<script src=\"{2}/Core/Main.js\" type=\"text/javascript\"><'+'/script>');\r\ndocument.write('<script src=\"{2}/Core/Main/Desktop.js\" type=\"text/javascript\"><'+'/script>');\r\ndocument.write('<script src=\"{2}/Core/Main/Window.js\" type=\"text/javascript\"><'+'/script>');\r\n";

        void IHttpHandler.ProcessRequest(HttpContext context)
        {
            string js;
            switch (Path.GetFileName(context.Request.FilePath).ToLower())
            {
                case "config.js.aspx":
                    js = string.Format("\r\n\t\t\t\t\tCore.Config = {{\r\n\t\t\t\t\t\tVersion: '{0}',\r\n\t\t\t\t\t\tServiceUrl: '{1}',\r\n\t\t\t\t\t\tResPath: '{2}'\r\n\t\t\t\t\t}};", ServerImpl.Instance.Version, ServerImpl.Instance.ServiceUrl, ServerImpl.Instance.ResPath);
                    context.Response.ContentType = "application/x-javascript";
                    context.Response.Write(js);
                    break;

                case "embed.js.aspx":
                {
                    string resRoot = ServerImpl.Instance.ServiceUrl;
                    if (!resRoot.EndsWith("/"))
                    {
                        resRoot = resRoot + "/";
                    }
                    resRoot = resRoot + ServerImpl.Instance.ResPath;
                    js = string.Format(EmbedJsFormat, new object[] { ServerImpl.Instance.Version, ServerImpl.Instance.ServiceUrl, resRoot, ServerImpl.Instance.ResPath });
                    context.Response.ContentType = "application/x-javascript";
                    context.Response.Write(js);
                    break;
                }
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

