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
    public class C_GoodType
    {
        /// <summary>
        /// 在业务逻辑层中设置一个静态只读C_GoodType操作类的对象
        /// </summary>
        private static readonly IC_GoodType dal = WC.Factory.DALFactory.CreateC_GoodTypeDAL();

        /// <summary>
        /// 封装业务层中C_GoodType操作类的构造方法
        /// </summary>
        private C_GoodType() { }

        /// <summary>
        /// 业务逻辑层中C_GoodType操作类对象的静态生成方法
        /// </summary>
        /// <returns></returns>
        public static C_GoodType Init()
        {
            return new C_GoodType();
        }

        #region NHibernate 方法

        public void Add(C_GoodTypeInfo com)
        {
            dal.Add(com);
        }

        public void Update(C_GoodTypeInfo com)
        {
            dal.Update(com);
        }

        public void Delete(int id)
        {
            dal.Delete(id);
        }

        public C_GoodTypeInfo GetById(int id)
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
