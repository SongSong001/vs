using System;
using System.Collections.Generic;
using System.Text;

namespace WC.Model
{
    [Serializable]
    public class CRMInfo
    {
        public CRMInfo()
        {
            this._guid = Guid.NewGuid().ToString("N");
        }

        #region 成员
        private int _id;
        private string _guid;
        private int _CreatorID;
        private string _CreatorRealName;
        private string _CreatorDepName;
        private string _CRM_Name;
        private string _Tel;
        private string _Fax;
        private string _Zip;
        private string _Address;
        private string _MainPeople;
        private string _Position;
        private string _Product;
        private string _Grade;
        private string _TypeName;
        private string _Notes;
        private string _FilePath;
        private int _IsShare;
        private string _ShareUsers;
        private string _namelist;
        private DateTime _AddTime;
        private DateTime _UpdateTime;
        private string _QQ;
        private string _Site;
        private string _Email;

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

        public string CRM_Name
        {
            get { return _CRM_Name; }
            set { _CRM_Name = value; }
        }

        public string Tel
        {
            get { return _Tel; }
            set { _Tel = value; }
        }

        public string Fax
        {
            get { return _Fax; }
            set { _Fax = value; }
        }

        public string Zip
        {
            get { return _Zip; }
            set { _Zip = value; }
        }

        public string Address
        {
            get { return _Address; }
            set { _Address = value; }
        }

        public string MainPeople
        {
            get { return _MainPeople; }
            set { _MainPeople = value; }
        }

        public string Position
        {
            get { return _Position; }
            set { _Position = value; }
        }

        public string Product
        {
            get { return _Product; }
            set { _Product = value; }
        }

        public string Grade
        {
            get { return _Grade; }
            set { _Grade = value; }
        }

        public string TypeName
        {
            get { return _TypeName; }
            set { _TypeName = value; }
        }

        public string Notes
        {
            get { return _Notes; }
            set { _Notes = value; }
        }

        public string FilePath
        {
            get { return _FilePath; }
            set { _FilePath = value; }
        }

        public int IsShare
        {
            get { return _IsShare; }
            set { _IsShare = value; }
        }

        public string ShareUsers
        {
            get { return _ShareUsers; }
            set { _ShareUsers = value; }
        }

        public string namelist
        {
            get { return _namelist; }
            set { _namelist = value; }
        }

        public DateTime AddTime
        {
            get { return _AddTime; }
            set { _AddTime = value; }
        }

        public DateTime UpdateTime
        {
            get { return _UpdateTime; }
            set { _UpdateTime = value; }
        }

        public string QQ
        {
            get { return _QQ; }
            set { _QQ = value; }
        }

        public string Site
        {
            get { return _Site; }
            set { _Site = value; }
        }

        public string Email
        {
            get { return _Email; }
            set { _Email = value; }
        }

        #endregion

    }
}
