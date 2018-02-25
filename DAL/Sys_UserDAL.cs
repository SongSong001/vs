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
    public class Sys_UserDAL : ISys_User
    {
        private EntityControl control;

        public Sys_UserDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(Sys_UserInfo Sys_User)
        {
            control.AddEntity(Sys_User);
        }

        public void Update(Sys_UserInfo Sys_User)
        {
            control.UpdateEntity(Sys_User, Sys_User.id);
        }

        public void Delete(int id)
        {
            Sys_UserInfo Sys_User = new Sys_UserInfo();
            Sys_User.id = id;
            control.DeleteEntity(Sys_User);
        }

        public Sys_UserInfo GetById(int id)
        {
            return (Sys_UserInfo)control.GetEntity("WC.Model.Sys_UserInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.Sys_UserInfo", where, orderBy);
        }
        #endregion
    }
}
