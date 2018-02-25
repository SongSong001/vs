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
using WC.DBUtility;
using System.Collections.Generic;

namespace WC.WebUI.Manage.Common
{
    public partial class Vote_UserList : WC.BLL.ViewPages
    {
        private DataSet ds;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["vid"]))
                Show(Convert.ToInt32(Request.QueryString["vid"]));
        }

        private void Show(int vid)
        {
            VoteInfo vi = Vote.Init().GetById(vid);
            if (!string.IsNullOrEmpty(vi.VoteContent) && (vi.ShowUser == 1 || Modules.Contains("45")) )
            {
                ds = MsSqlOperate.ExecuteDataset(CommandType.Text, "select * from VoteDetail where VoteID=" + vid);

                List<TmpInfo> list = new List<TmpInfo>();
                if (vi.VoteContent.Contains("\n"))
                {
                    string[] arr = vi.VoteContent.Split(new string[] { "\n" }, StringSplitOptions.None);
                    for (int j = 0; j < arr.Length; j++)
                    {
                        if (!string.IsNullOrEmpty(arr[j].Replace("\n", "").Replace("\r", "")))
                        {
                            TmpInfo t = new TmpInfo();
                            t.Tmp1 = arr[j].Replace("\n", "").Replace("\r", "");
                            list.Add(t);
                        }
                    }
                }
                else
                {
                    TmpInfo t = new TmpInfo();
                    t.Tmp1 = vi.VoteContent.Replace("\n", "").Replace("\r", "");
                    list.Add(t);
                }
                rpt.DataSource = list;
                rpt.DataBind();
            }

        }

        protected string GetCountDetail(string name)
        {
            string r = "";
            DataRow[] rlist = ds.Tables[0].Select("ItemName='" + name + "'");
            foreach (DataRow row in rlist)
            {
                r += row["VoteRealName"] + "(" + row["VoteDepName"] + "),";
            }
            return r;
        }

        protected string GetCount(string name)
        {
            return ds.Tables[0].Select("ItemName='" + name + "'").Length + "";
        }

    }
}
