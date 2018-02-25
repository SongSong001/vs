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
    public class ZEX2DAL : IZEX2
    {
        private EntityControl control;

        public ZEX2DAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(ZEX2Info ZEX2_)
        {
            control.AddEntity(ZEX2_);
        }

        public void Update(ZEX2Info ZEX2_)
        {
            control.UpdateEntity(ZEX2_, ZEX2_.id);
        }

        public void Delete(int id)
        {
            ZEX2Info ZEX2_ = new ZEX2Info();
            ZEX2_.id = id;
            control.DeleteEntity(ZEX2_);
        }

        public ZEX2Info GetById(int id)
        {
            return (ZEX2Info)control.GetEntity("WC.Model.ZEX2Info", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.ZEX2Info", where, orderBy);
        }
        #endregion
    }
}
