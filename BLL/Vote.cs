using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.OleDb;
using WC.Model;
using WC.DAL;
using WC.IDAL;
using WC.Factory;

namespace WC.BLL
{
    public class Vote
    {
        /// <summary>
        /// 在业务逻辑层中设置一个静态只读Vote操作类的对象
        /// </summary>
        private static readonly IVote dal = WC.Factory.DALFactory.CreateVoteDAL();

        /// <summary>
        /// 封装业务层中Vote操作类的构造方法
        /// </summary>
        private Vote() { }

        /// <summary>
        /// 业务逻辑层中Vote操作类对象的静态生成方法
        /// </summary>
        /// <returns></returns>
        public static Vote Init()
        {
            return new Vote();
        }

        #region NHibernate 方法

        public void Add(VoteInfo com)
        {
            dal.Add(com);
        }

        public void Update(VoteInfo com)
        {
            dal.Update(com);
        }

        public void Delete(int id)
        {
            dal.Delete(id);
        }

        public VoteInfo GetById(int id)
        {
            return dal.GetById(id);
        }

        public IList GetAll(string where, string orderBy)
        {
            return dal.GetAll(where, orderBy);
        }

        #endregion
    }
}
