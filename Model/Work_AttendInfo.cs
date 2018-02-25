using System;
using System.Collections.Generic;
using System.Text;

namespace WC.Model
{
    [Serializable]
    public class Work_AttendInfo
    {
        public Work_AttendInfo()
        {
            this._guid = Guid.NewGuid().ToString("N");
        }

        #region 成员
        private int _id;
        private string _guid;
        private int _UID;
        private int _DepID;
        private string _RealName;
        private string _DepName;
        private int _AttendType;
        private int _AttendTimeID;
        private string _StandardTimes;
        private string _StandardNames;
        private string _SignTimes;
        private string _SignDates;
        private string _SignJudge;
        private DateTime _BeginTime;
        private string _B1;
        private string _B2;
        private DateTime _EndTime;
        private string _E1;
        private string _E2;
        private string _TravelAddress;
        private string _Notes;
        private DateTime _AddTime;
        #endregion

        #region 属性
        public int id
        {
            get { return _id; }
            set { _id = value; }
        }

        public string guid
        {
            get { return _guid; }
            set { _guid = value; }
        }

        public int UID
        {
            get { return _UID; }
            set { _UID = value; }
        }

        public int DepID
        {
            get { return _DepID; }
            set { _DepID = value; }
        }

        public string RealName
        {
            get { return _RealName; }
            set { _RealName = value; }
        }

        public string DepName
        {
            get { return _DepName; }
            set { _DepName = value; }
        }

        public int AttendType
        {
            get { return _AttendType; }
            set { _AttendType = value; }
        }

        public int AttendTimeID
        {
            get { return _AttendTimeID; }
            set { _AttendTimeID = value; }
        }

        public string StandardTimes
        {
            get { return _StandardTimes; }
            set { _StandardTimes = value; }
        }

        public string StandardNames
        {
            get { return _StandardNames; }
            set { _StandardNames = value; }
        }

        public string SignTimes
        {
            get { return _SignTimes; }
            set { _SignTimes = value; }
        }

        public string SignDates
        {
            get { return _SignDates; }
            set { _SignDates = value; }
        }

        public string SignJudge
        {
            get { return _SignJudge; }
            set { _SignJudge = value; }
        }

        public DateTime BeginTime
        {
            get { return _BeginTime; }
            set { _BeginTime = value; }
        }

        public string B1
        {
            get { return _B1; }
            set { _B1 = value; }
        }

        public string B2
        {
            get { return _B2; }
            set { _B2 = value; }
        }

        public DateTime EndTime
        {
            get { return _EndTime; }
            set { _EndTime = value; }
        }

        public string E1
        {
            get { return _E1; }
            set { _E1 = value; }
        }

        public string E2
        {
            get { return _E2; }
            set { _E2 = value; }
        }

        public string TravelAddress
        {
            get { return _TravelAddress; }
            set { _TravelAddress = value; }
        }

        public string Notes
        {
            get { return _Notes; }
            set { _Notes = value; }
        }

        public DateTime AddTime
        {
            get { return _AddTime; }
            set { _AddTime = value; }
        }

        #endregion

    }
}
