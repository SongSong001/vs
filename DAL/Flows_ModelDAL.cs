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
    public class Flows_ModelDAL : IFlows_Model
    {
        private EntityControl control;

        public Flows_ModelDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(Flows_ModelInfo Flows_Model_)
        {
            control.AddEntity(Flows_Model_);
        }

        public void Update(Flows_ModelInfo Flows_Model_)
        {
            control.UpdateEntity(Flows_Model_, Flows_Model_.id);
        }

        public void Delete(int id)
        {
            Flows_ModelInfo Flows_Model_ = new Flows_ModelInfo();
            Flows_Model_.id = id;
            control.DeleteEntity(Flows_Model_);
        }

        public Flows_ModelInfo GetById(int id)
        {
            return (Flows_ModelInfo)control.GetEntity("WC.Model.Flows_ModelInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.Flows_ModelInfo", where, orderBy);
        }
        #endregion
    }
}
