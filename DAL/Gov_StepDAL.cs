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
    public class Gov_StepDAL : IGov_Step
    {
        private EntityControl control;

        public Gov_StepDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(Gov_StepInfo Gov_Step_)
        {
            control.AddEntity(Gov_Step_);
        }

        public void Update(Gov_StepInfo Gov_Step_)
        {
            control.UpdateEntity(Gov_Step_, Gov_Step_.id);
        }

        public void Delete(int id)
        {
            Gov_StepInfo Gov_Step_ = new Gov_StepInfo();
            Gov_Step_.id = id;
            control.DeleteEntity(Gov_Step_);
        }

        public Gov_StepInfo GetById(int id)
        {
            return (Gov_StepInfo)control.GetEntity("WC.Model.Gov_StepInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.Gov_StepInfo", where, orderBy);
        }
        #endregion
    }
}
