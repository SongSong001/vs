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
    public class C_GoodActionDAL : IC_GoodAction
    {
        private EntityControl control;

        public C_GoodActionDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(C_GoodActionInfo C_GoodAction_)
        {
            control.AddEntity(C_GoodAction_);
        }

        public void Update(C_GoodActionInfo C_GoodAction_)
        {
            control.UpdateEntity(C_GoodAction_, C_GoodAction_.id);
        }

        public void Delete(int id)
        {
            C_GoodActionInfo C_GoodAction_ = new C_GoodActionInfo();
            C_GoodAction_.id = id;
            control.DeleteEntity(C_GoodAction_);
        }

        public C_GoodActionInfo GetById(int id)
        {
            return (C_GoodActionInfo)control.GetEntity("WC.Model.C_GoodActionInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.C_GoodActionInfo", where, orderBy);
        }
        #endregion
    }
}
