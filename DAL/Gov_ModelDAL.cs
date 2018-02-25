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
    public class Gov_ModelDAL : IGov_Model
    {
        private EntityControl control;

        public Gov_ModelDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(Gov_ModelInfo Gov_Model_)
        {
            control.AddEntity(Gov_Model_);
        }

        public void Update(Gov_ModelInfo Gov_Model_)
        {
            control.UpdateEntity(Gov_Model_, Gov_Model_.id);
        }

        public void Delete(int id)
        {
            Gov_ModelInfo Gov_Model_ = new Gov_ModelInfo();
            Gov_Model_.id = id;
            control.DeleteEntity(Gov_Model_);
        }

        public Gov_ModelInfo GetById(int id)
        {
            return (Gov_ModelInfo)control.GetEntity("WC.Model.Gov_ModelInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.Gov_ModelInfo", where, orderBy);
        }
        #endregion
    }
}
