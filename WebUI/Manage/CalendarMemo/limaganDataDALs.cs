using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Collections.Generic;
using WC.DBUtility;
using WC.Tool;
using System.Text;

namespace WC.WebUI.Manage.CalendarMemo
{
    public class limaganDataDALs
    {
        public List<Calendars> Find_Calendar_List_ByUID_and_TIME(string[] uid, string[] stime, string[] etime, int startIndex, int pageNum)
        {
            string mytempuid = " ";
            for (int i = 0; i < uid.Length; i++)
            {
                if (i != uid.Length - 1)
                    mytempuid += " ( logicdelete= 0 and UID = '" + uid[i].ToString() + "' and STime > '" + stime[i].ToString() + "' and STime <= '" + etime[i].ToString() + "') or ";
                else
                    mytempuid += " ( logicdelete= 0 and UID = '" + uid[i].ToString() + "' and STime > '" + stime[i].ToString() + "' and STime <= '" + etime[i].ToString() + "') ";
            }
            string sql = "select * from Calendar where {0}";

            sql = string.Format(sql, mytempuid);

            using (DataSet ds = MsSqlOperate.ExecuteDataset(CommandType.Text, sql))
            {
                List<Calendars> list = new List<Calendars>();
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    list.Add(SetPram(ds.Tables[0].Rows[i]));
                }
                return list;
            }
        }

