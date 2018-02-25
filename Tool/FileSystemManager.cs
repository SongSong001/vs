using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.Web;
using System.Web.UI.WebControls;
using System.Drawing;
using System.Drawing.Imaging;
using WC.Model;

namespace WC.Tool
{
    /// <summary>
    /// 文件流 头字节码
    /// </summary>
    public enum FileExtension
    {
        JPG = 255216,
        GIF = 7173,
        BMP = 6677,
        PNG = 13780
        //EXE = 7790,
        //DLL = 7790,
        //RAR = 8297,
        //XML = 6063,
        //HTML = 6033,
        //ASPX = 239187,
        //CS = 117115,
        //JS = 119105,
        //TXT = 210187,
        //SQL = 255254
    }

    /// <summary>
    /// 文件管理类
    /// </summary>
    public class FileSystemManager
    {
        private static string strRootFolder;

        static FileSystemManager()
        {
            strRootFolder = HttpContext.Current.Server.MapPath("~/pic/UpFiles") + "\\";
            strRootFolder = strRootFolder.Substring(0, strRootFolder.LastIndexOf(@"\"));
        }

        public static FileSystemManager Iint()
        {
            return new FileSystemManager();
        }

        /// <summary>
        /// 读根目录
        /// </summary>
        /// <returns></returns>
        public static string GetRootPath()
        {
            return strRootFolder;
        }

        /// <summary>
        /// 写根目录
        /// </summary>
        /// <param name="path"></param>
        public static void SetRootPath(string path)
        {
            strRootFolder = path;
        }

        /// <summary>
        /// 读取列表
        /// </summary>
        /// <returns></returns>
        public static List<FileSystemItem> GetItems()
        {
            return GetItems(strRootFolder);
        }

        /// <summary>
        /// 读取列表
        /// </summary>
        /// <param name="path"></param>
        /// <returns></returns>
        public static List<FileSystemItem> GetItems(string path)
        {
            string[] folders = Directory.GetDirectories(path);
            string[] files = Directory.GetFiles(path);
            List<FileSystemItem> list = new List<FileSystemItem>();
            foreach (string s in folders)
            {
                FileSystemItem item = new FileSystemItem();
                DirectoryInfo di = new DirectoryInfo(s);
                item.Name = di.Name;
                item.FullName = di.FullName;
                item.CreationDate = di.CreationTime;
                item.IsFolder = true;
                item.WebName = item.FullName;
                item.WebName = item.WebName.Replace(GetRootPath(), "/UpFiles");
                item.WebName = item.WebName.Replace("\\", "/");
                list.Add(item);
            }
            foreach (string s in files)
            {
                FileSystemItem item = new FileSystemItem();
                FileInfo fi = new FileInfo(s);
                item.Name = fi.Name;
                item.FullName = fi.FullName;
                item.CreationDate = fi.CreationTime;
                item.IsFolder = false;
                item.WebName = item.FullName;
                item.WebName = item.WebName.Replace(GetRootPath(), "/UpFiles");
                item.WebName = item.WebName.Replace("\\", "/");
                item.Size = fi.Length / 1024;
                list.Add(item);
            }

            if (path.ToLower() != strRootFolder.ToLower())
            {
                FileSystemItem topitem = new FileSystemItem();
                DirectoryInfo topdi = new DirectoryInfo(path).Parent;
                topitem.Name = "[上一级]";
                topitem.FullName = topdi.FullName;
                list.Insert(0, topitem);

                FileSystemItem rootitem = new FileSystemItem();
                DirectoryInfo rootdi = new DirectoryInfo(strRootFolder);
                rootitem.Name = "[根目录]";
                rootitem.FullName = rootdi.FullName;
                list.Insert(0, rootitem);

            }
            return list;
        }

        /// <summary>
        /// 创建文件夹
        /// </summary>
        /// <param name="name"></param>
        /// <param name="parentName"></param>
        public static void CreateFolder(string name, string parentName)
        {
            DirectoryInfo di = new DirectoryInfo(parentName);
            di.CreateSubdirectory(name);
        }

        /// <summary>
        /// 删除文件夹
        /// </summary>
        /// <param name="path"></param>
        public static bool DeleteFolder(string path)
        {
            try
            {
                Directory.Delete(path);
                return true;
            }
            catch
            {
                return false;
            }
        }

        /// <summary>
        /// 移动文件夹
        /// </summary>
        /// <param name="oldPath"></param>
        /// <param name="newPath"></param>
        public static bool MoveFolder(string oldPath, string newPath)
        {
            try
            {
                Directory.Move(oldPath, newPath);
                return true;
            }
            catch
            {
                return false;
            }
        }

        /// <summary>
        /// 创建文件
        /// </summary>
        /// <param name="filename"></param>
        /// <param name="path"></param>
        public static bool CreateFile(string filename, string path)
        {
            try
            {
                FileStream fs = File.Create(path + "\\" + filename);
                fs.Close();
                return true;
            }
            catch
            {
                return false;
            }
        }

        /// <summary>
        /// 创建文件
        /// </summary>
        /// <param name="filename"></param>
        /// <param name="path"></param>
        /// <param name="contents"></param>
        public static bool CreateFile(string filename, string path, byte[] contents)
        {
            try
            {
                FileStream fs = File.Create(path + "\\" + filename);
                fs.Write(contents, 0, contents.Length);
                fs.Close();
                return true;
            }
            catch
            {
                return false;
            }
        }

        /// <summary>
        /// 读取文件
        /// </summary>
        /// <param name="name"></param>
        /// <param name="parentName"></param>
        public static string OpenText(string parentName)
        {
            StreamReader sr = File.OpenText(parentName);
            StringBuilder output = new StringBuilder();
            string rl;
            while ((rl = sr.ReadLine()) != null)
            {
                output.Append(rl);
            }
            sr.Close();
            return output.ToString();
        }

        /// <summary>
        /// 写入一个新文件，在文件中写入内容，然后关闭文件。如果目标文件已存在，则改写该文件。 
        /// </summary>
        /// <param name="name"></param>
        /// <param name="parentName"></param>
        public static bool WriteAllText(string parentName, string contents)
        {
            try
            {
                File.WriteAllText(parentName, contents, Encoding.Unicode);
                return true;
            }
            catch
            {
                return false;
            }
        }

        /// <summary>
        /// 删除文件
        /// </summary>
        /// <param name="path"></param>
        public static bool DeleteFile(string path)
        {
            try
            {
                File.Delete(path);
                return true;
            }
            catch
            {
                return false;
            }
        }

        /// <summary>
        /// 移动文件
        /// </summary>
        /// <param name="oldPath"></param>
        /// <param name="newPath"></param>
        public static bool MoveFile(string oldPath, string newPath)
        {
            try
            {
                File.Move(oldPath, newPath);
                return true;
            }
            catch
            {
                return false;
            }
        }

        /// <summary>
        /// 读取文件信息
        /// </summary>
        /// <param name="path"></param>
        /// <returns></returns>
        public static FileSystemItem GetItemInfo(string path)
        {
            FileSystemItem item = new FileSystemItem();
            if (Directory.Exists(path))
            {
                DirectoryInfo di = new DirectoryInfo(path);
                item.Name = di.Name;
                item.FullName = di.FullName;
                item.CreationDate = di.CreationTime;
                item.IsFolder = true;
                item.LastAccessDate = di.LastAccessTime;
                item.LastWriteDate = di.LastWriteTime;
                item.FileCount = di.GetFiles().Length;
                item.SubFolderCount = di.GetDirectories().Length;
            }
            else
            {
                FileInfo fi = new FileInfo(path);
                item.Name = fi.Name;
                item.FullName = fi.FullName;
                item.CreationDate = fi.CreationTime;
                item.LastAccessDate = fi.LastAccessTime;
                item.LastWriteDate = fi.LastWriteTime;
                item.IsFolder = false;
                item.Size = fi.Length;
            }
            return item;
        }

        /// <summary>
        /// 复制文件夹
        /// </summary>
        /// <param name="source"></param>
        /// <param name="destination"></param>
        public static bool CopyFolder(string source, string destination)
        {
            try
            {
                String[] files;
                if (destination[destination.Length - 1] != Path.DirectorySeparatorChar)
                    destination += Path.DirectorySeparatorChar;
                if (!Directory.Exists(destination)) Directory.CreateDirectory(destination);
                files = Directory.GetFileSystemEntries(source);
                foreach (string element in files)
                {
                    if (Directory.Exists(element))
                        CopyFolder(element, destination + Path.GetFileName(element));
                    else
                        File.Copy(element, destination + Path.GetFileName(element), true);
                }
                return true;
            }
            catch
            {
                return false;
            }
        }
        /// <summary>
        /// 判断是否为安全文件名 (以扩展名判断是否 是集合中的 后缀名）
        /// </summary>
        /// <param name="str">文件名</param>
        /// <returns></returns>
        public static bool IsSafeName(string strExtension)
        {
            strExtension = strExtension.ToLower();//变为小写
            //得到string的.XXX的文件名后缀 LastIndexOf（得到点的位置） Substring（剪切从X的位置）

            if (strExtension.LastIndexOf(".") >= 0)
            { strExtension = strExtension.Substring(strExtension.LastIndexOf(".")); }
            else
            { strExtension = ".txt"; }//如果没有点 就当成txt文件

            //允许上传的扩展名，可以改成从配置文件中读出 
            string[] arrExtension = { ".jpeg", ".jpg", ".gif", ".png", ".bmp" };

            for (int i = 0; i < arrExtension.Length; i++)
            {
                if (strExtension.Equals(arrExtension[i]))
                {
                    return true;
                }
            }

            ////从 头文件字节流 判断是否非法  未通过程序！
            //FileStream fs = new FileStream(strExtension, FileMode.Open, FileAccess.Read);
            //BinaryReader r = new BinaryReader(fs);
            //String bx = "";
            //byte buffer;

            //try
            //{
            //    buffer = r.ReadByte();
            //    bx = buffer.ToString();
            //    buffer = r.ReadByte();
            //    bx += buffer.ToString();

            //}
            //catch (Exception exc)
            //{
            //    Console.WriteLine(exc.Message);
            //}
            //r.Close();
            //fs.Close();
            //if (bx == "7790" || bx == "8297" || bx == "8075")
            //{
            //    return false;
            //}


            return false;
        }
        /// <summary>
        ///  判断是否为不安全文件名
        /// </summary>
        /// <param name="str">文件名、文件夹名</param>
        /// <returns>bool</returns>
        public static bool IsUnsafeName(string strExtension)
        {
            strExtension = strExtension.ToLower();//变为小写
            //得到string的.XXX的文件名后缀 LastIndexOf（得到点的位置） Substring（剪切从X的位置）

            if (strExtension.LastIndexOf(".") >= 0)
            { strExtension = strExtension.Substring(strExtension.LastIndexOf(".")); }
            else
            { strExtension = ".txt"; }//如果没有点 就当成txt文件

            //允许上传的扩展名，可以改成从配置文件中读出 
            string[] arrExtension = { ".", "jpg", "jpeg", "png", "bmp", "gif" };

            for (int i = 0; i < arrExtension.Length; i++)
            {
                if (strExtension.Equals(arrExtension[i]))
                {
                    return true;
                }
            }
            return false;

        }
        /// <summary>
        ///  判断是否为可编辑文件
        /// </summary>
        /// <param name="str">文件名、文件夹名</param>
        /// <returns>bool</returns>
        //public static bool IsCanEdit(string strExtension)
        //{
        //    strExtension = strExtension.ToLower();//变为小写
        //    //得到string的.XXX的文件名后缀 LastIndexOf（得到点的位置） Substring（剪切从X的位置）

        //    if (strExtension.LastIndexOf(".") >= 0)
        //    { strExtension = strExtension.Substring(strExtension.LastIndexOf(".")); }
        //    else
        //    { strExtension = ".txt"; }//如果没有点 就当成txt文件

        //    //允许上传的扩展名，可以改成从配置文件中读出 
        //    string[] arrExtension = { ".htm", ".html", ".txt", ".js", ".css", ".xml", ".sitemap" };

        //    for (int i = 0; i < arrExtension.Length; i++)
        //    {
        //        if (strExtension.Equals(arrExtension[i]))
        //        {
        //            return true;
        //        }
        //    }
        //    return false;
        //}

        /// <summary>
        /// 生成缩略图
        /// </summary>
        /// <param name="originalImagePath">源图路径（物理路径）</param>
        /// <param name="thumbnailPath">缩略图路径（物理路径）</param>
        /// <param name="width">缩略图宽度</param>
        /// <param name="height">缩略图高度</param>
        /// <param name="mode">生成缩略图的方式</param>    
        public static void MakeXpic(string originalImagePath, string thumbnailPath, int width, int height, string mode)
        {
            System.Drawing.Image originalImage = System.Drawing.Image.FromFile(originalImagePath);
            int towidth = width;
            int toheight = height;

            int x = 0;
            int y = 0;
            int ow = originalImage.Width;
            int oh = originalImage.Height;

            switch (mode)
            {
                case "HW"://指定高宽缩放（可能变形）                
                    break;
                case "W"://指定宽，高按比例                    
                    toheight = originalImage.Height * width / originalImage.Width;
                    break;
                case "H"://指定高，宽按比例
                    towidth = originalImage.Width * height / originalImage.Height;
                    break;
                case "Cut"://指定高宽裁减（不变形）                
                    if ((double)originalImage.Width / (double)originalImage.Height > (double)towidth / (double)toheight)
                    {
                        oh = originalImage.Height;
                        ow = originalImage.Height * towidth / toheight;
                        y = 0;
                        x = (originalImage.Width - ow) / 2;
                    }
                    else
                    {
                        ow = originalImage.Width;
                        oh = originalImage.Width * height / towidth;
                        x = 0;
                        y = (originalImage.Height - oh) / 2;
                    }
                    break;
                default:
                    break;
            }
            //新建一个bmp图片
            System.Drawing.Image bitmap = new System.Drawing.Bitmap(towidth, toheight);
            //新建一个画板
            System.Drawing.Graphics g = System.Drawing.Graphics.FromImage(bitmap);
            //设置高质量插值法
            g.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.High;
            //设置高质量,低速度呈现平滑程度
            g.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality;
            //清空画布并以透明背景色填充
            g.Clear(System.Drawing.Color.Transparent);
            //在指定位置并且按指定大小绘制原图片的指定部分
            g.DrawImage(originalImage, new System.Drawing.Rectangle(0, 0, towidth, toheight),
                new System.Drawing.Rectangle(x, y, ow, oh),
                System.Drawing.GraphicsUnit.Pixel);
            try
            {
                //以jpg格式保存缩略图
                bitmap.Save(thumbnailPath, System.Drawing.Imaging.ImageFormat.Jpeg);
            }
            catch (System.Exception e)
            {
                throw e;
            }
            finally
            {
                originalImage.Dispose();
                bitmap.Dispose();
                g.Dispose();
            }
        }


        //根据 文件2进制流 头字节判断 文件是否合法 (FileUpload)对.net上传控件
        public static bool IsAllowedExtension(FileUpload fu, FileExtension[] fileEx)
        {
            int fileLen = fu.PostedFile.ContentLength;
            byte[] imgArray = new byte[fileLen];
            fu.PostedFile.InputStream.Read(imgArray, 0, fileLen);
            MemoryStream ms = new MemoryStream(imgArray);
            System.IO.BinaryReader br = new System.IO.BinaryReader(ms);
            string fileclass = "";
            byte buffer;
            try
            {
                buffer = br.ReadByte();
                fileclass = buffer.ToString();
                buffer = br.ReadByte();
                fileclass += buffer.ToString();
            }
            catch
            {
            }
            br.Close();
            ms.Close();
            foreach (FileExtension fe in fileEx)
            {
                if (Int32.Parse(fileclass) == (int)fe)
                    return true;
            }
            return false;
        }

        //根据 文件2进制流 头字节判断 文件是否合法 (HttpPostedFile)对html上传控件
        public static bool IsAllowedExtension(HttpPostedFile fu, FileExtension[] fileEx)
        {
            int fileLen = fu.ContentLength;
            byte[] imgArray = new byte[fileLen];
            fu.InputStream.Read(imgArray, 0, fileLen);
            MemoryStream ms = new MemoryStream(imgArray);
            System.IO.BinaryReader br = new System.IO.BinaryReader(ms);
            string fileclass = "";
            byte buffer;
            try
            {
                buffer = br.ReadByte();
                fileclass = buffer.ToString();
                buffer = br.ReadByte();
                fileclass += buffer.ToString();
            }
            catch
            {
            }
            br.Close();
            ms.Close();
            foreach (FileExtension fe in fileEx)
            {
                try
                {
                    if (Int32.Parse(fileclass) == (int)fe)
                        return true;
                }
                catch { }
            }
            return false;
        }

        /// <summary>
        /// 产生验证码
        /// </summary>
        /// <returns>验证码</returns>
        public static string CreateRandomStr(int len)
        {
            int number;
            StringBuilder checkCode = new StringBuilder();
            Random random = new Random();
            for (int i = 0; i < len; i++)
            {
                number = random.Next(0, 10);
                checkCode.Append(number);
                //number = random.Next();
                //if (number % 2 == 0)
                //{
                //    checkCode.Append((char)('0' + (char)(number % 10)));
                //}
                //else
                //{
                //    checkCode.Append((char)('A' + (char)(number % 26)));
                //}
            }
            return checkCode.ToString();
        }

        /// <summary>
        /// 生成验证码图片
        /// </summary>
        /// <param name="authStr">验证码</param>
        /// <returns>MemoryStream</returns>
        public static MemoryStream DrawRandomStr(string authStr)
        {
            int fontSize = 13;//字体大小
            int imageWidth = authStr.Length * 20 + 2;//图片宽度
            int imageHeight = fontSize * 2 + 2;//图片高度
            Random ran = new Random();//随即数

            Bitmap bitMap = new Bitmap(imageWidth, imageHeight);
            Graphics graph = Graphics.FromImage(bitMap);
            graph.Clear(Color.FromArgb(ran.Next(255, 255), ran.Next(255, 255), ran.Next(250, 255)));//背景色
            Font myFont = new Font("Verdana", fontSize, FontStyle.Bold);

            ////生成干扰线
            //int chors = ran.Next(5, 10);
            //for (int i = 0; i < chors; i++)
            //{
            //    Pen chorPen = new Pen(Color.FromArgb(ran.Next(30, 50), ran.Next(30, 50), ran.Next(30, 50)));
            //    Point p1 = new Point(ran.Next(imageWidth - 1), ran.Next(imageHeight - 1));
            //    Point p2 = new Point(ran.Next(imageWidth - 1), ran.Next(imageHeight - 1));
            //    graph.DrawLine(chorPen, p1, p2);
            //}

            //为每个字符生成随即颜色
            for (int i = 0; i < authStr.Length; i++)
            {
                SolidBrush sb = new SolidBrush(Color.FromArgb(ran.Next(100, 150), ran.Next(100, 150), ran.Next(100, 150)));
                int left = i * 20;

                graph.DrawString(authStr.Substring(i, 1), myFont, sb, left, 1);
            }

            MemoryStream ms = new MemoryStream();
            bitMap.Save(ms, ImageFormat.Gif);
            graph.Dispose();
            bitMap.Dispose();
            return ms;
        }

    }
}
