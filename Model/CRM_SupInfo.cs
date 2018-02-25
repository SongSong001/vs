using System;
using System.Collections.Generic;
using System.Text;

namespace WC.Model
{
    [Serializable]
    public class CRM_SupInfo
    {
        public CRM_SupInfo()
        {
            this._guid = Guid.NewGuid().ToString("N");
        }

        #region 成员
        private int _id;
        private string _guid;
        private int _CreatorID;
        private string _CreatorRealName;
        private string _CreatorDepName;
        private string _Sup_Name;
        private string _MainPeople;
        private string _Tel;
        private string _Addr;
        private string _Notes;

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

        public int CreatorID
        {
            get { return _CreatorID; }
            set { _CreatorID = value; }
        }

        public string CreatorRealName
        {
            get { return _CreatorRealName; }
            set { _CreatorRealName = value; }
        }

        public string CreatorDepName
        {
            get { return _CreatorDepName; }
            set { _CreatorDepName = value; }
        }

        public string Sup_Name
        {
            get { return _Sup_Name; }
            set { _Sup_Name = value; }
        }

        public string MainPeople
        {
            get { return _MainPeople; }
            set { _MainPeople = value; }
        }

        public string Tel
        {
            get { return _Tel; }
            set { _Tel = value; }
        }

        public string Addr
        {
            get { return _Addr; }
            set { _Addr = value; }
        }

        public string Notes
        {
            get { return _Notes; }
            set { _Notes = value; }
        }

        #endregion

    }
}
