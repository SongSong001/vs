using System;
using System.Collections.Generic;
using System.Text;

namespace WC.Model
{
    [Serializable]
    public class CarsInfo
    {
        public CarsInfo()
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

        private string _CarName;

        public string CarName
        {
            get { return _CarName; }
            set { _CarName = value; }
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

        private string _CarNO;

        public string CarNO
        {
            get { return _CarNO; }
            set { _CarNO = value; }
        }

        private string _CarModel;

        public string CarModel
        {
            get { return _CarModel; }
            set { _CarModel = value; }
        }

        private string _EngineNO;

        public string EngineNO
        {
            get { return _EngineNO; }
            set { _EngineNO = value; }
        }

        private string _CarCost;

        public string CarCost
        {
            get { return _CarCost; }
            set { _CarCost = value; }
        }

        private string _CarDate;

        public string CarDate
        {
            get { return _CarDate; }
            set { _CarDate = value; }
        }

        private string _CarWeight;

        public string CarWeight
        {
            get { return _CarWeight; }
            set { _CarWeight = value; }
        }

        private string _CarFuel;

        public string CarFuel
        {
            get { return _CarFuel; }
            set { _CarFuel = value; }
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

        private string _AddPerson;

        public string AddPerson
        {
            get { return _AddPerson; }
            set { _AddPerson = value; }
        }



    }
}
