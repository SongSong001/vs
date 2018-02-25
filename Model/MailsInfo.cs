using System;
using System.Collections;

namespace WC.Model
{
    [Serializable]
    public class MailsInfo
    {
        #region 构造函数
        public MailsInfo()
        { this._guid = Guid.NewGuid().ToString("N"); }

        #endregion

        #region 成员
        private int _id;
        private string _guid;
        private int _ReceiverID;

        private int _SenderID;
        private string _SenderGUID;
        private string _SenderRealName;
        private string _SenderDepName;

        private string _Subject;

        private int _IsRead;

        private int _FolderType;
        private DateTime _SendTime;
        private int _SendType;

        private int _did;

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

        public int ReceiverID
        {
            get { return _ReceiverID; }
            set { _ReceiverID = value; }
        }

        public int SenderID
        {
            get { return _SenderID; }
            set { _SenderID = value; }
        }

        public string SenderGUID
        {
            get { return _SenderGUID; }
            set { _SenderGUID = value; }
        }

        public string SenderRealName
        {
            get { return _SenderRealName; }
            set { _SenderRealName = value; }
        }

        public string SenderDepName
        {
            get { return _SenderDepName; }
            set { _SenderDepName = value; }
        }


        public string Subject
        {
            get { return _Subject; }
            set { _Subject = value; }
        }


        public int IsRead
        {
            get { return _IsRead; }
            set { _IsRead = value; }
        }


        public int FolderType
        {
            get { return _FolderType; }
            set { _FolderType = value; }
        }

        public DateTime SendTime
        {
            get { return _SendTime; }
            set { _SendTime = value; }
        }

        public int SendType
        {
            get { return _SendType; }
            set { _SendType = value; }
        }

        public int did
        {
            get { return _did; }
            set { _did = value; }
        }
        #endregion

    }
}
