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
    public class FlowsDAL : IFlows
    {
        private EntityControl control;

        public FlowsDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(FlowsInfo Flows_)
        {
            control.AddEntity(Flows_);
        }

        public void Update(FlowsInfo Flows_)
        {
            control.UpdateEntity(Flows_, Flows_.id);
        }

        public void Delete(int id)
        {
            FlowsInfo Flows_ = new FlowsInfo();
            Flows_.id = id;
            control.DeleteEntity(Flows_);
        }

        public FlowsInfo GetById(int id)
        {
            return (FlowsInfo)control.GetEntity("WC.Model.FlowsInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.FlowsInfo", where, orderBy);
        }
        #endregion
    }
}
