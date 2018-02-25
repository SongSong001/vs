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

namespace WC.WebUI.CS_Maker
{
    public partial class MakerCS : System.Web.UI.Page
    {
        private string IDAL = "~/CS_Maker/IDAL.Model.txt";
        private string Factory = "~/CS_Maker/Factory.Model.txt";
        private string DAL = "~/CS_Maker/DAL.Model.txt";
        private string BLL = "~/CS_Maker/BLL.Model.txt";
        private string RS_PATH = "~/CS_Maker/rs/";

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_Onclick(object sender, EventArgs e)
        {
            Hashtable ht = new Hashtable();
            ht.Add("IDAL", IDAL);
            ht.Add("Factory", Factory);
            ht.Add("DAL", DAL);
            ht.Add("BLL", BLL);
            string tablename = Request.Form["tablename"];
            
            RS_PATH += tablename + "/";
            Directory.CreateDirectory(Server.MapPath(RS_PATH));
            int count = 0;
            foreach (System.Collections.DictionaryEntry obj in ht)
            {
                string item = obj.Key.ToString();
                string path = obj.Value.ToString();
                using (StreamReader sr = new StreamReader(Server.MapPath(path), System.Text.Encoding.UTF8))
                {
                    string total = sr.ReadToEnd().Replace("Admin", tablename);
                    if (item == "IDAL")
                    {
                        using (StreamWriter sw = new StreamWriter(Server.MapPath(RS_PATH + "I" + tablename + ".cs.txt"), false, System.Text.Encoding.UTF8))
                        {
                            sw.Write(total);
                            sw.Close();
                        }
                    }
                    if (item == "Factory")
                    {
                        using (StreamWriter sw = new StreamWriter(Server.MapPath(RS_PATH + "DALFactory.cs.txt"), false, System.Text.Encoding.UTF8))
                        {
                            sw.Write(total);
                            sw.Close();
                        }
                    }
                    if (item == "DAL")
                    {
                        using (StreamWriter sw = new StreamWriter(Server.MapPath(RS_PATH + tablename + "DAL.cs.txt"), false, System.Text.Encoding.UTF8))
                        {
                            sw.Write(total);
                            sw.Close();
                        }
                    }
                    if (item == "BLL")
                    {
                        using (StreamWriter sw = new StreamWriter(Server.MapPath(RS_PATH + tablename + ".cs.txt"), false, System.Text.Encoding.UTF8))
                        {
                            sw.Write(total);
                            sw.Close();
                        }
                    }
                    count++;
                    sr.Close();
                }
            }
            Response.Write("总计" + count + "个文件生成成功!");
        }
    }
}
