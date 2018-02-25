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
    public class Cars_Type
    {
        /// <summary>
        /// 在业务逻辑层中设置一个静态只读Cars_Type操作类的对象
        /// </summary>
        private static readonly ICars_Type dal = WC.Factory.DALFactory.CreateCars_TypeDAL();

        /// <summary>
        /// 封装业务层中Cars_Type操作类的构造方法
        /// </summary>
        private Cars_Type() { }

        /// <summary>
        /// 业务逻辑层中Cars_Type操作类对象的静态生成方法
        /// </summary>
        /// <returns></returns>
        public static Cars_Type Init()
        {
            return new Cars_Type();
        }

        #region NHibernate 方法

        public void Add(Cars_TypeInfo com)
        {
            dal.Add(com);
        }

        public void Update(Cars_TypeInfo com)
        {
            dal.Update(com);
        }

        public void Delete(int id)
        {
            dal.Delete(id);
        }

        public Cars_TypeInfo GetById(int id)
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
