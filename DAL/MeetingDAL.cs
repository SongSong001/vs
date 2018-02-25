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
    public class MeetingDAL : IMeeting
    {
        private EntityControl control;

        public MeetingDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(MeetingInfo Meeting_)
        {
            control.AddEntity(Meeting_);
        }

        public void Update(MeetingInfo Meeting_)
        {
            control.UpdateEntity(Meeting_, Meeting_.id);
        }

        public void Delete(int id)
        {
            MeetingInfo Meeting_ = new MeetingInfo();
            Meeting_.id = id;
            control.DeleteEntity(Meeting_);
        }

        public MeetingInfo GetById(int id)
        {
            return (MeetingInfo)control.GetEntity("WC.Model.MeetingInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.MeetingInfo", where, orderBy);
        }
        #endregion
    }
}
