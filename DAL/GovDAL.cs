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
    public class GovDAL : IGov
    {
        private EntityControl control;

        public GovDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(GovInfo Gov_)
        {
            control.AddEntity(Gov_);
        }

        public void Update(GovInfo Gov_)
        {
            control.UpdateEntity(Gov_, Gov_.id);
        }

        public void Delete(int id)
        {
            GovInfo Gov_ = new GovInfo();
            Gov_.id = id;
            control.DeleteEntity(Gov_);
        }

        public GovInfo GetById(int id)
        {
            return (GovInfo)control.GetEntity("WC.Model.GovInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.GovInfo", where, orderBy);
        }
        #endregion
    }
}
