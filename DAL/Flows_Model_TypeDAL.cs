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
    public class Flows_Model_TypeDAL : IFlows_Model_Type
    {
        private EntityControl control;

        public Flows_Model_TypeDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(Flows_Model_TypeInfo Flows_Model_Type_)
        {
            control.AddEntity(Flows_Model_Type_);
        }

        public void Update(Flows_Model_TypeInfo Flows_Model_Type_)
        {
            control.UpdateEntity(Flows_Model_Type_, Flows_Model_Type_.id);
        }

        public void Delete(int id)
        {
            Flows_Model_TypeInfo Flows_Model_Type_ = new Flows_Model_TypeInfo();
            Flows_Model_Type_.id = id;
            control.DeleteEntity(Flows_Model_Type_);
        }

        public Flows_Model_TypeInfo GetById(int id)
        {
            return (Flows_Model_TypeInfo)control.GetEntity("WC.Model.Flows_Model_TypeInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.Flows_Model_TypeInfo", where, orderBy);
        }
        #endregion
    }
}
