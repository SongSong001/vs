using System;
using System.Collections.Generic;
using System.Text;

namespace WC.Model
{
    [Serializable]
    public class PaperInfo
    {
        public PaperInfo()
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

        private string _PaperName;

        public string PaperName
        {
            get { return _PaperName; }
            set { _PaperName = value; }
        }
        private int _TypeID;

        public int TypeID
        {
            get { return _TypeID; }
            set { _TypeID = value; }
        }
        private int _CreatorID;

        public int CreatorID
        {
            get { return _CreatorID; }
            set { _CreatorID = value; }
        }
        private string _CreatorRealName;

        public string CreatorRealName
        {
            get { return _CreatorRealName; }
            set { _CreatorRealName = value; }
        }
        private string _CreatorDepName;

        public string CreatorDepName
        {
            get { return _CreatorDepName; }
            set { _CreatorDepName = value; }
        }
        private string _SendDep;

        public string SendDep
        {
            get { return _SendDep; }
            set { _SendDep = value; }
        }
        private string _PaperKind = "";

        public string PaperKind
        {
            get { return _PaperKind; }
            set { _PaperKind = value; }
        }
        private string _PaperSymbol;

        public string PaperSymbol
        {
            get { return _PaperSymbol; }
            set { _PaperSymbol = value; }
        }
        private string _PaperGrade;

        public string PaperGrade
        {
            get { return _PaperGrade; }
            set { _PaperGrade = value; }
        }
        private string _PaperUrgency = "";

        public string PaperUrgency
        {
            get { return _PaperUrgency; }
            set { _PaperUrgency = value; }
        }
        private string _PaperDate;

        public string PaperDate
        {
            get { return _PaperDate; }
            set { _PaperDate = value; }
        }
        private string _FilePath;

        public string FilePath
        {
            get { return _FilePath; }
            set { _FilePath = value; }
        }
        private string _PaperNO = "";

        public string PaperNO
        {
            get { return _PaperNO; }
            set { _PaperNO = value; }
        }
        private string _ShareDeps;

        public string ShareDeps
        {
            get { return _ShareDeps; }
            set { _ShareDeps = value; }
        }
        private string _namelist;

        public string namelist
        {
            get { return _namelist; }
            set { _namelist = value; }
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

    }
}
