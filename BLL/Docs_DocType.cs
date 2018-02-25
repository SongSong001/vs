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
    public class Docs_DocType
    {
        /// <summary>
        /// 在业务逻辑层中设置一个静态只读Docs_DocType操作类的对象
        /// </summary>
        private static readonly IDocs_DocType dal = WC.Factory.DALFactory.CreateDocs_DocTypeDAL();

        /// <summary>
        /// 封装业务层中Docs_DocType操作类的构造方法
        /// </summary>
        private Docs_DocType() { }

        /// <summary>
        /// 业务逻辑层中Docs_DocType操作类对象的静态生成方法
        /// </summary>
        /// <returns></returns>
        public static Docs_DocType Init()
        {
            return new Docs_DocType();
        }

        #region NHibernate 方法

        public void Add(Docs_DocTypeInfo com)
        {
            dal.Add(com);
        }

        public void Update(Docs_DocTypeInfo com)
        {
            dal.Update(com);
        }

        public void Delete(int id)
        {
            dal.Delete(id);
        }

        public Docs_DocTypeInfo GetById(int id)
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