        public List<Calendars> Find_Calendar_List_ByUID_and_TIME(string[] uid, string[] mtime, int startIndex, int pageNum)
        {
            string mytempuid = " ";
            for (int i = 0; i < uid.Length; i++)
            {
                DateTime aaa = new DateTime(1, 1, 1, 0, 0, 0).AddSeconds(Convert.ToInt64(mtime[i].ToString()));
                if (i != uid.Length - 1)
                    mytempuid += " ( logicdelete= 0 and UID = '" + uid[i].ToString() + "' and MTime > '" + aaa.ToString("yyyy-MM-dd HH:mm:ss") + "' ) or ";
                else
                    mytempuid += " ( logicdelete= 0 and UID = '" + uid[i].ToString() + "' and MTime > '" + aaa.ToString("yyyy-MM-dd HH:mm:ss") + "' ) ";
            }
            string sql = "select * from Calendar where {0}";

            sql = string.Format(sql, mytempuid);

            using (DataSet ds = MsSqlOperate.ExecuteDataset(CommandType.Text, sql))
            {
                List<Calendars> list = new List<Calendars>();
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    list.Add(SetPram(ds.Tables[0].Rows[i]));
                }
                return list;
            }
        }

        public Calendars Find_Calendar_ByPara(string uid, string eid)
        {
            string sql = "select * from Calendar where {0}";
            string mytempuid = " LogicDelete=0 and Uid='" + uid + "' and Eid='" + eid + "' ";

            sql = string.Format(sql, mytempuid);

            using (DataSet ds = MsSqlOperate.ExecuteDataset(CommandType.Text, sql))
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    return SetPram(ds.Tables[0].Rows[0]);
                }
                else
                    return null;
            }
        }

        public List<Calendars> Find_Calendar_ByPara_list(string uid, string eid)
        {
            string sql = "select * from Calendar where {0}";
            string mytempuid = " LogicDelete=0 and Uid='" + uid + "' and Eid='" + eid + "' ";

            sql = string.Format(sql, mytempuid);

            using (DataSet ds = MsSqlOperate.ExecuteDataset(CommandType.Text, sql))
            {
                if (ds.Tables[0].Rows.Count > 0)
                {
                    List<Calendars> list = new List<Calendars>();
                    for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                    {
                        list.Add(SetPram(ds.Tables[0].Rows[i]));
                    }
                    return list;
                }
                else
                    return null;
            }
        }

        public string Update<T>(T entity, Action<T> update) where T : class
        {
            try
            {
                update(entity);

                string sql = "update Calendar set UID=@UID,EID=@EID,EName=@EName,STime=@STime,ETime=@ETime,CTime=@CTime,MEMO=@MEMO,MTime=@MTime,LogicDelete=@LogicDelete where ID=@ID";
                Calendars c = entity as Calendars;

                SqlParameter[] ps = { new SqlParameter("@UID",c.UID), 
                                    new SqlParameter("@EID",c.EID),
                                    new SqlParameter("@EName",c.EName),
                                    new SqlParameter("@STime",c.STime),
                                    new SqlParameter("@ETime",c.ETime),
                                    new SqlParameter("@CTime",c.CTime),
                                    new SqlParameter("@MEMO",c.MEMO),
                                    new SqlParameter("@MTime",c.MTime),
                                    new SqlParameter("@LogicDelete",c.LogicDelete), 
                                    new SqlParameter("@ID",c.ID) };
                int t = MsSqlOperate.ExecuteNonQuery(CommandType.Text, sql, ps);
                if (t > 0)
                    return "1";
                else return "0";
            }
            catch
            {
                return "0";
            }

        }

        public string Insert<T>(T entity) where T : class
        {
            try
            {
                string sql = "insert into Calendar(UID,EID,EName,STime,ETime,CTime,MEMO,MTime,LogicDelete) values(@UID,@EID,@EName,@STime,@ETime,@CTime,@MEMO,@MTime,@LogicDelete)";
                Calendars c = entity as Calendars;

                SqlParameter[] ps = { new SqlParameter("@UID",c.UID), 
                                    new SqlParameter("@EID",c.EID),
                                    new SqlParameter("@EName",c.EName),
                                    new SqlParameter("@STime",c.STime),
                                    new SqlParameter("@ETime",c.ETime),
                                    new SqlParameter("@CTime",c.CTime),
                                    new SqlParameter("@MEMO",c.MEMO),
                                    new SqlParameter("@MTime",c.MTime),
                                    new SqlParameter("@LogicDelete",c.LogicDelete) };
                int t = MsSqlOperate.ExecuteNonQuery(CommandType.Text, sql, ps);
                if (t > 0)
                    return "1";
                else return "0";
            }
            catch 
            {
                return "0";
            }
        }

        public string Delete<T>(T entity) where T : class
        {
            try
            {
                Calendars c = entity as Calendars;
                string sql = "delete from Calendar where id=" + c.ID;
                int t = MsSqlOperate.ExecuteNonQuery(CommandType.Text, sql);
                if (t > 0)
                    return "1";
                else return "0";
            }
            catch
            {
                return "0";
            }

        }

        private Calendars SetPram(DataRow dbRow)
        {
            Calendars c = new Calendars();
            c.CTime = dbRow["CTime"] + "";
            c.EID = dbRow["EID"] + "";
            c.EName = dbRow["EName"] + "";
            c.ETime = dbRow["ETime"] + "";
            c.MEMO = dbRow["MEMO"] + "";
            c.UID = dbRow["UID"] + "";
            c.STime = dbRow["STime"] + "";

            c.MTime = Convert.ToDateTime(dbRow["MTime"]);
            c.ID = Convert.ToInt32(dbRow["ID"]);
            c.LogicDelete = Convert.ToInt32(dbRow["LogicDelete"]);
            return c;
        }

    }

    [Serializable]
    public class Calendars
    {
        private int _ID;

        public int ID
        {
            get { return _ID; }
            set { _ID = value; }
        }

        private string _UID;

        public string UID
        {
            get { return _UID; }
            set { _UID = value; }
        }

        private string _EID;

        public string EID
        {
            get { return _EID; }
            set { _EID = value; }
        }

        private string _EName;

        public string EName
        {
            get { return _EName; }
            set { _EName = value; }
        }

        private string _STime;

        public string STime
        {
            get { return _STime; }
            set { _STime = value; }
        }

        private string _ETime;

        public string ETime
        {
            get { return _ETime; }
            set { _ETime = value; }
        }

        private string _CTime;

        public string CTime
        {
            get { return _CTime; }
            set { _CTime = value; }
        }

        private System.DateTime _MTime;

        public System.DateTime MTime
        {
            get { return _MTime; }
            set { _MTime = value; }
        }

        private int _LogicDelete;

        public int LogicDelete
        {
            get { return _LogicDelete; }
            set { _LogicDelete = value; }
        }

        private string _MEMO;

        public string MEMO
        {
            get { return _MEMO; }
            set { _MEMO = value; }
        }

    }

}
