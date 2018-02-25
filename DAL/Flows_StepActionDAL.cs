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
    public class Flows_StepActionDAL : IFlows_StepAction
    {
        private EntityControl control;

        public Flows_StepActionDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(Flows_StepActionInfo Flows_StepAction_)
        {
            control.AddEntity(Flows_StepAction_);
        }

        public void Update(Flows_StepActionInfo Flows_StepAction_)
        {
            control.UpdateEntity(Flows_StepAction_, Flows_StepAction_.id);
        }

        public void Delete(int id)
        {
            Flows_StepActionInfo Flows_StepAction_ = new Flows_StepActionInfo();
            Flows_StepAction_.id = id;
            control.DeleteEntity(Flows_StepAction_);
        }

        public Flows_StepActionInfo GetById(int id)
        {
            return (Flows_StepActionInfo)control.GetEntity("WC.Model.Flows_StepActionInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.Flows_StepActionInfo", where, orderBy);
        }
        #endregion
    }
}
