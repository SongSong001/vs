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
    public class CRM_SupDAL : ICRM_Sup
    {
        private EntityControl control;

        public CRM_SupDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(CRM_SupInfo CRM_Sup_)
        {
            control.AddEntity(CRM_Sup_);
        }

        public void Update(CRM_SupInfo CRM_Sup_)
        {
            control.UpdateEntity(CRM_Sup_, CRM_Sup_.id);
        }

        public void Delete(int id)
        {
            CRM_SupInfo CRM_Sup_ = new CRM_SupInfo();
            CRM_Sup_.id = id;
            control.DeleteEntity(CRM_Sup_);
        }

        public CRM_SupInfo GetById(int id)
        {
            return (CRM_SupInfo)control.GetEntity("WC.Model.CRM_SupInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.CRM_SupInfo", where, orderBy);
        }
        #endregion
    }
}
