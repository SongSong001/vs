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
    public class C_GoodDAL : IC_Good
    {
        private EntityControl control;

        public C_GoodDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(C_GoodInfo C_Good_)
        {
            control.AddEntity(C_Good_);
        }

        public void Update(C_GoodInfo C_Good_)
        {
            control.UpdateEntity(C_Good_, C_Good_.id);
        }

        public void Delete(int id)
        {
            C_GoodInfo C_Good_ = new C_GoodInfo();
            C_Good_.id = id;
            control.DeleteEntity(C_Good_);
        }

        public C_GoodInfo GetById(int id)
        {
            return (C_GoodInfo)control.GetEntity("WC.Model.C_GoodInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.C_GoodInfo", where, orderBy);
        }
        #endregion
    }
}
