using System;
using System.Collections.Generic;
using System.Text;

namespace WC.Model
{
    [Serializable]
    public class PhoneBookInfo
    {
        public PhoneBookInfo()
        {
            this._guid = Guid.NewGuid().ToString("N");
        }

        #region 成员
        private int _id;
        private string _guid;
        private int _UserID;
        private string _RealName;
        private string _DepName;
        private DateTime _AddTime;
        private string _Person;
        private string _Phone;
        private string _TagName;
        private string _Notes;

        private int _ComID;

        public int ComID
        {
            get { return _ComID; }
            set { _ComID = value; }
        }
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

        public int UserID
        {
            get { return _UserID; }
            set { _UserID = value; }
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

        public DateTime AddTime
        {
            get { return _AddTime; }
            set { _AddTime = value; }
        }

        public string Person
        {
            get { return _Person; }
            set { _Person = value; }
        }

        public string Phone
        {
            get { return _Phone; }
            set { _Phone = value; }
        }

        public string TagName
        {
            get { return _TagName; }
            set { _TagName = value; }
        }

        public string Notes
        {
            get { return _Notes; }
            set { _Notes = value; }
        }
        #endregion
    }
}
