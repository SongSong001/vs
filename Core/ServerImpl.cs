namespace Core
{
    using Core.IO;
    using System;
    using System.IO;
    using System.Reflection;
    using System.Text;
    using System.Web;
    using System.Web.Configuration;

    public class ServerImpl
    {
        private string _fileRoot;
        private object _logLock = new object();
        private string _serviceUrl = "";
        private string m_BaseDirecotry = string.Empty;
        private static ServerImpl m_Instance = new ServerImpl();
        private int PublicSubItemsPermission = 4;
        private int RootDirectoryPermission = 4;
        private int RootPublicSubItemsPermission = 4;
        private int RootSubItemsPermission = 12;

        static ServerImpl()
        {
            Instance.Initialize(HttpContext.Current);
        }

        private ServerImpl()
        {
        }

        public void CheckPermission(HttpContext context, string path, int action)
        {
            string relative = Core.IO.Path.GetRelativePath(path);
            string relativeRoot = Core.IO.Path.GetRoot(relative).ToLower();
            switch (relativeRoot)
            {
                case "pub":
                case "public":
                    break;

                default:
                {
                    AccountInfo currentUser = Instance.GetCurrentUser(context);
                    string owner = Core.IO.Path.GetUser(path);
                    if (string.IsNullOrEmpty(owner))
                    {
                        owner = currentUser.Name;
                    }
                    AccountInfo ownerInfo = AccountImpl.Instance.GetUserInfo(owner);
                    if ((ownerInfo.Type == 0) || !ownerInfo.ContainsMember(currentUser.Name))
                    {
                        if (ownerInfo.ID != currentUser.ID)
                        {
                            throw new PermissionException();
                        }
                        if (string.IsNullOrEmpty(relative) && ((this.RootDirectoryPermission & action) != action))
                        {
                            throw new PermissionException();
                        }
                        if (string.Compare(relative, relativeRoot, true) == 0)
                        {
                            if (relativeRoot == "public")
                            {
                                if ((this.RootPublicSubItemsPermission & action) != action)
                                {
                                    throw new PermissionException();
                                }
                            }
                            else if ((this.RootSubItemsPermission & action) != action)
                            {
                                throw new PermissionException();
                            }
                        }
                        else if ((relativeRoot == "public") && ((this.PublicSubItemsPermission & action) != action))
                        {
                            throw new PermissionException();
                        }
                    }
                    break;
                }
            }
        }

        public void Dispose(HttpApplication app)
        {
        }

        public AccountInfo GetCurrentUser(HttpContext context)
        {
            return AccountImpl.Instance.GetUserInfo(this.GetUserName(context));
        }

        public string GetFileRoot(HttpContext context)
        {
            string path;
            string fileRoot = WebConfigurationManager.OpenWebConfiguration(((context.Request.ApplicationPath == "/") != null) ? "/Lesktop" : (context.Request.ApplicationPath + "/Lesktop")).AppSettings.Settings["FileRoot"].Value;
            if (string.IsNullOrEmpty(fileRoot))
            {
                path = context.Server.MapPath("~");
                while (path.EndsWith(@"\"))
                {
                    path = path.Substring(0, path.Length - 1);
                }
                return (System.IO.Path.GetDirectoryName(path) + @"\Lesktop\Files");
            }
            if (!System.IO.Path.IsPathRooted(fileRoot))
            {
                path = context.Server.MapPath("~");
                while (path.EndsWith(@"\"))
                {
                    path = path.Substring(0, path.Length - 1);
                }
                path = path + @"\Lesktop";
                System.IO.Directory.CreateDirectory(System.IO.Path.Combine(path, fileRoot));
                System.IO.DirectoryInfo dir = new System.IO.DirectoryInfo(System.IO.Path.Combine(path, fileRoot));
                return dir.FullName;
            }
            return fileRoot;
        }

        public string GetFullPath(HttpContext context, string path)
        {
            return (string.IsNullOrEmpty(Core.IO.Path.GetUser(path)) ? string.Format("/{0}/{1}", this.GetUserName(context), path) : path);
        }

        public string GetResourceUrl(string path)
        {
            return string.Format("\"{0}/{1}\"", this.ResPath, path);
        }

        public string GetUserName(HttpContext context)
        {
            if (context.Request.Cookies["Lesktop"] != null)
            {
                return context.Request.Cookies["Lesktop"].Value;
            }
            return string.Empty;
        }

        public void Initialize(HttpContext context)
        {
            this.m_BaseDirecotry = context.Server.MapPath("~");
            this._fileRoot = this.GetFileRoot(context);
            this._serviceUrl = context.Request.ApplicationPath;
            if (!this._serviceUrl.EndsWith("/"))
            {
                this._serviceUrl = this._serviceUrl + "/";
            }
            this._serviceUrl = this._serviceUrl + "Lesktop";
            AccountImpl.Instance.Init();
        }

        public bool IsPublic(string path)
        {
            return (Core.IO.Path.GetRoot(Core.IO.Path.GetRelativePath(path)).ToLower() == "public");
        }

        public void Login(string sessionId, HttpContext context, string user, DateTime? expires)
        {
            this.Login(sessionId, context, user, expires, true);
        }

        public void Login(string sessionId, HttpContext context, string user, DateTime? expires, bool startSession)
        {
            HttpCookie cookie = new HttpCookie("Lesktop", user);
            if (expires.HasValue)
            {
                cookie.Expires = expires.Value;
            }
            context.Response.Cookies.Add(cookie);
            if (startSession)
            {
                SessionManagement.Instance.GetAccountState(user).NewSession(sessionId);
            }
        }

        public void Logout(HttpContext context)
        {
            HttpCookie cookie = new HttpCookie("Lesktop", "");
            cookie.Expires = DateTime.Now.AddDays(-7.0);
            context.Response.Cookies.Add(cookie);
        }

        public string MapPath(string path)
        {
            string[] pns = Core.IO.Path.GetRelativePath(path).Split(new char[] { '/' }, StringSplitOptions.RemoveEmptyEntries);
            if ((pns.Length > 0) && (pns[0].ToLower() == "public"))
            {
                return Core.IO.Path.Join(@"\", new string[] { this._fileRoot, "Public", Core.IO.Path.Join(@"\", pns, 1) });
            }
            if ((pns.Length > 0) && (pns[0].ToLower() == "temp"))
            {
                return Core.IO.Path.Join(@"\", new string[] { this._fileRoot, "Temp", Core.IO.Path.GetUser(path), Core.IO.Path.Join(@"\", pns, 1) });
            }
            string user = Core.IO.Path.GetUser(path);
            return string.Format(@"{0}\Users\{1}\{2}", this._fileRoot, user, Core.IO.Path.Join(@"\", pns, 0));
        }

        public string ReplaceVersion(string path)
        {
            return path.Replace("{VERSION}", "CurrentVersion");
        }

        public void WriteLog(string text)
        {
            //lock (this._logLock)
            //{
            //    string line = string.Format("[{0:yyyy-MM-dd hh:mm:ss}] {1}", DateTime.Now, text);
            //    System.IO.File.AppendAllText(this._fileRoot + @"\trace.txt", line, Encoding.UTF8);
            //}
        }

        public string BaseDirecotry
        {
            get
            {
                return this.m_BaseDirecotry;
            }
        }

        /// <summary>
        /// Debug调试
        /// </summary>
        public String Debug
        {
            get
            {
#				if DEBUG
                return "true";
#				else
				return "false";
#				endif
            }
        }

        public static ServerImpl Instance
        {
            get
            {
                return m_Instance;
            }
        }

        public string ResPath
        {
            get
            {
                return WebConfigurationManager.OpenWebConfiguration(((HttpContext.Current.Request.ApplicationPath == "/") != null) ? "/Lesktop" : (HttpContext.Current.Request.ApplicationPath + "/Lesktop")).AppSettings.Settings["ResPath"].Value;
            }
        }

        public string ServiceUrl
        {
            get
            {
                return this._serviceUrl;
            }
        }

        public string Version
        {
            get
            {
                return Assembly.GetExecutingAssembly().GetName().Version.ToString();
            }
        }
    }
}

