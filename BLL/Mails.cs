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
    public class Mails
    {
        /// <summary>
        /// 在业务逻辑层中设置一个静态只读Mails操作类的对象
        /// </summary>
        private static readonly IMails dal = WC.Factory.DALFactory.CreateMailsDAL();

        /// <summary>
        /// 封装业务层中Mails操作类的构造方法
        /// </summary>
        private Mails() { }

        /// <summary>
        /// 业务逻辑层中Mails操作类对象的静态生成方法
        /// </summary>
        /// <returns></returns>
        public static Mails Init()
        {
            return new Mails();
        }

        #region NHibernate 方法

        public void Add(MailsInfo com)
        {
            dal.Add(com);
        }

        public void Update(MailsInfo com)
        {
            dal.Update(com);
        }

        public void Delete(int id)
        {
            dal.Delete(id);
        }

        public MailsInfo GetById(int id)
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
