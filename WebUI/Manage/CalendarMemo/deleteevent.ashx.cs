using System;
using System.Collections;
using System.Data;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Collections.Generic;
using WC.WebUI.Manage.CalendarMemo;

namespace WC.WebUI.limagan.cal
{
    /// <summary>
    /// $codebehindclassname$ 的摘要说明
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class deleteevent : IHttpHandler
    {
        limaganDataDALs bgs = new limaganDataDALs();

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/javascript";
            context.Response.Cache.SetCacheability(HttpCacheability.NoCache);
            context.Response.Expires = 0;
            string temp = "";
            string myuid = context.Request.Params["src"];
            string myeid = context.Request.Params["eid"];
            string mydroi = context.Request.Params["droi"];

            if ((myuid != null) && (myeid != null) && (mydroi != null))
            {
                try
                {
                    string[] mytempdates = mytempdates = mydroi.Split('/');

                    List<Calendars> my_lc01 = bgs.Find_Calendar_ByPara_list(myuid, myeid);
                    if ((my_lc01 != null) && (my_lc01.Count > 0))
                    {
                        for (int i = 0; i < my_lc01.Count; i++)
                        {
                            string re_meg = bgs.Delete<Calendars>(my_lc01[i]);//物理删除
                            //逻辑删除
                            // re_meg = bgs.Update<Calendar>(my_lc01[i],
                            //delegate(Calendar t)
                            //{
                            //    my_lc01[i].LogicDelete = -1;
                            //    my_lc01[i].MTime = DateTime.Now;
                            //});

                            if (re_meg == "1")
                            {
                                temp = @"while(1);[['d','" + myeid + "'],['_ShowMessageUndoable','工作日程已删除'],['_RefreshCalendarWhenDisplayedNext'],['_Ping','500'],['_Ping','3000'],['_Ping','15000']]";
                            }
                        }
                    }
                    else
                    {
                        temp = @"while(1);[['d','" + myeid + "'],['_ShowMessageUndoable','工作日程已删除'],['_RefreshCalendarWhenDisplayedNext'],['_Ping','500'],['_Ping','3000'],['_Ping','15000']]";
                    }
                }
                catch
                {
                    temp = "";
                }
            }
            context.Response.Write(temp);
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
