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
    public class Sys_Dep_ModuleDAL : ISys_Dep_Module
    {
        private EntityControl control;

        public Sys_Dep_ModuleDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(Sys_Dep_ModuleInfo Sys_Dep_Module)
        {
            control.AddEntity(Sys_Dep_Module);
        }

        public void Update(Sys_Dep_ModuleInfo Sys_Dep_Module)
        {
            control.UpdateEntity(Sys_Dep_Module, Sys_Dep_Module.id);
        }

        public void Delete(int id)
        {
            Sys_Dep_ModuleInfo Sys_Dep_Module = new Sys_Dep_ModuleInfo();
            Sys_Dep_Module.id = id;
            control.DeleteEntity(Sys_Dep_Module);
        }

        public Sys_Dep_ModuleInfo GetById(int id)
        {
            return (Sys_Dep_ModuleInfo)control.GetEntity("WC.Model.Sys_Dep_ModuleInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.Sys_Dep_ModuleInfo", where, orderBy);
        }
        #endregion
    }
}
