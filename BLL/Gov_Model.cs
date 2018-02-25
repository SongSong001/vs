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
    public class Gov_Model
    {
        /// <summary>
        /// 在业务逻辑层中设置一个静态只读Gov_Model操作类的对象
        /// </summary>
        private static readonly IGov_Model dal = WC.Factory.DALFactory.CreateGov_ModelDAL();

        /// <summary>
        /// 封装业务层中Gov_Model操作类的构造方法
        /// </summary>
        private Gov_Model() { }

        /// <summary>
        /// 业务逻辑层中Gov_Model操作类对象的静态生成方法
        /// </summary>
        /// <returns></returns>
        public static Gov_Model Init()
        {
            return new Gov_Model();
        }

        #region NHibernate 方法

        public void Add(Gov_ModelInfo com)
        {
            dal.Add(com);
        }

        public void Update(Gov_ModelInfo com)
        {
            dal.Update(com);
        }

        public void Delete(int id)
        {
            dal.Delete(id);
        }

        public Gov_ModelInfo GetById(int id)
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
