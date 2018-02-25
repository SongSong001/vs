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
    public class TasksDAL : ITasks
    {
        private EntityControl control;

        public TasksDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(TasksInfo Tasks_)
        {
            control.AddEntity(Tasks_);
        }

        public void Update(TasksInfo Tasks_)
        {
            control.UpdateEntity(Tasks_, Tasks_.id);
        }

        public void Delete(int id)
        {
            TasksInfo Tasks_ = new TasksInfo();
            Tasks_.id = id;
            control.DeleteEntity(Tasks_);
        }

        public TasksInfo GetById(int id)
        {
            return (TasksInfo)control.GetEntity("WC.Model.TasksInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.TasksInfo", where, orderBy);
        }
        #endregion
    }
}
