using System;
using System.Collections.Generic;
using System.Text;

namespace WC.Model
{
    [Serializable]
    public class Docs_OfficeInfo
    {
        public Docs_OfficeInfo()
        {
            this._guid = Guid.NewGuid().ToString("N");
        }

        #region 成员
        private int _id;
        private string _guid;
        private string _DocTitle;
        private string _FileName;
        private int _FileType;
        private int _CreatorID;
        private DateTime _AddTime;
        private DateTime _UpdateTime;
        private int _FileSize;

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

        public string DocTitle
        {
            get { return _DocTitle; }
            set { _DocTitle = value; }
        }

        public string FileName
        {
            get { return _FileName; }
            set { _FileName = value; }
        }

        public int FileType
        {
            get { return _FileType; }
            set { _FileType = value; }
        }

        public int CreatorID
        {
            get { return _CreatorID; }
            set { _CreatorID = value; }
        }

        public DateTime AddTime
        {
            get { return _AddTime; }
            set { _AddTime = value; }
        }

        public DateTime UpdateTime
        {
            get { return _UpdateTime; }
            set { _UpdateTime = value; }
        }

        public int FileSize
        {
            get { return _FileSize; }
            set { _FileSize = value; }
        }

        #endregion
    }
}
