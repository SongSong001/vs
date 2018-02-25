using System;
using System.Collections.Generic;
using System.Text;

namespace WC.Model
{
    [Serializable]
    public class Docs_DocTypeInfo
    {
        public Docs_DocTypeInfo()
        {
            this._guid = Guid.NewGuid().ToString("N");
        }

        #region 成员
        private int _id;
        private string _guid;
        private string _TypeName;
        private int _Uid;
        private string _Notes;

        public string Notes
        {
            get { return _Notes; }
            set { _Notes = value; }
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

        public string TypeName
        {
            get { return _TypeName; }
            set { _TypeName = value; }
        }

        public int Uid
        {
            get { return _Uid; }
            set { _Uid = value; }
        }

        #endregion

    }

}
