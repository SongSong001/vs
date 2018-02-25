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
    public class Work_Attend
    {
        /// <summary>
        /// 在业务逻辑层中设置一个静态只读Work_Attend操作类的对象
        /// </summary>
        private static readonly IWork_Attend dal = WC.Factory.DALFactory.CreateWork_AttendDAL();

        /// <summary>
        /// 封装业务层中Work_Attend操作类的构造方法
        /// </summary>
        private Work_Attend() { }

        /// <summary>
        /// 业务逻辑层中Work_Attend操作类对象的静态生成方法
        /// </summary>
        /// <returns></returns>
        public static Work_Attend Init()
        {
            return new Work_Attend();
        }

        #region NHibernate 方法

        public void Add(Work_AttendInfo com)
        {
            dal.Add(com);
        }

        public void Update(Work_AttendInfo com)
        {
            dal.Update(com);
        }

        public void Delete(int id)
        {
            dal.Delete(id);
        }

        public Work_AttendInfo GetById(int id)
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
