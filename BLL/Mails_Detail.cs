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
    public class Mails_Detail
    {
        /// <summary>
        /// 在业务逻辑层中设置一个静态只读Mails_Detail操作类的对象
        /// </summary>
        private static readonly IMails_Detail dal = WC.Factory.DALFactory.CreateMails_DetailDAL();

        /// <summary>
        /// 封装业务层中Mails_Detail操作类的构造方法
        /// </summary>
        private Mails_Detail() { }

        /// <summary>
        /// 业务逻辑层中Mails_Detail操作类对象的静态生成方法
        /// </summary>
        /// <returns></returns>
        public static Mails_Detail Init()
        {
            return new Mails_Detail();
        }

        #region NHibernate 方法

        public void Add(Mails_DetailInfo com)
        {
            dal.Add(com);
        }

        public void Update(Mails_DetailInfo com)
        {
            dal.Update(com);
        }

        public void Delete(int id)
        {
            dal.Delete(id);
        }

        public Mails_DetailInfo GetById(int id)
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
