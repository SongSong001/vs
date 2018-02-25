using System;
using System.Collections.Generic;
using System.Text;

namespace WC.Model
{
    [Serializable]
    public class VoteInfo
    {
        public VoteInfo()
        {
            this._guid = Guid.NewGuid().ToString("N");
        }

        #region 成员
        private int _id;
        private string _guid;
        private string _VoteTitle;
        private string _VoteContent;
        private int _IsValide;
        private int _IsMultiple;
        private int _ShowUser;
        private int _CreateUserID;
        private string _CreateRealName;
        private string _CreateDepName;
        private DateTime _AddTime;

        private string _userlist;

        public string userlist
        {
            get { return _userlist; }
            set { _userlist = value; }
        }

        private string _namelist;

        public string namelist
        {
            get { return _namelist; }
            set { _namelist = value; }
        }

        private string _VoteNotes;

        public string VoteNotes
        {
            get { return _VoteNotes; }
            set { _VoteNotes = value; }
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

        public string VoteTitle
        {
            get { return _VoteTitle; }
            set { _VoteTitle = value; }
        }

        public string VoteContent
        {
            get { return _VoteContent; }
            set { _VoteContent = value; }
        }

        public int IsValide
        {
            get { return _IsValide; }
            set { _IsValide = value; }
        }

        public int IsMultiple
        {
            get { return _IsMultiple; }
            set { _IsMultiple = value; }
        }

        public int ShowUser
        {
            get { return _ShowUser; }
            set { _ShowUser = value; }
        }

        public int CreateUserID
        {
            get { return _CreateUserID; }
            set { _CreateUserID = value; }
        }

        public string CreateRealName
        {
            get { return _CreateRealName; }
            set { _CreateRealName = value; }
        }

        public string CreateDepName
        {
            get { return _CreateDepName; }
            set { _CreateDepName = value; }
        }

        public DateTime AddTime
        {
            get { return _AddTime; }
            set { _AddTime = value; }
        }

        #endregion

    }
}
