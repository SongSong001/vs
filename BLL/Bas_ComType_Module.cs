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
    public class Bas_ComType_Module
    {
        /// <summary>
        /// 在业务逻辑层中设置一个静态只读Bas_ComType_Module操作类的对象
        /// </summary>
        private static readonly IBas_ComType_Module dal = WC.Factory.DALFactory.CreateBas_ComType_ModuleDAL();

        /// <summary>
        /// 封装业务层中Bas_ComType_Module操作类的构造方法
        /// </summary>
        private Bas_ComType_Module() { }

        /// <summary>
        /// 业务逻辑层中Bas_ComType_Module操作类对象的静态生成方法
        /// </summary>
        /// <returns></returns>
        public static Bas_ComType_Module Init()
        {
            return new Bas_ComType_Module();
        }

        #region NHibernate 方法

        public void Add(Bas_ComType_ModuleInfo com)
        {
            dal.Add(com);
        }

        public void Update(Bas_ComType_ModuleInfo com)
        {
            dal.Update(com);
        }

        public void Delete(int id)
        {
            dal.Delete(id);
        }

        public Bas_ComType_ModuleInfo GetById(int id)
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
