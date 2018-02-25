using Core;
using Core.IO;
using System;
using System.IO;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public class Upload : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (base.IsPostBack)
        {
            try
            {
                FileUpload fu = this.FindControl("UploadFile") as FileUpload;
                string name = System.IO.Path.GetFileName(fu.FileName);
                string filename = ServerImpl.Instance.GetFullPath(this.Context, "Temp") + "/" + Guid.NewGuid().ToString();
                Core.IO.Directory.CreateDirectory(filename);
                filename = filename + "/" + name;
                if (IsValidFile(fu.FileName))
                {
                    using (Stream stream = Core.IO.File.Create(filename))
                    {
                        try
                        {
                            byte[] buffer = new byte[0x4000];
                            int count = 0;
                            do
                            {
                                count = fu.FileContent.Read(buffer, 0, buffer.Length);
                                stream.Write(buffer, 0, count);
                            }
                            while (count == buffer.Length);
                        }
                        finally
                        {
                            stream.Close();
                        }
                    }
                    (this.FindControl("data") as HtmlInputHidden).Value = Utility.RenderHashJson(new object[] { "Result", true, "Path", filename });
                }
            }
            catch (Exception ex)
            {
                (this.FindControl("data") as HtmlInputHidden).Value = Utility.RenderHashJson(new object[] { "Result", false, "Exception", ex });
            }
        }
    }


    private string[] ForbiddenUploadType = { ".asp", ".aspx", ".php", ".cgi", ".asa", ".exe", ".dll", ".bat", ".com", ".xhtml", ".shtml", ".htx", ".ashx", ".cmd", ".cer", ".cdx", ".ad", ".adprototype", ".asax", ".ascx", ".ashx", ".asmx", ".axd", ".browser", ".cd", ".compiled", ".config", ".cs", ".csproj", ".dd", ".exclude", ".idc", ".java", ".jsl", ".ldb", ".ldd", ".lddprototype", ".ldf", ".licx", ".master", ".mdb", ".mdf", ".msgx", ".refresh", ".rem", ".resources", ".resx", ".rules", ".sd", ".sdm", ".sdmdocument", ".shtm", ".sitemap", ".skin", ".soap", ".stm", ".svc", ".vb", ".vbproj", ".vjsproj", ".vsdisco", ".webinfo", ".xoml" };

    private bool IsValidFile(string filename)
    {
        string ext = GetFileExtension(filename).ToLower();
        bool b = true;
        for (int i = 0; i < ForbiddenUploadType.Length; i++)
        {
            string t = ForbiddenUploadType[i].ToLower();
            if (!string.IsNullOrEmpty(ext))
            {
                string fn = System.IO.Path.GetFileName(ext).ToLower();
                if (fn.Contains(t))
                    b = false;
            }
            else b = false;
        }
        return b;
    }

    private string GetFileExtension(string filename)
    {
        string r = "";
        if (filename.Contains("."))
        {
            string[] arr = filename.Split('.');
            r = "." + arr[arr.Length - 1].ToLower();
        }
        return r;
    }

}

