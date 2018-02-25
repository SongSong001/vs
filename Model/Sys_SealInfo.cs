using System;
using System.Collections.Generic;
using System.Text;

namespace WC.Model
{
    [Serializable]
    public class Sys_SealInfo
    {
        public Sys_SealInfo()
        {
            this._guid = Guid.NewGuid().ToString("N");
        }

        #region 成员
        private int _id;
        private string _guid;
        private string _SealName;
        private string _FilePath;
        private string _TagName;
        private string _userlist;
        private string _namelist;
        private string _Notes;
        private DateTime _AddTime;
        private int _Status;
        private string _PWD;

        public string PWD
        {
            get { return _PWD; }
            set { _PWD = value; }
        }

        private int _Uid;

        public int Uid
        {
            get { return _Uid; }
            set { _Uid = value; }
        }

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

        public string SealName
        {
            get { return _SealName; }
            set { _SealName = value; }
        }

        public string FilePath
        {
            get { return _FilePath; }
            set { _FilePath = value; }
        }

        public string TagName
        {
            get { return _TagName; }
            set { _TagName = value; }
        }

        public string userlist
        {
            get { return _userlist; }
            set { _userlist = value; }
        }

        public string namelist
        {
            get { return _namelist; }
            set { _namelist = value; }
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

        public int Status
        {
            get { return _Status; }
            set { _Status = value; }
        }

        #endregion

    }
}
