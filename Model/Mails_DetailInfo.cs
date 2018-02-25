using System;
using System.Collections.Generic;
using System.Text;

namespace WC.Model
{
    [Serializable]
    public class Mails_DetailInfo
    {
        public Mails_DetailInfo()
        {
            this._guid = Guid.NewGuid().ToString("N");
        }

        #region 成员
        private int _id;
        private string _guid;

        private string _SendIDs;
        private string _SendRealNames;
        private string _CcIDs;
        private string _CcRealNames;
        private string _BccIDs;
        private string _BccRealNames;
        private string _Bodys;
        private string _Attachments;

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


        public string SendIDs
        {
            get { return _SendIDs; }
            set { _SendIDs = value; }
        }

        public string SendRealNames
        {
            get { return _SendRealNames; }
            set { _SendRealNames = value; }
        }

        public string CcIDs
        {
            get { return _CcIDs; }
            set { _CcIDs = value; }
        }

        public string CcRealNames
        {
            get { return _CcRealNames; }
            set { _CcRealNames = value; }
        }

        public string BccIDs
        {
            get { return _BccIDs; }
            set { _BccIDs = value; }
        }

        public string BccRealNames
        {
            get { return _BccRealNames; }
            set { _BccRealNames = value; }
        }

        public string Bodys
        {
            get { return _Bodys; }
            set { _Bodys = value; }
        }

        public string Attachments
        {
            get { return _Attachments; }
            set { _Attachments = value; }
        }

        #endregion

    }
}
