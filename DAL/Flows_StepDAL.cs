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
    public class Flows_StepDAL : IFlows_Step
    {
        private EntityControl control;

        public Flows_StepDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(Flows_StepInfo Flows_Step_)
        {
            control.AddEntity(Flows_Step_);
        }

        public void Update(Flows_StepInfo Flows_Step_)
        {
            control.UpdateEntity(Flows_Step_, Flows_Step_.id);
        }

        public void Delete(int id)
        {
            Flows_StepInfo Flows_Step_ = new Flows_StepInfo();
            Flows_Step_.id = id;
            control.DeleteEntity(Flows_Step_);
        }

        public Flows_StepInfo GetById(int id)
        {
            return (Flows_StepInfo)control.GetEntity("WC.Model.Flows_StepInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.Flows_StepInfo", where, orderBy);
        }
        #endregion
    }
}
