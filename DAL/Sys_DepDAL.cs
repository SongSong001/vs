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
    public class Sys_DepDAL : ISys_Dep
    {
        private EntityControl control;

        public Sys_DepDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(Sys_DepInfo Sys_Dep)
        {
            control.AddEntity(Sys_Dep);
        }

        public void Update(Sys_DepInfo Sys_Dep)
        {
            control.UpdateEntity(Sys_Dep, Sys_Dep.id);
        }

        public void Delete(int id)
        {
            Sys_DepInfo Sys_Dep = new Sys_DepInfo();
            Sys_Dep.id = id;
            control.DeleteEntity(Sys_Dep);
        }

        public Sys_DepInfo GetById(int id)
        {
            return (Sys_DepInfo)control.GetEntity("WC.Model.Sys_DepInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.Sys_DepInfo", where, orderBy);
        }
        #endregion
    }
}
