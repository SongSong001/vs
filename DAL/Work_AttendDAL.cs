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
    public class Work_AttendDAL : IWork_Attend
    {
        private EntityControl control;

        public Work_AttendDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(Work_AttendInfo Work_Attend_)
        {
            control.AddEntity(Work_Attend_);
        }

        public void Update(Work_AttendInfo Work_Attend_)
        {
            control.UpdateEntity(Work_Attend_, Work_Attend_.id);
        }

        public void Delete(int id)
        {
            Work_AttendInfo Work_Attend_ = new Work_AttendInfo();
            Work_Attend_.id = id;
            control.DeleteEntity(Work_Attend_);
        }

        public Work_AttendInfo GetById(int id)
        {
            return (Work_AttendInfo)control.GetEntity("WC.Model.Work_AttendInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.Work_AttendInfo", where, orderBy);
        }
        #endregion
    }
}
