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
    public class Cars_Action
    {
        /// <summary>
        /// 在业务逻辑层中设置一个静态只读Cars_Action操作类的对象
        /// </summary>
        private static readonly ICars_Action dal = WC.Factory.DALFactory.CreateCars_ActionDAL();

        /// <summary>
        /// 封装业务层中Cars_Action操作类的构造方法
        /// </summary>
        private Cars_Action() { }

        /// <summary>
        /// 业务逻辑层中Cars_Action操作类对象的静态生成方法
        /// </summary>
        /// <returns></returns>
        public static Cars_Action Init()
        {
            return new Cars_Action();
        }

        #region NHibernate 方法

        public void Add(Cars_ActionInfo com)
        {
            dal.Add(com);
        }

        public void Update(Cars_ActionInfo com)
        {
            dal.Update(com);
        }

        public void Delete(int id)
        {
            dal.Delete(id);
        }

        public Cars_ActionInfo GetById(int id)
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
