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
    public class Gov_StepActionDAL : IGov_StepAction
    {
        private EntityControl control;

        public Gov_StepActionDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(Gov_StepActionInfo Gov_StepAction_)
        {
            control.AddEntity(Gov_StepAction_);
        }

        public void Update(Gov_StepActionInfo Gov_StepAction_)
        {
            control.UpdateEntity(Gov_StepAction_, Gov_StepAction_.id);
        }

        public void Delete(int id)
        {
            Gov_StepActionInfo Gov_StepAction_ = new Gov_StepActionInfo();
            Gov_StepAction_.id = id;
            control.DeleteEntity(Gov_StepAction_);
        }

        public Gov_StepActionInfo GetById(int id)
        {
            return (Gov_StepActionInfo)control.GetEntity("WC.Model.Gov_StepActionInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.Gov_StepActionInfo", where, orderBy);
        }
        #endregion
    }
}
