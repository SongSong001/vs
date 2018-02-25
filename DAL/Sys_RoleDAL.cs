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
    public class Sys_RoleDAL : ISys_Role
    {
        private EntityControl control;

        public Sys_RoleDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(Sys_RoleInfo Sys_Role)
        {
            control.AddEntity(Sys_Role);
        }

        public void Update(Sys_RoleInfo Sys_Role)
        {
            control.UpdateEntity(Sys_Role, Sys_Role.id);
        }

        public void Delete(int id)
        {
            Sys_RoleInfo Sys_Role = new Sys_RoleInfo();
            Sys_Role.id = id;
            control.DeleteEntity(Sys_Role);
        }

        public Sys_RoleInfo GetById(int id)
        {
            return (Sys_RoleInfo)control.GetEntity("WC.Model.Sys_RoleInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.Sys_RoleInfo", where, orderBy);
        }
        #endregion
    }
}
