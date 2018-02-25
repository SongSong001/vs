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
    public class ZEX5DAL : IZEX5
    {
        private EntityControl control;

        public ZEX5DAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(ZEX5Info ZEX5_)
        {
            control.AddEntity(ZEX5_);
        }

        public void Update(ZEX5Info ZEX5_)
        {
            control.UpdateEntity(ZEX5_, ZEX5_.id);
        }

        public void Delete(int id)
        {
            ZEX5Info ZEX5_ = new ZEX5Info();
            ZEX5_.id = id;
            control.DeleteEntity(ZEX5_);
        }

        public ZEX5Info GetById(int id)
        {
            return (ZEX5Info)control.GetEntity("WC.Model.ZEX5Info", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.ZEX5Info", where, orderBy);
        }
        #endregion
    }
}
