namespace Core.IO
{
    using Core;
    using System;
    using System.IO;

    public static class Directory
    {
        public static void Copy(string src, string des)
        {
            if (!Exists(des))
            {
                CreateDirectory(des);
            }
            foreach (Core.IO.FileSystemInfo fsi in new Core.IO.DirectoryInfo(src).GetFileSystemInfos())
            {
                if ((fsi.Attributes & Core.IO.FileAttributes.Directory) == Core.IO.FileAttributes.Directory)
                {
                    Copy(fsi.FullName, des + "/" + fsi.Name);
                }
                else
                {
                    Core.IO.File.Copy(fsi.FullName, des + "/" + fsi.Name);
                }
            }
        }

        public static void CreateDirectory(string path)
        {
            System.IO.Directory.CreateDirectory(ServerImpl.Instance.MapPath(path));
        }

        public static void Delete(string path)
        {
            Core.IO.FileSystemInfo[] infos = new Core.IO.DirectoryInfo(path).GetFileSystemInfos();
            foreach (Core.IO.FileSystemInfo info in infos)
            {
                if ((Core.IO.File.GetAttributes(info.FullName) & System.IO.FileAttributes.Directory) == System.IO.FileAttributes.Directory)
                {
                    Delete(info.FullName);
                }
                else
                {
                    Core.IO.File.Delete(info.FullName);
                }
            }
            System.IO.Directory.Delete(ServerImpl.Instance.MapPath(path));
        }

        public static bool Exists(string path)
        {
            return System.IO.Directory.Exists(ServerImpl.Instance.MapPath(path));
        }

        public static void Move(string src, string des)
        {
            if (!Exists(des))
            {
                CreateDirectory(des);
            }
            foreach (Core.IO.FileSystemInfo fsi in new Core.IO.DirectoryInfo(src).GetFileSystemInfos())
            {
                if ((fsi.Attributes & Core.IO.FileAttributes.Directory) == Core.IO.FileAttributes.Directory)
                {
                    Move(fsi.FullName, des + "/" + fsi.Name);
                }
                else
                {
                    Core.IO.File.Move(fsi.FullName, des + "/" + fsi.Name);
                }
            }
            Delete(src);
        }

        public static void Rename(string path, string name)
        {
            string rpath = ServerImpl.Instance.MapPath(path);
            System.IO.Directory.Move(rpath, System.IO.Path.GetDirectoryName(rpath) + @"\" + name);
        }
    }
}

