﻿namespace Core.IO
{
    using Core;
    using System;
    using System.Collections.Generic;
    using System.IO;
    using System.Text;

    public class DirectoryInfo : Core.IO.FileSystemInfo, IRenderJson
    {
        private string _fullName;
        private System.IO.DirectoryInfo _info = null;
        private string _name;
        private string _path;

        public DirectoryInfo(string fullName)
        {
            this._fullName = fullName;
            this._name = Core.IO.Path.GetFileName(fullName);
            this._path = ServerImpl.Instance.MapPath(fullName);
            this._info = new System.IO.DirectoryInfo(this._path);
        }

        void IRenderJson.RenderJson(StringBuilder builder)
        {
            Utility.RenderHashJson(builder, new object[] { "FullName", this.FullName, "Name", this.Name, "Type", "D", "LastModifiedTime", this.LastWriteTime });
        }

        public Core.IO.FileSystemInfo[] GetDirectoryInfos()
        {
            List<Core.IO.FileSystemInfo> fss = new List<Core.IO.FileSystemInfo>();
            foreach (System.IO.DirectoryInfo dir in this._info.GetDirectories())
            {
                fss.Add(new Core.IO.DirectoryInfo(this.FullName + "/" + dir.Name));
            }
            if (Core.IO.Path.GetRelativePath(this.FullName) == "")
            {
                fss.Add(new Core.IO.DirectoryInfo(this.FullName + "/Public"));
            }
            return fss.ToArray();
        }

        public Core.IO.FileSystemInfo[] GetFileSystemInfos()
        {
            List<Core.IO.FileSystemInfo> fss = new List<Core.IO.FileSystemInfo>();
            foreach (System.IO.DirectoryInfo dir in this._info.GetDirectories())
            {
                fss.Add(new Core.IO.DirectoryInfo(this.FullName + "/" + dir.Name));
            }
            if (Core.IO.Path.GetRelativePath(this.FullName) == "")
            {
                fss.Add(new Core.IO.DirectoryInfo(this.FullName + "/Public"));
            }
            foreach (System.IO.FileInfo file in this._info.GetFiles())
            {
                fss.Add(new Core.IO.FileInfo(this.FullName + "/" + file.Name));
            }
            return fss.ToArray();
        }

        public override Core.IO.FileAttributes Attributes
        {
            get
            {
                return (Core.IO.FileAttributes) this._info.Attributes;
            }
        }

        public override DateTime CreationTime
        {
            get
            {
                return this._info.CreationTime;
            }
        }

        public override DateTime CreationTimeUtc
        {
            get
            {
                return this._info.CreationTimeUtc;
            }
        }

        public override string FullName
        {
            get
            {
                return this._fullName;
            }
        }

        public override DateTime LastAccessTime
        {
            get
            {
                return this._info.LastAccessTime;
            }
        }

        public override DateTime LastAccessTimeUtc
        {
            get
            {
                return this._info.LastAccessTimeUtc;
            }
        }

        public override DateTime LastWriteTime
        {
            get
            {
                return this._info.LastWriteTime;
            }
        }

        public override DateTime LastWriteTimeUtc
        {
            get
            {
                return this._info.LastWriteTimeUtc;
            }
        }

        public override string Name
        {
            get
            {
                return this._name;
            }
        }
    }
}

