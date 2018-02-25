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
    public class Sys_UserLoginDAL : ISys_UserLogin
    {
        private EntityControl control;

        public Sys_UserLoginDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(Sys_UserLoginInfo Sys_UserLogin_)
        {
            control.AddEntity(Sys_UserLogin_);
        }

        public void Update(Sys_UserLoginInfo Sys_UserLogin_)
        {
            control.UpdateEntity(Sys_UserLogin_, Sys_UserLogin_.id);
        }

        public void Delete(int id)
        {
            Sys_UserLoginInfo Sys_UserLogin_ = new Sys_UserLoginInfo();
            Sys_UserLogin_.id = id;
            control.DeleteEntity(Sys_UserLogin_);
        }

        public Sys_UserLoginInfo GetById(int id)
        {
            return (Sys_UserLoginInfo)control.GetEntity("WC.Model.Sys_UserLoginInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.Sys_UserLoginInfo", where, orderBy);
        }
        #endregion
    }
}
