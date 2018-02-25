using System;
using System.Collections.Generic;
using System.Text;

namespace WC.Model
{
    [Serializable]
    public class C_GoodTypeInfo
    {
        public C_GoodTypeInfo()
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

        private string _TypeName;

        public string TypeName
        {
            get { return _TypeName; }
            set { _TypeName = value; }
        }

        private string _Notes;

        public string Notes
        {
            get { return _Notes; }
            set { _Notes = value; }
        }

        private int _Orders;

        public int Orders
        {
            get { return _Orders; }
            set { _Orders = value; }
        }

        private int _ParentID;

        public int ParentID
        {
            get { return _ParentID; }
            set { _ParentID = value; }
        }

        private string _ch; //页面栏目 显示分页符

        public string Ch
        {
            get { return _ch; }
            set { _ch = value; }
        }

        private string _sh; //为了显示下拉框树形菜单 存放制表符+目录名

        public string Sh
        {
            get { return _sh; }
            set { _sh = value; }
        }
    }
}
