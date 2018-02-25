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
    public class Sys_Role_ModuleDAL : ISys_Role_Module
    {
        private EntityControl control;

        public Sys_Role_ModuleDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(Sys_Role_ModuleInfo Sys_Role_Module)
        {
            control.AddEntity(Sys_Role_Module);
        }

        public void Update(Sys_Role_ModuleInfo Sys_Role_Module)
        {
            control.UpdateEntity(Sys_Role_Module, Sys_Role_Module.id);
        }

        public void Delete(int id)
        {
            Sys_Role_ModuleInfo Sys_Role_Module = new Sys_Role_ModuleInfo();
            Sys_Role_Module.id = id;
            control.DeleteEntity(Sys_Role_Module);
        }

        public Sys_Role_ModuleInfo GetById(int id)
        {
            return (Sys_Role_ModuleInfo)control.GetEntity("WC.Model.Sys_Role_ModuleInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.Sys_Role_ModuleInfo", where, orderBy);
        }
        #endregion
    }
}
