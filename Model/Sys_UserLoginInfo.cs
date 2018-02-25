using System;
using System.Collections.Generic;
using System.Text;

namespace WC.Model
{
    [Serializable]
    public class Sys_UserLoginInfo
    {
        public Sys_UserLoginInfo()
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

        private string _UserName;

        public string UserName
        {
            get { return _UserName; }
            set { _UserName = value; }
        }

        private string _UserInfo;

        public string UserInfo
        {
            get { return _UserInfo; }
            set { _UserInfo = value; }
        }

        private string _LoginIP;

        public string LoginIP
        {
            get { return _LoginIP; }
            set { _LoginIP = value; }
        }

        private string _LoginTime;

        public string LoginTime
        {
            get { return _LoginTime; }
            set { _LoginTime = value; }
        }

    }
}
