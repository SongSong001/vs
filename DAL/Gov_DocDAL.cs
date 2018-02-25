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
    public class Gov_DocDAL : IGov_Doc
    {
        private EntityControl control;

        public Gov_DocDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(Gov_DocInfo Gov_Doc_)
        {
            control.AddEntity(Gov_Doc_);
        }

        public void Update(Gov_DocInfo Gov_Doc_)
        {
            control.UpdateEntity(Gov_Doc_, Gov_Doc_.id);
        }

        public void Delete(int id)
        {
            Gov_DocInfo Gov_Doc_ = new Gov_DocInfo();
            Gov_Doc_.id = id;
            control.DeleteEntity(Gov_Doc_);
        }

        public Gov_DocInfo GetById(int id)
        {
            return (Gov_DocInfo)control.GetEntity("WC.Model.Gov_DocInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.Gov_DocInfo", where, orderBy);
        }
        #endregion
    }
}
