using System;
using System.Collections.Generic;
using System.Text;

namespace WC.Model
{
    [Serializable]
    public class Work_AttendSetInfo
    {
        public Work_AttendSetInfo()
        {
            this._guid = Guid.NewGuid().ToString("N");
        }

        #region 成员
        private int _id;
        private string _guid;
        private string _AttendTimes;
        private string _AttendNames;
        private string _Offset;

        private int _WorkKind;

        public int WorkKind
        {
            get { return _WorkKind; }
            set { _WorkKind = value; }
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

        public string AttendTimes
        {
            get { return _AttendTimes; }
            set { _AttendTimes = value; }
        }

        public string AttendNames
        {
            get { return _AttendNames; }
            set { _AttendNames = value; }
        }

        public string Offset
        {
            get { return _Offset; }
            set { _Offset = value; }
        }

        #endregion

    }
}
