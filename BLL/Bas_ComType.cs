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
    public class Bas_ComType
    {
        /// <summary>
        /// 在业务逻辑层中设置一个静态只读Bas_ComType操作类的对象
        /// </summary>
        private static readonly IBas_ComType dal = WC.Factory.DALFactory.CreateBas_ComTypeDAL();

        /// <summary>
        /// 封装业务层中Bas_ComType操作类的构造方法
        /// </summary>
        private Bas_ComType() { }

        /// <summary>
        /// 业务逻辑层中Bas_ComType操作类对象的静态生成方法
        /// </summary>
        /// <returns></returns>
        public static Bas_ComType Init()
        {
            return new Bas_ComType();
        }

        #region NHibernate 方法

        public void Add(Bas_ComTypeInfo com)
        {
            dal.Add(com);
        }

        public void Update(Bas_ComTypeInfo com)
        {
            dal.Update(com);
        }

        public void Delete(int id)
        {
            dal.Delete(id);
        }

        public Bas_ComTypeInfo GetById(int id)
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
