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
    public class VoteDAL : IVote
    {
        private EntityControl control;

        public VoteDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(VoteInfo Vote_)
        {
            control.AddEntity(Vote_);
        }

        public void Update(VoteInfo Vote_)
        {
            control.UpdateEntity(Vote_, Vote_.id);
        }

        public void Delete(int id)
        {
            VoteInfo Vote_ = new VoteInfo();
            Vote_.id = id;
            control.DeleteEntity(Vote_);
        }

        public VoteInfo GetById(int id)
        {
            return (VoteInfo)control.GetEntity("WC.Model.VoteInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.VoteInfo", where, orderBy);
        }
        #endregion
    }
}
