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
    public class ZEX1DAL : IZEX1
    {
        private EntityControl control;

        public ZEX1DAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(ZEX1Info ZEX1_)
        {
            control.AddEntity(ZEX1_);
        }

        public void Update(ZEX1Info ZEX1_)
        {
            control.UpdateEntity(ZEX1_, ZEX1_.id);
        }

        public void Delete(int id)
        {
            ZEX1Info ZEX1_ = new ZEX1Info();
            ZEX1_.id = id;
            control.DeleteEntity(ZEX1_);
        }

        public ZEX1Info GetById(int id)
        {
            return (ZEX1Info)control.GetEntity("WC.Model.ZEX1Info", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.ZEX1Info", where, orderBy);
        }
        #endregion
    }
}
