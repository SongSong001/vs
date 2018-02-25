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
    public class Work_AttendSet
    {
        /// <summary>
        /// 在业务逻辑层中设置一个静态只读Work_AttendSet操作类的对象
        /// </summary>
        private static readonly IWork_AttendSet dal = WC.Factory.DALFactory.CreateWork_AttendSetDAL();

        /// <summary>
        /// 封装业务层中Work_AttendSet操作类的构造方法
        /// </summary>
        private Work_AttendSet() { }

        /// <summary>
        /// 业务逻辑层中Work_AttendSet操作类对象的静态生成方法
        /// </summary>
        /// <returns></returns>
        public static Work_AttendSet Init()
        {
            return new Work_AttendSet();
        }

        #region NHibernate 方法

        public void Add(Work_AttendSetInfo com)
        {
            dal.Add(com);
        }

        public void Update(Work_AttendSetInfo com)
        {
            dal.Update(com);
        }

        public void Delete(int id)
        {
            dal.Delete(id);
        }

        public Work_AttendSetInfo GetById(int id)
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
