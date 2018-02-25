using System;
using System.Collections.Generic;
using System.Text;

namespace WC.Model
{
    [Serializable]
    public class Tasks_UserInfo
    {
        public Tasks_UserInfo()
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

        private int _TaskID;

        public int TaskID
        {
            get { return _TaskID; }
            set { _TaskID = value; }
        }

        private int _UserID;

        public int UserID
        {
            get { return _UserID; }
            set { _UserID = value; }
        }

        private string _RealName;

        public string RealName
        {
            get { return _RealName; }
            set { _RealName = value; }
        }

        private string _DepName;

        public string DepName
        {
            get { return _DepName; }
            set { _DepName = value; }
        }

        private int _WorkTag;

        public int WorkTag
        {
            get { return _WorkTag; }
            set { _WorkTag = value; }
        }

        private string _WorkTitle;

        public string WorkTitle
        {
            get { return _WorkTitle; }
            set { _WorkTitle = value; }
        }

        private string _WorkNotes;

        public string WorkNotes
        {
            get { return _WorkNotes; }
            set { _WorkNotes = value; }
        }

        private string _FilePath;

        public string FilePath
        {
            get { return _FilePath; }
            set { _FilePath = value; }
        }

        private string _AddTime;

        public string AddTime
        {
            get { return _AddTime; }
            set { _AddTime = value; }
        }

        private string _Instruction;

        public string Instruction
        {
            get { return _Instruction; }
            set { _Instruction = value; }
        }


    }
}
