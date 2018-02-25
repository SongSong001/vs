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
    public class Tasks_UserDAL : ITasks_User
    {
        private EntityControl control;

        public Tasks_UserDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(Tasks_UserInfo Tasks_User_)
        {
            control.AddEntity(Tasks_User_);
        }

        public void Update(Tasks_UserInfo Tasks_User_)
        {
            control.UpdateEntity(Tasks_User_, Tasks_User_.id);
        }

        public void Delete(int id)
        {
            Tasks_UserInfo Tasks_User_ = new Tasks_UserInfo();
            Tasks_User_.id = id;
            control.DeleteEntity(Tasks_User_);
        }

        public Tasks_UserInfo GetById(int id)
        {
            return (Tasks_UserInfo)control.GetEntity("WC.Model.Tasks_UserInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.Tasks_UserInfo", where, orderBy);
        }
        #endregion
    }
}
