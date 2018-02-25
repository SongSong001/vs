using System;
using System.Collections;
using System.Data;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using WC.WebUI.Manage.CalendarMemo;

namespace WC.WebUI.limagan.cal
{
    /// <summary>
    /// $codebehindclassname$ 的摘要说明
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class _event : IHttpHandler
    {
        limaganDataDALs bgs = new limaganDataDALs();

        public void ProcessRequest(HttpContext context)
        {
            string temp = "";
            string myaction = context.Request.Params["action"];
            string mysf = context.Request.Params["sf"];
            if (myaction != null)
            {
                if (myaction.ToLower() == "create")//创建
                {
                    Calendars my_lc01 = new Calendars();

                    //my_lc01.UID = context.Request.Params["src"];
                    my_lc01.EID = RndNum(15);
                    my_lc01.UID = context.Request.Params["src"];
                    if ((context.Request.Params["ctext"] == null) && (context.Request.Params["text"] == null))
                    {
                        my_lc01.EName = "";
                    }
                    else
                    {
                        if (context.Request.Params["ctext"] != null)
                        {
                            my_lc01.EName = context.Request.Params["ctext"].Replace("'", "’").Replace("\\", "＼").Replace("<", "〈").Replace(">", "〉").Replace("&", "＆");
                        }
                        else
                        {
                            my_lc01.EName = context.Request.Params["text"].Replace("'", "’").Replace("\\", "＼").Replace("<", "〈").Replace(">", "〉").Replace("&", "＆");
                        }
                    }
                    string mytemp = context.Request.Params["dates"];
                    if (mytemp != null)
                    {
                        string[] mytempdates = mytemp.Split('/');
                        my_lc01.STime = mytempdates[0];
                        my_lc01.ETime = mytempdates[1];
                    }
                    my_lc01.CTime = context.Request.Params["eid"];
                    string mymemo = context.Request.Params["details"];
                    if (mymemo != null)
                    {
                        my_lc01.MEMO = mymemo.Replace("'", "’").Replace("\\", "＼").Replace("<", "〈").Replace(">", "〉").Replace("&", "＆");
                    }
                    else
                    {
                        my_lc01.MEMO = "";
                    }

                    my_lc01.LogicDelete = 0;
                    my_lc01.MTime = DateTime.Now;

                    string re_meg = bgs.Insert<Calendars>(my_lc01);
                    if (re_meg == "1")
                    {
                        temp = @"while(1);[['r','" + my_lc01.CTime + "','" + my_lc01.EID + "'],['a','" + my_lc01.EID + "','" + my_lc01.EName + "','" + my_lc01.STime + "','" + my_lc01.ETime + "','" + my_lc01.UID + "',,,525573,,,0,'',null,,null,[126975,60,null,'',[],0,'DEFAULT']],['_RefreshCalendarWhenDisplayedNext'],['_Ping','500'],['_Ping','3000'],['_Ping','15000'],['_RefreshCalendarWhenDisplayedNext'],['_ShowMessageUndoable','工作日程已添加。']]";
                    }
                }
                else if (myaction.ToLower() == "edit")//修改
                {
                    string myuid = context.Request.Params["src"];
                    string myeid = context.Request.Params["eid"];
                    string mydates = context.Request.Params["dates"];
                    string myename = context.Request.Params["text"];
                    string mymemo = context.Request.Params["details"];

                    Calendars my_lc01 = bgs.Find_Calendar_ByPara(myuid, myeid);
                    if (my_lc01 != null)
                    {
                        string re_meg = bgs.Update<Calendars>(my_lc01,
                            delegate(Calendars t)
                            {
                                if (mydates != null)
                                {
                                    string[] mytempdates = mytempdates = mydates.Split('/');
                                    my_lc01.STime = mytempdates[0];
                                    my_lc01.ETime = mytempdates[1];
                                }

                                if (myename != null)
                                {
                                    my_lc01.EName = myename.Replace("'", "’").Replace("\\", "＼").Replace("<", "〈").Replace(">", "〉").Replace("&", "＆");
                                }

                                if (mymemo != null)
                                {
                                    my_lc01.MEMO = mymemo.Replace("'", "’").Replace("\\", "＼").Replace("<", "〈").Replace(">", "〉").Replace("&", "＆");
                                }

                                my_lc01.MTime = DateTime.Now;
                            });

                        if (re_meg == "1")
                        {
                            temp = @"while(1);[['a','" + my_lc01.EID + "','" + my_lc01.EName + "','" + my_lc01.STime + "','" + my_lc01.ETime + "','" + my_lc01.UID + "',,,525573,,,0,'',null,,null,[126975,60,null,'',[],0,'DEFAULT']],['_RefreshCalendarWhenDisplayedNext'],['_Ping','500'],['_Ping','3000'],['_Ping','15000'],['_RefreshCalendarWhenDisplayedNext'],['_ShowMessageUndoable','您的工作日程已更新。']]";
                        }
                        else
                        {
                            temp = @"while(1);[['_ShowMessageUndoable','更新失败1。']]";
                        }
                    }
                    else
                    {
                        temp = @"while(1);[['_ShowMessageUndoable','更新失败2。']]";
                    }
                }
                else
                { }
            }
            else if (mysf != null)
            {
                string myemid = context.Request.Params["emid"];
                string myuid = context.Request.Params["src"];
                string myeid = context.Request.Params["eid"];

                Calendars my_lc01 = bgs.Find_Calendar_ByPara(myuid, myeid);
                if (my_lc01 != null)
                {
                    string myeventpageaction = "EDIT";
                    string myeventpageaccess = "editable";
                    if (myemid == null)
                    {
                        myeventpageaction = "VIEW";
                        myeventpageaccess = "readonly";
                    }

                    string mytemp_dates = "";
                    if (my_lc01.STime.Length == 15)
                    {
                        mytemp_dates = ""
                        + "	<dates access=\"" + myeventpageaccess + "\" editing=\"false\">"
                        + "		<value>" + my_lc01.STime + "/" + my_lc01.ETime + "</value>"
                        + "		<display>" + my_lc01.STime.Substring(0, 4) + "-" + my_lc01.STime.Substring(4, 2) + "-" + my_lc01.STime.Substring(6, 2) + " " + my_lc01.STime.Substring(9, 2) + ":" + my_lc01.STime.Substring(11, 2) + " - " + my_lc01.ETime.Substring(0, 4) + "-" + my_lc01.ETime.Substring(4, 2) + "-" + my_lc01.ETime.Substring(6, 2) + " " + my_lc01.ETime.Substring(9, 2) + ":" + my_lc01.ETime.Substring(11, 2) + "</display>"
                        + "		<start-date>" + my_lc01.STime.Substring(0, 4) + "-" + my_lc01.STime.Substring(4, 2) + "-" + my_lc01.STime.Substring(6, 2) + "</start-date>"
                        + "		<start-time>" + my_lc01.STime.Substring(9, 2) + ":" + my_lc01.STime.Substring(11, 2) + "</start-time>"
                        + "		<end-date>" + my_lc01.ETime.Substring(0, 4) + "-" + my_lc01.ETime.Substring(4, 2) + "-" + my_lc01.ETime.Substring(6, 2) + "</end-date>"
                        + "		<end-time>" + my_lc01.ETime.Substring(9, 2) + ":" + my_lc01.ETime.Substring(11, 2) + "</end-time>"
                        + "	</dates>";
                    }
                    else
                    {
                        mytemp_dates = ""
                        + "	<dates access=\"" + myeventpageaccess + "\" editing=\"false\">"
                        + "		<value>" + my_lc01.STime + "/" + my_lc01.ETime + "</value>"
                        + "		<display>" + my_lc01.STime.Substring(0, 4) + "-" + my_lc01.STime.Substring(4, 2) + "-" + my_lc01.STime.Substring(6, 2) + " - " + my_lc01.ETime.Substring(0, 4) + "-" + my_lc01.ETime.Substring(4, 2) + "-" + my_lc01.ETime.Substring(6, 2) + "</display>"
                        + "		<start-date>" + my_lc01.STime.Substring(0, 4) + "-" + my_lc01.STime.Substring(4, 2) + "-" + my_lc01.STime.Substring(6, 2) + "</start-date>"
                        + "		<end-date>" + my_lc01.ETime.Substring(0, 4) + "-" + my_lc01.ETime.Substring(4, 2) + "-" + my_lc01.ETime.Substring(6, 2) + "</end-date>"
                        + "	</dates>";
                    }

                    temp = ""
                        + "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\" ?>"
                        + "<eventpage action=\"" + myeventpageaction + "\" simplified=\"true\" url=\"event?sf=true&amp;output=xml&amp;hl=zh_CN&amp;eid=" + my_lc01.EID + "&amp;src=" + my_lc01.UID + "\" access-level=\"60\" specialized=\"false\" has-overrides=\"false\" static-file-prefix=\"6a3eb8ba4a07edb76f79a18d6bdb8933\" lang=\"zh_CN\" current-action=\"VIEW\" can-respond=\"true\" can-add-self=\"false\">"
                        + "	<features>"
                        + "		<feature enabled=\"false\"/>"
                        + "		<feature enabled=\"false\"/>"
                        + "		<feature enabled=\"false\"/>"
                        + "		<feature enabled=\"true\"/>"
                        + "		<feature enabled=\"true\"/>"
                        + "		<feature enabled=\"false\"/>"
                        + "		<feature enabled=\"true\"/>"
                        + "		<feature enabled=\"false\"/>"
                        + "		<feature enabled=\"false\"/>"
                        + "		<feature enabled=\"false\"/>"
                        + "		<feature enabled=\"false\"/>"
                        + "		<feature enabled=\"false\"/>"
                        + "		<feature enabled=\"false\"/>"
                        + "		<feature enabled=\"true\"/>"
                        + "		<feature enabled=\"false\"/>"
                        + "		<feature enabled=\"false\"/>"
                        + "		<feature enabled=\"false\"/>"
                        + "		<feature enabled=\"false\"/>"
                        + "		<feature enabled=\"false\"/>"
                        + "	</features>"
                        + "	<ref-date>"
                        + "		<value>" + DateTime.Now.ToString("yyyyMMdd") + "</value>"
                        + "	</ref-date>"
                        + "	<eid>"
                        + "		<value>" + my_lc01.EID + "</value>"
                        + "	</eid>"
                        + "	<self is-signed-in=\"true\" allow-guest-modify-feature=\"true\" allow-invite-yourself-feature=\"false\" allow-alternate-calendar-feature=\"true\" allow-publish-dialog-feature=\"false\" has-weekends=\"true\">"
                        + "		<principal id=\"" + my_lc01.UID + "\" status=\"5\" type=\"0\">"
                        + "			<value>admins@job18.net</value>"
                        + "			<display>日程管理系统</display>"
                        + "			<abbr>日程管理系统</abbr>"
                        + "		</principal>"
                        + "	</self>"
                        + "	<secid><value>1234567890</value></secid>"
                        + "	<summary access=\"" + myeventpageaccess + "\" editing=\"false\"><html>" + my_lc01.EName + "</html></summary>"
                        + "	<attachments access=\"readonly\" editing=\"false\"></attachments>"
                        + mytemp_dates
                        + "	<rrule access=\"readonly\" editing=\"false\" byday=\"WE\" interval=\"1\" wkst=\"MO\">"
                        + "		<value></value>"
                        + "		<display></display>"
                        + "	</rrule>"
                        + "	<timezone visible=\"false\">"
                        + "		<value>Asia/Shanghai</value>"
                        + "		<display>China - beijin</display>"
                        + "		<abbr>CST</abbr>"
                        + "	</timezone>"
                        + "	<attendees access=\"readonly\" editing=\"false\"></attendees>"
                        + "	<location access=\"readonly\" editing=\"false\"><value></value></location>"
                        + "	<transparent access=\"readonly\" editing=\"false\"><value>false</value><display>busy</display></transparent>"
                        + "	<class access=\"readonly\" editing=\"false\"><value>DEFAULT</value><display>default</display></class>"
                        + "	<description access=\"" + myeventpageaccess + "\" editing=\"false\"><html>" + my_lc01.MEMO + "</html></description>"
                        + "	<reminders access=\"readonly\" editing=\"true\" sms-verified=\"false\"><reminder method=\"3\" secs-lead=\"600\"></reminder></reminders>"
                        + "	<creator>"
                        + "		<principal id=\"" + myuid + "\" status=\"5\" type=\"0\">"
                        + "			<value>admins@job18.net</value>"
                        //+ "			<display>日程管理系统</display>"
                        //+ "			<abbr>日程管理系统</abbr>"
                        + "		</principal>"
                        + "	</creator>"
                        + "	<organizer>"
                        + "		<principal id=\"" + myuid + "\" status=\"5\" type=\"0\">"
                        + "			<value>admins@job18.net</value>"
                        //+ "			<display>日程管理系统</display>"
                        //+ "			<abbr>日程管理系统</abbr>"
                        + "		</principal>"
                        + "	</organizer>"
                        + "	<source-calendar access=\"readonly\" editing=\"false\">"
                        + "		<principal id=\"" + myuid + "\" status=\"5\" type=\"0\">"
                        + "			<value>admins@job18.net</value>"
                        //+ "			<display>日程管理系统</display>"
                        //+ "			<abbr>日程管理系统</abbr>"
                        + "		</principal>"
                        + "	</source-calendar>"
                        + "	<shared-property name=\"goo.allowInviteYourself\" access=\"readonly\" editing=\"true\"><value>false</value></shared-property>"
                        + "	<shared-property name=\"goo.allowModify\" access=\"readonly\" editing=\"true\"><value>false</value></shared-property>"
                        + "	<shared-property name=\"goo.allowInvitesOther\" access=\"readonly\" editing=\"true\">"
                        + "		<value>true</value>"
                        + "	</shared-property>"
                        + "	<shared-property name=\"goo.allowComments\" access=\"readonly\" editing=\"true\"><value>true</value></shared-property>"
                        + "	<shared-property name=\"goo.showInvitees\" access=\"readonly\" editing=\"true\"><value>true</value></shared-property>"
                        + "	<calendars></calendars>"
                        + "	<comments access=\"readonly\" editing=\"false\"></comments>"
                        + "	<modules>"
                        + "		<module module-id=\"4\"></module>"
                        + "		<module module-id=\"6\"></module>"
                        + "		<module module-id=\"8\"></module>"
                        + "	</modules>"
                        + "	<messages-to-user></messages-to-user>"
                        + "</eventpage>";
                }
                else
                {
                    temp = @"while(1);[['_ShowMessageUndoable','获取信息失败，请稍候重试。']]";
                }
            }

            if ((context.Request.Params["output"] != null) && (context.Request.Params["output"].ToString().ToLower() == "xml"))
            {
                context.Response.ContentType = "text/xml";
            }
            else
            {
                context.Response.ContentType = "text/javascript";
            }
            context.Response.Charset = "utf-8";
            context.Response.Cache.SetCacheability(HttpCacheability.NoCache);
            context.Response.Expires = 0;
            context.Response.Write(temp);
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }

        private string RndNum(int VcodeNum)
        {
            string Vchar = "0,1,2,3,4,5,6,7,8,9,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,h,e,l,l,o,h,i,l,l";
            string[] VcArray = Vchar.Split(',');
            string VNum = "";
            Random rdm = new Random(unchecked((int)DateTime.Now.Ticks));
            for (int i = 0; i < VcodeNum; i++)
            {
                VNum += VcArray[rdm.Next(0, 61)];
            }
            return VNum;
        }
    }
}
