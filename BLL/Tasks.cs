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
    public class Tasks
    {
        /// <summary>
        /// 在业务逻辑层中设置一个静态只读Tasks操作类的对象
        /// </summary>
        private static readonly ITasks dal = WC.Factory.DALFactory.CreateTasksDAL();

        /// <summary>
        /// 封装业务层中Tasks操作类的构造方法
        /// </summary>
        private Tasks() { }

        /// <summary>
        /// 业务逻辑层中Tasks操作类对象的静态生成方法
        /// </summary>
        /// <returns></returns>
        public static Tasks Init()
        {
            return new Tasks();
        }

        #region NHibernate 方法

        public void Add(TasksInfo com)
        {
            dal.Add(com);
        }

        public void Update(TasksInfo com)
        {
            dal.Update(com);
        }

        public void Delete(int id)
        {
            dal.Delete(id);
        }

        public TasksInfo GetById(int id)
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
