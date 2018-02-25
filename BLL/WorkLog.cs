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
    public class WorkLog
    {
        /// <summary>
        /// 在业务逻辑层中设置一个静态只读WorkLog操作类的对象
        /// </summary>
        private static readonly IWorkLog dal = WC.Factory.DALFactory.CreateWorkLogDAL();

        /// <summary>
        /// 封装业务层中WorkLog操作类的构造方法
        /// </summary>
        private WorkLog() { }

        /// <summary>
        /// 业务逻辑层中WorkLog操作类对象的静态生成方法
        /// </summary>
        /// <returns></returns>
        public static WorkLog Init()
        {
            return new WorkLog();
        }

        #region NHibernate 方法

        public void Add(WorkLogInfo com)
        {
            dal.Add(com);
        }

        public void Update(WorkLogInfo com)
        {
            dal.Update(com);
        }

        public void Delete(int id)
        {
            dal.Delete(id);
        }

        public WorkLogInfo GetById(int id)
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
