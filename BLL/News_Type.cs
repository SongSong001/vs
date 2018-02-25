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
    public class News_Type
    {
        /// <summary>
        /// 在业务逻辑层中设置一个静态只读News_Type操作类的对象
        /// </summary>
        private static readonly INews_Type dal = WC.Factory.DALFactory.CreateNews_TypeDAL();

        /// <summary>
        /// 封装业务层中News_Type操作类的构造方法
        /// </summary>
        private News_Type() { }

        /// <summary>
        /// 业务逻辑层中News_Type操作类对象的静态生成方法
        /// </summary>
        /// <returns></returns>
        public static News_Type Init()
        {
            return new News_Type();
        }

        #region NHibernate 方法

        public void Add(News_TypeInfo com)
        {
            dal.Add(com);
        }

        public void Update(News_TypeInfo com)
        {
            dal.Update(com);
        }

        public void Delete(int id)
        {
            dal.Delete(id);
        }

        public News_TypeInfo GetById(int id)
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
