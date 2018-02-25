using System;
using System.Collections.Generic;
using System.Text;

namespace WC.Model
{
    [Serializable]
    public class PaperDownloadInfo
    {
        public PaperDownloadInfo()
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

        private int _PaperID;

        public int PaperID
        {
            get { return _PaperID; }
            set { _PaperID = value; }
        }
        private int _DUserID;

        public int DUserID
        {
            get { return _DUserID; }
            set { _DUserID = value; }
        }
        private string _DUserName;

        public string DUserName
        {
            get { return _DUserName; }
            set { _DUserName = value; }
        }
        private string _DDepName;

        public string DDepName
        {
            get { return _DDepName; }
            set { _DDepName = value; }
        }
        private string _DPaperName;

        public string DPaperName
        {
            get { return _DPaperName; }
            set { _DPaperName = value; }
        }
        private string _DPaperNo;

        public string DPaperNo
        {
            get { return _DPaperNo; }
            set { _DPaperNo = value; }
        }
        private string _DPaperSymbol;

        public string DPaperSymbol
        {
            get { return _DPaperSymbol; }
            set { _DPaperSymbol = value; }
        }
        private string _DSendDep;

        public string DSendDep
        {
            get { return _DSendDep; }
            set { _DSendDep = value; }
        }
        private string _AddTime;

        public string AddTime
        {
            get { return _AddTime; }
            set { _AddTime = value; }
        }

    }
}
