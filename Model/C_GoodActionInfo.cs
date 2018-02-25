using System;
using System.Collections.Generic;
using System.Text;

namespace WC.Model
{
    [Serializable]
    public class C_GoodActionInfo
    {
        public C_GoodActionInfo()
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

        private int _GoodID;

        public int GoodID
        {
            get { return _GoodID; }
            set { _GoodID = value; }
        }

        private int _TypeID;

        public int TypeID
        {
            get { return _TypeID; }
            set { _TypeID = value; }
        }

        private int _OpeAmount;

        public int OpeAmount
        {
            get { return _OpeAmount; }
            set { _OpeAmount = value; }
        }

        private int _OpeKind;

        public int OpeKind
        {
            get { return _OpeKind; }
            set { _OpeKind = value; }
        }

        private string _GoodName;

        public string GoodName
        {
            get { return _GoodName; }
            set { _GoodName = value; }
        }

        private string _TypeName;

        public string TypeName
        {
            get { return _TypeName; }
            set { _TypeName = value; }
        }

        private string _OpeUserList;

        public string OpeUserList
        {
            get { return _OpeUserList; }
            set { _OpeUserList = value; }
        }

        private string _OpeNameList;

        public string OpeNameList
        {
            get { return _OpeNameList; }
            set { _OpeNameList = value; }
        }

        private string _Ope;

        public string Ope
        {
            get { return _Ope; }
            set { _Ope = value; }
        }

        private string _Notes;

        public string Notes
        {
            get { return _Notes; }
            set { _Notes = value; }
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


    }
}
