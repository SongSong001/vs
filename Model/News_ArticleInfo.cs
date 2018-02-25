using System;
using System.Collections.Generic;
using System.Text;

namespace WC.Model
{
    [Serializable]
    public class News_ArticleInfo
    {
        public News_ArticleInfo()
        {
            this._guid = Guid.NewGuid().ToString("N");
        }

        #region 成员
        private int _id;
        private string _guid;
        private string _NewsTitle;
        private string _FilePath;
        private string _Notes;
        private int _TypeID;
        private int _CreatorID;
        private string _CreatorRealName;
        private string _CreatorDepName;
        private DateTime _AddTime;
        private string _ShareUsers;
        private string _ShareDeps;
        private string _namelist;

        private int _ComID;

        public int ComID
        {
            get { return _ComID; }
            set { _ComID = value; }
        }
        #endregion


        #region 属性
        public string namelist
        {
            get { return _namelist; }
            set { _namelist = value; }
        }

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

        public string NewsTitle
        {
            get { return _NewsTitle; }
            set { _NewsTitle = value; }
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

        public int TypeID
        {
            get { return _TypeID; }
            set { _TypeID = value; }
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

        public DateTime AddTime
        {
            get { return _AddTime; }
            set { _AddTime = value; }
        }

        public string ShareUsers
        {
            get { return _ShareUsers; }
            set { _ShareUsers = value; }
        }

        public string ShareDeps
        {
            get { return _ShareDeps; }
            set { _ShareDeps = value; }
        }

        #endregion

    }
}
