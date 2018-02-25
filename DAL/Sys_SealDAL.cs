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
    public class Sys_SealDAL : ISys_Seal
    {
        private EntityControl control;

        public Sys_SealDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(Sys_SealInfo Sys_Seal_)
        {
            control.AddEntity(Sys_Seal_);
        }

        public void Update(Sys_SealInfo Sys_Seal_)
        {
            control.UpdateEntity(Sys_Seal_, Sys_Seal_.id);
        }

        public void Delete(int id)
        {
            Sys_SealInfo Sys_Seal_ = new Sys_SealInfo();
            Sys_Seal_.id = id;
            control.DeleteEntity(Sys_Seal_);
        }

        public Sys_SealInfo GetById(int id)
        {
            return (Sys_SealInfo)control.GetEntity("WC.Model.Sys_SealInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.Sys_SealInfo", where, orderBy);
        }
        #endregion
    }
}
