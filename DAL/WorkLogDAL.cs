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
    public class WorkLogDAL : IWorkLog
    {
        private EntityControl control;

        public WorkLogDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(WorkLogInfo WorkLog_)
        {
            control.AddEntity(WorkLog_);
        }

        public void Update(WorkLogInfo WorkLog_)
        {
            control.UpdateEntity(WorkLog_, WorkLog_.id);
        }

        public void Delete(int id)
        {
            WorkLogInfo WorkLog_ = new WorkLogInfo();
            WorkLog_.id = id;
            control.DeleteEntity(WorkLog_);
        }

        public WorkLogInfo GetById(int id)
        {
            return (WorkLogInfo)control.GetEntity("WC.Model.WorkLogInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.WorkLogInfo", where, orderBy);
        }
        #endregion
    }
}
