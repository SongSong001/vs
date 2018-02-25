﻿using System;
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
    public class SysHR
    {
        /// <summary>
        /// 在业务逻辑层中设置一个静态只读SysHR操作类的对象
        /// </summary>
        private static readonly ISysHR dal = WC.Factory.DALFactory.CreateSysHRDAL();

        /// <summary>
        /// 封装业务层中SysHR操作类的构造方法
        /// </summary>
        private SysHR() { }

        /// <summary>
        /// 业务逻辑层中SysHR操作类对象的静态生成方法
        /// </summary>
        /// <returns></returns>
        public static SysHR Init()
        {
            return new SysHR();
        }

        #region NHibernate 方法

        public void Add(SysHRInfo com)
        {
            dal.Add(com);
        }

        public void Update(SysHRInfo com)
        {
            dal.Update(com);
        }

        public void Delete(int id)
        {
            dal.Delete(id);
        }

        public SysHRInfo GetById(int id)
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