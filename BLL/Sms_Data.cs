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
    public class Sms_Data
    {
        /// <summary>
        /// 在业务逻辑层中设置一个静态只读Sms_Data操作类的对象
        /// </summary>
        private static readonly ISms_Data dal = WC.Factory.DALFactory.CreateSms_DataDAL();

        /// <summary>
        /// 封装业务层中Sms_Data操作类的构造方法
        /// </summary>
        private Sms_Data() { }

        /// <summary>
        /// 业务逻辑层中Sms_Data操作类对象的静态生成方法
        /// </summary>
        /// <returns></returns>
        public static Sms_Data Init()
        {
            return new Sms_Data();
        }

        #region NHibernate 方法

        public void Add(Sms_DataInfo com)
        {
            dal.Add(com);
        }

        public void Update(Sms_DataInfo com)
        {
            dal.Update(com);
        }

        public void Delete(int id)
        {
            dal.Delete(id);
        }

        public Sms_DataInfo GetById(int id)
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
