using System;
using System.Collections.Generic;
using System.Text;

namespace WC.Model
{
    [Serializable]
    public class Sms_DataInfo
    {
        public Sms_DataInfo()
        {
            this._guid = Guid.NewGuid().ToString("N");
        }

        private int _id;

        public int id
        {
            get { return _id; }
            set { _id = value; }
        }
        private string _guid;

        public string guid
        {
            get { return _guid; }
            set { _guid = value; }
        }

        private int _UserID;

        public int UserID
        {
            get { return _UserID; }
            set { _UserID = value; }
        }

        private string _RealName;

        public string RealName
        {
            get { return _RealName; }
            set { _RealName = value; }
        }

        private string _DepName;

        public string DepName
        {
            get { return _DepName; }
            set { _DepName = value; }
        }

        private string _Subject;

        public string Subject
        {
            get { return _Subject; }
            set { _Subject = value; }
        }

        private string _PhoneList;

        public string PhoneList
        {
            get { return _PhoneList; }
            set { _PhoneList = value; }
        }

        private int _IsLongMessage;

        public int IsLongMessage
        {
            get { return _IsLongMessage; }
            set { _IsLongMessage = value; }
        }

        private string _AddTime;

        public string AddTime
        {
            get { return _AddTime; }
            set { _AddTime = value; }
        }

    }
}
