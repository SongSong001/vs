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
    public class ZEX5
    {
        /// <summary>
        /// 在业务逻辑层中设置一个静态只读ZEX5操作类的对象
        /// </summary>
        private static readonly IZEX5 dal = WC.Factory.DALFactory.CreateZEX5DAL();

        /// <summary>
        /// 封装业务层中ZEX5操作类的构造方法
        /// </summary>
        private ZEX5() { }

        /// <summary>
        /// 业务逻辑层中ZEX5操作类对象的静态生成方法
        /// </summary>
        /// <returns></returns>
        public static ZEX5 Init()
        {
            return new ZEX5();
        }

        #region NHibernate 方法

        public void Add(ZEX5Info com)
        {
            dal.Add(com);
        }

        public void Update(ZEX5Info com)
        {
            dal.Update(com);
        }

        public void Delete(int id)
        {
            dal.Delete(id);
        }

        public ZEX5Info GetById(int id)
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
