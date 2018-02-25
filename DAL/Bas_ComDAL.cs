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
    public class Bas_ComDAL : IBas_Com
    {
        private EntityControl control;

        public Bas_ComDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(Bas_ComInfo Bas_Com)
        {
            control.AddEntity(Bas_Com);
        }

        public void Update(Bas_ComInfo Bas_Com)
        {
            control.UpdateEntity(Bas_Com, Bas_Com.id);
        }

        public void Delete(int id)
        {
            Bas_ComInfo Bas_Com = new Bas_ComInfo();
            Bas_Com.id = id;
            control.DeleteEntity(Bas_Com);
        }

        public Bas_ComInfo GetById(int id)
        {
            return (Bas_ComInfo)control.GetEntity("WC.Model.Bas_ComInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.Bas_ComInfo", where, orderBy);
        }
        #endregion
    }
}
