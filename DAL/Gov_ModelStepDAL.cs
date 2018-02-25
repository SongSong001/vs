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
    public class Gov_ModelStepDAL : IGov_ModelStep
    {
        private EntityControl control;

        public Gov_ModelStepDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(Gov_ModelStepInfo Gov_ModelStep_)
        {
            control.AddEntity(Gov_ModelStep_);
        }

        public void Update(Gov_ModelStepInfo Gov_ModelStep_)
        {
            control.UpdateEntity(Gov_ModelStep_, Gov_ModelStep_.id);
        }

        public void Delete(int id)
        {
            Gov_ModelStepInfo Gov_ModelStep_ = new Gov_ModelStepInfo();
            Gov_ModelStep_.id = id;
            control.DeleteEntity(Gov_ModelStep_);
        }

        public Gov_ModelStepInfo GetById(int id)
        {
            return (Gov_ModelStepInfo)control.GetEntity("WC.Model.Gov_ModelStepInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.Gov_ModelStepInfo", where, orderBy);
        }
        #endregion
    }
}
