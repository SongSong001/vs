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
    /// �ļ��� ͷ�ֽ���
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
    /// �ļ�������
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
        /// ����Ŀ¼
        /// </summary>
        /// <returns></returns>
        public static string GetRootPath()
        {
            return strRootFolder;
        }

        /// <summary>
        /// д��Ŀ¼
        /// </summary>
        /// <param name="path"></param>
        public static void SetRootPath(string path)
        {
            strRootFolder = path;
        }

        /// <summary>
        /// ��ȡ�б�
        /// </summary>
        /// <returns></returns>
        public static List<FileSystemItem> GetItems()
        {
            return GetItems(strRootFolder);
        }

        /// <summary>
        /// ��ȡ�б�
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
                topitem.Name = "[��һ��]";
                topitem.FullName = topdi.FullName;
                list.Insert(0, topitem);

                FileSystemItem rootitem = new FileSystemItem();
                DirectoryInfo rootdi = new DirectoryInfo(strRootFolder);
                rootitem.Name = "[��Ŀ¼]";
                rootitem.FullName = rootdi.FullName;
                list.Insert(0, rootitem);

            }
            return list;
        }

        /// <summary>
        /// �����ļ���
        /// </summary>
        /// <param name="name"></param>
        /// <param name="parentName"></param>
        public static void CreateFolder(string name, string parentName)
        {
            DirectoryInfo di = new DirectoryInfo(parentName);
            di.CreateSubdirectory(name);
        }

        /// <summary>
        /// ɾ���ļ���
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
        /// �ƶ��ļ���
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
        /// �����ļ�
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
        /// �����ļ�
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
        /// ��ȡ�ļ�
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
        /// д��һ�����ļ������ļ���д�����ݣ�Ȼ��ر��ļ������Ŀ���ļ��Ѵ��ڣ����д���ļ��� 
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
        /// ɾ���ļ�
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
        /// �ƶ��ļ�
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
        /// ��ȡ�ļ���Ϣ
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
        /// �����ļ���
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
        /// �ж��Ƿ�Ϊ��ȫ�ļ��� (����չ���ж��Ƿ� �Ǽ����е� ��׺����
        /// </summary>
        /// <param name="str">�ļ���</param>
        /// <returns></returns>
        public static bool IsSafeName(string strExtension)
        {
            strExtension = strExtension.ToLower();//��ΪСд
            //�õ�string��.XXX���ļ�����׺ LastIndexOf���õ����λ�ã� Substring�����д�X��λ�ã�

            if (strExtension.LastIndexOf(".") >= 0)
            { strExtension = strExtension.Substring(strExtension.LastIndexOf(".")); }
            else
            { strExtension = ".txt"; }//���û�е� �͵���txt�ļ�

            //�����ϴ�����չ�������Ըĳɴ������ļ��ж��� 
            string[] arrExtension = { ".jpeg", ".jpg", ".gif", ".png", ".bmp" };

            for (int i = 0; i < arrExtension.Length; i++)
            {
                if (strExtension.Equals(arrExtension[i]))
                {
                    return true;
                }
            }

            ////�� ͷ�ļ��ֽ��� �ж��Ƿ�Ƿ�  δͨ������
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
        ///  �ж��Ƿ�Ϊ����ȫ�ļ���
        /// </summary>
        /// <param name="str">�ļ������ļ�����</param>
        /// <returns>bool</returns>
        public static bool IsUnsafeName(string strExtension)
        {
            strExtension = strExtension.ToLower();//��ΪСд
            //�õ�string��.XXX���ļ�����׺ LastIndexOf���õ����λ�ã� Substring�����д�X��λ�ã�

            if (strExtension.LastIndexOf(".") >= 0)
            { strExtension = strExtension.Substring(strExtension.LastIndexOf(".")); }
            else
            { strExtension = ".txt"; }//���û�е� �͵���txt�ļ�

            //�����ϴ�����չ�������Ըĳɴ������ļ��ж��� 
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
        ///  �ж��Ƿ�Ϊ�ɱ༭�ļ�
        /// </summary>
        /// <param name="str">�ļ������ļ�����</param>
        /// <returns>bool</returns>
        //public static bool IsCanEdit(string strExtension)
        //{
        //    strExtension = strExtension.ToLower();//��ΪСд
        //    //�õ�string��.XXX���ļ�����׺ LastIndexOf���õ����λ�ã� Substring�����д�X��λ�ã�

        //    if (strExtension.LastIndexOf(".") >= 0)
        //    { strExtension = strExtension.Substring(strExtension.LastIndexOf(".")); }
        //    else
        //    { strExtension = ".txt"; }//���û�е� �͵���txt�ļ�

        //    //�����ϴ�����չ�������Ըĳɴ������ļ��ж��� 
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
        /// ��������ͼ
        /// </summary>
        /// <param name="originalImagePath">Դͼ·��������·����</param>
        /// <param name="thumbnailPath">����ͼ·��������·����</param>
        /// <param name="width">����ͼ���</param>
        /// <param name="height">����ͼ�߶�</param>
        /// <param name="mode">��������ͼ�ķ�ʽ</param>    
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
                case "HW"://ָ���߿����ţ����ܱ��Σ�                
                    break;
                case "W"://ָ�����߰�����                    
                    toheight = originalImage.Height * width / originalImage.Width;
                    break;
                case "H"://ָ���ߣ�������
                    towidth = originalImage.Width * height / originalImage.Height;
                    break;
                case "Cut"://ָ���߿�ü��������Σ�                
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
            //�½�һ��bmpͼƬ
            System.Drawing.Image bitmap = new System.Drawing.Bitmap(towidth, toheight);
            //�½�һ������
            System.Drawing.Graphics g = System.Drawing.Graphics.FromImage(bitmap);
            //���ø�������ֵ��
            g.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.High;
            //���ø�����,���ٶȳ���ƽ���̶�
            g.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality;
            //��ջ�������͸������ɫ���
            g.Clear(System.Drawing.Color.Transparent);
            //��ָ��λ�ò��Ұ�ָ����С����ԭͼƬ��ָ������
            g.DrawImage(originalImage, new System.Drawing.Rectangle(0, 0, towidth, toheight),
                new System.Drawing.Rectangle(x, y, ow, oh),
                System.Drawing.GraphicsUnit.Pixel);
            try
            {
                //��jpg��ʽ��������ͼ
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


        //���� �ļ�2������ ͷ�ֽ��ж� �ļ��Ƿ�Ϸ� (FileUpload)��.net�ϴ��ؼ�
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

        //���� �ļ�2������ ͷ�ֽ��ж� �ļ��Ƿ�Ϸ� (HttpPostedFile)��html�ϴ��ؼ�
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
        /// ������֤��
        /// </summary>
        /// <returns>��֤��</returns>
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
        /// ������֤��ͼƬ
        /// </summary>
        /// <param name="authStr">��֤��</param>
        /// <returns>MemoryStream</returns>
        public static MemoryStream DrawRandomStr(string authStr)
        {
            int fontSize = 13;//�����С
            int imageWidth = authStr.Length * 20 + 2;//ͼƬ���
            int imageHeight = fontSize * 2 + 2;//ͼƬ�߶�
            Random ran = new Random();//�漴��

            Bitmap bitMap = new Bitmap(imageWidth, imageHeight);
            Graphics graph = Graphics.FromImage(bitMap);
            graph.Clear(Color.FromArgb(ran.Next(255, 255), ran.Next(255, 255), ran.Next(250, 255)));//����ɫ
            Font myFont = new Font("Verdana", fontSize, FontStyle.Bold);

            ////���ɸ�����
            //int chors = ran.Next(5, 10);
            //for (int i = 0; i < chors; i++)
            //{
            //    Pen chorPen = new Pen(Color.FromArgb(ran.Next(30, 50), ran.Next(30, 50), ran.Next(30, 50)));
            //    Point p1 = new Point(ran.Next(imageWidth - 1), ran.Next(imageHeight - 1));
            //    Point p2 = new Point(ran.Next(imageWidth - 1), ran.Next(imageHeight - 1));
            //    graph.DrawLine(chorPen, p1, p2);
            //}

            //Ϊÿ���ַ������漴��ɫ
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
