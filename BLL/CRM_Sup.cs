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
    public class CRM_Sup
    {
        /// <summary>
        /// 在业务逻辑层中设置一个静态只读CRM_Sup操作类的对象
        /// </summary>
        private static readonly ICRM_Sup dal = WC.Factory.DALFactory.CreateCRM_SupDAL();

        /// <summary>
        /// 封装业务层中CRM_Sup操作类的构造方法
        /// </summary>
        private CRM_Sup() { }

        /// <summary>
        /// 业务逻辑层中CRM_Sup操作类对象的静态生成方法
        /// </summary>
        /// <returns></returns>
        public static CRM_Sup Init()
        {
            return new CRM_Sup();
        }

        #region NHibernate 方法

        public void Add(CRM_SupInfo com)
        {
            dal.Add(com);
        }

        public void Update(CRM_SupInfo com)
        {
            dal.Update(com);
        }

        public void Delete(int id)
        {
            dal.Delete(id);
        }

        public CRM_SupInfo GetById(int id)
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
