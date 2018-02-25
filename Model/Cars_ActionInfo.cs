using System;
using System.Collections.Generic;
using System.Text;

namespace WC.Model
{
    [Serializable]
    public class Cars_ActionInfo
    {
        public Cars_ActionInfo()
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

        private int _CarID;

        public int CarID
        {
            get { return _CarID; }
            set { _CarID = value; }
        }

        private int _IsValid;

        public int IsValid
        {
            get { return _IsValid; }
            set { _IsValid = value; }
        }

        private string _CarName;

        public string CarName
        {
            get { return _CarName; }
            set { _CarName = value; }
        }

        private string _AimAddr;

        public string AimAddr
        {
            get { return _AimAddr; }
            set { _AimAddr = value; }
        }

        private string _ApplyUserList;

        public string ApplyUserList
        {
            get { return _ApplyUserList; }
            set { _ApplyUserList = value; }
        }

        private string _ApplyNameList;

        public string ApplyNameList
        {
            get { return _ApplyNameList; }
            set { _ApplyNameList = value; }
        }

        private string _ApproveUserList;

        public string ApproveUserList
        {
            get { return _ApproveUserList; }
            set { _ApproveUserList = value; }
        }

        private string _ApproveNameList;

        public string ApproveNameList
        {
            get { return _ApproveNameList; }
            set { _ApproveNameList = value; }
        }

        private string _BeginTime;

        public string BeginTime
        {
            get { return _BeginTime; }
            set { _BeginTime = value; }
        }

        private string _EndTime;

        public string EndTime
        {
            get { return _EndTime; }
            set { _EndTime = value; }
        }

        private string _Reasons;

        public string Reasons
        {
            get { return _Reasons; }
            set { _Reasons = value; }
        }

        private string _Notes;

        public string Notes
        {
            get { return _Notes; }
            set { _Notes = value; }
        }

        private string _ValidTime;

        public string ValidTime
        {
            get { return _ValidTime; }
            set { _ValidTime = value; }
        }

        private string _AddTime;

        public string AddTime
        {
            get { return _AddTime; }
            set { _AddTime = value; }
        }

        private string _AddPerson;

        public string AddPerson
        {
            get { return _AddPerson; }
            set { _AddPerson = value; }
        }


    }
}
