using System;
using System.Collections;
using System.Data;
using System.Data.OleDb;
using WC.Common;
using WC.Model;
using WC.DBUtility;
using WC.IDAL;
using WC.Tool;

namespace WC.DAL
{
    public class CarsDAL : ICars
    {
        private EntityControl control;

        public CarsDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(CarsInfo Cars_)
        {
            control.AddEntity(Cars_);
        }

        public void Update(CarsInfo Cars_)
        {
            control.UpdateEntity(Cars_, Cars_.id);
        }

        public void Delete(int id)
        {
            CarsInfo Cars_ = new CarsInfo();
            Cars_.id = id;
            control.DeleteEntity(Cars_);
        }

        public CarsInfo GetById(int id)
        {
            return (CarsInfo)control.GetEntity("WC.Model.CarsInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.CarsInfo", where, orderBy);
        }
        #endregion
    }
}
