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
using System.Collections.Generic;

namespace WC.WebUI.Manage.Common
{
    public partial class Vote_Manage : WC.BLL.ViewPages
    {
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
            VoteTitle.Value = vi.VoteTitle;
            VoteContent.Value = vi.VoteContent;
            IsValide.SelectedValue = vi.IsValide + "";
            IsMultiple.SelectedValue = vi.IsMultiple + "";
            ShowUser.SelectedValue = vi.ShowUser + "";
            userlist.Value = vi.userlist;
            namelist.Value = vi.namelist;
            ViewState["vi"] = vi;

        }

        protected void Save_Btn(object sender, EventArgs e)
        {
            if (CheckItemCount(VoteContent.Value))
            {
                if (string.IsNullOrEmpty(Request.QueryString["vid"]))
                {
                    VoteInfo vi = new VoteInfo();
                    vi.AddTime = DateTime.Now;
                    vi.CreateDepName = DepName;
                    vi.CreateRealName = RealName;
                    vi.CreateUserID = Convert.ToInt32(Uid);
                    vi.VoteTitle = VoteTitle.Value;
                    vi.VoteContent = VoteContent.Value.Replace("'", "").Replace("\"", "");
                    vi.IsMultiple = Convert.ToInt32(IsMultiple.SelectedValue);
                    vi.IsValide = Convert.ToInt32(IsValide.SelectedValue);
                    vi.ShowUser = Convert.ToInt32(ShowUser.SelectedValue);
                    vi.userlist = userlist.Value;
                    vi.namelist = namelist.Value;

                    Vote.Init().Add(vi);
                }
                else
                {
                    VoteInfo vi = ViewState["vi"] as VoteInfo;
                    vi.VoteTitle = VoteTitle.Value;
                    vi.VoteContent = VoteContent.Value.Replace("'", "").Replace("\"", "");
                    vi.IsMultiple = Convert.ToInt32(IsMultiple.SelectedValue);
                    vi.IsValide = Convert.ToInt32(IsValide.SelectedValue);
                    vi.ShowUser = Convert.ToInt32(ShowUser.SelectedValue);
                    vi.userlist = userlist.Value;
                    vi.namelist = namelist.Value;

                    Vote.Init().Update(vi);
                }
                string words = HttpContext.Current.Server.HtmlEncode("您好!投票保存成功!");
                Response.Redirect("/InfoTip/Operate_Success.aspx?returnpage="
                + "/Manage/Common/Vote_List.aspx" + "&tip=" + words);
            }
            else
            {
                Response.Write("<script>alert('最多只支持11个选项!');window.location='Vote_List.aspx';</script>");
            }

        }

        private bool CheckItemCount(string content)
        {
            bool b = true;
            int c = 0;
            if (content.Contains("\n"))
            {
                string[] arr = content.Split(new string[] { "\n" }, StringSplitOptions.None);
                for (int i = 0; i < arr.Length; i++)
                {
                    if (!string.IsNullOrEmpty(arr[i].Replace("\n", "").Replace("\r", "")))
                        c++;
                }
                if (c > 11)
                    b = false;
            }

            return b;
        }

    }
}
