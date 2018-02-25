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
    public class C_GoodTypeDAL : IC_GoodType
    {
        private EntityControl control;

        public C_GoodTypeDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(C_GoodTypeInfo C_GoodType_)
        {
            control.AddEntity(C_GoodType_);
        }

        public void Update(C_GoodTypeInfo C_GoodType_)
        {
            control.UpdateEntity(C_GoodType_, C_GoodType_.id);
        }

        public void Delete(int id)
        {
            C_GoodTypeInfo C_GoodType_ = new C_GoodTypeInfo();
            C_GoodType_.id = id;
            control.DeleteEntity(C_GoodType_);
        }

        public C_GoodTypeInfo GetById(int id)
        {
            return (C_GoodTypeInfo)control.GetEntity("WC.Model.C_GoodTypeInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.C_GoodTypeInfo", where, orderBy);
        }
        #endregion
    }
}
