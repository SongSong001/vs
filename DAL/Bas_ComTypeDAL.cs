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
    public class Bas_ComTypeDAL : IBas_ComType
    {
        private EntityControl control;

        public Bas_ComTypeDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(Bas_ComTypeInfo Bas_ComType_)
        {
            control.AddEntity(Bas_ComType_);
        }

        public void Update(Bas_ComTypeInfo Bas_ComType_)
        {
            control.UpdateEntity(Bas_ComType_, Bas_ComType_.id);
        }

        public void Delete(int id)
        {
            Bas_ComTypeInfo Bas_ComType_ = new Bas_ComTypeInfo();
            Bas_ComType_.id = id;
            control.DeleteEntity(Bas_ComType_);
        }

        public Bas_ComTypeInfo GetById(int id)
        {
            return (Bas_ComTypeInfo)control.GetEntity("WC.Model.Bas_ComTypeInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.Bas_ComTypeInfo", where, orderBy);
        }
        #endregion
    }
}
