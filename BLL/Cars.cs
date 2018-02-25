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
    public class Cars
    {
        /// <summary>
        /// 在业务逻辑层中设置一个静态只读Cars操作类的对象
        /// </summary>
        private static readonly ICars dal = WC.Factory.DALFactory.CreateCarsDAL();

        /// <summary>
        /// 封装业务层中Cars操作类的构造方法
        /// </summary>
        private Cars() { }

        /// <summary>
        /// 业务逻辑层中Cars操作类对象的静态生成方法
        /// </summary>
        /// <returns></returns>
        public static Cars Init()
        {
            return new Cars();
        }

        #region NHibernate 方法

        public void Add(CarsInfo com)
        {
            dal.Add(com);
        }

        public void Update(CarsInfo com)
        {
            dal.Update(com);
        }

        public void Delete(int id)
        {
            dal.Delete(id);
        }

        public CarsInfo GetById(int id)
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
