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

using WC.BLL;
using WC.Model;

namespace WC.WebUI.Manage.Paper
{
    public partial class PaperView : WC.BLL.ViewPages
    {
        protected string pid = "";
        protected string fjs = "";
        protected string fj = "<span style='font-weight:bold;'>{1}</span> &nbsp;&nbsp;&nbsp;&nbsp;<a href='/Manage/Paper/Download.aspx?destFileName={0}&pid={2}' ><img src='/img/mail_attachment.gif' />下载附件</a><br>";
        protected string docfj = "<span style='font-weight:bold;'>{1}</span> &nbsp;&nbsp;&nbsp;&nbsp;<a href='/Manage/Paper/Download.aspx?destFileName={0}&pid={2}' ><img src='/img/mail_attachment.gif' />下载附件</a> &nbsp;&nbsp;";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && !string.IsNullOrEmpty(Request.QueryString["pid"]))
            {
                pid = Request.QueryString["pid"];
                Show(pid);
            }

        }

        private void Show(string pid)
        {
            PaperInfo pi = WC.BLL.Paper.Init().GetById(Convert.ToInt32(pid));
            PaperTypeInfo pti = PaperType.Init().GetById(pi.TypeID);
            if ((pi.ShareDeps.Trim() == "") || pi.ShareDeps.Contains("#" + DepID + "#") || (pi.CreatorID == Convert.ToInt32(Uid)) || Modules.Contains("53"))
            {
                TypeName.InnerText = "[" + pti.TypeName + "] ";
                PaperName.InnerText = pi.PaperName;
                try
                {
                    PaperDate.InnerText = pi.PaperDate + " (" + WC.Tool.Utils.ConvertDate4(Convert.ToDateTime(pi.PaperDate.Substring(0, 4) + "-" + pi.PaperDate.Substring(4, 2) + "-" + pi.PaperDate.Substring(6, 2))) + ")";
                }
                catch
                {
                    PaperDate.InnerText = "错误的日期格式！";
                }
                SendDep.InnerText = pi.SendDep;
                PaperSymbol.InnerText = pi.PaperSymbol;
                //PaperNO.InnerText = pi.PaperNO;
                //PaperKind.InnerText = pi.PaperKind;
                PaperGrade.InnerText = pi.PaperGrade;
                //PaperUrgency.InnerText = pi.PaperUrgency;
                Notes.InnerText = pi.Notes;

                if (pi.ShareDeps.Contains(","))
                {
                    string td = "";
                    string[] array = pi.ShareDeps.Split(',');
                    for (int i = 0; i < array.Length; i++)
                    {
                        if (array[i].Contains("#"))
                        {
                            td += array[i].Split('#')[0] + " ";
                        }
                    }
                    namelist_dep.InnerText = td;
                }
                else
                {
                    namelist_dep.InnerText = "全体人员";
                }

                if (!string.IsNullOrEmpty(pi.FilePath))
                {
                    fjs = "";
                    string[] array = pi.FilePath.Split('|');
                    for (int i = 0; i < array.Length; i++)
                    {
                        if (array[i].Trim() != "")
                        {
                            int t = array[i].LastIndexOf('/') + 1;
                            string filename = array[i].Substring(t, array[i].Length - t);
                            string fileurl = array[i].ToString();

                            fjs += string.Format(fj, Server.UrlEncode(fileurl), filename, pid);

                        }
                    }
                }
            }
            else
            {
                Response.Write("<script>alert('您没有查看权限');</script>");
            }

        }

    }
}