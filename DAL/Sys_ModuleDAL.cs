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
    public class Sys_ModuleDAL : ISys_Module
    {
        private EntityControl control;

        public Sys_ModuleDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(Sys_ModuleInfo Sys_Module)
        {
            control.AddEntity(Sys_Module);
        }

        public void Update(Sys_ModuleInfo Sys_Module)
        {
            control.UpdateEntity(Sys_Module, Sys_Module.id);
        }

        public void Delete(int id)
        {
            Sys_ModuleInfo Sys_Module = new Sys_ModuleInfo();
            Sys_Module.id = id;
            control.DeleteEntity(Sys_Module);
        }

        public Sys_ModuleInfo GetById(int id)
        {
            return (Sys_ModuleInfo)control.GetEntity("WC.Model.Sys_ModuleInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.Sys_ModuleInfo", where, orderBy);
        }
        #endregion
    }
}
