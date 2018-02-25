using System;
using System.Collections;
using System.Data;
using System.Data.OleDb;
using WC.Common;
using WC.Model;
using WC.DBUtility;
using WC.IDAL;
using WC.Tool;

namespace WC.DAL
{
    public class News_ArticleDAL : INews_Article
    {
        private EntityControl control;

        public News_ArticleDAL()
        {
            control = EntityControl.CreateEntityControl("WC.Model");
        }

        #region NHibernate 方法
        public void Add(News_ArticleInfo News_Article_)
        {
            control.AddEntity(News_Article_);
        }

        public void Update(News_ArticleInfo News_Article_)
        {
            control.UpdateEntity(News_Article_, News_Article_.id);
        }

        public void Delete(int id)
        {
            News_ArticleInfo News_Article_ = new News_ArticleInfo();
            News_Article_.id = id;
            control.DeleteEntity(News_Article_);
        }

        public News_ArticleInfo GetById(int id)
        {
            return (News_ArticleInfo)control.GetEntity("WC.Model.News_ArticleInfo", "id", id.ToString());
        }

        public IList GetAll(string where, string orderBy)
        {
            if (!Utils.CheckSql(where))
            {
                throw new Exception("sql注入非法字符串! -- " + where);
            }
            return control.GetEntities("WC.Model.News_ArticleInfo", where, orderBy);
        }
        #endregion
    }
}
