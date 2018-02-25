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
    public class Meeting
    {
        /// <summary>
        /// 在业务逻辑层中设置一个静态只读Meeting操作类的对象
        /// </summary>
        private static readonly IMeeting dal = WC.Factory.DALFactory.CreateMeetingDAL();

        /// <summary>
        /// 封装业务层中Meeting操作类的构造方法
        /// </summary>
        private Meeting() { }

        /// <summary>
        /// 业务逻辑层中Meeting操作类对象的静态生成方法
        /// </summary>
        /// <returns></returns>
        public static Meeting Init()
        {
            return new Meeting();
        }

        #region NHibernate 方法

        public void Add(MeetingInfo com)
        {
            dal.Add(com);
        }

        public void Update(MeetingInfo com)
        {
            dal.Update(com);
        }

        public void Delete(int id)
        {
            dal.Delete(id);
        }

        public MeetingInfo GetById(int id)
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
