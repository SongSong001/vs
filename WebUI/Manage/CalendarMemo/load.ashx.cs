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
    public class load : IHttpHandler
    {
        limaganDataDALs bgs = new limaganDataDALs();

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/javascript";
            context.Response.Charset = "utf-8";
            context.Response.Cache.SetCacheability(HttpCacheability.NoCache);
            context.Response.Expires = 0;
            string temp = "";

            string myemf = context.Request.Params["emf"];//用户&时间列表
            string[] mytemp_emf = myemf.Split('\n');

            int lefflag = 0;
            string myuid = context.Request.Params["lef"];//用户列表
            if (myuid == null)
            {
                //这里表明是新增/更新/删除后提交的查询
                lefflag = 1;
            }

            Hashtable ht = new Hashtable();
            string myrangebegin = "";//已经加载到用户的时间范围(开始)
            string myrangeend = "";//已经加载到用户的时间范围(结束)
            ArrayList aluidtime = new ArrayList();//查找的时候
            ArrayList newut = new ArrayList();//增删改的时候

            #region 整理并分析接受到的参数
            for (int i = 0; i < mytemp_emf.Length; i++)
            {
                string[] mytempsz = mytemp_emf[i].Split(' ');

                string[] mytemp_date = mytempsz[1].Split('/');

                if (myrangebegin == "")
                {
                    myrangebegin = mytemp_date[0];
                }

                if (myrangeend == "")
                {
                    myrangeend = mytemp_date[1];
                }

                if (Convert.ToDateTime(string.Format("{0:0000-00-00}", Convert.ToInt32(mytemp_date[0]))) < Convert.ToDateTime(string.Format("{0:0000-00-00}", Convert.ToInt32(myrangebegin))))
                {
                    myrangebegin = mytemp_date[0];
                }

                if (Convert.ToDateTime(string.Format("{0:0000-00-00}", Convert.ToInt32(mytemp_date[1]))) > Convert.ToDateTime(string.Format("{0:0000-00-00}", Convert.ToInt32(myrangeend))))
                {
                    myrangeend = mytemp_date[1];
                }

                if (mytempsz[2] == "0")
                {
                    string[] tempuidtime = new string[3] { mytempsz[0], mytemp_date[0], mytemp_date[1] };
                    aluidtime.Add(tempuidtime);
                }
                else
                {
                    if (lefflag == 1)//查找新增项
                    {
                        string[] tempuidtime = new string[2] { mytempsz[0], mytempsz[2] };
                        newut.Add(tempuidtime);
                    }
                }

                if (!ht.Contains(mytempsz[0]))
                {
                    ht.Add(mytempsz[0], mytempsz[0]);//记录用户id列表
                }

            }
            #endregion

            ArrayList aKeys = new ArrayList(ht.Keys);
            if (aKeys.Count > 0)
            {
                string myus = "";
                string mytempvar = "";
                string[] tempuid = new string[aKeys.Count];

                for (int j = 0; j < aKeys.Count; j++)
                {
                    tempuid[j] = aKeys[j].ToString();

                    mytempvar += "b" + j.ToString() + "='" + aKeys[j].ToString() + "',";
                }

                mytempvar += "bf='',n=525573";
                temp = @"while(1);(function(){var a = 'a',d = 'd', " + mytempvar + ";return [";

                if (aluidtime.Count > 0)
                {
                    #region 搜索
                    string[] finduid = new string[aluidtime.Count];
                    string[] findbegin = new string[aluidtime.Count];
                    string[] findend = new string[aluidtime.Count];
                    for (int j = 0; j < aluidtime.Count; j++)
                    {
                        finduid[j] = ((string[])aluidtime[j])[0];
                        findbegin[j] = ((string[])aluidtime[j])[1];
                        findend[j] = ((string[])aluidtime[j])[2];
                    }

                    List<Calendars> myllc = new List<Calendars>();
                    myllc = bgs.Find_Calendar_List_ByUID_and_TIME(finduid, findbegin, findend, 0, 1189);

                    if ((myllc != null) && (myllc.Count > 0))
                    {
                        string aordflag = "a";
                        string myindexflag = "bf";

                        for (int i = 0; i < myllc.Count; i++)
                        {
                            for (int k = 0; k < tempuid.Length; k++)
                            {
                                if (tempuid[k] == myllc[i].UID)
                                {
                                    myindexflag = "b" + k;
                                    break;
                                }
                            }

                            temp += @"[" + aordflag + ",'" + myllc[i].EID + "','" + myllc[i].EName + "','" + myllc[i].STime + "','" + myllc[i].ETime + "'," + myindexflag + ",,,n],";
                            myindexflag = "bf";
                        }
                    }
                    #endregion
                }
                else
                {
                    #region 添加或删除
                    if (newut.Count > 0)
                    {
                        string[] finduid = new string[newut.Count];
                        string[] findnew = new string[newut.Count];
                        for (int j = 0; j < newut.Count; j++)
                        {
                            finduid[j] = ((string[])newut[j])[0];
                            findnew[j] = ((string[])newut[j])[1];
                        }

                        List<Calendars> myllc = new List<Calendars>();
                        myllc = bgs.Find_Calendar_List_ByUID_and_TIME(finduid, findnew, 0, 500);

                        if ((myllc != null) && (myllc.Count > 0))
                        {
                            string aordflag = "a";
                            string myindexflag = "bf";

                            for (int i = 0; i < myllc.Count; i++)
                            {
                                for (int k = 0; k < tempuid.Length; k++)
                                {
                                    if (tempuid[k] == myllc[i].UID)
                                    {
                                        myindexflag = "b" + k;
                                        break;
                                    }
                                }
                                if (myllc[i].LogicDelete == 0)
                                {
                                    aordflag = "a";
                                }
                                else if (myllc[i].LogicDelete == -1)
                                {
                                    aordflag = "d";
                                }
                                temp += @"[" + aordflag + ",'" + myllc[i].EID + "','" + myllc[i].EName + "','" + myllc[i].STime + "','" + myllc[i].ETime + "'," + myindexflag + ",,,n],";
                                myindexflag = "bf";
                            }
                        }
                    }
                    #endregion
                }

                for (int j = 0; j < aKeys.Count; j++)
                {
                    string aaa = Convert.ToInt64(DateTime.Now.Subtract(new DateTime(1, 1, 1, 0, 0, 0)).TotalSeconds).ToString();
                    if ((j + 1) == aKeys.Count)
                    {
                        myus = myus + aKeys[j].ToString() + " " + myrangebegin + "/" + myrangeend + " " + aaa;
                    }
                    else
                    {
                        myus = myus + aKeys[j].ToString() + " " + myrangebegin + "/" + myrangeend + " " + aaa + "\\n";
                    }
                }

                myus = myus.Substring(0, myus.Length);
                temp += @"['us','" + myus + "'],['_RefreshCalendarWhenDisplayedNext']]})()";
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
