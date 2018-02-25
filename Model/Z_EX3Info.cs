using System;
using System.Collections.Generic;
using System.Text;

namespace WC.Model
{
    [Serializable]
    public class ZEX3Info
    {
        public ZEX3Info()
        {
            this._guid = Guid.NewGuid().ToString("N");
        }
        #region 成员
        private int _id;
        private string _guid;
        private int _e1;
        private int _e2;
        private int _e3;
        private int _e4;
        private string _e5;
        private string _e6;
        private string _e7;
        private string _e8;
        private string _e9;
        private DateTime _e10;
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

        public int e1
        {
            get { return _e1; }
            set { _e1 = value; }
        }

        public int e2
        {
            get { return _e2; }
            set { _e2 = value; }
        }

        public int e3
        {
            get { return _e3; }
            set { _e3 = value; }
        }

        public int e4
        {
            get { return _e4; }
            set { _e4 = value; }
        }

        public string e5
        {
            get { return _e5; }
            set { _e5 = value; }
        }

        public string e6
        {
            get { return _e6; }
            set { _e6 = value; }
        }

        public string e7
        {
            get { return _e7; }
            set { _e7 = value; }
        }

        public string e8
        {
            get { return _e8; }
            set { _e8 = value; }
        }

        public string e9
        {
            get { return _e9; }
            set { _e9 = value; }
        }

        public DateTime e10
        {
            get { return _e10; }
            set { _e10 = value; }
        }

        #endregion
    }
}
