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
    public class Flows_DocDAL : IFlows_Doc
    {
        private EntityControl control;

        public Flows_DocDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(Flows_DocInfo Flows_Doc_)
        {
            control.AddEntity(Flows_Doc_);
        }

        public void Update(Flows_DocInfo Flows_Doc_)
        {
            control.UpdateEntity(Flows_Doc_, Flows_Doc_.id);
        }

        public void Delete(int id)
        {
            Flows_DocInfo Flows_Doc_ = new Flows_DocInfo();
            Flows_Doc_.id = id;
            control.DeleteEntity(Flows_Doc_);
        }

        public Flows_DocInfo GetById(int id)
        {
            return (Flows_DocInfo)control.GetEntity("WC.Model.Flows_DocInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.Flows_DocInfo", where, orderBy);
        }
        #endregion
    }
}
