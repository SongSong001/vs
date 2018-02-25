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
    public class CRM_ContactDAL : ICRM_Contact
    {
        private EntityControl control;

        public CRM_ContactDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(CRM_ContactInfo CRM_Contact_)
        {
            control.AddEntity(CRM_Contact_);
        }

        public void Update(CRM_ContactInfo CRM_Contact_)
        {
            control.UpdateEntity(CRM_Contact_, CRM_Contact_.id);
        }

        public void Delete(int id)
        {
            CRM_ContactInfo CRM_Contact_ = new CRM_ContactInfo();
            CRM_Contact_.id = id;
            control.DeleteEntity(CRM_Contact_);
        }

        public CRM_ContactInfo GetById(int id)
        {
            return (CRM_ContactInfo)control.GetEntity("WC.Model.CRM_ContactInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.CRM_ContactInfo", where, orderBy);
        }
        #endregion
    }
}
