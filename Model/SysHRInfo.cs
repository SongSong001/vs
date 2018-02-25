using System;
using System.Collections.Generic;
using System.Text;

namespace WC.Model
{
    [Serializable]
    public class SysHRInfo
    {
        public SysHRInfo()
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



        private int _UserID;

        public int UserID
        {
            get { return _UserID; }
            set { _UserID = value; }
        }
        private string _UserName = "";

        public string UserName
        {
            get { return _UserName; }
            set { _UserName = value; }
        }
        private string _DepName = "";

        public string DepName
        {
            get { return _DepName; }
            set { _DepName = value; }
        }
        private string _RealName = "";

        public string RealName
        {
            get { return _RealName; }
            set { _RealName = value; }
        }
        private int _DepID;

        public int DepID
        {
            get { return _DepID; }
            set { _DepID = value; }
        }
        private string _MinZu = "";

        public string MinZu
        {
            get { return _MinZu; }
            set { _MinZu = value; }
        }
        private string _HuKouXZ = "";

        public string HuKouXZ
        {
            get { return _HuKouXZ; }
            set { _HuKouXZ = value; }
        }
        private string _HuKouSZD = "";

        public string HuKouSZD
        {
            get { return _HuKouSZD; }
            set { _HuKouSZD = value; }
        }
        private string _WorkTime = "";

        public string WorkTime
        {
            get { return _WorkTime; }
            set { _WorkTime = value; }
        }
        private string _BiYeYX = "";

        public string BiYeYX
        {
            get { return _BiYeYX; }
            set { _BiYeYX = value; }
        }
        private string _SchoolTime = "";

        public string SchoolTime
        {
            get { return _SchoolTime; }
            set { _SchoolTime = value; }
        }
        private string _XueLi = "";

        public string XueLi
        {
            get { return _XueLi; }
            set { _XueLi = value; }
        }
        private string _ZhuanYe = "";

        public string ZhuanYe
        {
            get { return _ZhuanYe; }
            set { _ZhuanYe = value; }
        }




        private int _SYQMonth;

        public int SYQMonth
        {
            get { return _SYQMonth; }
            set { _SYQMonth = value; }
        }
        private DateTime _ZhuanZhengRQ;

        public DateTime ZhuanZhengRQ
        {
            get { return _ZhuanZhengRQ; }
            set { _ZhuanZhengRQ = value; }
        }
        private string _SFZNO = "";

        public string SFZNO
        {
            get { return _SFZNO; }
            set { _SFZNO = value; }
        }
        private string _SFZFilePath = "";

        public string SFZFilePath
        {
            get { return _SFZFilePath; }
            set { _SFZFilePath = value; }
        }
        private string _HTRQ = "";

        public string HTRQ
        {
            get { return _HTRQ; }
            set { _HTRQ = value; }
        }
        private string _HTNX = "";

        public string HTNX
        {
            get { return _HTNX; }
            set { _HTNX = value; }
        }
        private string _HuoJiang = "";

        public string HuoJiang
        {
            get { return _HuoJiang; }
            set { _HuoJiang = value; }
        }
        private string _ChuFa = "";

        public string ChuFa
        {
            get { return _ChuFa; }
            set { _ChuFa = value; }
        }



    }
}
