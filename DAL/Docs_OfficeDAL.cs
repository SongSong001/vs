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
    public class Docs_OfficeDAL : IDocs_Office
    {
        private EntityControl control;

        public Docs_OfficeDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(Docs_OfficeInfo Docs_Office_)
        {
            control.AddEntity(Docs_Office_);
        }

        public void Update(Docs_OfficeInfo Docs_Office_)
        {
            control.UpdateEntity(Docs_Office_, Docs_Office_.id);
        }

        public void Delete(int id)
        {
            Docs_OfficeInfo Docs_Office_ = new Docs_OfficeInfo();
            Docs_Office_.id = id;
            control.DeleteEntity(Docs_Office_);
        }

        public Docs_OfficeInfo GetById(int id)
        {
            return (Docs_OfficeInfo)control.GetEntity("WC.Model.Docs_OfficeInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.Docs_OfficeInfo", where, orderBy);
        }
        #endregion
    }
}
