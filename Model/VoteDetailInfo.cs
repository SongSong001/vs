using System;
using System.Collections.Generic;
using System.Text;

namespace WC.Model
{
    [Serializable]
    public class VoteDetailInfo
    {
        public VoteDetailInfo()
        {
            this._guid = Guid.NewGuid().ToString("N");
        }

        #region 成员
        private int _id;
        private string _guid;
        private int _VoteID;
        private string _ItemName;
        private int _VoteUserID;
        private string _VoteRealName;
        private string _VoteDepName;
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

        public int VoteID
        {
            get { return _VoteID; }
            set { _VoteID = value; }
        }

        public string ItemName
        {
            get { return _ItemName; }
            set { _ItemName = value; }
        }

        public int VoteUserID
        {
            get { return _VoteUserID; }
            set { _VoteUserID = value; }
        }

        public string VoteRealName
        {
            get { return _VoteRealName; }
            set { _VoteRealName = value; }
        }

        public string VoteDepName
        {
            get { return _VoteDepName; }
            set { _VoteDepName = value; }
        }

        public DateTime AddTime
        {
            get { return _AddTime; }
            set { _AddTime = value; }
        }

        #endregion

    }
}
