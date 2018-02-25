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
    public class C_GoodAction
    {
        /// <summary>
        /// 在业务逻辑层中设置一个静态只读C_GoodAction操作类的对象
        /// </summary>
        private static readonly IC_GoodAction dal = WC.Factory.DALFactory.CreateC_GoodActionDAL();

        /// <summary>
        /// 封装业务层中C_GoodAction操作类的构造方法
        /// </summary>
        private C_GoodAction() { }

        /// <summary>
        /// 业务逻辑层中C_GoodAction操作类对象的静态生成方法
        /// </summary>
        /// <returns></returns>
        public static C_GoodAction Init()
        {
            return new C_GoodAction();
        }

        #region NHibernate 方法

        public void Add(C_GoodActionInfo com)
        {
            dal.Add(com);
        }

        public void Update(C_GoodActionInfo com)
        {
            dal.Update(com);
        }

        public void Delete(int id)
        {
            dal.Delete(id);
        }

        public C_GoodActionInfo GetById(int id)
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
