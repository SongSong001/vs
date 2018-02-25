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
    public class PhoneBook
    {
        /// <summary>
        /// 在业务逻辑层中设置一个静态只读PhoneBook操作类的对象
        /// </summary>
        private static readonly IPhoneBook dal = WC.Factory.DALFactory.CreatePhoneBookDAL();

        /// <summary>
        /// 封装业务层中PhoneBook操作类的构造方法
        /// </summary>
        private PhoneBook() { }

        /// <summary>
        /// 业务逻辑层中PhoneBook操作类对象的静态生成方法
        /// </summary>
        /// <returns></returns>
        public static PhoneBook Init()
        {
            return new PhoneBook();
        }

        #region NHibernate 方法

        public void Add(PhoneBookInfo com)
        {
            dal.Add(com);
        }

        public void Update(PhoneBookInfo com)
        {
            dal.Update(com);
        }

        public void Delete(int id)
        {
            dal.Delete(id);
        }

        public PhoneBookInfo GetById(int id)
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
