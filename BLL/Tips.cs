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
    public class Tips
    {
        /// <summary>
        /// 在业务逻辑层中设置一个静态只读Tips操作类的对象
        /// </summary>
        private static readonly ITips dal = WC.Factory.DALFactory.CreateTipsDAL();

        /// <summary>
        /// 封装业务层中Tips操作类的构造方法
        /// </summary>
        private Tips() { }

        /// <summary>
        /// 业务逻辑层中Tips操作类对象的静态生成方法
        /// </summary>
        /// <returns></returns>
        public static Tips Init()
        {
            return new Tips();
        }

        #region NHibernate 方法

        public void Add(TipsInfo com)
        {
            dal.Add(com);
        }

        public void Update(TipsInfo com)
        {
            dal.Update(com);
        }

        public void Delete(int id)
        {
            dal.Delete(id);
        }

        public TipsInfo GetById(int id)
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
