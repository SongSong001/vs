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
    public class Flows_Doc
    {
        /// <summary>
        /// 在业务逻辑层中设置一个静态只读Flows_Doc操作类的对象
        /// </summary>
        private static readonly IFlows_Doc dal = WC.Factory.DALFactory.CreateFlows_DocDAL();

        /// <summary>
        /// 封装业务层中Flows_Doc操作类的构造方法
        /// </summary>
        private Flows_Doc() { }

        /// <summary>
        /// 业务逻辑层中Flows_Doc操作类对象的静态生成方法
        /// </summary>
        /// <returns></returns>
        public static Flows_Doc Init()
        {
            return new Flows_Doc();
        }

        #region NHibernate 方法

        public void Add(Flows_DocInfo com)
        {
            dal.Add(com);
        }

        public void Update(Flows_DocInfo com)
        {
            dal.Update(com);
        }

        public void Delete(int id)
        {
            dal.Delete(id);
        }

        public Flows_DocInfo GetById(int id)
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
