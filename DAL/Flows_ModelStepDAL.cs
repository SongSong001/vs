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
    public class Flows_ModelStepDAL : IFlows_ModelStep
    {
        private EntityControl control;

        public Flows_ModelStepDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(Flows_ModelStepInfo Flows_ModelStep_)
        {
            control.AddEntity(Flows_ModelStep_);
        }

        public void Update(Flows_ModelStepInfo Flows_ModelStep_)
        {
            control.UpdateEntity(Flows_ModelStep_, Flows_ModelStep_.id);
        }

        public void Delete(int id)
        {
            Flows_ModelStepInfo Flows_ModelStep_ = new Flows_ModelStepInfo();
            Flows_ModelStep_.id = id;
            control.DeleteEntity(Flows_ModelStep_);
        }

        public Flows_ModelStepInfo GetById(int id)
        {
            return (Flows_ModelStepInfo)control.GetEntity("WC.Model.Flows_ModelStepInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.Flows_ModelStepInfo", where, orderBy);
        }
        #endregion
    }
}
