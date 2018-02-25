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
    public class TipsDAL : ITips
    {
        private EntityControl control;

        public TipsDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(TipsInfo Tips_)
        {
            control.AddEntity(Tips_);
        }

        public void Update(TipsInfo Tips_)
        {
            control.UpdateEntity(Tips_, Tips_.id);
        }

        public void Delete(int id)
        {
            TipsInfo Tips_ = new TipsInfo();
            Tips_.id = id;
            control.DeleteEntity(Tips_);
        }

        public TipsInfo GetById(int id)
        {
            return (TipsInfo)control.GetEntity("WC.Model.TipsInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.TipsInfo", where, orderBy);
        }
        #endregion
    }
}
