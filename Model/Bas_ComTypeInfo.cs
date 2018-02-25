using System;
using System.Collections.Generic;
using System.Text;

namespace WC.Model
{
    [Serializable]
    public class Bas_ComTypeInfo
    {
        public Bas_ComTypeInfo()
        {
            this._guid = Guid.NewGuid().ToString("N");
        }

        #region 成员
        private int _id;
        private string _guid;
        private string _TypeName;
        private int _VipTime;
        private int _UserLimit;
        private int _FileLimit;
        private int _AD_Lock;
        private string _Notes;
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

        public int VipTime
        {
            get { return _VipTime; }
            set { _VipTime = value; }
        }

        public int UserLimit
        {
            get { return _UserLimit; }
            set { _UserLimit = value; }
        }

        public int FileLimit
        {
            get { return _FileLimit; }
            set { _FileLimit = value; }
        }

        public int AD_Lock
        {
            get { return _AD_Lock; }
            set { _AD_Lock = value; }
        }

        public string Notes
        {
            get { return _Notes; }
            set { _Notes = value; }
        }

        #endregion


    }
}
