using System;
using System.Collections.Generic;
using System.Text;

namespace WC.Model
{
    [Serializable]
    public class TasksInfo
    {
        public TasksInfo()
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

        private string _TaskName;

        public string TaskName
        {
            get { return _TaskName; }
            set { _TaskName = value; }
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

        private string _Important;

        public string Important
        {
            get { return _Important; }
            set { _Important = value; }
        }

        private int _Status;

        public int Status
        {
            get { return _Status; }
            set { _Status = value; }
        }

        private int _IsOtherSee;

        public int IsOtherSee
        {
            get { return _IsOtherSee; }
            set { _IsOtherSee = value; }
        }

        private int _OnceSubmit;

        public int OnceSubmit
        {
            get { return _OnceSubmit; }
            set { _OnceSubmit = value; }
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

        private string _ManageUserList;

        public string ManageUserList
        {
            get { return _ManageUserList; }
            set { _ManageUserList = value; }
        }

        private string _ManageNameList;

        public string ManageNameList
        {
            get { return _ManageNameList; }
            set { _ManageNameList = value; }
        }

        private string _ExecuteUserList;

        public string ExecuteUserList
        {
            get { return _ExecuteUserList; }
            set { _ExecuteUserList = value; }
        }

        private string _ExecuteNameList;

        public string ExecuteNameList
        {
            get { return _ExecuteNameList; }
            set { _ExecuteNameList = value; }
        }

        private string _AddTime;

        public string AddTime
        {
            get { return _AddTime; }
            set { _AddTime = value; }
        }

        private string _UpdateTime;

        public string UpdateTime
        {
            get { return _UpdateTime; }
            set { _UpdateTime = value; }
        }

        private string _ExpectTime;

        public string ExpectTime
        {
            get { return _ExpectTime; }
            set { _ExpectTime = value; }
        }

        private string _Notes;

        public string Notes
        {
            get { return _Notes; }
            set { _Notes = value; }
        }

        private string _FilePath;

        public string FilePath
        {
            get { return _FilePath; }
            set { _FilePath = value; }
        }

        private int _IsComplete;

        public int IsComplete
        {
            get { return _IsComplete; }
            set { _IsComplete = value; }
        }

        private string _Records;

        public string Records
        {
            get { return _Records; }
            set { _Records = value; }
        }

    }
}
