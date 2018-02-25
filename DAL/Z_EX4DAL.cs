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
    public class ZEX4DAL : IZEX4
    {
        private EntityControl control;

        public ZEX4DAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(ZEX4Info ZEX4_)
        {
            control.AddEntity(ZEX4_);
        }

        public void Update(ZEX4Info ZEX4_)
        {
            control.UpdateEntity(ZEX4_, ZEX4_.id);
        }

        public void Delete(int id)
        {
            ZEX4Info ZEX4_ = new ZEX4Info();
            ZEX4_.id = id;
            control.DeleteEntity(ZEX4_);
        }

        public ZEX4Info GetById(int id)
        {
            return (ZEX4Info)control.GetEntity("WC.Model.ZEX4Info", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.ZEX4Info", where, orderBy);
        }
        #endregion
    }
}
