using System;
using System.Collections.Generic;
using System.Text;

namespace WC.Model
{
    [Serializable]
    public class TipsInfo
    {
        public TipsInfo()
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
        private int _Orders;

        public int Orders
        {
            get { return _Orders; }
            set { _Orders = value; }
        }
        private string _Tips;

        public string Tips
        {
            get { return _Tips; }
            set { _Tips = value; }
        }

        private int _ComID;

        public int ComID
        {
            get { return _ComID; }
            set { _ComID = value; }
        }

    }
}
