using System;
using System.Text;

namespace WC.Model
{
    [Serializable]
    public class MeetingInfo
    {
        public MeetingInfo()
        {
            this._guid = Guid.NewGuid().ToString("N");
        }

        private int _id;
        private string _guid;

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

        private string _Bodys;

        public string Bodys
        {
            get { return _Bodys; }
            set { _Bodys = value; }
        }

        private string _CTime;

        public string CTime
        {
            get { return _CTime; }
            set { _CTime = value; }
        }




        private string _Address;

        public string Address
        {
            get { return _Address; }
            set { _Address = value; }
        }

        private string _Recorder;

        public string Recorder
        {
            get { return _Recorder; }
            set { _Recorder = value; }
        }

        private string _ListPerson;

        public string ListPerson
        {
            get { return _ListPerson; }
            set { _ListPerson = value; }
        }

        private string _AbsencePerson;

        public string AbsencePerson
        {
            get { return _AbsencePerson; }
            set { _AbsencePerson = value; }
        }

        private string _Chaired;

        public string Chaired
        {
            get { return _Chaired; }
            set { _Chaired = value; }
        }

        private string _MainTopics;

        public string MainTopics
        {
            get { return _MainTopics; }
            set { _MainTopics = value; }
        }

        private string _Remarks;

        public string Remarks
        {
            get { return _Remarks; }
            set { _Remarks = value; }
        }

        private string _FilePath;

        public string FilePath
        {
            get { return _FilePath; }
            set { _FilePath = value; }
        }

        private int _UserID;

        public int UserID
        {
            get { return _UserID; }
            set { _UserID = value; }
        }




    }
}
