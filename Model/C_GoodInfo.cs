using System;
using System.Collections.Generic;
using System.Text;

namespace WC.Model
{
    [Serializable]
    public class C_GoodInfo
    {
        public C_GoodInfo()
        {
            this._guid = Guid.NewGuid().ToString("N");
        }

        private int _id;

        public int id
        {
            get { return _id; }
            set { _id = value; }
        }

        private string _guid;

        public string guid
        {
            get { return _guid; }
            set { _guid = value; }
        }

        private string _GoodName;

        public string GoodName
        {
            get { return _GoodName; }
            set { _GoodName = value; }
        }

        private int _TypeID;

        public int TypeID
        {
            get { return _TypeID; }
            set { _TypeID = value; }
        }

        private string _TypeName;

        public string TypeName
        {
            get { return _TypeName; }
            set { _TypeName = value; }
        }

        private string _Units;

        public string Units
        {
            get { return _Units; }
            set { _Units = value; }
        }

        private int _Inventory;

        public int Inventory
        {
            get { return _Inventory; }
            set { _Inventory = value; }
        }

        private int _UpLimit;

        public int UpLimit
        {
            get { return _UpLimit; }
            set { _UpLimit = value; }
        }

        private int _LowLimit;

        public int LowLimit
        {
            get { return _LowLimit; }
            set { _LowLimit = value; }
        }

        private string _AddTime;

        public string AddTime
        {
            get { return _AddTime; }
            set { _AddTime = value; }
        }

        private string _AddPerson;

        public string AddPerson
        {
            get { return _AddPerson; }
            set { _AddPerson = value; }
        }

        private string _Notes;

        public string Notes
        {
            get { return _Notes; }
            set { _Notes = value; }
        }


    }
}
