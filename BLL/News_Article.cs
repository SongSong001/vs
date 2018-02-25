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
    public class News_Article
    {
        /// <summary>
        /// 在业务逻辑层中设置一个静态只读News_Article操作类的对象
        /// </summary>
        private static readonly INews_Article dal = WC.Factory.DALFactory.CreateNews_ArticleDAL();

        /// <summary>
        /// 封装业务层中News_Article操作类的构造方法
        /// </summary>
        private News_Article() { }

        /// <summary>
        /// 业务逻辑层中News_Article操作类对象的静态生成方法
        /// </summary>
        /// <returns></returns>
        public static News_Article Init()
        {
            return new News_Article();
        }

        #region NHibernate 方法

        public void Add(News_ArticleInfo com)
        {
            dal.Add(com);
        }

        public void Update(News_ArticleInfo com)
        {
            dal.Update(com);
        }

        public void Delete(int id)
        {
            dal.Delete(id);
        }

        public News_ArticleInfo GetById(int id)
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
