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
    public class CRM
    {
        /// <summary>
        /// 在业务逻辑层中设置一个静态只读CRM操作类的对象
        /// </summary>
        private static readonly ICRM dal = WC.Factory.DALFactory.CreateCRMDAL();

        /// <summary>
        /// 封装业务层中CRM操作类的构造方法
        /// </summary>
        private CRM() { }

        /// <summary>
        /// 业务逻辑层中CRM操作类对象的静态生成方法
        /// </summary>
        /// <returns></returns>
        public static CRM Init()
        {
            return new CRM();
        }

        #region NHibernate 方法

        public void Add(CRMInfo com)
        {
            dal.Add(com);
        }

        public void Update(CRMInfo com)
        {
            dal.Update(com);
        }

        public void Delete(int id)
        {
            dal.Delete(id);
        }

        public CRMInfo GetById(int id)
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
