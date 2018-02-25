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
    public class Gov_Model_TypeDAL : IGov_Model_Type
    {
        private EntityControl control;

        public Gov_Model_TypeDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(Gov_Model_TypeInfo Gov_Model_Type_)
        {
            control.AddEntity(Gov_Model_Type_);
        }

        public void Update(Gov_Model_TypeInfo Gov_Model_Type_)
        {
            control.UpdateEntity(Gov_Model_Type_, Gov_Model_Type_.id);
        }

        public void Delete(int id)
        {
            Gov_Model_TypeInfo Gov_Model_Type_ = new Gov_Model_TypeInfo();
            Gov_Model_Type_.id = id;
            control.DeleteEntity(Gov_Model_Type_);
        }

        public Gov_Model_TypeInfo GetById(int id)
        {
            return (Gov_Model_TypeInfo)control.GetEntity("WC.Model.Gov_Model_TypeInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.Gov_Model_TypeInfo", where, orderBy);
        }
        #endregion
    }
}
