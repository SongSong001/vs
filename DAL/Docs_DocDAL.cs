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
    public class Docs_DocDAL : IDocs_Doc
    {
        private EntityControl control;

        public Docs_DocDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(Docs_DocInfo Docs_Doc_)
        {
            control.AddEntity(Docs_Doc_);
        }

        public void Update(Docs_DocInfo Docs_Doc_)
        {
            control.UpdateEntity(Docs_Doc_, Docs_Doc_.id);
        }

        public void Delete(int id)
        {
            Docs_DocInfo Docs_Doc_ = new Docs_DocInfo();
            Docs_Doc_.id = id;
            control.DeleteEntity(Docs_Doc_);
        }

        public Docs_DocInfo GetById(int id)
        {
            return (Docs_DocInfo)control.GetEntity("WC.Model.Docs_DocInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.Docs_DocInfo", where, orderBy);
        }
        #endregion
    }
}
