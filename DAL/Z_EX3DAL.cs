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
    public class ZEX3DAL : IZEX3
    {
        private EntityControl control;

        public ZEX3DAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(ZEX3Info ZEX3_)
        {
            control.AddEntity(ZEX3_);
        }

        public void Update(ZEX3Info ZEX3_)
        {
            control.UpdateEntity(ZEX3_, ZEX3_.id);
        }

        public void Delete(int id)
        {
            ZEX3Info ZEX3_ = new ZEX3Info();
            ZEX3_.id = id;
            control.DeleteEntity(ZEX3_);
        }

        public ZEX3Info GetById(int id)
        {
            return (ZEX3Info)control.GetEntity("WC.Model.ZEX3Info", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.ZEX3Info", where, orderBy);
        }
        #endregion
    }
}
