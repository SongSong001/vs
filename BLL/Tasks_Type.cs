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
    public class Tasks_Type
    {
        /// <summary>
        /// 在业务逻辑层中设置一个静态只读Tasks_Type操作类的对象
        /// </summary>
        private static readonly ITasks_Type dal = WC.Factory.DALFactory.CreateTasks_TypeDAL();

        /// <summary>
        /// 封装业务层中Tasks_Type操作类的构造方法
        /// </summary>
        private Tasks_Type() { }

        /// <summary>
        /// 业务逻辑层中Tasks_Type操作类对象的静态生成方法
        /// </summary>
        /// <returns></returns>
        public static Tasks_Type Init()
        {
            return new Tasks_Type();
        }

        #region NHibernate 方法

        public void Add(Tasks_TypeInfo com)
        {
            dal.Add(com);
        }

        public void Update(Tasks_TypeInfo com)
        {
            dal.Update(com);
        }

        public void Delete(int id)
        {
            dal.Delete(id);
        }

        public Tasks_TypeInfo GetById(int id)
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
