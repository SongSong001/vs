namespace Core.Web
{
    using Core;
    using Core.IO;
    using System;
    using System.Collections;
    using System.Drawing;
    using System.Drawing.Imaging;
    using System.IO;
    using System.Text;
    using System.Web;

    public class DownloadHandler : IHttpHandler
    {
        private static Hashtable ContentType = new Hashtable();

        static DownloadHandler()
        {
            ContentType[".JS"] = "application/x-javascript";
            ContentType[".XML"] = "text/xml";
            ContentType[".HTML"] = "text/html";
            ContentType[".HTM"] = "text/html";
            ContentType[".CSS"] = "text/css";
            ContentType[".TXT"] = "text";
            ContentType[".PNG"] = "image";
            ContentType[".BMP"] = "image";
            ContentType[".GIF"] = "image";
            ContentType[".JPG"] = "image";
            ContentType[".ICO"] = "image";
            ContentType[".CUR"] = "image";
        }

        void IHttpHandler.ProcessRequest(HttpContext context)
        {
            string fileName = "";
            if (System.IO.Path.GetFileName(context.Request.Url.AbsolutePath).ToLower() == "headimg.aspx")
            {
                string user = context.Request.QueryString["user"];
                int size = Convert.ToInt32(context.Request.QueryString["size"] ?? "0");
                bool gred = Convert.ToBoolean(context.Request.QueryString["gred"] ?? "false");
                string OnLine = context.Request.QueryString["OnLine"];
                AccountInfo userInfo = AccountImpl.Instance.GetUserInfo(user);
                string preFileName = userInfo.HeadIMG;
                if (!Core.IO.File.Exists(preFileName))
                {
                    preFileName = string.Format("/{0}/Public/Images/HeadImg/{1}.png", userInfo.Name, (userInfo.Type == 0) ? "user" : "group");
                }
                fileName = preFileName;
                if (gred)
                {
                    fileName = fileName + ".gred";
                }
                if (size > 0)
                {
                    fileName = fileName + string.Format(".{0}", size);
                }
                if (fileName != preFileName)
                {
                    fileName = fileName + ".png";
                    if (!Core.IO.File.Exists(fileName))
                    {
                        fileName = ZoomHeadImage(preFileName, fileName, size, size, gred);
                    }
                }
            }
            else
            {
                fileName = ServerImpl.Instance.GetFullPath(context, context.Request["FileName"]);
            }
            ServerImpl.Instance.CheckPermission(context, fileName, 4);
            using (Stream stream = Core.IO.File.Open(fileName, FileMode.Open, FileAccess.Read, FileShare.Read))
            {
                try
                {
                    int c;
                    bool CS_4_0000;
                    string ext = Core.IO.Path.GetExtension(fileName).ToUpper();
                    if (ContentType.ContainsKey(ext))
                    {
                        context.Response.ContentType = ContentType[ext] as string;
                        context.Response.AppendHeader("Content-Disposition", string.Format("filename={0}", HttpUtility.UrlEncode(Core.IO.Path.GetFileName(fileName), Encoding.UTF8)));
                    }
                    else
                    {
                        context.Response.ContentType = "application/octet-stream";
                        context.Response.AppendHeader("Content-Disposition", string.Format("attachment;filename={0}", HttpUtility.UrlEncode(Core.IO.Path.GetFileName(fileName), Encoding.UTF8)));
                    }
                    Core.IO.FileSystemInfo fileInfo = new Core.IO.FileInfo(fileName);
                    if (fileInfo != null)
                    {
                        context.Response.AppendHeader("Last-Modified", string.Format("{0:R}", fileInfo.LastWriteTime));
                    }
                    context.Response.AppendHeader("Content-Length", stream.Length.ToString());
                    byte[] buffer = new byte[0x1000];
                    goto Label_02FB;
                Label_02C3:
                    c = stream.Read(buffer, 0, buffer.Length);
                    if (c == 0)
                    {
                        return;
                    }
                    context.Response.OutputStream.Write(buffer, 0, c);
                Label_02FB:
                    CS_4_0000 = true;
                    goto Label_02C3;
                }
                finally
                {
                    stream.Close();
                }
            }
        }

        public static string update_pixelColor(string filePath, string targetImg, bool colorIndex)
        {
            using (Stream stream = Core.IO.File.Open(filePath, FileMode.Open, FileAccess.Read, FileShare.Read))
            {
                Bitmap img = new Bitmap(stream);
                using (Stream target_stream = Core.IO.File.Open(targetImg, FileMode.Create, FileAccess.Write, FileShare.None))
                {
                    if (colorIndex)
                    {
                        Utility.ToGray(img, 0).Save(target_stream, ImageFormat.Png);
                        return targetImg;
                    }
                    img.Save(target_stream, ImageFormat.Png);
                    return targetImg;
                }
            }
        }

        private static string ZoomHeadImage(string headImg, string targetImg, int width, int height, bool gred)
        {
            using (Stream stream = Core.IO.File.Open(headImg, FileMode.Open, FileAccess.Read, FileShare.Read))
            {
                Stream target_stream;
                Bitmap img = new Bitmap(stream);
                if (((width > 0) && (height > 0)) && (((img.Width > width) || (img.Height > height)) || (stream.Length > 0x5000)))
                {
                    int newWidth;
                    int newHeight;
                    if (System.IO.Path.GetExtension(targetImg).ToLower() != ".png")
                    {
                        targetImg = targetImg + ".png";
                    }
                    if ((img.Width * height) > (img.Height * width))
                    {
                        newWidth = width;
                        newHeight = (img.Height * width) / img.Width;
                    }
                    else
                    {
                        newHeight = height;
                        newWidth = (img.Width * height) / img.Height;
                    }
                    using (target_stream = Core.IO.File.Open(targetImg, FileMode.Create, FileAccess.Write, FileShare.None))
                    {
                        Bitmap t_img = new Bitmap(img, new Size(newWidth, newHeight));
                        if (gred)
                        {
                            t_img = Utility.ToGray(t_img, 0);
                        }
                        t_img.Save(target_stream, ImageFormat.Png);
                    }
                    return targetImg;
                }
                if (gred)
                {
                    using (target_stream = Core.IO.File.Open(targetImg, FileMode.Create, FileAccess.Write, FileShare.None))
                    {
                        Utility.ToGray(img, 0).Save(target_stream, ImageFormat.Png);
                    }
                    return targetImg;
                }
                Core.IO.File.Copy(headImg, targetImg);
            }
            return targetImg;
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

