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
    public class Tasks_TypeDAL : ITasks_Type
    {
        private EntityControl control;

        public Tasks_TypeDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(Tasks_TypeInfo Tasks_Type_)
        {
            control.AddEntity(Tasks_Type_);
        }

        public void Update(Tasks_TypeInfo Tasks_Type_)
        {
            control.UpdateEntity(Tasks_Type_, Tasks_Type_.id);
        }

        public void Delete(int id)
        {
            Tasks_TypeInfo Tasks_Type_ = new Tasks_TypeInfo();
            Tasks_Type_.id = id;
            control.DeleteEntity(Tasks_Type_);
        }

        public Tasks_TypeInfo GetById(int id)
        {
            return (Tasks_TypeInfo)control.GetEntity("WC.Model.Tasks_TypeInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.Tasks_TypeInfo", where, orderBy);
        }
        #endregion
    }
}
