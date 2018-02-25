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
    public class CRMDAL : ICRM
    {
        private EntityControl control;

        public CRMDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(CRMInfo CRM_)
        {
            control.AddEntity(CRM_);
        }

        public void Update(CRMInfo CRM_)
        {
            control.UpdateEntity(CRM_, CRM_.id);
        }

        public void Delete(int id)
        {
            CRMInfo CRM_ = new CRMInfo();
            CRM_.id = id;
            control.DeleteEntity(CRM_);
        }

        public CRMInfo GetById(int id)
        {
            return (CRMInfo)control.GetEntity("WC.Model.CRMInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.CRMInfo", where, orderBy);
        }
        #endregion
    }
}
