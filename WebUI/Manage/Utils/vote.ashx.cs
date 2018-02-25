using System;
using System.Collections;
using System.Data;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using WC.BLL;
using WC.Model;
using System.Collections.Generic;

namespace WC.WebUI.Manage.Utils
{
    /// <summary>
    /// $codebehindclassname$ 的摘要说明
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class vote : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {

            context.Response.Charset = "UTF-8";
            context.Request.ContentType = "text/html;charset=UTF-8";
            context.Response.Cache.SetNoStore();

            string u = context.Request.Params["u"];
            string p = context.Request.Params["p"];
            string vid = context.Request.Params["v"];
            string n = context.Server.UrlDecode(context.Request.Params["n"]);
            string result = "0";

            Sys_UserInfo ui = Sys_User.Init().GetById(Convert.ToInt32(u));
            VoteInfo vi = Vote.Init().GetById(Convert.ToInt32(vid));

            if (!string.IsNullOrEmpty(u) && !string.IsNullOrEmpty(p) && !string.IsNullOrEmpty(vid))
            {
                if (vi.userlist.Contains("#" + u + "#") && (vi.IsValide == 1) && !IsUserVoted(u, vid))
                {
                    if (p.Contains(","))
                    {
                        string[] arr = p.Split(',');
                        for (int i = 0; i < arr.Length; i++)
                        {
                            if (!string.IsNullOrEmpty(arr[i]))
                            {
                                VoteDetailInfo di = new VoteDetailInfo();
                                di.AddTime = DateTime.Now;
                                di.ItemName = GetVoteitem(Convert.ToInt32(arr[i]), vi);
                                di.VoteDepName = ui.DepName;
                                di.VoteRealName = ui.RealName;
                                di.VoteUserID = ui.id;
                                di.VoteID = Convert.ToInt32(vid);

                                VoteDetail.Init().Add(di);
                            }
                        }

                        if (!string.IsNullOrEmpty(n) && n != "在这里输入投票评论")
                        {
                            vi.VoteNotes += (vi.ShowUser == 1) ? ("<span>" + n + " &nbsp; &nbsp; --- " + ui.RealName + "(" + ui.DepName + ") " + WC.Tool.Utils.ConvertDate_(DateTime.Now) + " </span><br>") : ("<span>" + n + " &nbsp; &nbsp; --- 匿名用户 " + WC.Tool.Utils.ConvertDate_(DateTime.Now) + " </span><br>");
                            Vote.Init().Update(vi);
                        }

                        result = "1";
                    }
                }
            }

            context.Response.Write(result);
            context.Response.End();
        }

        private string GetVoteitem(int i,VoteInfo vi)
        {
            string res = "";
            List<string> list = new List<string>();
            if (vi.VoteContent.Contains("\n"))
            {
                string[] arr = vi.VoteContent.Split(new string[] { "\n" }, StringSplitOptions.None);
                for (int j = 0; j < arr.Length; j++)
                {
                    if (!string.IsNullOrEmpty(arr[j].Replace("\n", "").Replace("\r", "")))
                        list.Add(arr[j].Replace("\n", "").Replace("\r", ""));
                }
            }
            else
            {
                list.Add(vi.VoteContent.Replace("\n", "").Replace("\r", ""));
                
            }

            if (list.Count > i - 1)
                res = list[i - 1];

            return res;
        }

        private bool IsUserVoted(string uid, string vid)
        {
            IList list = VoteDetail.Init().GetAll("VoteUserID=" + uid + " and VoteID=" + vid, null);
            return (list.Count > 0) ? true : false;

        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}
