using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.IO;
using System.Globalization;
using LitJson;

namespace WC.WebUI.KindEditor4
{
    public partial class upload_json : WC.BLL.ViewPages
    {
        //文件保存目录路径
        private String savePath = "/KindEditor4/attached/";
        //文件保存目录URL
        private String saveUrl = "/KindEditor4/attached/";
        //定义允许上传的文件扩展名
        private String fileTypes = "gif,jpg,jpeg,png,bmp,flv,swf,doc,xls,ppt,rar,zip,7z,docx,xlsx,pptx,csv,txt";
        //最大文件大小
        private int maxSize = 311000000; //约310M

        protected void Page_Load(object sender, EventArgs e)
        {
            savePath += DateTime.Now.ToString("yyMM");
            saveUrl += DateTime.Now.ToString("yyMM");

            HttpPostedFile imgFile = Request.Files["imgFile"];
            if (imgFile == null)
            {
                showError("请选择文件。");
            }

            String dirPath = Server.MapPath(savePath);

            if (!Directory.Exists(dirPath))
            {
                WC.Tool.FileSystemManager.CreateFolder(DateTime.Now.ToString("yyMM"), Server.MapPath("~/KindEditor4/attached"));
            }

            if (!Directory.Exists(dirPath))
            {
                showError("上传目录不存在。");
            }

            String fileName = imgFile.FileName;
            String fileExt = Path.GetExtension(fileName).ToLower();
            ArrayList fileTypeList = ArrayList.Adapter(fileTypes.Split(','));

            if (imgFile.InputStream == null || imgFile.InputStream.Length > maxSize)
            {
                showError("上传文件大小超过限制。");
            }

            if (String.IsNullOrEmpty(fileExt) || Array.IndexOf(fileTypes.Split(','), fileExt.Substring(1).ToLower()) == -1)
            {
                showError("上传文件扩展名是不允许的扩展名。");
            }
            //FileExtension[] fe = { FileExtension.GIF, FileExtension.JPG, FileExtension.PNG, FileExtension.BMP };
            //if (!IsAllowedExtension(imgFile, fe))
            //{
            //    showError("非法图片文件! 上传文件发生异常。");
            //}

            String newFileName = DateTime.Now.ToString("yyyyMMddHHmmss_ffff", DateTimeFormatInfo.InvariantInfo) + fileExt;
            String filePath = dirPath + "/" + newFileName;

            imgFile.SaveAs(filePath);

            String fileUrl = saveUrl + "/" + newFileName;

            Hashtable hash = new Hashtable();
            hash["error"] = 0;
            hash["url"] = fileUrl;
            Response.AddHeader("Content-Type", "text/html; charset=UTF-8");
            Response.Write(JsonMapper.ToJson(hash));
            Response.End();
        }

        private void showError(string message)
        {
            Hashtable hash = new Hashtable();
            hash["error"] = 1;
            hash["message"] = message;
            Response.AddHeader("Content-Type", "text/html; charset=UTF-8");
            Response.Write(JsonMapper.ToJson(hash));
            Response.End();
        }

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
                return false;
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
                catch
                {
                    return false;
                }
            }
            return false;
        }
    }
}
