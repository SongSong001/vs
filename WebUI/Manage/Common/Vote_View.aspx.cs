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
    public partial class Vote_View : WC.BLL.ViewPages
    {
        protected string data = "", title = "", showPoll = "", multiple = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && !string.IsNullOrEmpty(Request.QueryString["vid"]))
            {
                Show(Convert.ToInt32(Request.QueryString["vid"]));
            }
        }

        private void Show(int vid)
        {
            VoteInfo vi = Vote.Init().GetById(vid);
            //Subject.InnerText = vi.VoteTitle;
            
            Creator.InnerText = vi.CreateRealName + "(" + vi.CreateDepName + ")";
            AddTime.InnerText = WC.Tool.Utils.ConvertDate3(vi.AddTime);
            IsValide.InnerHtml = Convert.ToBoolean(vi.IsValide) ? "<strong>投票进行中</strong>" : "<strong>投票已停止</strong>";
            ShowUser.InnerHtml = (Convert.ToBoolean(vi.IsMultiple) ? "多选投票" : "单选投票") + " &nbsp; &nbsp; &nbsp; " +
                (Convert.ToBoolean(vi.ShowUser) ? "公开投票&nbsp;<a href='Vote_UserList.aspx?vid=" + vid + "' target=_blank>[查看选票]</a>" : "匿名投票");
            namelist.InnerText = WC.Tool.Utils.GetSubString2(vi.namelist, 250, "...");

            if (!string.IsNullOrEmpty(vi.VoteContent))
            {
                if (vi.VoteContent.Contains("\n"))
                {
                    string[] arr = vi.VoteContent.Split(new string[] { "\n" }, StringSplitOptions.None);
                    List<string> list = new List<string>();
                    for (int i = 0; i < arr.Length; i++)
                    {
                        if (!string.IsNullOrEmpty(arr[i].Replace("\n", "").Replace("\r", "")))
                            list.Add(arr[i]);
                    }
                    data = "\"{root:[";
                    for (int i = 0; i < list.Count; i++)
                    {
                        string name = list[i].Replace("\n", "").Replace("\r", "");
                        string count = GetVoteItemCount(name, vid);
                        if (i != list.Count - 1)
                        {
                            data += "{id:'" + (i + 1) + "',name:'" + name + "',value:'" + count + "'},";
                        }
                        else
                        {
                            data += "{id:'" + (i + 1) + "',name:'" + name + "',value:'" + count + "'}]}\"";
                        }
                    }

                }
                else
                {
                    string name = vi.VoteContent.Replace("\n", "").Replace("\r", "");
                    string count = GetVoteItemCount(name, vid);
                    data = "\"{root:[{id:'1',name:'" + name + "',value:'" + count + "'}]}\"";
                }

                title = "'" + vi.VoteTitle + "'";
                multiple = "false";
                showPoll = "false";

                if (vi.userlist.Contains("#" + Uid + "#") && (vi.IsValide == 1) && !IsUserVoted(Uid, vid + ""))
                {
                    multiple = Convert.ToBoolean(vi.IsMultiple) ? "true" : "false";
                    IsVote1.Visible = true;
                    showPoll = "true";
                }

                vi.VoteNotes = vi.VoteNotes + "";
                if (vi.VoteNotes.ToLower().Contains("script"))
                {
                    notes.InnerHtml = vi.VoteNotes.ToLower().Replace("script", "scrript");
                }
                else
                {
                    notes.InnerHtml = vi.VoteNotes.ToLower().Replace("<p>", "").Replace("</p>", "<br>");
                }
            }

        }

        private string GetVoteItemCount(string name, int vid)
        {
            string sql = "select count(*) from VoteDetail where VoteID=" + vid + " and ItemName=@ItemName";
            return MsSqlOperate.ExecuteScalar(CommandType.Text, sql, new System.Data.SqlClient.SqlParameter("@ItemName", name + "")) + "";
        }

        private bool IsUserVoted(string uid, string vid)
        {
            IList list = VoteDetail.Init().GetAll("VoteUserID=" + uid + " and VoteID=" + vid, null);
            return (list.Count > 0) ? true : false;

        }

    }
}
