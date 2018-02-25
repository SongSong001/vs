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
    public class VoteDetailDAL : IVoteDetail
    {
        private EntityControl control;

        public VoteDetailDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(VoteDetailInfo VoteDetail_)
        {
            control.AddEntity(VoteDetail_);
        }

        public void Update(VoteDetailInfo VoteDetail_)
        {
            control.UpdateEntity(VoteDetail_, VoteDetail_.id);
        }

        public void Delete(int id)
        {
            VoteDetailInfo VoteDetail_ = new VoteDetailInfo();
            VoteDetail_.id = id;
            control.DeleteEntity(VoteDetail_);
        }

        public VoteDetailInfo GetById(int id)
        {
            return (VoteDetailInfo)control.GetEntity("WC.Model.VoteDetailInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.VoteDetailInfo", where, orderBy);
        }
        #endregion
    }
}
