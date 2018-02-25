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
    public class Docs_DocTypeDAL : IDocs_DocType
    {
        private EntityControl control;

        public Docs_DocTypeDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(Docs_DocTypeInfo Docs_DocType_)
        {
            control.AddEntity(Docs_DocType_);
        }

        public void Update(Docs_DocTypeInfo Docs_DocType_)
        {
            control.UpdateEntity(Docs_DocType_, Docs_DocType_.id);
        }

        public void Delete(int id)
        {
            Docs_DocTypeInfo Docs_DocType_ = new Docs_DocTypeInfo();
            Docs_DocType_.id = id;
            control.DeleteEntity(Docs_DocType_);
        }

        public Docs_DocTypeInfo GetById(int id)
        {
            return (Docs_DocTypeInfo)control.GetEntity("WC.Model.Docs_DocTypeInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.Docs_DocTypeInfo", where, orderBy);
        }
        #endregion
    }
}
