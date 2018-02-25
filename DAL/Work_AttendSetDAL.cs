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
    public class Work_AttendSetDAL : IWork_AttendSet
    {
        private EntityControl control;

        public Work_AttendSetDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(Work_AttendSetInfo Work_AttendSet_)
        {
            control.AddEntity(Work_AttendSet_);
        }

        public void Update(Work_AttendSetInfo Work_AttendSet_)
        {
            control.UpdateEntity(Work_AttendSet_, Work_AttendSet_.id);
        }

        public void Delete(int id)
        {
            Work_AttendSetInfo Work_AttendSet_ = new Work_AttendSetInfo();
            Work_AttendSet_.id = id;
            control.DeleteEntity(Work_AttendSet_);
        }

        public Work_AttendSetInfo GetById(int id)
        {
            return (Work_AttendSetInfo)control.GetEntity("WC.Model.Work_AttendSetInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.Work_AttendSetInfo", where, orderBy);
        }
        #endregion
    }
}
