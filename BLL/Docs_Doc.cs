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
    public class Docs_Doc
    {
        /// <summary>
        /// 在业务逻辑层中设置一个静态只读Docs_Doc操作类的对象
        /// </summary>
        private static readonly IDocs_Doc dal = WC.Factory.DALFactory.CreateDocs_DocDAL();

        /// <summary>
        /// 封装业务层中Docs_Doc操作类的构造方法
        /// </summary>
        private Docs_Doc() { }

        /// <summary>
        /// 业务逻辑层中Docs_Doc操作类对象的静态生成方法
        /// </summary>
        /// <returns></returns>
        public static Docs_Doc Init()
        {
            return new Docs_Doc();
        }

        #region NHibernate 方法

        public void Add(Docs_DocInfo com)
        {
            dal.Add(com);
        }

        public void Update(Docs_DocInfo com)
        {
            dal.Update(com);
        }

        public void Delete(int id)
        {
            dal.Delete(id);
        }

        public Docs_DocInfo GetById(int id)
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
