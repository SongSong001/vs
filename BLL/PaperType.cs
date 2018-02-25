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
    public class PaperType
    {
        /// <summary>
        /// 在业务逻辑层中设置一个静态只读PaperType操作类的对象
        /// </summary>
        private static readonly IPaperType dal = WC.Factory.DALFactory.CreatePaperTypeDAL();

        /// <summary>
        /// 封装业务层中PaperType操作类的构造方法
        /// </summary>
        private PaperType() { }

        /// <summary>
        /// 业务逻辑层中PaperType操作类对象的静态生成方法
        /// </summary>
        /// <returns></returns>
        public static PaperType Init()
        {
            return new PaperType();
        }

        #region NHibernate 方法

        public void Add(PaperTypeInfo com)
        {
            dal.Add(com);
        }

        public void Update(PaperTypeInfo com)
        {
            dal.Update(com);
        }

        public void Delete(int id)
        {
            dal.Delete(id);
        }

        public PaperTypeInfo GetById(int id)
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
