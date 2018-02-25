using System;
using System.Collections.Generic;
using System.Text;

namespace WC.Model
{
    [Serializable]
    public class WorkLogInfo
    {
        public WorkLogInfo()
        {
            this._guid = Guid.NewGuid().ToString("N");
        }

        #region 成员
        private int _id;
        private string _guid;
        private string _LogTitle;
        private string _FilePath;
        private string _Notes;
        private int _CreatorID;
        private string _CreatorRealName;
        private string _CreatorDepName;

        private string _ShareUsers;
        private string _AddTime;
        private string _UpdateTime;

        public string UpdateTime
        {
            get { return _UpdateTime; }
            set { _UpdateTime = value; }
        }
        private string _namelist;

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

        public string LogTitle
        {
            get { return _LogTitle; }
            set { _LogTitle = value; }
        }

        public string FilePath
        {
            get { return _FilePath; }
            set { _FilePath = value; }
        }

        public string Notes
        {
            get { return _Notes; }
            set { _Notes = value; }
        }

        public int CreatorID
        {
            get { return _CreatorID; }
            set { _CreatorID = value; }
        }

        public string CreatorRealName
        {
            get { return _CreatorRealName; }
            set { _CreatorRealName = value; }
        }

        public string CreatorDepName
        {
            get { return _CreatorDepName; }
            set { _CreatorDepName = value; }
        }

        public string ShareUsers
        {
            get { return _ShareUsers; }
            set { _ShareUsers = value; }
        }

        public string namelist
        {
            get { return _namelist; }
            set { _namelist = value; }
        }

        public string AddTime
        {
            get { return _AddTime; }
            set { _AddTime = value; }
        }

        #endregion

    }
}
