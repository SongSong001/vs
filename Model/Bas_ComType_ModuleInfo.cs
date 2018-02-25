using System;
using System.Collections.Generic;
using System.Text;

namespace WC.Model
{
    [Serializable]
    public class Bas_ComType_ModuleInfo
    {
        public Bas_ComType_ModuleInfo()
        {
            this._guid = Guid.NewGuid().ToString("N");
        }

        #region 成员
        private int _id;
        private string _guid;
        private int _ModuleID;
        private int _ComTypeID;
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

        public int ModuleID
        {
            get { return _ModuleID; }
            set { _ModuleID = value; }
        }

        public int ComTypeID
        {
            get { return _ComTypeID; }
            set { _ComTypeID = value; }
        }

        #endregion

    }
}
