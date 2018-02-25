using System;
using System.Collections.Generic;
using System.Text;

namespace WC.Model
{
    [Serializable]
    public class CRM_ContactInfo
    {
        public CRM_ContactInfo()
        {
            this._guid = Guid.NewGuid().ToString("N");
        }

        #region 成员
        private int _id;
        private string _guid;
        private int _cid;
        private int _CreatorID;
        private string _CreatorRealName;
        private string _CreatorDepName;
        private DateTime _AddTime;
        private string _ContactAim;
        private string _ContactCharge;
        private string _ContactChargeType;
        private string _ContactType;
        private string _ContactState;
        private string _ContactDetail;
        private string _ContactPeople;
        private string _CRM_Name;

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

        public string CRM_Name
        {
            get { return _CRM_Name; }
            set { _CRM_Name = value; }
        }

        public int cid
        {
            get { return _cid; }
            set { _cid = value; }
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

        public DateTime AddTime
        {
            get { return _AddTime; }
            set { _AddTime = value; }
        }

        public string ContactAim
        {
            get { return _ContactAim; }
            set { _ContactAim = value; }
        }

        public string ContactCharge
        {
            get { return _ContactCharge; }
            set { _ContactCharge = value; }
        }

        public string ContactChargeType
        {
            get { return _ContactChargeType; }
            set { _ContactChargeType = value; }
        }

        public string ContactType
        {
            get { return _ContactType; }
            set { _ContactType = value; }
        }

        public string ContactState
        {
            get { return _ContactState; }
            set { _ContactState = value; }
        }

        public string ContactDetail
        {
            get { return _ContactDetail; }
            set { _ContactDetail = value; }
        }

        public string ContactPeople
        {
            get { return _ContactPeople; }
            set { _ContactPeople = value; }
        }

        #endregion

    }
}
