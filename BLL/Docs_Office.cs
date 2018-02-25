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
    public class Docs_Office
    {
        /// <summary>
        /// 在业务逻辑层中设置一个静态只读Docs_Office操作类的对象
        /// </summary>
        private static readonly IDocs_Office dal = WC.Factory.DALFactory.CreateDocs_OfficeDAL();

        /// <summary>
        /// 封装业务层中Docs_Office操作类的构造方法
        /// </summary>
        private Docs_Office() { }

        /// <summary>
        /// 业务逻辑层中Docs_Office操作类对象的静态生成方法
        /// </summary>
        /// <returns></returns>
        public static Docs_Office Init()
        {
            return new Docs_Office();
        }

        #region NHibernate 方法

        public void Add(Docs_OfficeInfo com)
        {
            dal.Add(com);
        }

        public void Update(Docs_OfficeInfo com)
        {
            dal.Update(com);
        }

        public void Delete(int id)
        {
            dal.Delete(id);
        }

        public Docs_OfficeInfo GetById(int id)
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
