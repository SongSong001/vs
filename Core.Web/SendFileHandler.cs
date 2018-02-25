namespace Core.Web
{
    using Core;
    using Core.IO;
    using System;
    using System.Web;

    internal class SendFileHandler : IHttpHandler
    {
        void IHttpHandler.ProcessRequest(HttpContext context)
        {
            Exception error = null;
            HttpPostedFile file = context.Request.Files[0];
            string filename = ServerImpl.Instance.GetFullPath(context, "Temp") + "/" + Guid.NewGuid().ToString();
            Directory.CreateDirectory(filename);
            filename = filename + "/" + file.FileName;
            try
            {
                if (WC.Tool.Config.IsValidFile(file))
                    file.SaveAs(ServerImpl.Instance.MapPath(filename));
            }
            catch (Exception e)
            {
                error = e;
            }
            if (error == null)
            {
                context.Response.Write(Utility.RenderHashJson(new object[] { "Result", true, "Path", filename }));
            }
            else
            {
                context.Response.Write(Utility.RenderHashJson(new object[] { "Result", false, "Exception", error }));
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

