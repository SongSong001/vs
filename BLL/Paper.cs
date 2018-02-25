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
    public class Paper
    {
        /// <summary>
        /// 在业务逻辑层中设置一个静态只读Paper操作类的对象
        /// </summary>
        private static readonly IPaper dal = WC.Factory.DALFactory.CreatePaperDAL();

        /// <summary>
        /// 封装业务层中Paper操作类的构造方法
        /// </summary>
        private Paper() { }

        /// <summary>
        /// 业务逻辑层中Paper操作类对象的静态生成方法
        /// </summary>
        /// <returns></returns>
        public static Paper Init()
        {
            return new Paper();
        }

        #region NHibernate 方法

        public void Add(PaperInfo com)
        {
            dal.Add(com);
        }

        public void Update(PaperInfo com)
        {
            dal.Update(com);
        }

        public void Delete(int id)
        {
            dal.Delete(id);
        }

        public PaperInfo GetById(int id)
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
