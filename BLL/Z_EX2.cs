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
    public class ZEX2
    {
        /// <summary>
        /// 在业务逻辑层中设置一个静态只读ZEX2操作类的对象
        /// </summary>
        private static readonly IZEX2 dal = WC.Factory.DALFactory.CreateZEX2DAL();

        /// <summary>
        /// 封装业务层中ZEX2操作类的构造方法
        /// </summary>
        private ZEX2() { }

        /// <summary>
        /// 业务逻辑层中ZEX2操作类对象的静态生成方法
        /// </summary>
        /// <returns></returns>
        public static ZEX2 Init()
        {
            return new ZEX2();
        }

        #region NHibernate 方法

        public void Add(ZEX2Info com)
        {
            dal.Add(com);
        }

        public void Update(ZEX2Info com)
        {
            dal.Update(com);
        }

        public void Delete(int id)
        {
            dal.Delete(id);
        }

        public ZEX2Info GetById(int id)
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
